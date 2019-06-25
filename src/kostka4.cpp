#include <iostream>
#include <conio.h>

//zeby nie pisac wszedzie np: std::cin, tylko samo cin
using namespace std;


class Scianka{  

	private:
		char *Tab; // 8-elementowa tablica
		const char KolorSrodka; // sta³a - œrodek pozostaje bez zmian

	public:    
		// Konstruktor przydziela pamiêæ i ustawia KolorSrodka na podany (na liœcie po dwukropku, inaczej siê nie da)
		Scianka(char kolor):KolorSrodka( kolor )
		{//KolorSrodka = kolor;
			Tab = new char[8];			
		}


		~Scianka()
		{
			cout<<"Scianka usunieta" << endl;
			free(Tab);
		}

		void ObrotC()   // obraca œciankê zgodnie z ruchem wskazówek zegara
		{
			char *temp;
			temp = new char[8];

			//for(int i=1; i<7; i++)
			//{
			//	temp[i] = Tab[i-1];
			//}
			//temp[0] = Tab[7];

			//for(int i=0; i<7; i++)
			//{
			//	Tab[i] = temp[i];
			//}

			for(int i=0; i<8; i++)
			{
				temp[i] = Tab[i];
			}
			// juz jest backup
			// 0 1 2	6 7 0
			// 7   3 =>	5   1
			// 6 5 4	4 3 2

			Tab[0] = temp[6];
			Tab[1] = temp[7];
			Tab[2] = temp[0];
			Tab[3] = temp[1];
			Tab[4] = temp[2];
			Tab[5] = temp[3];
			Tab[6] = temp[4];
			Tab[7] = temp[5];

			free(temp);
		}

		void ObrotAC()  //  obraca œciankê przeciwnie do ruchu wskazówek zegara 
		{
			char *temp;
			temp = new char[8];
			
			for(int i=0; i<8; i++)
			{
				temp[i] = Tab[i];
			}
			// juz jest backup
			// 0 1 2	2 3 4
			// 7   3 =>	1   5
			// 6 5 4	0 7 6

			Tab[0] = temp[2];
			Tab[1] = temp[3];
			Tab[2] = temp[4];
			Tab[3] = temp[5];
			Tab[4] = temp[6];
			Tab[5] = temp[7];
			Tab[6] = temp[0];
			Tab[7] = temp[1];

			free(temp);
		}

		void Wypisz()    // wypisuje œciankê na ekran
		{
			cout << Tab[0] << " " << Tab[1] << " " << Tab[2] << endl;
			cout << Tab[7] << " " << KolorSrodka << " " << Tab[3] << endl;
			cout << Tab[6] << " " << Tab[5] << " " << Tab[4] << endl;
		}

		void Wypisz(int i)    //  wypisuje i-ty wiersz œcianki (jeden z trzech) - bêdzie potrzebna do wypisania ca³ej kostki
		{
			if(i == 1)
			{
				cout << Tab[0] << " " << Tab[1] << " " << Tab[2] ;
			}
			else if(i == 2)
			{
				cout << Tab[7] << " " << KolorSrodka << " " << Tab[3] ;
			}
			else if(i == 3)
			{
				cout << Tab[6] << " " << Tab[5] << " " << Tab[4] ;
			}
			else
			{
				cout << "Nie ma takiego wiersza (sa tylko 1,2,3)" ;
			}
		}

		void Set(int i,char k)
		{
			Tab[i] = k;
		}

		char Get(int i)
		{
			return Tab[i];
		}

		// bêdzie potrzebna do zmiany kolorów na s¹siednich œciankach podczas obrotu, z za³o¿enia ma dzia³aæ wed³ug schematu 
		// A[ai]=>B[bi]=>C[ci]=>D[di]=>A[ai].

		friend void Obrot(Scianka &A,int a1,int a2,int a3,Scianka &B,int b1,int b2,int b3,Scianka &C,int c1,int c2,int c3,Scianka &D,int d1,int d2,int d3)
		{
			int temp1, temp2, temp3;

			temp1 = B.Get(b1);
			temp2 = B.Get(b2);
			temp3 = B.Get(b3);

			B.Set(b1, A.Get(a1));
			B.Set(b2, A.Get(a2));
			B.Set(b3, A.Get(a3));

			A.Set(a1, D.Get(d1));
			A.Set(a2, D.Get(d2));
			A.Set(a3, D.Get(d3));

			D.Set(d1, C.Get(c1));
			D.Set(d2, C.Get(c2));
			D.Set(d3, C.Get(c3));

			C.Set(c1, temp1);
			C.Set(c2, temp2);
			C.Set(c3, temp3);
		}
};



class Kostka{  
private:   
	
	// znaki oznaczajace kolory pol
	char white;
	char red;
	char blue;
	char orange;
	char green;
	char yellow;

	// scianki z kolorem w srodku
	Scianka Up;
	Scianka Left;
	Scianka Front;
	Scianka Right;
	Scianka Back;
	Scianka Down;

public:

