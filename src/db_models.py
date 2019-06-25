from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres99@localhost/stat_db'


db = SQLAlchemy(app)
db.init_app(app)


class Basicinfo(db.Model):


    id = db.Column(db.Integer, primary_key=True)

    tcname_id = db.Column(db.Integer, db.ForeignKey('tcname.id'))
    tcname = db.relationship('Tcname', backref=db.backref('basicinfos', lazy='dynamic'))

    timestamp_time = db.Column(db.Time)

    timestamp_date = db.Column(db.Date)

    tcexecutiontime = db.Column(db.Interval)

    btslogconf_id = db.Column(db.Integer, db.ForeignKey('btslogconf.id'))
    btslogconf = db.relationship('Btslogconf', backref=db.backref('basicinfos', lazy='dynamic'))

    btssw_id = db.Column(db.Integer, db.ForeignKey('btssw.id'))
    btssw = db.relationship('Btssw', backref=db.backref('basicinfos', lazy='dynamic'))

    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    user = db.relationship('User', backref=db.backref('basicinfos', lazy='dynamic'))

    ignoreby_id = db.Column(db.Integer, db.ForeignKey('ignoreby.id'))
    ignoreby = db.relationship('Ignoreby', backref=db.backref('basicinfos', lazy='dynamic'))

    tcverdict = db.Column(db.Integer)


    def __init__(self,
                 timestamp_time,
                 timestamp_date,
                 tcexecutiontime,
                 tcverdict,
                 tcname,
                 btslogconf,
                 btssw,
                 user,
                 ignoreby
                 ):
        self.timestamp_time = timestamp_time
        self.timestamp_date = timestamp_date
        self.tcexecutiontime = tcexecutiontime
        self.tcverdict = tcverdict
        self.tcname = tcname
        self.btslogconf = btslogconf
        self.btssw = btssw
        self.user = user
        self.ignoreby = ignoreby


