#include <cstddef>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <fstream>

using namespace std;

class Node{
	private:
		int value;
 		Node* left;
		Node* right;
		Node* parent;
	public:
		Node(int v) { value = v; left = right = parent = NULL;}
		inline int getValue() { return value; }
		inline Node* getLeft() { return left; }
		inline Node* getRight() { return right; }
		inline Node* getParent() { return parent; }
		inline void setParent(Node* n) { parent = n; }
		inline void setLeft(Node* n) { left = n; }
		inline void setRight(Node* n) { right = n; }
		inline void setValue(int n) { value = n; }
};

class BinarySearchTree{
	private:
		long int nbr_of_compares_insert, nbr_of_compares_remove;
		Node* root;
		void remove_subtree_rooted_in_node(Node* e){
			if(e != NULL){
				remove_subtree_rooted_in_node(e->getLeft());
				remove_subtree_rooted_in_node(e->getRight());
                if(e->getParent() != NULL){
                    if (e->getParent()->getRight() == e) e->getParent()->setRight(NULL); 
                    if (e->getParent()->getLeft() == e) e->getParent()->setLeft(NULL); 
                }
				delete e;
			}
		}
		int height_of_tree(Node* e){
			if(e == NULL) return 0;
			return 1 + max(height_of_tree(e->getLeft()), height_of_tree(e->getRight()));
		}
		Node* ins(Node* v, Node* e){
			if(e == NULL) { return v; }
			nbr_of_compares_insert++;
			if(v->getValue() < e->getValue()) {
				v->setParent(e);
				e->setLeft(ins(v, e->getLeft()));
			}
			else {
				v->setParent(e);
				e->setRight(ins(v, e->getRight()));
			}
			return e;
 		}
		Node* find(int v, Node* root){
			if(root == NULL) return root;
			this->nbr_of_compares_remove++;
			if(root->getValue() == v) return root;
			this->nbr_of_compares_remove++;
			if(root->getValue() < v ) return find(v, root->getRight());
			else return find(v, root->getLeft());	
		}
		Node* get_min(Node* root){
			if(root->getLeft()==NULL) return root;
			else return get_min(root->getLeft());
		}
		void remove_element(int v, Node* root) {
			Node* removed = find(v, root);
			if(root == NULL || removed == NULL) return;
			if(removed->getLeft() == NULL && removed->getRight() == NULL){
				if(removed->getParent() == NULL) this->root=NULL;
				else if (removed->getParent()->getLeft() == removed) removed->getParent()->setLeft(NULL);
				else removed->getParent()->setRight(NULL);
				delete removed;
			}
			else if (removed->getLeft() == NULL || removed->getRight() == NULL){
				if (removed->getLeft() != NULL){
					if (removed->getParent() == NULL) {
						removed->getLeft()->setParent(NULL);
						this->root = removed->getLeft();
					}
					else{
						removed->getLeft()->setParent(removed->getParent());
						if (removed->getParent()->getLeft() == removed)
							removed->getParent()->setLeft(removed->getLeft());
						else 
							removed->getParent()->setRight(removed->getLeft());
					}
					delete removed;	
				}
				else{
					if (removed->getParent() == NULL) {
						removed->getRight()->setParent(NULL);
						this->root = removed->getRight();
					}
					else{
						removed->getRight()->setParent(removed->getParent());
						if (removed->getParent()->getLeft() == removed)
							removed->getParent()->setLeft(removed->getRight());
						else 
							removed->getParent()->setRight(removed->getRight());
					}
					delete removed;
				}
			}
			//jeśli ma dwójke dzieci
			else{
				Node* temp;
				temp = get_min(removed->getRight());
				int value = temp->getValue();
				if (temp->getRight()!=NULL){
					temp->getRight()->setParent(temp->getParent());
					temp->getParent()->setLeft(temp->getRight());
				}
				remove_subtree_rooted_in_node(temp);
				removed->setValue(value);
				if (removed->getParent()==NULL) this->root = removed;
			}
		}
		
    public :
		BinarySearchTree(){ 
			nbr_of_compares_insert=nbr_of_compares_remove=0;
			root = NULL; 
		}
		~ BinarySearchTree(){ remove_subtree_rooted_in_node(root); }
		inline bool empty(){ return root == NULL; }
		int height(){ return height_of_tree(root); }
		long int compares_insert(){return nbr_of_compares_insert; }
		long int compares_remove(){return nbr_of_compares_remove; }
		void insert(Node* v){ root = ins(v, root); }
		void remove_element(int v){remove_element(v, root);}
};

void make_all_values_in_table_zero(long int table[], int n){
	for(int i=0;i<=n;i++){
			table[i]=0;
		}
}

string make_string_from_int(int n){
	ostringstream ss;
	ss << n;
	string str = ss.str();
	return str;
}

void print_table(int table[], int n){
	for (int i=0;i<n;i++)
		cout<<table[i]<<", ";
	cout<<endl;
}

