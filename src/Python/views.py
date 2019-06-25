import hashlib
import json
import os
import datetime
import pandas as pd
from functools import wraps
from sqlalchemy import create_engine
from flask import render_template, flash, redirect, url_for, request, g, make_response
from flask_login import login_user, logout_user, current_user, AnonymousUserMixin
from app import app, lm, db
from app.utils import get_properties, send_mail_to_confirm, get_list_of_ordered_shirts, update_finished_orders
from .models import User
from .forms import LoginForm


# define a guest user
class Anonymous(AnonymousUserMixin):
    def __init__(self):
        self.nickname = 'None'

# define login wrapper
def logged_in(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if g.user is not None and g.user.is_authenticated():
            return f(*args, **kwargs)
        else:
            flash('Please log in first...', 'error')
            return redirect(url_for('login', wantsurl=request.url))
    return decorated_function

# define logout function
@app.route('/logout', methods=['GET', 'POST'])
def logout():
    logout_user()
    return redirect("index")


# define before_request
@app.before_request
def before_request():
    g.user = current_user

app_location = os.path.dirname(os.path.realpath(__file__))
lm.anonymous_user = Anonymous

@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html', user=str(g.user.nickname), properties=get_properties())

@app.route('/save_order', methods=["GET", "POST"])
def save_order():
    global id_order
    if request.method == "POST":
        engine = create_engine('mysql+mysqlconnector://student@localhost:3306/koszulki', echo=False)
        json_data = request.json
        index = json_data["index"]
        command = "SELECT * FROM studenci WHERE nr_indeksu={}".format(index)
        data = pd.read_sql_query(command, engine)
        new_person = [json_data["index"], json_data["name"], json_data["surename"], json_data["mail"], json_data["tel"]]
        if (len(data) > 0):
            print(list(data.values)[0])
            if (list(data.values)[0] != new_person):
                return make_response(json.dumps({"success": True, "wrong_person": True}))
        else:
            columns = "nr_indeksu,imie,nazwisko,mail,telefon"
            command = "INSERT INTO studenci({0}) VALUES ({1[index]},'{1[name]}','{1[surename]}','{1[mail]}',{1[tel]});".format(columns, json_data)
            print(command)
            engine.execute(command)

        columns = "nr_indeksu_studenta,wartosc_zamowienia"
        command = "INSERT INTO zamowienia({}) VALUES ({},{})".format(columns, index, 15 * len(json_data["shirts"]))
        engine.execute(command)
        id_order = list(pd.read_sql_query("SELECT LAST_INSERT_ID()", engine).values)[0][0]

        new_shirts = []
        counts = []
        for shirt in json_data["shirts"]:
            if shirt not in new_shirts:
                new_shirts.append(shirt)
                counts.append(1)
            else:
                new_shirts[new_shirts.index(shirt)] += 1

        columns = "id_zamowienia,id_produktu,ilosc"
        for nbr, shirt in enumerate(new_shirts):
            command = r"SELECT id_produktu FROM produkty WHERE kolor LIKE '{0[0]}' AND rozmiar LIKE '{0[1]}%' AND typ LIKE '{0[2]}'".format(shirt)
            print(command)
            id_shirt = list(pd.read_sql_query(command, engine).values)[0][0]
            print(id_shirt)
            command = "INSERT INTO detale_zamowien({}) VALUES ({},'{}',{})".format(columns, id_order, id_shirt, counts[nbr])
            engine.execute(command)
        send_mail_to_confirm(json_data["mail"], id_order, json_data["shirts"])
        return make_response(json.dumps({"success": True}))
    if request.method == 'GET':
        return make_response(json.dumps({"success": True, "nbr": str(id_order)}))
    return render_template('index.html', user=str(g.user.nickname), properties=get_properties())


@app.route('/login', methods=['GET', 'POST'])
def login():
    args = dict(request.args)
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(nickname=form.log.data).first()
        if user is None:
            user = User(nickname=form.log.data)
            db.session.add(user)
            db.session.commit()
        user = User.query.filter_by(nickname=form.log.data).first()
        try:
            form.password.data = ""
            if form.log.data.strip() not in ["SSW13", "MANUS"]:
                flash('Only admins!:', 'error')
                return redirect(url_for('login', wantsurl=request.url))
            else:
                hashed_pass = hashlib.md5(form.password.data)
                engine = create_engine('mysql+mysqlconnector://student@localhost:3306/koszulki', echo=False)
                command = "SELECT haslo FROM uzytkownicy WHERE login={}".format(form.log.data.strip())
                hash_from_db = pd.read_sql_query(command, engine)[0][0]
                if hashed_pass != hash_from_db:
                    flash('Wrong credentials, try again:', 'error')
                    return redirect(url_for('login', wantsurl=request.url))
        except Exception:
            flash('Wrong credentials, try again:', 'error')
            return redirect(url_for('login', wantsurl=request.url))
        else:
            login_user(user)
            if 'wantsurl' in args:
                if request.args['wantsurl'].strip().endswith("login"):
                    return redirect("index")
                return redirect(request.args['wantsurl'])
        return redirect('index')

    return render_template('login.html',
                           title='Zaloguj',
                           form=form)

# contact page
@app.route('/contact')
def contact():
    return render_template('contact.html', user=g.user.nickname)

# contact page
@app.route('/get_order')
def get_order():
    return render_template('get_order.html', user=g.user.nickname)

# contact page
@logged_in
@app.route('/finish_order')
def finish_order():
    return render_template('finish_order.html', user=g.user.nickname)


@app.route('/check_order', methods=["GET", "POST"])
def check_order():
    global shirts
    if request.method == "POST":
        nbr = request.json['index']
        check_type = request.json.get('index', None)
        shirts = get_list_of_ordered_shirts(nbr, check_type)
        return make_response(json.dumps({"success": True}))
    if request.method == 'GET':
        return make_response(json.dumps({"success": True, "shirts": shirts}))
    return render_template('check_order.html', user=str(g.user.nickname))


@app.route('/save_given_away', methods=["GET", "POST"])
def save_given_order():
    global shirts
    if request.method == "POST":
        orders = [int(item) for item in request.json['order_nbrs']]
        update_finished_orders(orders, request.json['firstname'], request.json['lastname'])
        return make_response(json.dumps({"success": True}))
    return render_template('check_order.html', user=str(g.user.nickname))

# contact page
@app.route('/summary')
def summary():
    return render_template('summary.html', user=g.user.nickname)

@app.route('/display_summary', methods=["GET", "POST"])
def display_summary():
    global html
    if request.method == "POST":
        if request.json["val"] == "not_payed":
            command = "SELECT * FROM do_zaplaty"
        elif request.json["val"] == "not_taken":
            command = ""
        elif request.json["val"] == "summary":
            command = "SELECT * FROM do_zamowienia"

        html = ""
        indeks = request.json['index']
        return make_response(json.dumps({"success": True}))
    if request.method == 'GET':
        return make_response(json.dumps({"success": True, "shirts": ""}))
    return render_template('summary.html', user=str(g.user.nickname))










# # duties page
# @app.route('/duties')
# def duties():
#     with open(os.path.join(app_location, "duties", "choiced_guys.pickle")) as f:
#         all_guys = pickle.load(f)
#         guys_wro = all_guys["wro"]
#         guys_hz = all_guys["hz"]
#
#     names = names_mapping()
#     days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
#     duties_wro = {}
#     duties_hz = {}
#     for day in days:
#         duties_wro[day] = [names[guys_wro[day]], guys_wro[day]]
#         duties_hz[day] = [names[guys_hz[day]], guys_hz[day]]
#     current_date = time.strftime("%A, %d %B %Y")
#     ip_address = request.remote_addr
#     stats.connect_db()
#     stats.send_Count(ip_address)
#     return render_template("duties.html",
#                            duties=duties_wro, dutiesHZ=duties_hz,
#                            user=str(g.user.nickname), current_date=current_date,
#                            users_wro=[], users_hz=[])
#
#
# # edit_duties page
# @app.route('/edit_duties')
# @logged_in
# def edit_duties():
#     with open(os.path.join(app_location, "duties", "choiced_guys.pickle")) as f:
#         all_guys = pickle.load(f)
#         guys_wro = all_guys["wro"]
#         guys_hz = all_guys["hz"]
#     days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
#     duties_wro = {}
#     duties_hz = {}
#     for day in days:
#         duties_wro[day] = guys_wro[day]
#         duties_hz[day] = guys_hz[day]
#     with open((os.path.join(app_location, "duties", "history_of_changes.pickle")), "r") as changes:
#         messages = pickle.load(changes)[::-1]
#     return render_template('edit_duties.html',
#                            dutiesWRO=duties_wro, dutiesHZ=duties_hz, messages=messages, user=str(g.user.nickname),
#                            users_wro=sorted([]),
#                            users_hz=sorted([u for u in [] if u != "jkochel"]))
#
#
# # function to apply changed duties
# @app.route('/save_duties', methods=["GET", "POST"])
# @logged_in
# def save_duties():
#     """
#     Function to load new commits after selecting options and click "submit"
#     buttom
#
#     """
#
#     if request.method == "POST":
#         json_data = request.json
#         with open(os.path.join(app_location, "duties", "choiced_guys.pickle")) as f:
#             current_duties = pickle.load(f)
#
#         with open(os.path.join(app_location, "duties", "history_of_changes.pickle")) as f:
#             changes = pickle.load(f)
#
#         new_messages = []
#         current_time = str((time.strftime("%A, %d %B %Y, %H:%M")))
#         days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
#         changed_guys = []
#         for day in days:
#             if json_data["wro"][day] is not False and current_duties["wro"][day] != json_data["wro"][day]:
#                 new_messages.append({"time": current_time, "user": g.user.nickname,
#                                      "change": [current_duties["wro"][day], json_data["wro"][day]], "day": day})
#                 current_duties["wro"][day] = json_data["wro"][day]
#                 changed_guys.append(json_data["wro"][day])
#                 changed_guys.append(current_duties["wro"][day])
#             if json_data["hz"][day] is not False and current_duties["hz"][day] != json_data["hz"][day]:
#                 new_messages.append({"time": current_time, "user": g.user.nickname,
#                                      "change": [current_duties["hz"][day], json_data["hz"][day]], "day": day})
#                 current_duties["hz"][day] = json_data["hz"][day]
#         with open(os.path.join(app_location, "duties", "choiced_guys.pickle"), "wb") as f:
#             pickle.dump(current_duties, f)
#         if new_messages:
#             with open(os.path.join(app_location, "duties", "history_of_changes.pickle"), "wb") as f:
#                 changes += new_messages
#                 weekly_changes = []
#                 for change in changes:
#                     change_time = change["time"]
#                     change_time = time.mktime(time.strptime(change_time, "%A, %d %B %Y, %H:%M"))
#                     change_time = datetime.datetime.fromtimestamp(int(change_time))
#                     week_ago = (datetime.datetime.now() - datetime.timedelta(days=7))
#                     if change_time > week_ago:
#                         weekly_changes.append(change)
#                 pickle.dump(weekly_changes, f)
#         with open(os.path.join(app_location, "duties", "choiced_guys.pickle"), "r") as f:
#             all_guys = pickle.load(f)
#             wro_random = all_guys["wro"]
#             hz_random = all_guys["hz"]
#
#         html = '<html>\n<head>\n<style>\ntable\n{\nwidth:70%;\ntext-align:center;\n}\ntable,th,td\n{\nborder:1px solid \
#                 #a8bbc0;\nborder-collapse:collapse;\ncolor:#68717a;\n}\nth,td,p\n{\nfont-family:"Calibri";\npadding: \
#                5px\n}\n</style>\n</head>\n<body>\n'
#         html += '<p>Dear users, <br></p><p>Duties schedule for this week has been changed:<br><br></p>'
#         html += '<table>\n<tr style="background-color:#d8d9da;">\n<th>Day</th>\n<th>WRO</th>\n<th>HZ</th></tr>'
#         html += '<tr>\n<td>Monday</td>\n<td>{}</td>\n<td>{}</td></tr>'.format(wro_random["Monday"], hz_random["Monday"])
#         html += '<tr>\n<td>Tuesday</td>\n<td>{}</td>\n<td>{}</td></tr>'.format(wro_random["Tuesday"],
#                                                                                hz_random["Tuesday"])
#         html += '<tr>\n<td>Wednesday</td>\n<td>{}</td>\n<td>{}</td></tr>'.format(wro_random["Wednesday"],
#                                                                                  hz_random["Wednesday"])
#         html += '<tr>\n<td>Thursday</td>\n<td>{}</td>\n<td>{}</td></tr>'.format(wro_random["Thursday"],
#                                                                                 hz_random["Thursday"])
#         html += '<tr>\n<td>Friday</td>\n<td>{}</td>\n<td>{}</td></tr>'.format(wro_random["Friday"], hz_random["Friday"])
#         html += '</table></body></html>'
#
#         if len(changed_guys) > 0:
#             changed_guys = [guy + "@nokia.com" for guy in changed_guys]
#             list_of_users = ["appel@nokia.com", "blaszyk@nokia.com", "pkrych@nokia.com", "chapko@nokia.com",
#                              "jkochel@nokia.com"] + changed_guys
#             send_mail("Changed duties for this week.", html, list_of_users)
#         return make_response(json.dumps({"success": True}))
#     if request.method == 'GET':
#         return make_response(json.dumps({"success": True}))
#
#
# # testlines page
# @app.route('/testlines')
# def testlines_template():
#     with open(os.path.join(app_location, "testlines", "testlines.pickle"), "r") as f:
#         testlines = pickle.load(f)
#     for testline in testlines:
#         testline["comments"] = testline["comments"].split("\n")
#         testline["hw_per_scf"] = testline["hw_per_scf"].split("\n")
#         testline["config_per_scf"] = testline["config_per_scf"].split("\n")
#     return render_template('testlines.html', testlines=testlines, nbr=len(testlines), user=g.user.nickname,
#                            users_wro=[], users_hz=[])
#
#
# # edit testline page
# @app.route('/edit_testlines')
# @logged_in
# def edit_testlines():
#     with open(os.path.join(app_location, "testlines", "testlines.pickle"), "r") as f:
#         testlines = pickle.load(f)
#     return render_template('edit_testlines.html', testlines=testlines, nbr=len(testlines), user=g.user.nickname,
#                            users_wro=[], users_hz=[])
#
#
# # function to save changes in testlines
# @app.route('/save_testlines', methods=["GET", "POST"])
# @logged_in
# def save_testline():
#     """
#     Function to load new commits after selecting options and click "submit" button
#
#     """
#     global answer
#     if request.method == "POST":
#         json_data = request.json
#         with open(os.path.join(app_location, "testlines", "testlines.pickle"), "w") as f:
#             pickle.dump(json_data["testlines"], f)
#         return make_response(json.dumps({"success": True}))
#     if request.method == 'GET':
#         return make_response(json.dumps({"success": True}))
#
#
# # stats page
# @app.route('/stat')
# def stat():
#     stats.connect_db()
#     ip_list = stats.get_CounterList()[-500:]
#     visit_list = [l[:2] for l in ip_list]
#     return render_template('stats.html', visit_list=visit_list, ip_list=ip_list, user=g.user.nickname,
#                            users_wro=[], users_hz=[])
#
#
# # function to get csv file with statistics
# @app.route('/get_stat_csv', methods=["GET", "POST"])
# def get_stat_csv():
#     global csv
#     if request.method == "POST":
#         csv = request.json[:-1]
#         return make_response()
#     if request.method == "GET":
#         response = make_response(csv)
#         csv = ""
#         response.headers["Content-Disposition"] = "attachment; filename=export.csv"
#         return response
#
#
# # commit tracker page
# @app.route('/commits')
# def commits():
#     with open(os.path.join(app_location, "commit_tracker", "tree.pickle")) as pickle_open:
#         tree = pickle.load(pickle_open)
#     return render_template('comits.html', tree_to_store=tree, user=g.user.nickname,
#                            users_wro=[], users_hz=[])
#
#
# # funstion to get chosen options from commit tracker and return list of commits
# @app.route('/get_options', methods=["GET", "POST"])
# def get_options():
#     global commits
#     if request.method == "POST":
#         json_data = request.json
#         commits = store_list_of_valid_commits(json_data)
#         return make_response()
#     if request.method == "GET":
#         return make_response(commits)
#
#
# # function to get ip address
# @app.route('/ip')
# def ip():
#     return request.remote_addr
#
#
# # TC times page
# @app.route('/planningtool')
# def tctime():
#     tcname = Tcname.query.all()
#     tcname = [nametc.tcname for nametc in tcname]
#     btssw = Btssw.query.all()
#     btslogconf = Btslogconf.query.all()
#     msm_list = []
#     scfid = []
#     btsid = []
#     rncid = []
#     for item in btslogconf:
#         msm_list += item.listoffsms.split("+")
#         scfid += [item.scfid]
#         rncid += [item.rncid]
#         btsid += [item.btsid]
#
#     msm = sorted([item for item in list(set(msm_list)) if item.strip()])
#     scfid = sorted(list(set(scfid)))
#     rncid = sorted(list(set(rncid)))
#     btsid = sorted(list(set(btsid)))
#     release = []
#     for sw in btssw:
#         if sw.release != "null" and sw.release not in release and sw.release != "empty":
#             release.append(sw.release)
#     return render_template('tctime.html', tcname=sorted(tcname), release=sorted(release),
#                            msm=msm, user=g.user.nickname, scfid=scfid,
#                            rncid=rncid, btsid=btsid,
#                            users_wro=[], users_hz=[])
#
#
# # function to prepare and send data to planningtool
# @app.route('/data', methods=["GET", "POST"])
# def prepare_data_for_planningtool():
#     global answer_tctime
#     if request.method == "POST":
#         data = request.json
#         answer_tctime = do_math_and_get_output(data)
#         return make_response()
#     if request.method == "GET":
#         return make_response(answer_tctime)
#

#
# @app.route('/tcplot')
# def tcplot():
#     tcname = Tcname.query.all()
#     btssw = Btssw.query.all()
#     btslogconf = Btslogconf.query.all()
#     msm_list = []
#     for item in btslogconf:
#         msm_list += item.listoffsms.split("+")
#     msm = [item for item in list(set(msm_list)) if item.strip()]
#     release = []
#     for sw in btssw:
#         if sw.release != "empty" and sw.release not in release:
#             release.append(sw.release)
#     return render_template('tcplot.html', tcname=tcname, release=release, msm=msm, user=g.user.nickname,
#                            users_wro=[], users_hz=[])
#
#

# @app.route('/get_taxbreak', methods=["GET", "POST"])
# @logged_in
# def load_path_to_dowload():
#     global commits, path, answer
#     if request.method == "POST":
#         json_data = request.json
#         answer = {}
#         commits = get_commits(json_data)
#         if commits is False:
#             answer["error"] = "Sorry, you can get files to taxbreak only from 20th to the end of the month."
#         else:
#             answer["error"] = ""
#             user = json_data["users"][0]
#             path = get_zip_file(commits, user)
#             answer["path"] = path
#         answer = json.dumps(answer)
#         return make_response(answer)
#     if request.method == 'GET':
#         return make_response(answer)
#
#
# @app.route('/plotdata', methods=["GET", "POST"])
# def plotData():
#     global plotAnswer
#     if request.method == "POST":
#         data = request.json
#         if 'axis2' in data:
#             plot1 = Chart(data['axis1'])
#             plot2 = Chart(data['axis2'])
#             plotAnswer = json.dumps({"plot1": plot1.plots_list, "plot2": plot2.plots_list})
#         else:
#             plot1 = Chart(data['axis1'])
#             plotAnswer = json.dumps({"plot1": plot1.plots_list})
#         return make_response()
#     if request.method == "GET":
#         return make_response(plotAnswer)
#
#
# @app.route('/mail_handler', methods=["POST"])
# def mail_handler():
#     if request.method == "POST":
#         data = request.json
#         afterjob_sendmail.send_mail(data["mail_list"], afterjob_sendmail.create_message(data["job_name"]))
#         return make_response()
#
#
# @app.route('/taxbreak')
# @logged_in
# def taxbreak_site():
#     return render_template('taxbreak.html', users=[u for u in [] if u != "jkochel"], user=g.user.nickname,
#                            users_wro=[], users_hz=[])
#
#
# # page to set availability for next week
# @app.route('/rand_duties')
# @logged_in
# def rand_duties():
#     def next_weekday(day, weekday):
#         days_ahead = weekday - day.weekday()
#         if days_ahead <= 0:
#             days_ahead += 7
#         return day + datetime.timedelta(days_ahead)
#
#     days_string = {}
#     days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
#     sunday = next_weekday(datetime.datetime.now(), 6)
#     for day in days:
#         days_string[day] = next_weekday(sunday, days.index(day)).strftime("%A, %d. %b")
#     names = names_mapping()
#     guys_wro = [names[user] for user in [] if user != "jkochel"]
#     guys_hz = [names[user] for user in []]
#     try:
#         with open(os.path.join(app_location, "duties", "availability_for_next_week.pickle"), "r") as f:
#             availability = pickle.load(f)
#             for location in availability:
#                 for day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']:
#                     new_list = [names[guy] for guy in availability[location][day]]
#                     availability[location][day] = new_list
#     except Exception:
#         availability = {"wro": {'Monday': guys_wro, 'Tuesday': guys_wro, 'Wednesday': guys_wro, 'Thursday': guys_wro,
#                                 'Friday': guys_wro},
#                         "hz": {'Monday': guys_hz, 'Tuesday': guys_hz, 'Wednesday': guys_hz, 'Thursday': guys_hz,
#                                'Friday': guys_hz}}
#     try:
#         with open((os.path.join(app_location, "duties", "history_of_rands.pickle")), "r") as changes:
#             messages = pickle.load(changes)[::-1]
#     except Exception:
#         messages = []
#     return render_template('rand_duties.html', user=g.user.nickname,
#                            users_wro=[], users_hz=[],
#                            guys_wro=guys_wro, guys_hz=guys_hz,
#                            days=days_string, availability=availability,
#                            messages=messages)
#
#
# # function to save availability
# @app.route('/save_rand_duties', methods=["GET", "POST"])
# def save_rand_duties():
#     if request.method == "POST":
#         json_data = request.json
#         names = names_mapping()
#         names = dict((y, x) for x, y in names.items())
#         for location in json_data:
#             for day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']:
#                 new_list = [names[guy] for guy in json_data[location][day]]
#                 json_data[location][day] = new_list
#
#         with open(os.path.join(app_location, "duties", "availability_for_next_week.pickle"), "w") as f:
#             pickle.dump(json_data, f)
#
#         try:
#             with open(os.path.join(app_location, "duties", "history_of_rands.pickle")) as f:
#                 changes = pickle.load(f)
#         except Exception:
#             changes = []
#
#         with open((os.path.join(app_location, "duties", "history_of_rands.pickle")), "wb") as f:
#             current_time = str((time.strftime("%A, %d %B %Y, %H:%M")))
#             new_message = {"user": g.user.nickname, "time": current_time}
#             changes.append(new_message)
#             weekly_changes = []
#             for change in changes:
#                 change_time = change["time"]
#                 change_time = time.mktime(time.strptime(change_time, "%A, %d %B %Y, %H:%M"))
#                 change_time = datetime.datetime.fromtimestamp(int(change_time))
#                 week_ago = (datetime.datetime.now() - datetime.timedelta(days=7))
#                 if change_time > week_ago:
#                     weekly_changes.append(change)
#             pickle.dump(weekly_changes, f)
#
#         return make_response(json.dumps({"success": True}))
#
#
# @app.route('/trial_rand_duties', methods=["GET", "POST"])
# def trial_rand_duties():
#     global trial_duties
#     if request.method == "POST":
#         trial_duties = request.json
#         return make_response(json.dumps({"success": True}))
#     if request.method == "GET":
#         wro = trial_duties["wro"]
#         hz = trial_duties["hz"]
#         wro_random = make_random_for_week(wro)
#         hz_random = make_random_for_week(hz)
#         return make_response(json.dumps({"wro": wro_random, "hz": hz_random}))
