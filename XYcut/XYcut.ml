let get_X img x =
  let nb  = ref 0 in
  let (w,h) = Image_helper.get_dims img in
    for i = 0 to w-1 do
      nb := !nb  + To_grey.get_r(Sdlvideo.get_pixel_color img i x) ;
    done;
  nb := !nb / (w - 1);
  !nb

let get_Y img y =
  let nb = ref 0 in 
  let (w,h) = Image_helper.get_dims img in
    for i= 0 to h - 1 do
      nb := !nb + To_grey.get_r(Sdlvideo.get_pixel_color img y i);
    done;
  nb := !nb / (h - 1);
  !nb
(*
let extract_line img =
  let (w,h) = Image_helper.get_dims img in
    (*
    for i = 0 to w-1 do
      if get_Y img i = 0 then
        for j = 0 to h-1 do
          Sdlvideo.put_pixel_color img i j (255,0,0)
        done;
    done;*)
      for i = 0 to h-1 do
        if get_X img i = 0 then 
          for j = 0 to w-1 do
            print_int(j);
            Sdlvideo.put_pixel_color img j i (255,0,0)
          done;
      done;
 *)
      let display_XYcut img = 
        Box.draw_Box (Box.origin img) img
