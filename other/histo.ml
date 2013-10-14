type histogram = int array

(* creer l'histogramme de l'image *)

let get_histogram img =
  let (w,h) = Image_helper.get_dims img in
  let t = Array.make 256 0 in 
    for x =0 to w-1 do
      for y=0 to h-1 do 
        let v = To_grey.get_r(Sdlvideo.get_pixel_color img x y) in 
          t.(v) <- t.(v)+1;
      done;
    done;
      (t:histogram)

(*renvoie la valeur mediane de l'histogramme*)

let histogram_median (h : histogram) = 
  let from = 0 and 
  to_ = 255 in 
  let left = h.(from) and right = h.(to_) in 
  let rec aux from to_ left right =
    if from = to_
    then (from)
    else 
      if left < right 
      then aux (succ from) to_ (left + h.(from)) right 
      else aux from (pred to_) left (right + h.(to_))
  in
    aux from to_ left right

(*affiche l'histogramme*)

let display_histo dst =
  let h = get_histogram dst in
    for x = 0 to 255 do
        for y =0 to  h.(x)  do
          Sdlvideo.put_pixel_color dst x (y/1000) (0,255,0);
        done;
    done;
    
