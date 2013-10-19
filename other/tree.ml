type null = Null

type tree =
   Null
  | Node of int * tree * tree

let rec search k  = function
   Node(k',fg,fd) when k < k'  -> search k fg
  |Node(k',fg,fd) when k > k' -> search k fd
  |Node(k', fg, fd) when k = k' -> true
  |_ -> false

let rec insert (Node(k, fg, fd)) = function
  |Node(k', fg1, fd1) when k <= k' -> Node(k',(insert (Node(k, fg, fd)) fg1), fd1)
  |Node(k', fg1, fd1) when k > k' -> Node(k', fg1, (insert (Node(k, fg, fd)) fd1))
  |_ -> Node(k, fg, fd)

let rec print  = function
    Null -> print_string "()"
  |Node(k,fg,fd) -> 
      begin
        print_string "(";
        print_int k;
        print_string ", ";
        print fg;
        print_string ", ";
        print fd;
        print_string ")"
      end

let _ = main ()
