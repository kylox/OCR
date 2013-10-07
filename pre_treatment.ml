let level (r, g, b) =  int_of_float(0.299 *. float r +. 0.587 *. float g +. 0.114 *. float b)

let image_to_grey img dst = 
  let (w,h) = Image_helper.get_dims img in 
    for x = 0 to h-1 do
      for y = 0 to w-1 do
        let m = level (Sdlvideo.get_pixel_color img x y) in 
          Sdlvideo.put_pixel_color dst w y (m, m, m)
      done;
    done
