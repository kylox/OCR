
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

let init img =
  let (w,h) = Image_helper.get_dims img in
    for x = 0 to h-1 do
      for y = 0 to w-1 do
          Sdlvideo.put_pixel_color img x y (255,255,255)
      done
    done

let rot img angle =
 	let (w,h) = Image_helper.get_dims img in
 	let diag = int_of_float (sqrt (float (w * w + h * h))) in
 	let dst = Sdlvideo.create_RGB_surface_format img [] diag diag in init dst;
		(*Printf.printf "\nw:%d h:%d diag:%d\n" w h diag;*)
 	let rot_matrix = [|[|cos angle; -.sin angle|]; 
			               [|sin angle; cos angle|]|] in
	let (cx, cy) = (float w /. 2., float h /. 2.) in
 	for x = 0 to h-1 do
 	for y = 0 to w-1 do
 		let color = Sdlvideo.get_pixel_color img x y in
    if color != (255,255,255) then
		let pos = matrix_mult rot_matrix
			 [|[|float x -. cx|]; [|float y -. cy|]|] in
        let (posx, posy) = (int_of_float ((pos.(0).(0) +. cx +. 1.)), int_of_float ((pos.(1).(0) +. cy +. 1.))) in
          if posx < diag && posy < diag && posx >= 0 && posy >= 0 then
	 	         Sdlvideo.put_pixel_color dst
			         posx posy color
          else ()(*Printf.printf "segfault: %d %d\n" posx posy*)
 	done
 	done;
  dst

  let rot2 img angle =
  let (w,h) = Image_helper.get_dims img in
  let diag = sqrt (float (w * w + h * h)) in
  let dst = Sdlvideo.create_RGB_surface_format img [] (int_of_float diag) (int_of_float diag) in init dst;
    (*Printf.printf "\nw:%d h:%d diag:%d\n" w h diag;*)
  let (cx, cy) = (diag /. 2., diag /. 2.) in
  for x = 0 to int_of_float diag-1 do
  for y = 0 to int_of_float diag-1 do
      let (posx, posy) = (cos angle *. (float x -. cx) +. sin angle *. (float y -. cy), cos angle *. (float x -.cx) -. sin angle *. (float y -. cy) ) in
          if posx < float w && posy < float h && posx >= 0. && posy >= 0. then
            let color = Sdlvideo.get_pixel_color img (int_of_float (posx +. cx)) (int_of_float (posy +. cy)) in
              Sdlvideo.put_pixel_color dst
                x y color
          else ()(*Printf.printf "segfault: %d %d\n" posx posy*)
  done
  done;
  dst
 		
