open "image_helper.ml"

(*filtre gris*)

let level (r,g,b) = (r + g + b)/3

let color2grey (r, g, b) = 
  (level(r,g,b), level(r,g,b), level(r,g,b))

let image_to_grey img dst  =
  for x = 0 to ((Sdlvideo.surface_info img).Sdlvideo.h-1) do
    for y = 0  to ((Sdlvideo.surface_info img).Sdlvideo.w-1) do
     let (r,g,b) = f (Sdlvideo.get_pixel_color img x y) in
      Sdlvideo.put_pixel_color dst x y (r,g,b)
    done
  done

(*filtre median*)

let median img dst =
 image2grey color2grey img dst ; 
  let (w,h) = get_dims img in
    for i = 1 to w-2 do
      for j = 1 to h-2 do
	begin
        let liste = ref [] in
	liste := (Sdlvideo.get_pixel_color dst i-1 j-1)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i j-1)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i-1 j)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i j)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i+1 j-1)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i-1 j+1)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i j+1)::!liste;
        liste := (Sdlvideo.get_pixel_color dst i+1 j)::!liste;
(*for k = i-1 to i+1 do
    for l = j-1 to j+1 do
      liste := (Sdlvideo.get_pixel_color dst k l)::!liste
    done
  done;*)
         liste := triFusion(!liste);
         Sdlvideo.put_pixel_color dst w h (List.nth (!liste) 4)
	end;
       done
     done

let binarise = 0

