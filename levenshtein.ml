let get_distance str1 str2 =
	if (str1 = str2) then 0
	else if (str1 = "") then String.length str2
	else if (str2 = "") then String.length str1
	else
		let s1 = if String.length str1 < String.length str2 then str1 else str2 in
		let s2 = if s1 = str1 then str2 else str1 in
		let array1 = Array.init (String.length s2 + 1) (fun i -> i) and
			array2 = Array.make (String.length s2 + 1) 0 in
				for i = 0 to String.length s1 - 1 do
					array2.(i) <- i + 1;
					for j = 0 to String.length s2 - 1 do
						let cost = if s1.[i] = s2.[j] then 0 else 1 in
							array2.(j+1) <- min (array2.(j) + 1) (min (array1.(j + 1) + 1) (array1.(j) + cost))
					done;
					Array.blit array2 0 array1 0 (Array.length array2)
				done;
				array2.(String.length s2);;

print_int (get_distance "bite" "vitesse")

(Array.Sub (i * nl.neurons.(i).nb_li) nl.neurons.(i).nb_li)