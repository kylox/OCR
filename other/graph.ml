type edge = {
  value : int;
  vertex : (int) list;
}

type graph = { 
  ordre : int;
  edges : edge array;
}

let empty_edge () = {value = -1; vertex = [];}