int main(int argc, char* argv []){
	int N = 9;//liczba n dla jakiej (od 3 do N) wykonujemy tabele
	string table_string;
	long int *final_nbr_of_trees = new long int[13],
		*final_nbr_of_compares_insert = new long int[13], 
		*final_nbr_of_compares_remove_from_one_to_n = new long int[13], 
		*final_nbr_of_compares_remove_reverted = new long int[13],
		*final_nbr_of_compares_remove_as_added = new long int[13],
		*final_nbr_of_compares_remove_from_n_to_1 = new long int[13];
	for(int n=3;n<=N;n++){
		make_all_values_in_table_zero(final_nbr_of_compares_remove_from_one_to_n, 13);
		make_all_values_in_table_zero(final_nbr_of_trees, 13);
		make_all_values_in_table_zero(final_nbr_of_compares_insert, 13);
		make_all_values_in_table_zero(final_nbr_of_compares_remove_reverted, 13);
		make_all_values_in_table_zero(final_nbr_of_compares_remove_as_added, 13);
		make_all_values_in_table_zero(final_nbr_of_compares_remove_from_n_to_1, 13);
		cout<<n<<"..."<<endl;
		table_string += "n = " + make_string_from_int(n) + "\n";
		table_string += "srednia ilosc porownan przy:, h=1, h=2, h=3, h=4, h=5, h=6, h=7, h=8, h=9, h=10, h=11, h=12\n";
		int *table = new int[n], *reverted_table = new int[n];
		for (int a=0;a<n;a++)
			table[a]=a+1;
		do{
			BinarySearchTree tree1, tree2, tree3, tree4;
			for (int i=0;i<n;i++)
				reverted_table[i] = table[n-1-i];
			for (int i=0;i<n;i++){
				tree1.insert(new Node(table[i]));
				tree2.insert(new Node(table[i]));
				tree3.insert(new Node(table[i]));
				tree4.insert(new Node(table[i]));
			}
			int height = tree1.height();
			final_nbr_of_trees[height]++;
			final_nbr_of_compares_insert[height] += tree1.compares_insert();
            
			for (int i=1;i<=n;i++) tree1.remove_element(i);
			final_nbr_of_compares_remove_from_one_to_n[height] += tree1.compares_remove();
			
			for (int i=n;i>=1;i--) tree2.remove_element(i);
			final_nbr_of_compares_remove_from_n_to_1[height] += tree2.compares_remove();
			
			for (int i=0;i<n;i++) tree3.remove_element(table[i]);
			final_nbr_of_compares_remove_as_added[height] += tree3.compares_remove();
			
			for (int i=0;i<n;i++) tree4.remove_element(reverted_table[i]);
			final_nbr_of_compares_remove_reverted[height] += tree4.compares_remove();
			
		}while(next_permutation(table,table + n));
	
		table_string += "wstawianiu,";
		for(int i=1;i<13;i++){
			long int nbr;
			if (final_nbr_of_trees[i]!=0) nbr = final_nbr_of_compares_insert[i]/final_nbr_of_trees[i];
			else nbr = 0;
			table_string = table_string + make_string_from_int(nbr) + ",";}
		table_string += "\nusuwaniu w porzadku rosnacym,";
		for(int i=1;i<13;i++){
			long int nbr;
			if (final_nbr_of_trees[i]!=0) nbr = final_nbr_of_compares_remove_from_one_to_n[i]/final_nbr_of_trees[i];
			else nbr = 0;
			table_string = table_string + make_string_from_int(nbr) + ",";
		}
		table_string += "\nusuwaniu w porzadku malejacym,";
		for(int i=1;i<13;i++){
			long int nbr;
			if (final_nbr_of_trees[i]!=0) nbr = final_nbr_of_compares_remove_from_n_to_1[i]/final_nbr_of_trees[i];
			else nbr = 0;
			table_string = table_string + make_string_from_int(nbr) + ",";
		}
		table_string += "\nusuwaniu w porzadku wstawiania,";
		for(int i=1;i<13;i++){
			long int nbr;
			if (final_nbr_of_trees[i]!=0) nbr = final_nbr_of_compares_remove_as_added[i]/final_nbr_of_trees[i];
			else nbr = 0;
			table_string = table_string + make_string_from_int(nbr) + ",";
		}
		table_string += "\nusuwaniu w porzadku odwrotnym do wstawiania,";
		for(int i=1;i<13;i++){
			long int nbr;
			if (final_nbr_of_trees[i]!=0) nbr = final_nbr_of_compares_remove_reverted[i]/final_nbr_of_trees[i];
			else nbr = 0;
			table_string = table_string + make_string_from_int(nbr) + ",";
		}
		table_string = table_string + "\n";
	}
	ofstream myfile;
	myfile.open("C:\\Users\\Joanna\\Desktop\\drzewa_new.csv");//do tego pliku zapisuje tabele
	myfile << table_string;
	myfile.close();
	return 0;
}
