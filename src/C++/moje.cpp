#include<math.h>
#include<queue>
#include<stdlib.h>
#include<time.h>
#include<iostream>

#define TESTS 100
#define MAX_K 10
#define MAX_N 2000
#define inf 1000000000
#define mp make_pair
using namespace std;

int ABS( int x){
    if(x<0) return -1*x;
    return x;
}

struct pkt{
    int x, y;
    pkt(){}
    pkt(int _x, int _y){ x=_x; y=_y;}
    int dist(pkt P) {
        return ABS(P.x-x)+ABS(P.y-y);
    }
} graph[MAX_N];

priority_queue<pair<int, pair<int,int> > > Q;
vector<int> tree[MAX_N];
bool in_tree[MAX_N], vstDFS[MAX_N];
int dist_from_tree[MAX_N];
vector<int> order;

void generate_graph(int k)
{
     for( int i=0; i< (1<<k); ++i)
        graph[i] = pkt(rand(), rand());
}

void DFS(int v){
    vstDFS[v]=1;
    order.push_back(v);
    for( int i=0; i< tree[v].size(); ++i)
        if( vstDFS[tree[v][i]]==0)
            DFS(tree[v][i]);

}

void MST(int korzen, int k)
{
    while(!Q.empty())Q.pop();
    Q.push(mp(0,mp(MAX_N-1, korzen)));
    order.resize(0);

    for(int i=0; i< (1<<k); ++i){
        tree[i].resize(0);
        in_tree[i]=0;
        dist_from_tree[i]=inf;
        vstDFS[i]=0;
    }
    dist_from_tree[korzen]=0;

    while(!Q.empty()){
        int w = Q.top().second.second;
        int ance = Q.top().second.first; /// krawedz ance -- w dodajemy do drzewa
        Q.pop();
        if(in_tree[w]) continue;

        if(ance != MAX_N -1){
            tree[ance].push_back(w);
            tree[w].push_back(ance);
        }

        in_tree[w]=1;
        for( int i=0 ;i <(1<<k); ++i){
            if( in_tree[i]==0 and dist_from_tree[i] > graph[w].dist(graph[i]) ){
                dist_from_tree[i] = graph[w].dist(graph[i]);
                Q.push(mp(-dist_from_tree[i], mp(w, i)));
            }
        }
    }
}

long long APPROX_TSP_TOUR(int k)
{
    int korzen= rand()%(1<<k);

    MST(korzen, k);

    DFS( korzen);

    long long  ans=0LL;

    for( int i=0; i<order.size()-1; ++i)
        ans+=graph[order[i]].dist(graph[order[i+1]]);
    ans += graph[order[0]].dist(graph[order.back()]);

    return ans;
}

int main()
{
    srand(time(NULL));
    for(int k=3; k<=MAX_K; ++k)
    {
        long long sum_len=0LL;
        for(int t=0; t<TESTS; ++t)
        {
            generate_graph(k);
            sum_len += APPROX_TSP_TOUR(k);
        }
        double  av_len =  sum_len/TESTS;
        double prop = av_len/RAND_MAX;
        cout<<"k="<<k<<", sr.dlugosc="<<av_len<<", stosunek="<<prop<<"\n";
    }
}
