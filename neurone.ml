Random.self_init();;

type neurone = {
	inputs : float array;
	weights : float array;
}

let random_fill a =
	for	i = 0 to Array.length a - 1 do
			a.(i) <- (Random.float 1.) -. 0.5
	done;
	a

let create n = { inputs = Array.make n 0.; weights = random_fill (Array.make n 0.) }

let sigma neurone =
	let s = ref 0. in
		for	i = 0 to Array.length neurone.inputs - 1 do
			s := !s +. neurone.inputs.(i) *. neurone.weights.(i)
		done;
		!s
		
let eval neurone f = f (sigma neurone)

let set_inputs neurone array_inputs =
	for i = 0 to Array.length neurone.inputs - 1 do
		neurone.inputs.(i) <- array_inputs.(i)
	done

let learn neurone f array_test array_res coef =
	let r = ref true in
		for	i = 0 to Array.length array_test - 1 do
			set_inputs neurone array_test.(i);
			let output = eval neurone f in
				if (abs_float (output -. array_res.(i)) > 0.0001) then
					r := false;
					for j = 0 to Array.length neurone.weights - 1 do
						neurone.weights.(j) <- neurone.weights.(j) +. neurone.inputs.(j) *. coef *. (array_res.(i) -. output)
					done
		done;
		!r
	
let learn_all neurone f array_test array_res coef max print =
	let i = ref 0 in
		while !i < max && not (learn neurone f array_test array_res coef) do
			print neurone f array_test array_res !i;
			incr i
		done
		
let print_neurone neurone f =
	Printf.printf " inputs : [|";
	Array.iter (fun x -> Printf.printf "%f; " x) neurone.inputs;
	Printf.printf "|] -> %f \n" (eval neurone f)
	
let print_learning neurone f array_test array_res n =
	Printf.printf "\nlearning %d : " n;
	Printf.printf "weights : [|";
	Array.iter (fun x -> Printf.printf "%f; " x) neurone.weights;
	Printf.printf "|]\n";
	for i = 0 to Array.length array_test - 1 do
		set_inputs neurone array_test.(i);
		print_neurone neurone f
	done
	
	(* Test *)
	
let neurone = create 3

let array_test = [|[|1.; 1.; 1.|]; [|1.; 0.; 1.|]; [|1.; 1.; 0.|]; [|1.; 0.; 0.|]|]

let array_res = if Array.length Sys.argv > 4 then [|float_of_string
Sys.argv.(1); float_of_string Sys.argv.(2);
float_of_string Sys.argv.(3); float_of_string Sys.argv.(4)|] else [|1.; 1.; 1.; 0.|]

(*let g x = 1. /. (1. +. exp (-.x));;*)
let f x = if x > 0. then 1. else 0.;;
Printf.printf "neurone.ml\n";
learn_all neurone f array_test array_res 0.1 30 print_learning;;
