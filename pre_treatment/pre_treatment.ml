
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

let contour img dst = Convolution.bord img dst;
  dst


let invert_black_white mat =
   let(w,h) = (Array.length mat,Array.length mat.(0)) in
   for y = 0 to h-1 do
   for x = 0 to w-1 do
     if(mat.(x).(y) = (0,0,0)) then
        mat.(x).(y) <- (255,255,255)
     else
        mat.(x).(y) <-(0,0,0)
   done
   done;
(mat)
(*h1, w1 => hauteur et largeur de l'image de base , h2 w2 => hauteur et largeur de l'image redimensionne,img est la matrice image de base *)
  let resize img h2 w2=
  let(w1,h1) =(Array.length img,Array.length img.(0)) in
  let dst = Array.make_matrix h2 w2 (255,255,255) in
  let x_ratio =w1/w2 in
  let y_ratio = h1/h2 in
  for y=0 to h2-1 do
    for x=0 to w2-1 do
       let (x2,y2) = (x*x_ratio,y*y_ratio) in
       dst.((y*w2)+x).((x*h2)+y) <- img.((y2*w1)+x2).((x2*h1)+y2)
    done
  done;
dst
 
(* let resize matrice h2 w2 *)
   		
