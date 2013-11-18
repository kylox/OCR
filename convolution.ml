let in_bounds (x,y) img = 
  let (w,h) = Image_helper.get_dims img in 
   (x > 0 && x < w && y > 0 && y < h)

let apply_filter (x,y) filter img = 
  let r = ref 0 in
  let g = ref 0 in
  let b = ref 0 in 
    for i = (-1) to 1 do
      for j = (-1) to 1 do
        if in_bounds (x+i,y+j) img then 
         begin 
          r := !r + To_grey.get_r(Sdlvideo.get_pixel_color img (x+i) (y+j) )*filter.(i+1).(j+1);
          g:= !g + To_grey.get_r(Sdlvideo.get_pixel_color img (x+i) (y+j))*filter.(i+1).(j+1);
          b:= !b +  To_grey.get_r(Sdlvideo.get_pixel_color img (x+i) (y+j))*filter.(i+1).(j+1);
         end
      done;
    done;
      (!r/9,!g/9,!b/9)

let convolution filter img dst = 
  let (w,h) = Image_helper.get_dims img in 
    for i = 0 to w do
      for j = 0 to h do 
     Sdlvideo.put_pixel_color dst i j (apply_filter (i,j) filter img);
      done
    done

let flou img dst = 
  let flou = Array.make_matrix 3 3 1 in
    convolution flou img dst

let bord img dst = 
  let bord = Array.make_matrix 3 3 0 in
    begin
      bord.(1).(1) <- (-4);
      bord.(0).(1) <- 1;
      bord.(1).(0) <- 1;
      bord.(2).(0) <- 1;
      bord.(0).(2) <- 1;
    end;
      convolution bord img dst

    
