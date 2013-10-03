open "image_helper.ml"
open "pre_treatment.ml"
open "post_treatment.ml"

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
    wait_key ();
    exit 0
  end
  
let _ = main ()