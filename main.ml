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
      if Array.length (Sys.argv) < 3 then
        failwith "Il manque le nom du fichier!";

      sdl_init ();
      let img = Sdlloader.load_image Sys.argv.(2) in
      let (w,h) = Image_helper.get_dims img in
      let display = Sdlvideo.set_video_mode w h [`DOUBLEBUF] in
      let dst = ref (Sdlvideo.create_RGB_surface_format img [] w h) in
        if(Sys.argv).(1) = "-g" then 
          begin
            To_grey.image_to_grey img !dst;
            Image_helper.show !dst display;
            Printf.printf "image_to_grey\n";
            wait_key ();
          end
        else
          if (Sys.argv).(1) = "-c" then
            begin
              if (Sys.argv).(3) = "flou" then
                begin 
                  Convolution.flou img !dst;
                  Image_helper.show !dst display;
                  Printf.printf("flou done!");
                  wait_key();
                end
              else
                if(Sys.argv).(3) = "bords" then 
                  begin
                    Convolution.bord img !dst;
                    Image_helper.show !dst display;
                    Printf.printf("bord done!");
                    wait_key();
                  end
                else
                  Printf.printf("please chose a valid filter : ./ocr -b [img] [flou|bord]")
            end
          else
            if(Sys.argv).(1)  = "-b" then
              begin
                To_grey.image_to_grey img !dst;
                Image_helper.show !dst display;
                Printf.printf "image_to_grey\n";
                Binarize.binarize !dst;
                Image_helper.show !dst display;
                Printf.printf "binarize\n";
                wait_key ();
              end
            else
              if(Sys.argv).(1) = "-m" then 
                begin
                  Median.median img !dst; 
                  Image_helper.show !dst display;
                  Printf.printf "median\n";
                  wait_key ();
                end  
                else
                  if (Sys.argv).(1) = "-r" then 
                    begin

                      dst := img;
                      let im2mat = Rotation.img2matrice !dst in
                      let angle = Rotation.hough im2mat in
                        dst := Pre_treatment.rot !dst angle;
                        Image_helper.show !dst display;
                        Printf.printf "rot\n";
                        wait_key();
                    end
                    else
                      if(Sys.argv).(1) = "-x" then
                        begin 
                          To_grey.image_to_grey img !dst;
                          Image_helper.show !dst display;
                          Printf.printf "image_to_grey\n";
                          Binarize.binarize !dst;
                          Image_helper.show !dst display;
                          Printf.printf "binarize\n";
                          Printf.printf "rot\n";
                          Xy_cut.test_blocks !dst (if (Array.length Sys.argv > 3) then int_of_string (Sys.argv).(3) else 6);
                          Image_helper.show !dst display;
                          Printf.printf "xycut\n";
                          wait_key (); 
                        end
                        else
                          if(Sys.argv).(1) = "-rx" then
                            begin 
                              To_grey.image_to_grey img !dst;
                              Image_helper.show !dst display;
                              Printf.printf "image_to_grey\n";
                              Binarize.binarize !dst;
                              Image_helper.show !dst display;
                              Printf.printf "binarize\n";
                              let im2mat = Rotation.img2matrice !dst in
			      let little = Pre_treatment.resize im2mat 200 200 in
                               Image_helper.show little display;
                              
                             (* let angle = Rotation.hough im2mat in
                              dst := Pre_treatment.rot !dst angle;
                              Image_helper.show !dst display;
                              Printf.printf "rot\n";
                              Xy_cut.test_blocks !dst (if (Array.length Sys.argv > 3) then int_of_string (Sys.argv).(3) else 6);
                              Image_helper.show !dst display;
                              Printf.printf "xycut\n";*) 
                              wait_key (); 
                            end;
        (* 
         (*
          Median.median img !dst; 
          Image_helper.show !dst display;
          Printf.printf "median\n";
          (*wait_key ();*)
          *)
         Binarize.binarize !dst;
         Image_helper.show !dst display;
         Printf.printf "binarize\n";
         (*wait_key ();*)
         (*
          Median.median img !dst; 
          Image_helper.show !dst display;
          Printf.printf "median\n";
          (*wait_key ();*)

          let im2mat = Rotation.img2matrice !dst in
          let angle = Rotation.hough im2mat in
          dst := Pre_treatment.rot !dst 0.0;
          Image_helper.show !dst display;
          Printf.printf "rot\n";
          (*wait_key ();*)

          Xy_cut.test_blocks !dst;
          Image_helper.show !dst display;
          Printf.printf "xycut\n";
          wait_key ();*)*)
        if (Array.length Sys.argv > 3 && String.length (Sys.argv).(Array.length Sys.argv - 1) > 1) then
            Sdlvideo.save_BMP !dst ((Sys.argv).(Array.length Sys.argv - 1));
        exit 0
    end

let _ = main ()
