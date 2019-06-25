#include "wielomian.h"
#include "exception.h"
#include "misc.h"

#include <cmath>
#include <limits>
using namespace std;

//---------------------------------------------------------------------------
// konstruktor WielomianRef

WielomianRef::WielomianRef(Wielomian * pWielomian, int i) : 
	pWielomian(pWielomian), i(i) 
{}

//---------------------------------------------------------------------------
// operator przypisania
// po wprowadzeniu wartosci
// w klasie wektor wywolywana jest funkcja trim

WielomianRef & WielomianRef::operator = (double x) {
	pWielomian->set(i, x);
	return * this;
}

//---------------------------------------------------------------------------
// pobranie wartosci
WielomianRef::operator double const () {
	return pWielomian->get(i);
}

//---------------------------------------------------------------------------
// operator +=

WielomianRef & WielomianRef::operator += (double x) {
	pWielomian->set(i,  pWielomian->get(i) + x);
	return * this;
}

//---------------------------------------------------------------------------
// operator -=

WielomianRef & WielomianRef::operator -= (double x) {
	pWielomian->set(i,  pWielomian->get(i) - x);
	return * this;
}

//---------------------------------------------------------------------------
// operator *=

WielomianRef & WielomianRef::operator *= (double x) {
	pWielomian->set(i,  pWielomian->get(i) * x);
	return * this;
}

//---------------------------------------------------------------------------
// operator /=

WielomianRef & WielomianRef::operator /= (double x) {
	pWielomian->set(i,  pWielomian->get(i) / x);
	return * this;
}

//---------------------------------------------------------------------------
// ++a[i]

WielomianRef & WielomianRef::operator ++() {
	pWielomian->set(i,  pWielomian->get(i) + 1);
	return *this;
}

//---------------------------------------------------------------------------
// a[i]++;

double WielomianRef::operator ++(int) {
	double r = pWielomian->get(i);
	pWielomian->set(i,  r + 1);
	return r;
}

//---------------------------------------------------------------------------
// --a[i]

WielomianRef & WielomianRef::operator --() {
	pWielomian->set(i,  pWielomian->get(i) - 1);
	return *this;
}

//---------------------------------------------------------------------------
// a[i]--

double WielomianRef::operator --(int) {
	double r = pWielomian->get(i);
	pWielomian->set(i,  r - 1);
	return r;
}

//---------------------------------------------------------------------------
// domyslny konstruktor W(x) = 0

Wielomian::Wielomian() {
	v.push_back(0);
}

//---------------------------------------------------------------------------
// konstruktor merytoryczny W(x) = x0

Wielomian::Wielomian(double x) {
	v.push_back(x);
}

//---------------------------------------------------------------------------
// konstruktor kopiuj¹cy W(x) = V(x)

Wielomian::Wielomian(const Wielomian & w) {
	v = w.v;
}

//---------------------------------------------------------------------------
// konstruktor merytoryczny wspolczynniki wielomianu zapisane sa w wektorze v

Wielomian::Wielomian(const vector<double> & v) {

	this->v = v;
	
	if (this->v.size() == 0)
		this->v.push_back(0);
	else	
		trim();
}

//---------------------------------------------------------------------------
// tworzenie wielomianu ze stringa
// w przypadku bledu W(x) = 0

Wielomian::Wielomian(const string & s) {
	try {
		Wielomian w = fromString(s);
		v = w.v;
	} catch (...) {
		v = vector<double>(1, 0);
	}
}

//---------------------------------------------------------------------------
// operator przypisania W(x) = V(x)

Wielomian & Wielomian::operator = (const Wielomian & w) {
	if (this != &w)
		v = w.v;
		
	return * this;
}

//---------------------------------------------------------------------------
// operator sumowania W(x) = W(x) + V(x)

Wielomian & Wielomian::operator += (const Wielomian & w) {
	if (v.size() < w.v.size()) 
		v.resize(w.v.size(), 0);
	
	for (int i=0; i<w.v.size(); i++)
		v[i] += w.v[i];
	
	trim();
		
	return *this;
}