class Tcname(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    tcname = db.Column(db.String(200))

    def __init__(self, tcname):
        self.tcname = tcname



class User(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    username = db.Column(db.String(50))

    def __init__(self, username):
        self.username = username



class Btssw(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    release = db.Column(db.String(10))

    build_number = db.Column(db.String(30))

    def __init__(self, release, build_number):
        self.release = release
        self.build_number = build_number



class Ignoreby(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    reason = db.Column(db.String(100))

    def __init__(self, reason):
        self.reason = reason





class Btslogconf(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    btsid = db.Column(db.Integer)

    nbrofcells = db.Column(db.Integer)

    nbrofphones = db.Column(db.Integer)

    listofrfs = db.Column(db.String(50))

    nbrofrfs = db.Column(db.Integer)

    listoffsms = db.Column(db.String(25))

    nbroffsms = db.Column(db.Integer)

    listofesmextcards = db.Column(db.String(50))

    nbrofesmextcards = db.Column(db.Integer)

    trs = db.Column(db.String(20))

    nbroflcg = db.Column(db.Integer)

    testlinename = db.Column(db.String(50))

    scfid = db.Column(db.String(10))

    btsconfiguration = db.Column(db.String(50))

    fdeenabled = db.Column(db.Boolean)

    transportmode = db.Column(db.String(50))

    rncid = db.Column(db.String(50))

    location = db.Column(db.String(50))

    listofmsmextcards = db.Column(db.String(50))

    nbrofmsmextcards = db.Column(db.Integer)

    conftype = db.Column(db.String(50))

    btslogconf_hash = db.Column(db.String(256))


    def __init__(self,
                 btsid,
                 nbrofcells,
                 nbrofphones,
                 listofrfs,
                 nbrofrfs,
                 listoffsms,
                 nbroffsms,
                 listofesmextcards,
                 nbrofesmextcards,
                 trs,
                 nbroflcg,
                 testlinename,
                 scfid,
                 btsconfiguration,
                 fdeenabled,
                 transportmode,
                 rncid,
                 location,
                 listofmsmextcards,
                 nbrofmsmextcards,
                 conftype,
                 btslogconf_hash
                 ):

        self.btsid = btsid
        self.nbrofcells = nbrofcells
        self.nbrofphones = nbrofphones
        self.listofrfs = listofrfs
        self.nbrofrfs = nbrofrfs
        self.listoffsms = listoffsms
        self.nbroffsms = nbroffsms
        self.listofesmextcards = listofesmextcards
        self.nbrofesmextcards = nbrofesmextcards
        self.trs = trs
        self.nbroflcg = nbroflcg
        self.testlinename = testlinename
        self.scfid = scfid
        self.btsconfiguration = btsconfiguration
        self.fdeenabled = fdeenabled
        self.transportmode = transportmode
        self.rncid = rncid
        self.location = location
        self.listofmsmextcards = listofmsmextcards
        self.nbrofmsmextcards = nbrofmsmextcards
        self.conftype = conftype
        self.btslogconf_hash = btslogconf_hash




class Cell(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    btscellid = db.Column(db.Integer)

    vamenabled = db.Column(db.Boolean)

    maxcarrierpower = db.Column(db.Integer)

    defaultcarrier = db.Column(db.Integer)

    cellclass_id = db.Column(db.Integer, db.ForeignKey('cellclass.id'))
    cellclass = db.relationship('Cellclass', backref=db.backref('cells', lazy='dynamic'))

    btslogconf_id = db.Column(db.Integer, db.ForeignKey('btslogconf.id'))
    btslogconf = db.relationship('Btslogconf', backref=db.backref('cells', lazy='dynamic'))



    def __init__(self,
                 cellclass,
                 btslogconf,
                 btscellid,
                 vamenabled,
                 maxcarrierpower,
                 defaultcarrier
                 ):

        self.cellclass = cellclass
        self.btslogconf = btslogconf
        self.btscellid = btscellid
        self.vamenabled = vamenabled
        self.maxcarrierpower = maxcarrierpower
        self.defaultcarrier = defaultcarrier


class Cellclass(db.Model):

    id = db.Column(db.Integer, primary_key=True)

    hsdpa64quamallowed = db.Column(db.Integer)

    adminpicstate = db.Column(db.String(50))

    picstate = db.Column(db.String(50))

    fdpchenabled = db.Column(db.Integer)

    cpcenabled = db.Column(db.Integer)

    cellrange = db.Column(db.String(50))

    dcellhsdpaenabled = db.Column(db.Integer)

    mimoenabled = db.Column(db.Integer)

    dbandhsdpaenabled = db.Column(db.Integer)

    mimowith64qamusage = db.Column(db.Integer)

    hsupa16qamallowed = db.Column(db.Integer)

    hsupa2msttienabled = db.Column(db.Integer)

    maxtotaluplinksymbolrate = db.Column(db.String(50))

    prxmaxtargetbts = db.Column(db.String(50))

    prxmaxorigtargetbts = db.Column(db.String(50))

    cellclass_hash = db.Column(db.String(300))

    def __init__(self,
                 hsdpa64quamallowed,
                 adminpicstate,
                 picstate,
                 fdpchenabled,
                 cpcenabled,
                 cellrange,
                 dcellhsdpaenabled,
                 mimoenabled,
                 dbandhsdpaenabled,
                 mimowith64qamusage,
                 hsupa16qamallowed,
                 hsupa2msttienabled,
                 maxtotaluplinksymbolrate,
                 prxmaxtargetbts,
                 prxmaxorigtargetbts,
                 cellclass_hash
                 ):

        self.cellclass_hash = cellclass_hash
        self.hsdpa64quamallowed = hsdpa64quamallowed
        self.adminpicstate = adminpicstate
        self.picstate = picstate
        self.fdpchenabled = fdpchenabled
        self.cpcenabled = cpcenabled
        self.cellrange = cellrange
        self.dcellhsdpaenabled = dcellhsdpaenabled
        self.mimoenabled = mimoenabled
        self.dbandhsdpaenabled = dbandhsdpaenabled
        self.mimowith64qamusage = mimowith64qamusage
        self.hsupa16qamallowed = hsupa16qamallowed
        self.hsupa2msttienabled = hsupa2msttienabled
        self.maxtotaluplinksymbolrate = maxtotaluplinksymbolrate
        self.prxmaxtargetbts = prxmaxtargetbts
        self.prxmaxorigtargetbts = prxmaxorigtargetbts
        self.cellclass_hash = cellclass_hash