	Kostka(char _wh, char _re, char _bl, char _or, char _gr, char _ye):Up(_wh),Left(_re),Front(_bl),Right(_or),Back(_gr),Down(_ye)
	{		

		// znaki oznaczajace kolory pol
		 white = _wh; //'W';
		 red = _re;//'R';
		 blue = _bl;//'B';
		 orange = _or;//'O';
		 green = _gr;//'G';
		 yellow = _ye;//'Y';

		// scianki z kolorem w srodku
		

		//kolorowanie pozostalych 8 pol na sciankach
		for(int i = 0; i<8; i++)
		{
			Up.Set(i, white);
			Left.Set(i, red);
			Front.Set(i, blue);
			Right.Set(i, orange);
			Back.Set(i, green);
			Down.Set(i, yellow);
		}

	}//konstruktor



    void U()//gorna zgodnie
	{
		cout << "Ruch U" << endl;
		Up.ObrotC();
		Obrot(Front,0,1,2,Left,0,1,2,Back,0,1,2,Right,0,1,2);
	}
    void u()//gorna przeciwnie
	{
		cout << "Ruch u" << endl;
		Up.ObrotAC();
		Obrot(Front,0,1,2,Right,0,1,2,Back,0,1,2,Left,0,1,2);
	}
	void L()//lewe
	{
		cout << "Ruch L" << endl;
		Left.ObrotC();
		Obrot(Front,0,7,6,Down,0,7,6,Back,2,3,4,Up,0,7,6);
	}
	void l()
	{
		cout << "Ruch l" << endl;
		Left.ObrotAC();
		Obrot(Front,0,7,6,Up,0,7,6,Back,2,3,4,Down,0,7,6);
	}
	void F()//przednie
	{
		cout << "Ruch F" << endl;
		Front.ObrotC();
		Obrot(Up,6,5,4,Right,0,7,6,Down,0,1,2,Left,2,3,4);
	}
    void f()
	{
		cout << "Ruch f" << endl;
		Front.ObrotAC();
		Obrot(Up,6,5,4,Left,2,3,4,Down,0,1,2,Right,0,7,6);
	}
    void R()//prawe
	{
		cout << "Ruch R" << endl;
		Right.ObrotC();
		Obrot(Back,0,7,6,Down,2,3,4,Front,2,3,4,Up,2,3,4);
	}
    void r()
	{
		cout << "Ruch r" << endl;
		Right.ObrotAC();
		Obrot(Back,0,7,6,Up,2,3,4,Front,2,3,4,Down,2,3,4);
	}
    void B()//z tylu
	{
		cout << "Ruch B" << endl;
		Back.ObrotC();
		Obrot(Right,2,3,4,Down,6,5,4,Left,0,7,6,Up,0,1,2);
	}
    void b()
	{
		cout << "Ruch b" << endl;
		Back.ObrotAC();
		Obrot(Right,2,3,4,Up,0,1,2,Left,0,7,6,Down,6,5,4);
	}
    void D()//dolne obroty
	{
		cout << "Ruch D" << endl;
		Down.ObrotC();
		Obrot(Front,6,5,4,Left,6,5,4,Back,6,5,4,Right,6,5,4);
	}
    void d()
	{
		cout << "Ruch d" << endl;
		Down.ObrotAC();
		Obrot(Front,6,5,4,Right,6,5,4,Back,6,5,4,Left,6,5,4);
	} 

	void Wypisz()
	{
		cout << ". . .  " ;
		Up.Wypisz(1);
		cout << "  . . ." << "  . . . " << endl;
		cout << ". . .  " ;
		Up.Wypisz(2);
		cout << "  . . ." << "  . . . " << endl;
		cout << ". . .  " ;
		Up.Wypisz(3);
		cout << "  . . ." << "  . . . " << endl;

		Left.Wypisz(1); cout << "  "; Front.Wypisz(1); cout << "  "; Right.Wypisz(1); cout << "  "; Back.Wypisz(1);
		cout << endl;
		Left.Wypisz(2); cout << "  "; Front.Wypisz(2); cout << "  "; Right.Wypisz(2); cout << "  "; Back.Wypisz(2);
		cout << endl;
		Left.Wypisz(3); cout << "  "; Front.Wypisz(3); cout << "  "; Right.Wypisz(3); cout << "  "; Back.Wypisz(3);
		cout << endl;

		cout << ". . .  " ;
		Down.Wypisz(1);
		cout << "  . . ." << "  . . . " << endl;
		cout << ". . .  " ;
		Down.Wypisz(2);
		cout << "  . . ." << "  . . . " << endl;
		cout << ". . .  " ;
		Down.Wypisz(3);
		cout << "  . . ." << "  . . . " << endl;





	}


