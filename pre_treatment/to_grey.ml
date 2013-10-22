let level (r, g, b) = int_of_float(0.299 *. float r +. 0.587 *. float g +. 0.114 *. float b)
   
let get_r (r,g,b) = r
let get_g (r,g,b) = g
let get_b (r,g,b) = b

let image_to_grey img dst =
  let (w,h) = Image_helper.get_dims img in
    for y = 0 to h-1 do
      for x = 0 to w-1 do
        let m = ref (level (Sdlvideo.get_pixel_color img x y)) in
          Sdlvideo.put_pixel_color dst x y (!m,!m , !m);
      done;
    done;
