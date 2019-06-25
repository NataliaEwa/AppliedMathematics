from itertools import combinations
import sys
import re


class R(object):
    def __init__(self, opor):
        self.R = opor

    def opor(self):
        return self.R

    def __str__(self):
        return str(self.R)+" Ohm"


class Szeregowo(object):
    def __init__(self, *obwody):
        self.obwody = obwody

    def opor(self):
        return sum(obwod.opor() for obwod in self.obwody)

    def __str__(self):
        return 'Szeregowo(' + ", ".join(str(obwod) for obwod in self.obwody) + ')'


class Rownolegle(object):
    def __init__(self, *obwody):
        self.obwody = obwody

    def opor(self):
        return 1.0/sum(1.0/obwod.opor() for obwod in self.obwody)

    def __str__(self):
        return 'Rownolegle(' + ", ".join(str(obwod) for obwod in self.obwody) + ')'


def wszystkie_nawiasowania(lista, znalezione, szukany_wynik, najblizszy):
    if(len(lista)==1):
        yield lista[0]
    else:
        for i in range(0,len(lista)-1):
            break_ = False
            x1=lista[i]
            x2=lista[i+1]
            if type(x1) is int:
                x1 = R(x1)
            if type(x2) is int:
                x2 = R(x2)
            if x1.opor() + x2.opor() > szukany_wynik:
                opory = [Rownolegle(x1,x2)]
            elif x1.opor()<szukany_wynik and x2.opor()<szukany_wynik:
                opory = [Szeregowo(x1,x2)]
            else:
                opory = [Rownolegle(x1,x2), Szeregowo(x1,x2)]  
            for op in opory:
                for a in wszystkie_nawiasowania(lista[:i]+[op]+lista[i+2:], znalezione, szukany_wynik, najblizszy):
                    if a.opor() == szukany_wynik or abs(a.opor()-szukany_wynik)<=0.5:
                        znalezione.append(a)
                        break_ = True
                    if abs(a.opor()-szukany_wynik) < najblizszy["delta"]:
                        najblizszy["delta"] = abs(a.opor()-szukany_wynik)
                        najblizszy["polaczenie"] = a
                    if break_: break
                    yield a
                if break_: break
            if break_: break
        if break_:
            yield znalezione[0]


def przejdz_przez_wszytskie_opcje(x,znalezione, szukany_wynik, najblizszy):
    for i in wszystkie_nawiasowania(x, znalezione, szukany_wynik, najblizszy):
        yield i

def znajdz_najmniejszy_obwod(lista, znalezione, szukany_wynik, ilosc, najblizszy):
    checked_combinations = []
    for i in combinations(lista, ilosc):
		if list(i) not in checked_combinations: 
			checked_combinations.append(list(i))
			for x in przejdz_przez_wszytskie_opcje(list(i),znalezione, szukany_wynik, najblizszy):
				pass
			if len(znalezione) > 0:
				return znalezione[0]

def projekt(oporniki, szukany_opor):
    znalezione = []
    znaleziony_wynik = None
    lista_opornikow = []
    najblizszy = {"delta": sys.maxint, "polaczenie": ""}
    for key in oporniki:
        for i in range(oporniki[key]):
            lista_opornikow.append(key)
    for i in lista_opornikow:
        if i==szukany_opor:
            return R(i)
    for i in range(2, len(lista_opornikow)+1):
        znaleziony_wynik = znajdz_najmniejszy_obwod(lista_opornikow, znalezione, szukany_opor, i, najblizszy)
        if znaleziony_wynik is not None:
            return znaleziony_wynik

    for i in lista_opornikow:
        if abs(i - szukany_opor) < najblizszy["delta"]:
            return R(i)
    return najblizszy["polaczenie"]


if __name__ == "__main__":
    szukany_opor = 82
    oporniki = {1000000:2, 330000:2, 100000:2,  68000:2, 22000:2, 10000:5, 2200:5, 1000:2, 680:2, 220:20, 56:2, 10:2, 2:2}
    znaleziony_obwod = projekt(oporniki, szukany_opor)
    print "Polaczenie: ", znaleziony_obwod
    print "Szukany opor:", szukany_opor, "\nZnaleziony opor:", znaleziony_obwod.opor()