	bool CzyUlozona()
	{
		bool ulozono = false;
		int ulozonoscianek = 0;

		if(Up.Get(1)==Up.Get(2)&&Up.Get(2)==Up.Get(3)&&Up.Get(3)==Up.Get(4)&&Up.Get(4)==Up.Get(5)&&Up.Get(5)==Up.Get(6)&&Up.Get(6)==Up.Get(7)&&Up.Get(7)==Up.Get(0) )
			ulozonoscianek++;

		if(Left.Get(1)==Left.Get(2)&&Left.Get(2)==Left.Get(3)&&Left.Get(3)==Left.Get(4)&&Left.Get(4)==Left.Get(5)&&Left.Get(5)==Left.Get(6)&&Left.Get(6)==Left.Get(7)&&Left.Get(7)==Left.Get(0) )
			ulozonoscianek++;

		if(Front.Get(1)==Front.Get(2)&&Front.Get(2)==Front.Get(3)&&Front.Get(3)==Front.Get(4)&&Front.Get(4)==Front.Get(5)&&Front.Get(5)==Front.Get(6)&&Front.Get(6)==Front.Get(7)&&Front.Get(7)==Front.Get(0) )
			ulozonoscianek++;

		if(Right.Get(1)==Right.Get(2)&&Right.Get(2)==Right.Get(3)&&Right.Get(3)==Right.Get(4)&&Right.Get(4)==Right.Get(5)&&Right.Get(5)==Right.Get(6)&&Right.Get(6)==Right.Get(7)&&Right.Get(7)==Right.Get(0) )
			ulozonoscianek++;

		if(Back.Get(1)==Back.Get(2)&&Back.Get(2)==Back.Get(3)&&Back.Get(3)==Back.Get(4)&&Back.Get(4)==Back.Get(5)&&Back.Get(5)==Back.Get(6)&&Back.Get(6)==Back.Get(7)&&Back.Get(7)==Back.Get(0) )
			ulozonoscianek++;

		if(Down.Get(1)==Down.Get(2)&&Down.Get(2)==Down.Get(3)&&Down.Get(3)==Down.Get(4)&&Down.Get(4)==Down.Get(5)&&Down.Get(5)==Down.Get(6)&&Down.Get(6)==Down.Get(7)&&Down.Get(7)==Down.Get(0) )
			ulozonoscianek++;

		if(ulozonoscianek == 6)
			ulozono = true;

		cout << endl << "Liczba ulozonych scianek: " << ulozonoscianek << endl;
		
		return ulozono;
	}


	void Ruch(char c)
	{
		if(c=='U')
		{
			U();
			Wypisz();
		}
		else if(c=='u')
		{
			u();
			Wypisz();
		}
		else if(c=='L')
		{
			L();
			Wypisz();
		}
		else if(c=='l')
		{
			l();
			Wypisz();
		}
		else if(c=='F')
		{
			F();
			Wypisz();
		}
		else if(c=='f')
		{
			f();
			Wypisz();
		}
		else if(c=='R')
		{
			R();
			Wypisz();
		}
		else if(c=='r')
		{
			r();
			Wypisz();
		}
		else if(c=='B')
		{
			B();
			Wypisz();
		}
		else if(c=='b')
		{
			b();
			Wypisz();
		}
		else if(c=='D')
		{
			D();
			Wypisz();
		}
		else if(c=='d')
		{
			d();
			Wypisz();
		}
		else
		{
			//cout << "Taki ruch nie jest poprawny." << endl;
		}
	}
};





int main()
{
	cout << "Kostka na poczatku: " << endl << endl;

    Kostka kostka('W','R','B','O','G','Y');
	kostka.Wypisz();

	bool sprawdz = kostka.CzyUlozona();
	if(sprawdz)
	{
		cout << endl << "Kostka JEST ulozona!" << endl;
	}
	else
	{
		cout << endl << "Kostka nie jest jeszcze ulozona." << endl;
	}

	int zabawatrwa = 1;
	while(zabawatrwa)
	{
		char znakyq = 'q';

		cout << "Czy chcesz podac nowa serie ruchow (np.: UuLlFfRrBbDd)?" << endl ;
		cout << "  y - tak" << endl ;
		cout << "  q - nie" << endl ;
		cin >> znakyq;

		if(znakyq == 'y')
		{//zabawa trwa
			
			const int max_ruchow = 99;
			char ciag_znakow[max_ruchow];

			cout << "Wykonaj nastepujace ruchy: " << endl ;
			cin >> ciag_znakow;

			for(int i = 0; i < max_ruchow; i++) {
				kostka.Ruch(ciag_znakow[i]);				
			}

			sprawdz = kostka.CzyUlozona();
			if(sprawdz)
			{
				cout << endl << "Kostka JEST ulozona!" << endl;
			}
			else
			{
				cout << endl << "Kostka nie jest jeszcze ulozona." << endl;
			}







		}
		else
		{
			//skoncz
			zabawatrwa = 0;
		}

	}




	cout << endl;
	system("PAUSE");
    return 0;
}
