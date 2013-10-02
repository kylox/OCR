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


let binarisation img dst =
  for x = 0 to ((Sdlvideo.surface_info img).Sdlvideo.h-1) do
    for y = 0  to ((Sdlvideo.surface_info img).Sdlvideo.w-1) do
	let (r,g,b) =  Sdlvideo.get_pixel_color img x y in 
		if (r+b+g/3) < 127 then (r,g,b) = (0,0,0)
		else (r,g,b) = (255,255,255);
		Sdlvideo.put_pixel_color dst x y (r,g,b)
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
    let dst = Sdlvideo.create_RGB_surface_format img [] w h in
    let display = Sdlvideo.set_video_mode w h [`DOUBLEBUF] in
    image2grey color2grey img tem; 
    binarisation tem dst;
    show tem display;
    wait_key ();
    exit 0
  end
let _ = main ()
