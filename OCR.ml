let get_dims img =
  ((Sdlvideo.surface_info img).Sdlvideo.w, (Sdlvideo.surface_info img).Sdlvideo.h)

let sdl_init () =
  begin
    Sdl.init [`EVERYTHING];
    Sdlevent.enable_events Sdlevent.all_events_mask;
  end

let rec wait_key () =
  let e = Sdlevent.wait_event () in
    match e with
    Sdlevent.KEYDOWN _ -> ()
      | _ -> wait_key ()

let show img dst =
  let d = Sdlvideo.display_format img in
    Sdlvideo.blit_surface d dst ();
    Sdlvideo.flip dst

let level (r, g, b) = (r + g + b)/3;;

let color2grey (r,g,b) = 
  (level(r, g, b), level(r, g, b), level(r, g, b));;

let image2grey f img dst  =
  for x = 0 to ((Sdlvideo.surface_info img).Sdlvideo.h-1) do
    for y = 0  to ((Sdlvideo.surface_info img).Sdlvideo.w-1) do
     let (r,g,b) = f (Sdlvideo.get_pixel_color img x y) in
      Sdlvideo.put_pixel_color dst x y (r,g,b)
    done
  done


let rec count = function
  |[] -> 0
  |e::l -> 1 + count l ;;

let rec split =  function
  |[] -> ([],[])
  |[a] -> ([a],[])
  |e1::e2::l -> let (l1,l2) = split(l) in (e1::l1, e2::l2);;

let rec fusion (x,y) = match (x,y) with
  |([],[]) -> []
  |([],l2) -> l2
  |(l1,[]) -> l1
  |(e::l1,f::l2) when e <= f -> e::fusion(l1, y)
  |(e::l1,f::l2) when f <= e -> f::fusion (x, l2)
  |(_::_,_::_) -> failwith("somethings went wrong");;

let rec triFusion = function
  |[] -> []
  |[a] -> [a]
  |l -> let (l1,l2) = split(l) in fusion(triFusion(l1), triFusion(l2));;

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
  (*        for k = i-1 to i+1 do
             for l = j-1 to j+1 do
                liste := (Sdlvideo.get_pixel_color dst k l)::!liste
             done
          done;*)
         liste := triFusion(!liste);
         Sdlvideo.put_pixel_color dst w h (List.nth (!liste) 4)
	end;
       done
     done

let main () =
  begin
    if Array.length (Sys.argv) < 2 then
      failwith "Il manque le nom du fichier!";
    sdl_init ();
    let img = Sdlloader.load_image Sys.argv.(1) in
    let (w,h) = get_dims img in
    let tem = Sdlvideo.create_RGB_surface_format img [] w h in
    let display = Sdlvideo.set_video_mode w h [`DOUBLEBUF] in
   (* image2grey color2grey img tem; *)
    median img tem;
    show tem display;
    wait_key ();
    exit 0
  end
let _ = main ()
