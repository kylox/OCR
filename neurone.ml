type neurone = {
	inputs : float array;
	weights : float array;
};;

Random.self_init();;

let random_fill a =
	for	i = 0 to Array.length a - 1 do
			a.(i) <- (Random.float 2.) -. 1.
	done;
	a

let create array_sy = { inputs = array_sy; weights = random_fill (Array.make (Array.length array_sy) 0.) }

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
	for	i = 0 to Array.length array_test - 1 do
		set_inputs neurone array_test.(i);
		let output = eval neurone f in
			if (output != array_res.(i)) then
				for j = 0 to Array.length neurone.weights - 1 do
					neurone.weights.(j) <- neurone.weights.(j) +. neurone.inputs.(j) *. coef *. (array_res.(i) -. output)
				done
	done
	
	(* Test *)
	
let neurone_OR = create [|1.; 1.; 1.|]

let array_test = [|[|1.; 1.; 1.|]; [|1.; 0.; 1.|]; [|1.; 1.; 0.|]; [|1.; 0.; 0.|]|]

let array_res = [|1.; 1.; 1.; 0.|]

(*let g x = 1. /. (1. +. exp (-.x));;*)
let f x = if x > 0. then 1. else 0.;;

for i = 0 to 40 do
	learn neurone_OR f array_test array_res 0.1;
	
	print_string "\n eval ";
	print_int i;
	print_string " : ";
		
	set_inputs neurone_OR [|1.; 1.; 1.|];
	print_float (eval neurone_OR f);
	
	print_string " ";

	set_inputs neurone_OR [|1.; 0.; 1.|];
	print_float (eval neurone_OR f);
	
	print_string " ";

	set_inputs neurone_OR [|1.; 1.; 0.|];
	print_float (eval neurone_OR f);
	
	print_string " ";

	set_inputs neurone_OR [|1.; 0.; 0.|];
	print_float (eval neurone_OR f);
	
	print_string "\n coefs: ";

	print_float neurone_OR.weights.(0);
	print_string " ";
	print_float neurone_OR.weights.(1);
	print_string " ";
	print_float neurone_OR.weights.(2);
	
	print_string "\n";
done;;