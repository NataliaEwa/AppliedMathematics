#!/usr/bin/env python3
"""     Jest to prgram, który tworzy i modyfikuje grafy skierowane za pomocą czytania poleceń znajdujących
        się w pliku lub wpisywanych w konsololi. Rozumiane polecenia są nastepujące:
        1)"insert node ID" - dopisanie nowego wezła o zadanym identyfikatorze ID. Program odpowiednio reaguje
        gdy próbuje sie wpisac wezeł o juz uzytym identyfikatorze
        2)"delete node ID" - usuniecie wezła o podanym identyfikatorze oraz wszystkich łuków z nim incydentnych.
        Program odpowiednio reaguje gdy próbuje sie usunac nieistniejacy wezeł.
        3)"insert arc ID from ID1 to ID2" - dopisanie nowego łuku o identyfikatorze ID. Łuk prowadzi od wezła o
        identyfikatorze ID1 do wezła o identyfikatorze ID2. Program odpowiednio reaguje gdy próbuje sie wpisac
        łuk o juz uzytym identyfikatorze lub którys z wezłów koncowych nie istnieje.
        4)"delete arc ID" - usuniecie łuku o podanym identyfikatorze. Program odpowiednio reaguje gdy próbuje
        sie usunac nieistniejacy łuk.
        5)"nodes" - Wydrukowanie identyfikatorów wszystkich wezłów znajdujacych sie w przechowywanym grafie.
        6)"arcs" - Wydrukowanie identyfikatorów wszystkich łuków znajdujacych sie w przechowywanym grafie oraz
        informacji jakie wezły łaczy dany łuk.
        Ponadto przy następujących komendach:
        1)"path from ID1 to ID2" - sprawdza czy istnieje połaczenie od wezła ID1 do wezła ID2 (bezposrednie lub
        posrednie). Jesli jest takie połaczenie, to program drukuje przez które wezły ono przechodzi.
        W przeciwnym przypadku pojawia sie komunikat, ze nie ma takiego połaczenia.
        2) "shortest path from ID1 to ID2" - sprawdza czy istnieje połaczenie od wezła ID1 do wezła ID2 (bezposrednie lub
        posrednie). Jesli jest takie połaczenie, to wyszukuje najkrótsze i drukuje przez które wezły ono przechodzi.
        W przeciwnym przypadku pojawia sie komunikat, ze nie ma takiego połaczenia.
        3)"exit" - Opuszczenie głównej petli programu.
"""
def lista_sasiadow(G):
	lista_sasiedztwa={}
	for i in G[0]: lista_sasiedztwa[i]=[]
	for x in G[1]:
		lista_sasiedztwa[x[0]].append(x[1])
	return lista_sasiedztwa
def path(u,ID2,droga):
    if u==ID2: 
        return True
    odwiedzone[u]=True
    for x in S[u]:
        if x not in odwiedzone:
            if path(x,ID2,droga)==True: 
                droga+=x
                return True
    return False
graph={}
graph.clear()
arcs=[]
while True:    
        a=input("Wpisz polecenie: ")
        order=a.split(' ')    
        if order[:2]==['insert','node']:
                if order[2] not in graph: graph[order[2]]=[]
                else: print("ten wierzchołek jest już w grafie")
        if order[:2]==['delete', 'node']:
                if order[2] in graph:
                        graph.pop(order[2])
                        for x in graph.values():
                                if order[2] in x:
                                        x.remove(order[2])
                        for x in arcs:
                                if x[0]==order[2]:
                                        arcs.remove(x)
        else: print ( "nie ma takiego wierzchołka")
    if order[:2]==['insert','arc']:
        if (order[4] in graph and order[6] in graph):
            if order[2] not in arcs:
                arcs[order[2]]=[order[4],order[6]]
            else: print ("taka krawędź już istnieje")  
        else: print ("conajmniej jeden z wierzchołków nie istnieje")
    if order[:2]==['delete','arc']:
        start=arcs[order[2]][0]
        end=arcs[order[2]][1]
        if start in graph:
                graph[start].remove(end)
        if a==0: print ("nie ma takiego łuku")
        else:	
            for x in G[1]:
                if x[2]==s[2]:
            	    G[1].remove(x)
    if s[0]=='nodes': print (G[0])
    if s[0]=='arcs': print(G[1]) 
    if s[0]=='path':
        S=lista_sasiadow(G)
        odwiedzone={}
        droga=[]
        if path(s[2],s[4],droga)==True:
            droga.append(s[2])
            print(droga[::-1])
        else: print("nie ma takiej drogi")
    if s[0]=='exit': break
print("zakończono")
