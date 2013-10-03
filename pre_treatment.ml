let image_to_grey img dst =
	let (w, h) - Image_helper.get_dims img in
		for x = 0 to h-1 do
			for y = 0  to w-1 do
				let m = level (Sdlvideo.get_pixel_color img x y) in
					Sdlvideo.put_pixel_color dst x y (m, m, m)
			done
		done
		
let level (r, g, b) = 0.299 *. float r + 0.587 *. float g + 0.114 *. float b;

let get_moyenne img =
	let (w, h) - Image_helper.get_dims img in
	let m = ref 0 in
		for x = 0 to h-1 do
			for y = 0  to w-1 do
				let (r, g, b) = Sdlvideo.get_pixel_color img x y in
					m := !m + r
			done
		done
		m / (h * w)

let binarise img =
	let (w, h) - Image_helper.get_dims img in
	let m = get_moyenne img in
		for x = 0 to h-1 do
			for y = 0  to w-1 do
				let (r, g, b) = Sdlvideo.get_pixel_color img x y in
					if (r > m) then
						Sdlvideo.put_pixel_color dst x y (255, 255, 255)
					else
						Sdlvideo.put_pixel_color dst x y (0, 0, 0)
			done
		done