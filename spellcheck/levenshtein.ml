(*levenstein distance*)

(*long and not effective*)
(*
let get_distance_rec x y =
  let m = Array.make_matrix ((String.length x)+1) ((String.length) y+1) 0 in
  let rec distance = function
      (0,k)-> let x = k in m.(0).(k) <- x;x
    |(k,0) -> let x = k in m.(k).(0) <- x;x 
    |(i,j) when x.[i-1] = y.[j-1] -> let x = min ((distance (i-1, j)) +1) (min ((distance (i, j-1)) +1)  (distance (i-1, j-1))) in m.(i).(j) <- x;x
    |(i,j) -> let x = min ((distance (i - 1, j)) + 1) (min ((distance (i, j - 1)) + 1) ((distance (i-1, j-1)) + 2)) in m.(i).(j) <- x;x
  in
    (distance ((String.length x), (String.length y)));
    (m.(String.length x).(String.length y))
 *)

(*better implementation*)

let get_distance x y = 
  let m = Array.make_matrix ((String.length x)+1) ((String.length) y+1) 0 in
    for i = 0 to (String.length x) do
      m.(i).(0) <- i
    done;
    for j = 0 to (String.length y) do
      m.(0).(j) <- j
    done;
    for i = 1 to (String.length x) do
      for  j = 1 to (String.length y) do
        if x.[i-1] = y.[j-1] then
          m.(i).(j) <- min (m.(i - 1).(j) + 1) (min (m.(i).(j - 1) + 1)  (m.(i - 1).(j - 1)))
        else
          m.(i).(j) <- min (m.(i - 1).(j) + 1) (min (m.(i).(j - 1) + 1) (m.(i - 1).(j - 1) + 2))
      done;
    done;
    (m.(String.length x).(String.length y))

(*split words in a list*)

let words s = 
  let w = ref [] in
  let start = ref 0 in
    for i = 0 to String.length s do
      begin
        if i = String.length s || s.[i] = ' ' || s.[i] = ',' ||
           s.[i] = ';' || s.[i] = ':' || s.[i] = '!' ||
           s.[i] = '?' || s.[i] = '.' || s.[i] = '/' || s.[i] = '\'' then
          begin
            let s1 = String.sub s (!start) (i - !start) in 
              if(s1 <> " ") then
                w :=  s1::!w;
              start := i+1;
          end
      end
    done;
    (!w)

let lowercase w = w.[0] <- Char.lowercase w.[0]

let get_numbers w = 
  let s = ref "0000" in
  let j = ref 0 in 
  let i = ref 1 in
    String.set !s !j w.[0] ; j := !j + 1;
    while !i < (String.length w) && !j < 4 do
      begin 
        match w.[!i] with
            'b'|'f'|'p'|'v' -> String.set !s !j '1'; j := !j + 1 
            |'c'|'g'|'j'|'k'|'q'|'s'|'x'|'z' -> String.set !s !j '2'; j := !j + 1
            |'d'|'t' ->String.set !s !j '3'; j := !j + 1
            |'l' ->String.set !s !j '4'; j := !j + 1
            |'m'|'n' ->String.set !s !j '5'; j := !j + 1
            |'r' -> String.set !s !j '6'; j := !j + 1
            |_ -> ()
      end;
      i := !i+1
    done;
    (s) 

(*verify if each word in l is in d and build the list of unknown word*)

let rec verify d l =  match l with 
    [] -> []
  |w::r -> if not (w = "") && Lexical_tree.exists w d then verify d r else w::verify d r

(*add a bad word and the number of it's occurence in a list*)

let rec add w l = match l with
    [] -> (w,1)::[]
  |(m,x)::r when w = m -> (m,x+1)::r
  |(m,x)::r -> (m,x)::(add w r)

let rec list_add lv l = match l with
    [] -> lv
  |w::r -> let rest = list_add lv r in add w rest

let occurences l = list_add [] l 

(*load a dictionary*)

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

(*correct all the word in l using the dicionary*)

let possibilities dico w = 
  let pos = Lexical_tree.select dico (String.length w) in
  let rec test = function
        [] -> []
      |m::l when w.[0] = m.[0] -> m::(test l)
      |m::l -> test l
  in test pos

let rec correct dico l =
  print_string("debut de la correction : ");
  print_newline();
  match l with
      [] -> []
    |w::r ->print_string(w); print_newline(); let sol = possibilities dico w in
     let rec build_sol = function
         [] -> [] 
       |m::t when get_distance w m <= 4 ->
           print_string(m);
           print_string(" - ");
           print_string(w);
           print_newline(); 
           m::(build_sol t)
       |m::t ->
           (build_sol t)
     in build_sol sol

let test_words () =
  let f = open_in "texte.txt" and res = ref[] in
    try
      while true do 
        let s = input_line f in
        let w = words s in
          res := w::!res;
      done;
      failwith "impossible"
    with
        End_of_file -> close_in f; !res
      |x -> close_in f; raise x

let spellcheck dico file =
  let f = open_in file and res = ref [] in
    try
      while true do 
        let s = input_line f in
        let w = words s in
          print_string("decoupe done");
          let bw = verify dico w in
            print_string (" verification done");
            res := list_add !res bw ;
            print_newline();
      done;
      failwith "imposible case"
    with
        End_of_file -> close_in f; !res
      |x -> close_in f; raise x

let correction dico file = 
  let f = open_in file and core = ref [] in
    try 
      while true do
        let s= input_line f in
        let w = words s in
        let bw = verify dico w in 
          core := correct dico bw;
          print_newline();
      done;
      failwith "impossible"
    with
        End_of_file -> close_in f; !core
      |x -> close_in f; raise x 

let rec display_core l = match l with
    [] -> ()
  |w::r -> print_string(w);print_newline()

let rec display_res l = match l with
    [] -> ()
  |(a,b)::r -> print_string(a);print_string(" - ");print_int(b);print_newline(); display_res r

let main () =
  let dico = load_dico (Sys.argv).(1) in
  let res = spellcheck dico (Sys.argv).(2) in
  let core = correction dico (Sys.argv).(2) in
    display_res res

let _ = main ()
