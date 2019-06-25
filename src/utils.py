import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr

from flask import g
from sqlalchemy import create_engine
import pandas as pd


def get_user():
    if g.user.nickname in [None, "None"]:
        return "student"
    return g.user.nickname


def get_properties():
    engine = create_engine('mysql+mysqlconnector://{}@localhost:3306/koszulki'.format(get_user()), echo=False)
    colors = pd.read_sql_query("SELECT DISTINCT kolor  FROM produkty", engine)["kolor"].tolist()
    types = pd.read_sql_query("SELECT DISTINCT typ  FROM produkty", engine)["typ"].tolist()
    sizes = pd.read_sql_query("SELECT DISTINCT rozmiar  FROM produkty", engine)["rozmiar"].tolist()
    return {"Kolor": colors, "Typ": types, "Rozmiar": sizes}


def send_main(to, text):
    fromaddr = 'wmat@samorzad.pwr.edu.pl'
    toaddrs = to
    msg = MIMEText(text.encode("utf-8"), 'plain', "utf-8")
    msg['Subject'] = "Koszulki juwenaliowe"
    msg['From'] = formataddr(("Samorząd Studencki Wydziału Matematyki", fromaddr))
    msg['To'] = toaddrs
    username = 'wmat@samorzad.pwr.edu.pl'
    password = 'Sn86NGGA9U'
    server = smtplib.SMTP('student.pwr.wroc.pl:587')
    server.starttls()
    server.ehlo()
    server.login(username, password)
    server.sendmail(fromaddr, toaddrs, msg.as_string())
    server.quit()


def send_mail_to_confirm(to, id_order, shirts):
    shirts_text = ""
    for nbr, shirt in enumerate(shirts):
        shirts_text += "{0}. {1[0]} {1[2]} {1[1]}\n".format(nbr, shirt)
    text = u"""Cześć!\n \n \n
Twoje zamówienie nr {} zostało zarejestrowane w naszym systemie:\n
{}\n\n

Jeśli coś się nie zgadza, skontaktuj się z nami!

Pozdrawiamy,\n
Samorząd Studencki Wydziału Matematyki
""".format(id_order, shirts_text)
    send_main(to, text)


def get_list_of_ordered_shirts(indeks, check_type):
    if check_type == "nr zamowienia":
        sql_filter = "W.id_zamowienia={}".format(indeks)
    else:
        sql_filter = "S.nr_indeksu={}".format(indeks)

    engine = create_engine('mysql+mysqlconnector://{}@localhost:3306/koszulki'.format(get_user()), echo=False)
    data = pd.read_sql_query("""SELECT D.id_zamowienia, P.rozmiar, P.typ, P.kolor, D.ilosc,
CASE WHEN W.id_zamowienia IS NULL THEN 'NIE' ELSE 'TAK' END AS zaplacono
FROM studenci S
JOIN zamowienia Z ON S.nr_indeksu=Z.nr_indeksu_studenta
JOIN detale_zamowien D ON Z.id_zamowienia=D.id_zamowienia
JOIN produkty P ON D.id_produktu=P.id_produktu
LEFT JOIN wplaty W ON Z.id_zamowienia=W.id_zamowienia
WHERE {}""".format(sql_filter), engine)
    shirts = data.T.to_dict().values()
    return shirts


def update_finished_orders(orders, firstname, lastname):
    engine = create_engine('mysql+mysqlconnector://{}@localhost:3306/koszulki'.format(get_user()), echo=False)
    for order in orders:
        command = "INSERT INTO odbiory (id_zamowienia, data_odbioru imie, nazwisko) VALUES ({},DATE(NOW()),{},{})".format(
            order, firstname, lastname)
        engine.execute(command)
