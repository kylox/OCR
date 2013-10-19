let get_Mat img = 
  let (w,h) = Image_helper.get_dims img in 
  let mat = ref (Array.make_matrix w h 0) in
    for x = 0 to w do
      for y = 0 to h do
        match Sdlvideo.get_pixel_color x y img with
           (0,0,0) -> !mat.(x).(y) = 0
          | _ -> !mat.(x).(y) = 1
      done;
    done;
