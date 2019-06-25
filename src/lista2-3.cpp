# include <cstddef>
# include <iostream>
# include <cstdlib>
# include <cmath>
# include <ctime>
# include <sstream>

using namespace std;

class Element {
	private:
		int value;
		Element* next;
		Element* prev;
	public :
		Element(int v){ 
			value = v; 
			next = prev = NULL ; 
		}
		inline int getValue(){ return value; }
		inline Element* getNext(){ return next; }
		inline Element* getPrev(){ return prev; }
		inline void setNext(Element* n){ next = n; }
		inline void setPrev(Element* n){ prev = n; }
};
class Queue{
	private:
		Element* first;
		Element* last;
	public:
		int count;
		Queue(){ 
			first = last = NULL ;
			count = 0;
		}
		~Queue(){
			while (first != NULL){
				last = first -> getNext ();
				delete first;
				first = last;
			};
		}		
		inline bool empty(){ return first == NULL; }
		int min(){
			if(first==last){
				int value = first->getValue();
				first=NULL;
				return value;
			}
			Element* tmp = first->getNext();
			int value = first->getValue();
			tmp->setPrev(NULL);
			delete first;
			first = tmp;
			return value;
		}
		string return_table(){
			string table="";
			Element* tmp = first;
			while(tmp != last){
				ostringstream ss;
				ss << tmp->getValue();
				string str = ss.str();
				table = table + str + ", ";
				tmp = tmp->getNext();
			}
			ostringstream ss;
			ss << last->getValue();
			string str = ss.str();
			table += str;
			return table;
		}
		void insert (int e){
		
			if (first == NULL)
				first = last = new Element (e);
			else{
				Element* new_element = new Element(e);
				if (e < first->getValue()){
					Element* tmp = first;
					new_element->setNext(tmp);
					tmp->setPrev(new_element);
					first = new_element;
				}
				else{
					if (e > last->getValue()){
						Element* tmp = last;
						new_element->setPrev(tmp);
						tmp->setNext(new_element);
						last = new_element;
					}
					else{
						Element* min = first;
						Element* item = first -> getNext();
						while (item != NULL) {
							if (e < item->getValue()){
								Element* smaller = item->getPrev();
								smaller->setNext(new_element);
								item->setPrev(new_element);
								new_element->setPrev(smaller);
								new_element->setNext(item);
								count++;
								break;
							}
							else
								item = item->getNext();
						}
					}
				}
			}
		}	
};

int main(){
	int trials = 0, 
	    all_counts = 0, 
		n = 10;
	srand(time(0));
	for(int i=1;i<100;i++){
		int *table = new int[n];
		for (int a=1;a<=10;a++)
			table[a-1]=a;
		int lasting = int( n* (log(n) / log(2))) + 1,
			one = 0, 
			two = 1;
		for(int i=1;i<lasting;i++){
			int a=rand()%2;
			if (a==1){
				int tmp = table[one];
				table[one] = table[two];
				table[two] = tmp;
			}
			if (two != n-1){
				one++;
				two++;
			}
			else{
				one = 0;
				two = 1;
			}
		}

		Queue k;
		for (int i=0;i<10;i++){cout<<table[i]<<", ";}
		cout<<endl;
		for(int i=9;i>=0;i--) k.insert(table[i]);
		cout<<k.return_table()<<endl;
 		while (!k.empty()) k.min(); 
		all_counts = all_counts + k.count;
		trials++;
	}	
	cout<<all_counts/trials;
	return 0;
}
