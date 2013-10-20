(* matrice est un tableau de pixel *)
let hough matrice =
        (* Declaration des constantes *)
        let pi = acos(-1.) and pi02 = asin(1.) in
        let  (w,h) = (Array.length matrice,Array.length matrice.(0)) in
        let diagonal = int_of_float(sqrt(float_of_int(w*w+ h*h))) in
        let matrice_de_vote = Array.make_matrix diagonal ((int_of_float(pi*.100.))+1) 0 in
        (* on declare les variables qu'on va remplire : a savoir teta max et l
         * angle le plus vote *)
        let teta_max = ref 0. in
        let vote_max = ref 0  in
        (* Allez les noobs, on va parcourire l'image *)
        for y=0 to h-1 do
           for x=0 to w-1 do
              if (matrice.(x).(y) == (0,0,0)) then
                begin
             (* t est l angle qu on fera variee -pi/2 a pi/2 *)
                let t = ref(-.pi02) in
                (* parcour de l'inertvalle d'angle  *)                   
                 while ( !t <= pi02 ) do
                  let droite =int_of_float((float x *. (cos !t))+.(float
                  y *. (sin !t))) in
                       if droite>=0 then (* on remplis le tableau de vote *)
                         begin
                          let teta_i = int_of_float(!t*.100. +. pi02*.100.)in
                           matrice_de_vote.(droite).(teta_i) <-
                                  matrice_de_vote.(droite).(teta_i)+1;
                           if !vote_max < matrice_de_vote.(droite).(teta_i) then
                                  begin
                                  vote_max := matrice_de_vote.(droite).(teta_i);
                                  teta_max := !t;
                                  end;
                         end;
                         t := !t +. 0.01; (* on incremente l'angle de 0.01 *) 
                 done;
                end;
           done;
        done;
        print_float(!teta_max);
        (!teta_max)


let img2matrice img =
   let(w,h) = Image_helper.get_dims img in
   let matrice = Array.make_matrix w h (255,255,255) in
	for y=0 to h-1 do
	   for x=0 to w-1 do
	     matrice.(x).(y) <- Sdlvideo.get_pixel_color img x y
	   done;
 	done;
     matrice;;
		       