//---------------------------------------------------------------------------
// operator roznicy W(x) = W(x) - V(x)

Wielomian & Wielomian::operator -= (const Wielomian & w) {
	if (v.size() < w.v.size()) 
		v.resize(w.v.size(), 0);
	
	for (int i=0; i<w.v.size(); i++)
		v[i] -= w.v[i];
	
	trim();
		
	return *this;
}

//---------------------------------------------------------------------------
// operator mnozenia W(x) = W(x) * V(x)

Wielomian & Wielomian::operator *= (const Wielomian & w) {
	vector<double> r(v.size() + w.v.size() - 1, 0);
	
	for (int i=0; i<v.size(); i++)
	for (int j=0; j<w.v.size(); j++)
		r[i+j] += v[i]*w.v[j];

	v.swap(r);
	
	trim();

	return *this;
}

//---------------------------------------------------------------------------
// operator dzielenia W(x) = W(x) / V(x) bez reszty

Wielomian & Wielomian::operator /= (const Wielomian & w) {

	int N = v.size() - 1;
	int M = w.v.size() - 1;
		
	if (M > N) {
		v.resize(1);
		v[0] = 0;
		return *this;
	}

	vector<double> d(N - M + 1, 0);

	double c = w.v[M];
	if (c == 0)	
		throw Exception("dzielenie przez 0");

	for (int i=N; i>=M; i--) {
		double k = v[i] / c;
		d[i-M] = k;
		for (int j=M; j>=0; j--)
			v[i+j-M] -= w.v[j]*k;
	}
	
	v.swap(d);
	
	trim();

	return *this;
}

//---------------------------------------------------------------------------
// operator % W(x) = reszta z dzielenia W(x) / V(x) 

Wielomian & Wielomian::operator %= (const Wielomian & w) {

	int N = v.size() - 1;
	int M = w.v.size() - 1;
	
	if (M > N) {
		v = w.v;
		return *this;
	}

	double c = w.v[M];
	if (c == 0)	
		throw Exception("dzielenie przez 0");
	
	for (int i=N; i>=M; i--) {
		double k = v[i] / c;
		for (int j=M; j>=0; j--)
			v[i+j-M] -= w.v[j]*k;
	}
	
	v.resize(M);
	
	trim();

	return *this;
}

//---------------------------------------------------------------------------
// operator + zwraca W(x) + V(x)

Wielomian Wielomian::operator + (const Wielomian & w) const {
	return Wielomian(*this) += w;
}

//---------------------------------------------------------------------------
// operator - zwraca W(x) + V(x)

Wielomian Wielomian::operator - (const Wielomian & w) const {
	return Wielomian(*this) -= w;
}

//---------------------------------------------------------------------------
// operator * zwraca W(x) * V(x)

Wielomian Wielomian::operator * (const Wielomian & w) const {
	return Wielomian(*this) *= w;
}

//---------------------------------------------------------------------------
// operator / zwraca W(x) / V(x) (bez reszty)

Wielomian Wielomian::operator / (const Wielomian & w) const {
	return Wielomian(*this) /= w;
}

//---------------------------------------------------------------------------
// operator & zwraca reszte z dzielenia W(x) / V(x)

Wielomian Wielomian::operator % (const Wielomian & w) const {
	return Wielomian(*this) %= w;
}

//---------------------------------------------------------------------------
// zwraca true jesli W(x) = V(x)

bool Wielomian::operator == (const Wielomian & w) const {
	return v == w.v;
}

//---------------------------------------------------------------------------
// zwraca true jesli W(x) = x0

bool Wielomian::operator == (double x) const {
	if (v.size() > 1) return false;
	return v[0] == x;
}

//---------------------------------------------------------------------------
// zwraca true jesli W(x) != V(x)

bool Wielomian::operator != (const Wielomian & w) const {
	return v != w.v;
}

//---------------------------------------------------------------------------
// zwraca true jesli W(x) != x0

bool Wielomian::operator != (double x) const {
	if (v.size() > 1) return true;
	return v[0] != x;
}

//---------------------------------------------------------------------------
// oblicza wartosc wielomianu dla danego x

