let level (r, g, b) =  int_of_float(0.299 *. float r +. 0.587 *. float g +. 0.114 *. float b)

let image_to_grey img dst = 
  let (w,h) = Image_helper.get_dims img in 
    for x = 0 to h-1 do
      for y = 0 to w-1 do
        let m = level (Sdlvideo.get_pixel_color img x y) in 
          Sdlvideo.put_pixel_color dst w y (m, m, m)
      done;
    done

let rot img angle =
	let (w,h) = Image_helper.get_dims img in
	let diag = sqrt (w*w + h*h) in
	let dst = Sdlvideo.create_RGB_surface_format diag diag in
	let rot_matrix = [|[|cos angle; -sin angle|]; [|sin angle; cos angle|] in
		for x = 0 to h-1 do
			for y = 0 to w-1 do
				let pos = matrix_mult rot_matrix [|[|x|]; [|y|] in
				let color = Sdlvideo.get_pixel_color img x y in
					Sdlvideo.put_pixel_color dst pos.(0).(0) pos.(1).(0) color
			done;
		done
		
		
let matrix_mult x y =
  let x0 = Array.length x
  and y0 = Array.length y in
  let y1 = if y0 = 0 then 0 else Array.length y.(0) in
  let z = Array.make_matrix x0 y1 0 in
  for i = 0 to x0-1 do
    for j = 0 to y1-1 do
      for k = 0 to y0-1 do
        z.(i).(j) <- z.(i).(j) + x.(i).(k) * y.(k).(j)
      done
    done
  done;
  z