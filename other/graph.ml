type vertex =
{
cost : int;
succ : int;
pred : int
}

type 'a edge = 
{
value : 'a;
succ : vertex list;
pred : vertex list
}

type graphe = {tab : int * 'a edge array}
