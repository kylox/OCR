
let matrix_mult x y =
	let x0 = Array.length x
   	and y0 = Array.length y in
   	let y1 = if y0 = 0 then 0 else Array.length y.(0) in
   	let z = Array.make_matrix x0 y1 0. in
   	for i = 0 to x0-1 do
     		for j = 0 to y1-1 do
       			for k = 0 to y0-1 do
         			z.(i).(j) <- z.(i).(j) +. x.(i).(k) *. y.(k).(j)
       			done
     		done
   	done;
   	z

let rot img angle =
 	let (w,h) = Image_helper.get_dims img in
 	let diag = int_of_float (sqrt (float (w * w + h * h))) in
 	let dst = Sdlvideo.create_RGB_surface_format img [] diag diag in
		Printf.printf "\nw:%d h:%d diag:%d\n" w h diag;
 	let rot_matrix = [|[|cos angle; -.sin angle|]; 
			   [|sin angle; cos angle|]|] in
	let (cx, cy) = (w / 2, h / 2) in
 	for x = 0 to h-1 do
 	for y = 0 to w-1 do
 		let color = Sdlvideo.get_pixel_color img x y in 
		let pos = matrix_mult rot_matrix
			 [|[|float (x - cx)|]; [| float (y - cy)|]|] in
		if ((int_of_float pos.(0).(0)) + cx) >= diag ||
		   ((int_of_float pos.(1).(0)) + cy) >= diag then
			Printf.printf "segfault %d %d"
				((int_of_float pos.(0).(0)) + cx) 
				((int_of_float pos.(1).(0)) + cy);
 (*Printf.printf "x:%d y:%d" 
		((int_of_float pos.(0).(0)) + cx) 
		((int_of_float pos.(1).(0)) + cy)*)
	 	(*Sdlvideo.put_pixel_color dst
			 (int_of_float pos.(0).(0))
			 (int_of_float pos.(1).(0)) color*)
 	done
 	done
 		
