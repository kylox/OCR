type box = {
  c : int * int;
  w : int;
  h : int;
}

let init c w h = {
  c = c;
  w = w;
  h = h;
}

let origin img = 
  let (w, h) = Image_helper.get_dims img in 
  let box = init (0,0) w h in box
    
let draw_Box b img =
  let (x,y) = b.c in 
  for i = 0 to b.w do
      Sdlvideo.put_pixel_color img i x  (255,0,0);
      Sdlvideo.put_pixel_color img i (x + (b.h) - 1) (255, 0, 0);
  done;
  for i = 0 to b.h do
    Sdlvideo.put_pixel_color img  y i (255, 0, 0);
    Sdlvideo.put_pixel_color img  (y + (b.w) - 1) i  (255, 0, 0);
  done
