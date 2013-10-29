(*levenstein distance*)

let get_distance x y =
  let m = Array.make_matrix ((String.length x)+1) ((String.length) y+1) 0 in
  let rec distance = function
      (0,k)-> let x = k in m.(0).(k) <- x;x
    |(k,0) -> let x = k in m.(k).(0) <- x;x 
    |(i,j) when x.[i-1] = y.[j-1] -> let x = min ((distance (i-1, j)) +1) (min ((distance (i, j-1)) +1)  (distance (i-1, j-1))) in m.(i).(j) <- x;x
    |(i,j) -> let x = min ((distance (i - 1, j)) + 1) (min ((distance (i, j - 1)) + 1) ((distance (i-1, j-1)) + 2)) in m.(i).(j) <- x;x
  in
    (distance ((String.length x), (String.length y)));
      (m.(String.length x).(String.length y))

(*split words in a list*)

let words s = 
  let w = ref [] in
  let start = ref (String.length s) in
    for i = String.length s-1 downto 0 do
      if s.[i] = ' '|| s.[i] = ',' || s.[i] = ';' || s.[i] = ':' || s.[i] = '!' || s.[i] = '?' || s.[i] = '.' || s.[i] = '/' then 
        let s1 = String.sub s i (!start-i) in 
          w := s1::!w;
          start := i;
  done;
(!w)
(*verify if each word in l is in d and build the list of unknown word*)
let rec verify d l =  match l with 
    [] -> []
  |w::r -> if Lexical_tree.exists w d then verify d l else w::verify d r

let rec add w l = match l with
  [] -> (w,1)::[]
    |(m,x)::r when w = m -> (m,x+1)::r
    |(m,x)::r -> (m,x)::(add w r)

let rec list_add lv l = match l with
    [] -> lv
  |w::r -> let rest = list_add lv r in add w rest

let occurences l = list_add [] l 

let load_dico file = 
  let f = open_in file in
  let l = ref [] in
  let dico = ref [] in
    try
      while true do
        let s = input_line f in
         l := s::!l;
      done;
      failwith "impossible"
    with
        End_of_file ->close_in f; dico := Lexical_tree.construct !l; !dico
      |x -> close_in f; raise x


let spellcheck dico file =
  let f = open_in file and res = ref [] in
    try
    while true do 
      let s = input_line f in
      let w = words s in
      let bw = verify dico w in
      res := list_add !res bw ;
    done;
    failwith "imposible case"
    with
        End_of_file -> close_in f; !res
      |x -> close_in f; raise x

let rec display_res l = match l with
    [] -> ()
  |(a,b)::r -> print_string(a);print_string(" - ");print_int(b);print_newline(); display_res r

let main () =
  let dico = load_dico (Sys.argv).(1) (*in*)
  (*let res = spellcheck dico (Sys.argv).(2) in*)
    display_res res
  
  let _ = main ()
