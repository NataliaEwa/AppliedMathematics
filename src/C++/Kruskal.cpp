#include <iostream>
#include <ctime> //do time(NULL)
#include <cstdlib> //do srand()
#include <cmath> //dla pow();
#include <tuple>
#include <vector>
#include <algorithm> //do sort()

using namespace std;

class UnionFind
{
private:
	int *set; //tablica przechowuj¹ca indeksy elemento nadrzednych
public:
	UnionFind(int n) //konstruktor pobierajacy rozmiar jako argument
	{
		set = new int[n]; //inicjacja tablicy
		for (int i = 0; i < n; i++) //wypelnienie tablicy wartosciami od 0 do n-1
			set[i] = i;
	}

	~UnionFind() //destruktor tablicy
	{
		delete[] set;
	}

	int FindSet(int e) //poszukiwanie nazwe zbioru do ktorego nalezy e, tzn najmniejsza wartosc z danego zbioru
	{
		while (e != set[e]) //poszukiwanie pierwszego elementu (ktory jest najmniejszy)
			e = set[e];
		return e;
	}
	void Union(int x, int y)
	{
		int i = FindSet(x);
		int j = FindSet(y);

		//if (i != j) //jesli nie naleza do tego samego zbioru
		//{
			if (i<j) //to mniejszy korzen ma pozostac pierwszy  - wiekszy korzen doklejany jest do zbioru mniejszego korzenia
			{
				set[j] = i;
			}
			else
			{
				set[i] = j;
			}
		//}
	}
};

vector<tuple<int, int, double>> generatorGrafow(int n, double p)
{
	vector<tuple<int, int, double>> tablicaKrawedzi;
	//zarezerwowanie przestrzeni dla najwiekszej mozliwej liczby krawedzi wzglêdem prawdopodobieñstwa z 10 % maeginesem
	tablicaKrawedzi.reserve(n / 2 * (n - 1)*p*1.1);
	//wypelnianie tablicy krawedzi - dla i{0,..,m-1}, j{i,...,n-1) losujemy czy dana krawedz ma istniec 
	int i, j;
	for (i = 0; i < n; i++)
	{
		for (j = i; j < n; j++)
		{
			//dla kazdej z poszukiwanych krawedzi nalezy dokonac losowania i sprawdzenia czy jest mniejsze niz prawdopodobienstwo
			if ((double)rand() / RAND_MAX < p)
			{
				//krawedz ma istniec wiec losujemy wage z zakresu [0,1] i tworzymy tuple zawierajacy: (wierzcholek startowy, wierzcholek koncowy, waga krawedzi)
				tablicaKrawedzi.push_back(make_tuple(i, j, (double)rand() / RAND_MAX)); //utworzonego tupla dodajemy do vectora
			}
		}
	}
	return tablicaKrawedzi;
}
struct strukturaPorownawcza
{
	inline bool operator() (tuple<int, int, double> v1, tuple<int, int, double> v2) //dodanie inline
	{
		return get<2>(v1) < get<2>(v2);
	}
}obiektPorownujacy;

//modyfikacja funkcji Connected na tak¹, ktora analizuje tablice krawedzi
bool Connected(int n, vector<tuple<int, int, double>> *G)
{
	UnionFind testSpojnosci(n);
	for (int i = 0; i < G->size(); i++) //dla wszystkich krawedzi
	{
		testSpojnosci.Union(get<0>((*G)[i]), get<1>((*G)[i])); //dodajemy krawedz przekazujac numery polaczonych wierzcholkow z tuple (element 0. i 1.)
	}
	
	//graf jest spojny, jesli wszystkie elementy naleza teraz do jednego zbioru. wszyskie wezly powinny wiec miec jako wezel pierwotny wezel 0!
	for (int i = 0; i < n; i++)
	{
		if (testSpojnosci.FindSet(i) != 0) //ktorys z wierzcholkow nie jest spojny
			return false;
	}

	return true;
}

double kruskal(int n, double p)
{
	vector<tuple<int, int, double>> graf = generatorGrafow(n, p); //tworzenie grafu w postaci wektora tupli zawieraj¹cyh wierzcholek poczatkowy i koncowy krawedzi oraz jej wage
	int a, b, i, j;
	double waga, wagaCalkowita=0;

	if (Connected(n, &graf)) //algorytm kruskala wymaga grafu spojnego
	{
		UnionFind unionFind(n);
		bool* tablicaWierzcholkow = new bool[n]; //tablica zawierajaca 0 jesli wierzcholek nie zostal odwiedzony, 1 jesli zostal odwiedzony
		memset(tablicaWierzcholkow, 0, n*sizeof(*tablicaWierzcholkow)); //wyzerowanie tablicy
		bool wszystkieWierzcholkiOdwiedzone = false;

		sort(graf.begin(), graf.end(), obiektPorownujacy); //sortowanie krawedzi od najlzejszej do najciezszej
		
		for (i = 0; i < graf.size(); i++)
		{
			tie(a, b, waga) = graf[i];
			if (a == b) //nie interesuja nas petle wlasne
				continue;
			if (tablicaWierzcholkow[a] == 0 || tablicaWierzcholkow[b] == 0 || unionFind.FindSet(a)!=unionFind.FindSet(b)) //wierzcholki polaczone dana krawedzia nie naleza na razie do tego samego drzewa
			{
				unionFind.Union(a, b);
				wagaCalkowita += waga;
				tablicaWierzcholkow[a] = 1;
				tablicaWierzcholkow[b] = 1;
			}


			//sprawdzenie czy drzewo juz jest drzewem rozpinajacym (zawiera wszystkie wierzcholki)
			if (wszystkieWierzcholkiOdwiedzone == false) //przede wszystkim wszystkie wierzcholki musza byc odwiedzone - sprawdzamy
			{
				for (j = 0; j < n; j++)
				{
					if (tablicaWierzcholkow[j] == 0) //ktorys z wierzcholkow nie zostal jeszcze dodany
						break;
					wszystkieWierzcholkiOdwiedzone = true;
				}
			}
			if (wszystkieWierzcholkiOdwiedzone == true) //skoro wszystkie wierzcholki zostaly odwiedzone, to sprawdzimy czy sa spojne
			{
				bool test = true;
				for (j = 0; j < n; j++)
				{
					if (unionFind.FindSet(j) != 0) //ktorys z wierzcholkow nie jest spojny
					{
						test = false;
						break;
					}
				}
				if (test==true)
					break;
			}
			
		}
		delete[] tablicaWierzcholkow;
		return wagaCalkowita;
	}
	return -1;
	
}

int main()
{
	for (int k = 1; k <= 16; k++)
	{
		int liczbaSpojnych = 0;
		double waga = 0;
		double wagaGrafu;
		for (int i = 0; i < 1000; i++)
		{
			wagaGrafu = kruskal(pow(2, k), k*pow(2, (-1)*k));
			if (wagaGrafu != -1) //drzewo jest spojne
			{
				liczbaSpojnych++;
				waga += wagaGrafu;
			}
		}
		cout << "k = " << k<<"\tspojnych = " << (double)liczbaSpojnych / 1000 << "\tsrednia waga = " << waga / liczbaSpojnych << endl;
	}
	
	return 0;
}