double Wielomian::operator() (double x) const {

	double f = 1.0;
	double r = 0;
	for (int i=0; i<v.size(); i++) {
		r += v[i]*f;
		f *= x;
	}
	return r;
}

//---------------------------------------------------------------------------
// zwraca wartosc wspolczynnika wielomianu o ineksie i

const double Wielomian::operator[] (int i) const {
	return get(i);
}

//---------------------------------------------------------------------------
// zwraca referencje (w postaci klasy) do wspolczynnika wielomianu o ineksie i

WielomianRef Wielomian::operator[] (int i) {
	return WielomianRef(this, i);
}

//---------------------------------------------------------------------------
// zwraca stopien wielomianu

int Wielomian::getDegree() const {
	return v.size() - 1;
}

//---------------------------------------------------------------------------
// usuwa zerowe wiodace wspolczynniki, skracajac dlugosc wielomianu

void Wielomian::trim() {
	double e = 1e-16;	// epsilon
	while (v.size() > 1 && fabs(v[v.size()-1]) < e)
		v.pop_back();
}

//---------------------------------------------------------------------------
// zwraca wartosc wsp wielomianu o indeksie i

double Wielomian::get(int i) const {
	if (i < 0) throw Exception("niepoprawny indeks wspolczynnika");
	if (i >= v.size()) return 0;
	return v[i];
}

//---------------------------------------------------------------------------
// ustala wartosc wsp wielomianu o indeksie i na wartosc x

void Wielomian::set(int i, double x) {

	if (i < 0) throw Exception("niepoprawny indeks wspolczynnika");
	if (i >= v.size()) v.resize(i+1, 0);
	v[i] = x;
	trim();
}

//---------------------------------------------------------------------------
// zapis wielomianu w postaci stringu

string Wielomian::toString() const {

	double e = 1e-8;

	string s;
	s += "(";
	if (v.size() == 1 && v[0]==0) {
		s += "0";
	} else {
		bool ws = false;
		for (int i=v.size()-1; i>=0; i--) {
			
			double c = v[i];
			if (fabs(c) > e) {
				if (ws) {
					if (c > 0) {
						s += " + ";
					} else {
						s += " - ";
						c = -c;
					}					
				} else {
					if (c < 0) {
						s += "-";
						c = -c;
					}
					ws = true;
				}
				
				if (i == 0 || fabs(c - 1) > e) s += ToString(c);
				if (i >= 1) s += "x";
				if (i >= 2) s += "^" + ToString(i);
				
			}		
		}
	}
	s += ")";
	return s;
}

//---------------------------------------------------------------------------

bool Wielomian::parseChar(const string & s, int & i, char ch) {
	if (i >= s.length() || s[i] != ch)
		return false;
		
	i++;
	return true;
}

//---------------------------------------------------------------------------

bool Wielomian::parseWhiteSpace(const string & s, int & i) {
	bool r = false;
	while (i < s.length() && isspace(s[i])) {
		i++;
		r = true;
	}
	return r;
}

//---------------------------------------------------------------------------

bool Wielomian::parseEos(const string & s, int & i) {
	return i >= s.length();
}

//---------------------------------------------------------------------------

bool Wielomian::parseInteger(const string & s, int & i, long long & x, int & d) {

	bool neg = false;

	int j = i;

	if (j < s.length()) {
		if (s[j]=='-') {
			neg = true;
			j++;
		} else if (s[j]=='+') {
			j++;
		}
	}
	
	double dx = 0;
	
	d = 0;
	while (j < s.length() && s[j]>='0' && s[j]<='9') {
		int v = s[j] - '0';
		dx = 10.0*dx + v;
		d++;
		j++;
	}

	if (d == 0)
		return false;

	if (neg) dx = -dx;

	if (dx > std::numeric_limits<long long>::max() || 
		dx < std::numeric_limits<long long>::min() ) 
	{
		return false;
	}

	i = j;
	x = (long long)dx;	
	return true;
}

//---------------------------------------------------------------------------

