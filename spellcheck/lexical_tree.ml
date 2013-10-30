type lex_node = Letter of char * bool * lex_tree
                                          and lex_tree = lex_node list
type word = string

let rec exists w d =
  let aux sw i n = 
    match d with
        [] -> false
      |(Letter (c, b, l))::t when c = sw.[i] ->  
          if n = 1 then
            b
          else exists (String.sub sw (i+1) (n-1)) l
      |(Letter (c,b,l))::t -> exists sw t
  in aux w 0 (String.length w)


let rec insert w d =
  let aux sw i n =
    if n = 0 then
      d
    else
      match d with 
          [] -> [Letter (sw.[i], n = 1, insert (String.sub sw (i+1) (n-1)) [])]
        |(Letter (c, b, l))::t when c = sw.[i] ->
            if n = 1 then
              (Letter (c, true , l))::t
            else
              (Letter(c ,b, insert (String.sub sw (i+1) (n-1)) l))::t
        |(Letter (c, b, l))::t -> (Letter (c,b,l))::(insert sw t) 
  in aux w 0 (String.length w)

let rec construct l =
  let rec aux l d = match l with
      [] -> d
    | h::t -> aux t (insert h d)
  in aux l []

(*delete an element of the list l wich don't succes the function f*)
let rec filter f = function
    [] ->[]
  |h::l -> if f h then h::filter f l else filter f l 

let verify l d = filter (function w -> not (exists w d)) l

let string_of_char c = String.make 1 c
  
let rec select d n = match d with
    [] -> []
  |(Letter (c,b,l)):: t when n = 1 -> 
      let f (Letter (c,b,_)) = if b then string_of_char c else "!" in
        filter (function x -> x <> "!") (List.map f d)
  |(Letter(c,b,l))::t -> 
      let r1 = select l (n-1) 
      and r2 = select t n in
      let pr = List.map (function s -> (string_of_char c)^s) r1 in
        pr@r2
