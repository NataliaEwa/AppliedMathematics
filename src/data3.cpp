#include <iostream>
#include <conio.h>
#include <queue>

//zeby nie pisac wszedzie np: std::cin, tylko samo cin
using namespace std;

//strukura Data
struct Data
{
	int dzien;
	int miesiac;
	int rok;
};

//wypisywanie na ekran
void wypisz(Data wypisuje)
{
	cout<<wypisuje.dzien<<'/'<<wypisuje.miesiac<<'/'<<wypisuje.rok<<endl;
}


//sprawdza czy rok jest przestepny
bool czyPrzestepny(int rok)
{
	return (!(rok%4) && (rok%100) || !(rok%400));
}

// zwraca prawde jesli data jest ok a falsz, jesli nie ok (1 - prawda lub 0 - falsz)
bool czyPoprawnaData(Data data)
{
	//tablica zawierajaca kolejne dlugosci miesiecy
    int dlugoscMiesiaca[]= {31,28,31,30,31,30,31,31,30,31,30,31};

	if (!data.rok || !data.miesiac || !data.dzien || data.miesiac>12)
		//blad danych
		return 0;

	//jesli luty w roku przestepnym - bedzie dluzszy (29 dni)
	if (czyPrzestepny(data.rok) && data.miesiac==2)
		dlugoscMiesiaca[1]++;

	if (data.dzien>dlugoscMiesiaca[data.miesiac-1])
		//jesli wprowadzony dzien wychodzi poza ilosc dni danego miesiaca to tez falsz
		return 0;

	//data poprawna
	return 1;
}

void wypiszJutrzejszaDate(Data data)
{
	Data jutro;

	//tablica zawierajaca kolejne dlugosci miesiecy
    int dlugoscMiesiaca[]= {31,28,31,30,31,30,31,31,30,31,30,31};

	//jesli luty w roku przestepnym - bedzie dluzszy (29 dni)
	if (czyPrzestepny(data.rok) && data.miesiac==2)
		dlugoscMiesiaca[1]++;

	//jesli bylby to dzien dalszy, niz w tym miesiacu jest dni to zmiana miesiaca
	if((data.dzien+1)>dlugoscMiesiaca[data.miesiac-1])
	{
		//sprawdzamy czy to byl ostatni dzien roku
		if((data.dzien == 31)&&(data.miesiac==12))
		{
			jutro.dzien = 1;
			jutro.miesiac = 1;
			jutro.rok = data.rok + 1;
		}

		//nie byl to ostatni dzien roku
		else
		{
			jutro.dzien = 1;
			jutro.miesiac = data.miesiac + 1;
		}
	}
	//wszystko bez zmian poza dniem
	else
	{
		jutro.dzien = data.dzien + 1;
		jutro.miesiac = data.miesiac;
		jutro.rok = data.rok;
	}

	

	//wypisz
	cout << "Nastepny dzien to: ";
	wypisz(jutro);
}


int main()
{
    char odp;

	//zwieksza sie z kazda podana data, jest rowniez iteratorem tablicy
	int ile_podano = 1;

	//kolejka obiektow typu data (beda dodawane kolejno, jesli sa poprawne)
	queue < Data > kolejka;
    
	//stworzenie obiektu typu Data o nazwie data
	Data data;
	//data zawiera 3 pola: dzien, miesiac i rok
	//sa to inty, odwolujemy sie do nich jak do czesci daty, czyli np: data.dzien

	//petla do-while (pierwszy raz wykona sie na pewno, kolejne jesli nie bedzie N lub n)
    do {
		cout<<"Wprowadzanie daty nr: " << ile_podano << endl;

        cout<<"Wprowadz dzien: \n";
		//wczytanie do zmiennej uzywajac cin >> [zmienna_do_zapisania_danych]
        cin>> data.dzien;

        cout<<"Wprowadz miesiac: \n";
        cin>> data.miesiac;

        cout<<"Wprowadz rok: \n";
        cin>> data.rok;

        if (czyPoprawnaData(data))
		{			
            cout<<"Data poprawna: ";
			wypisz(data);

			//dodanie do tablicy dat
			kolejka.push(data);

			//zwiekszenie licznika
			ile_podano++;

			//data poprawna, wiec wywolanie funkcji, ktora wypisze date dnia nastepnego
			wypiszJutrzejszaDate(data);
		}
        else
            cout<<"Data jest niepoprawna!"<<endl;

        cout<<"Czy dodac jeszcze jedna date? (T/N)"<<endl;
        cin>>odp;

    } while (odp != 'n' && odp != 'N');

	int rozmiar_kolejki = kolejka.size();
	cout << "W kolejce znajduje sie dat: " << rozmiar_kolejki << endl;

	Data najwczesniejsza;
	Data porownuje;

	//pierwsza data jest poki co najwczesniejsza
	najwczesniejsza = kolejka.front();

	//usuwam pierwszy element z tablicy
	kolejka.pop();

	//wykonanie petli tyle razy, ile podano dat minus pierwsza
	for(int i = 0; i < ile_podano - 2; i++)
	{
		//odczytanie pierwszej daty z kolejki
		porownuje = kolejka.front();

		//usuwam pierwszy element z tablicy
		kolejka.pop();

		//porownuje rok z kolejnym elementem w kolejce
		if(porownuje.rok <= najwczesniejsza.rok)
		{
			//porownuje teraz miesiac
			if(porownuje.miesiac <= najwczesniejsza.miesiac)
			{
				//jesli dzien bedzie nizszy, to mamy nowa najwczesniejsza date
				if(porownuje.dzien < najwczesniejsza.dzien)
				{
					najwczesniejsza = porownuje;
					//usuwam z kolejki porownany element
					//kolejka.pop();
				}
			}

		}
		else
		{
			//najwczesniejsza juz jest w najwczesniejsza
		}

	}








	cout << "Najwczesniejsza sposrod nich to: ";
	wypisz(najwczesniejsza);

	//system czeka na dowolny przycisk
	system("PAUSE");
	//program zakonczy dzialanie, jesli wybrano N lub n
    return 0;
}