bool Wielomian::parseDouble(const string & s, int & i, double & x) {
	
	int j = i;
	
	long long i1 = 0;
	long long i2 = 0;
	long long i3 = 0;
	
	int d1 = 0;
	int d2 = 0;
	int d3 = 0;
	
	parseInteger(s, j, i1, d1);
	if (parseChar(s, j, '.')) {
		parseInteger(s, j, i2, d2);
		if (i2 < 0) return false;
	}
	
	if (d1==0 && d2==0)
		return false;
	
	if (parseChar(s, j, 'e') || parseChar(s, j, 'E')) {
		parseChar(s, j, '+');
		parseInteger(s, j, i3, d3);
	}

	x = i1;
	if (d2 > 0) x += (i1 >= 0 ? 1 : -1)*i2*pow(10.0, -d2);
	if (d3 > 0) x *= pow(10.0, i3);
	
	if (isnan(x)) return false;
		
	i = j;
	return true;
}

//---------------------------------------------------------------------------

bool Wielomian::parseCoeff(const string & s, int & i, double & x, long long & k) {
	
	int j = i;
	
	bool hd = false;	// wspolczynnik
	bool hk = false;	// wartosc po ^
	bool hx = false;	// znak x
	bool hs = false;	// znak -
		
	if (parseDouble(s, j, x))
		hd = true;
	else if (parseChar(s, j, '-'))
		hs = true;
		
	if (parseChar(s, j, 'x') || parseChar(s, j, 'X')) {
		hx = true;
		if (parseChar(s, j, '^')) {
			int d1;
			if (!parseInteger(s, j, k, d1)) 
				return false;
			hk = true;
		} 
	}

	if (!hd && !hx) return false;
	
	if (!hd) { 
		if (hs)
			x = -1;
		else
			x = 1;
	}
	
	if (!hk) {
		if (hx) 
			k = 1;
		else
			k = 0;
	}
		
	i = j;
	return true;
}

//---------------------------------------------------------------------------
// tworzy wielomian ze stringa

Wielomian Wielomian::fromString(const string & s) {

	bool lb = false;	// lewy nawias (
	bool rb = false;	// prawy nawias )
	bool hv = false;	// dowolny wspolczynnik ak
	bool hs = false;	// znak + lub -
	
	Wielomian w;		// wynik
	
	int i = 0;			// indeks w stringu
	int f = 1;			// znak wspolczynnika wielomianu
	long long k;		// indeks wspolczynnika wielomianu
	
	double x;			// wartosc wspolczynnika wielomianu;
	
	int st = 0;			// zawiera indeks poprzedniej operacji
	
	while (true) {
		if ((st==0 || st==6) && parseChar(s, i, '(')) {
			if (lb || hv) throw Exception("Niepoprawna skladnia na pozycji(" + ToString(i) + ")");
			lb = true;
			st = 1;
		} else if ((st==3 || st==6) && parseChar(s, i, ')')) {
			if (!lb || !hv) throw Exception("Niepoprawna skladnia na pozycji(" + ToString(i) + ")");
			rb = true;			
			st = 2;
		} else if ((st==0 || st==1 || st==4 || st==5 || st==6) && parseCoeff(s, i, x, k)) {
			if (k < 0 || (hv && x > 0 && !hs)) throw Exception("Niepoprawna skladnia na pozycji(" + ToString(i) + ")");
			w[k] += x*f;
			f = 1;
			hv = true;
			hs = false;
			st = 3;
		} else if (!hs && (st==3 || st==6) && parseChar(s, i, '+')) {
			hs = true;
			st = 4;
		} else if (!hs && (st==3 || st==6) && parseChar(s, i, '-')) {
			hs = true;
			f = -f;
			st = 5;
		} else if (parseWhiteSpace(s, i)) {
			st = 6;
		} else if (parseEos(s, i)) {	
			if (lb != rb || !hv || hs) throw Exception("Niepoprawna skladnia na pozycji(" + ToString(i) + ")");
			return w;
		} else {
			throw Exception("Niepoprawna skladnia na pozycji(" + ToString(i) + ")");
		}
	};	
}

//---------------------------------------------------------------------------
