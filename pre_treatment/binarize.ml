let var k h  = 
  let v = ref 0. in
  for i = 0 to k do
    v := !v +. h.(i) *. float i
  done;
  (!v)

let moy k h =
  let m = ref 0. in 
    for i = 0 to k do
      m:= !m +.  h.(i)
    done;
    (!m)
 

let otsu img = 
  let (w,h) = Image_helper.get_dims img in
  let hi = Histo.get_histogram img in
  let p = Array.make 256 0. in
    for i = 0 to 255 do 
      p.(i) <- float(hi.(i)) /. (float w *. float h);
    done;
    let seuil_1 = ref 0. in
    let seuil_2 = ref 0. in 
    let t_1 = ref 0 in
    let t_2 = ref 0 in  
     for i = 1 to 255 do
     let s = (var i p) *. (1. -. (var i p)) *. (p.(255) *. (var i p) -. (moy i p)) *. (p.(255) *. (var i p) -. (moy i p)) in 
       if s > !seuil_2 then
         begin
         if s > !seuil_1 then 
           begin
           seuil_2 := !seuil_1 ;
           seuil_1 := s;
           t_2 := !t_1;
           t_1 := i
           end 
         else
           seuil_2 := s;
           t_2 := i
         end
     done;
     (!t_2 + !t_1)*8/5

let binarize img =
 let h = Histo.get_histogram img in
 let moy = otsu img in
 let (w,h) = Image_helper.get_dims img in
   for i = 0 to w-1 do
     for j =0 to h-1 do
     (*  print_int(moy); *)
       if To_grey.get_r(Sdlvideo.get_pixel_color img i j) <= moy then
        Sdlvideo.put_pixel_color img i j (0,0,0)
       else
        Sdlvideo.put_pixel_color img i j (255,255,255)
      done;
     done; 
(*let binarize greypict =
	let(w,h) = Image_helper.get_dims greypict in
	  for y=0 to h-1 do
	     for x=0 to w-1 do
               let pix = Sdlvideo.get_pixel_color greypict x y in
                 if To_grey.get_r(pix) <=127 then
		    Sdlvideo.put_pixel_color greypict x y (0,0,0)
                 else
                    Sdlvideo.put_pixel_color greypict x y (255,255,255)
              done;
           done;

 *)              
