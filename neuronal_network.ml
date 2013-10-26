type neuron = {
	nb_li : int;
	weights : float array
}

type neuron_layer = {
	nb_n : int;
	neurons : neuron array
}

type neuronal_network = {
	nb_la : int;
	nb_out : int;
	layers : neuron_layer array;
	inputs : float array
}

let random_fill =
	Random.self_init();
	fun a ->
		for	i = 0 to Array.length a - 1 do
				a.(i) <- (Random.float 1.) -. 0.5
		done;
		a

let create_neuron nb_li = { nb_li = nb_li; weights = random_fill (Array.make nb_li 0.) }

let create_layer nb_n nb_li = { nb_n = nb_n; neurons = Array.init nb_n (fun i -> create_neuron nb_li) }

let create_network nb_in nb_la nb_n = { 
	nb_la = nb_la;
	nb_out = nb_la - nb_n + 1;
	layers = Array.init nb_la (fun i -> create_layer (nb_n - i) (if i = 0 then nb_in else nb_la - i + 1));
	inputs = Array.make nb_in 0.
}

let eval_neuron n f inputs = 
	let s = ref 0. in
		for i = 0 to Array.length inputs do
			s := !s +. inputs.(i) *. n.weights.(i)
		done;
		f !s
		
let eval_layer nl f inputs = Array.init nl.nb_n 
	(fun i -> eval_neuron nl.neurons.(i) f (Array.sub inputs (i * nl.neurons.(i).nb_li) nl.neurons.(i).nb_li))
									
let eval_network nn f inputs = 
	let out = ref inputs in
		for i = 0 to nn.nb_la do
			out := eval_layer nn.layers.(i) f !out
		done;
		!out


