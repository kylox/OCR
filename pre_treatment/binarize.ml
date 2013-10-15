let binarize img =
 let h = Histo.get_histogram img in
 let moy = Histo.histogram_median h in
 let (w,h) = Image_helper.get_dims img in
   for i = 0 to w-1 do
     for j =0 to h-1 do
       print_int(i);
       if To_grey.get_r(Sdlvideo.get_pixel_color img i j) <= moy then
        Sdlvideo.put_pixel_color img i j (0,0,0)
       else
        Sdlvideo.put_pixel_color img i j (255,255,255)
      done;
     done;
