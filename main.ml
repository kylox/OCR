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
    let (w,h) = Image_helper.get_dims img in
    let display = Sdlvideo.set_video_mode w h [`DOUBLEBUF] in
    let dst = ref (Sdlvideo.create_RGB_surface_format img [] w h) in

    To_grey.image_to_grey img !dst;
    Image_helper.show !dst display;
    Printf.printf "image_to_grey\n";
    wait_key ();

    Binarize.binarize !dst;
<<<<<<< HEAD
    (*Median.median !dst; 
    XYcut.display_XYcut !dst;
    let im2mat = Rotation.img2matrice !dst in
    	let angle = Rotation.hough im2mat in
		Pre_treatment.rot !dst 1.5;*)
                Sdlvideo.save_BMP !dst "dst";
    		Image_helper.show !dst display;
=======
    Image_helper.show !dst display;
    Printf.printf "binarize\n";
    wait_key ();

    Median.median !dst; 
    Image_helper.show !dst display;
    Printf.printf "median\n";
    wait_key ();

    let im2mat = Rotation.img2matrice !dst in
    	let angle = Rotation.hough im2mat in
		      dst := Pre_treatment.rot !dst 0.02;
          Image_helper.show !dst display;
          Printf.printf "rot\n";
          wait_key ();

    XYcut.display_XYcut !dst;
	  Image_helper.show !dst display;
    Printf.printf "xycut\n";
>>>>>>> df7a04edffbad23ea5badd87a90c0e990afceda1
    wait_key ();

    exit 0
  end
  
let _ = main ()
