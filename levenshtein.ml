let get_matrix_distance x y =
  let m = Array.make_matrix ((String.length x)+1) ((String.length) y+1) 0 in
  let rec distance = function
      (0,k)-> let x = k in m.(0).(k) <- x;x
    |(k,0) -> let x = k in m.(k).(0) <- x;x 
    |(i,j) when x.[i-1] = y.[j-1] -> let x = min ((distance (i-1, j)) +1) (min ((distance (i, j-1)) +1)  (distance (i-1, j-1))) in m.(i).(j) <- x;x
    |(i,j) -> let x = min ((distance (i - 1, j)) + 1) (min ((distance (i, j - 1)) + 1) ((distance (i-1, j-1)) + 2)) in m.(i).(j) <- x;x
  in
    (distance ((String.length x), (String.length y)));
      m

let _ = let m = get_matrix_distance "intention" "execution" in
  print_string("   |0|1|2|3|4|5|6|7|8|9|");
  print_newline();
    print_string("--------------------------");
  for i = 0 to 9 do
    print_newline();
    print_string("---------------");
    print_newline();
    print_int(i); print_string("||");
      for j = 0 to 9 do
        print_string("|");
        print_int(m.(i).(j))
      done;
  done 
 
