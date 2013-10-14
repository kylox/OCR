 let level (r, g, b) =  int_of_float(0.299 *. float r     +. 0.587 *. float g +. 0.114 *. float b)

let rec split =  function
  |[] -> ([],[])
  |[a] -> ([a],[])
  |e1::e2::l -> let (l1,l2) = split(l) in (e1::l1, e2::l2)

let rec fusion (x,y) = match (x,y) with 
  |([],[]) -> []
  |([],l2) -> l2
  |(l1,[]) -> l1
  |(e::l1,f::l2) when e <= f -> e::fusion(l1, y)
  |(e::l1,f::l2) when f <= e -> f::fusion (x, l2)
  |(_::_,_::_) -> failwith("somethings went wrong")

let rec triFusion = function
  |[] -> []
  |[a] -> [a]
  |l -> let (l1,l2) = split(l) in fusion(triFusion(l1), triFusion(l2))

let get_median img x y =
  let  liste = ref [] in
    for x = x - 1 to x + 1 do
      for y = y - 1 to y + 1 do
        let color = Sdlvideo.get_pixel_color img x y in
          liste := color::!liste
      done;
    done;
    liste := triFusion(!liste);
    List.nth !liste 4

let median img dst =  
  let (w,h) = Image_helper.get_dims img in 
    for i = 1 to w-2 do 
      for j = 1 to h-2 do 
        let m = get_median img i j  in
         Sdlvideo.put_pixel_color dst i j m;
       done;
     done;
