let _ = GMain.init ()
 
(* Fenêtre principale de l'application. *)
let window = GWindow.window
  ~title:"CamlT'OCR"
  ~height:700
  ~width:1000 ()
 
(* Pack principal qui contient tous les widget *)
let vboxall = GPack.vbox
  ~packing:window#add ()
 
(* Pack dans lequel il y a la toolbar *)
 
let box = GPack.vbox
        ~packing:vboxall#add ()
 
let toolbar = GButton.toolbar  
  ~orientation:`HORIZONTAL  
  ~style:`ICONS
  ~packing:(box#pack ~expand:false) ()
 
let item = GButton.tool_item  ~packing:toolbar#insert ()
let item2 = GButton.tool_item  ~packing:toolbar#insert ()
let item3 = GButton.tool_item  ~packing:toolbar#insert ()
let item4 = GButton.tool_item  ~packing:toolbar#insert ()
let item5 = GButton.tool_item  ~packing:toolbar#insert ()
let itemabout = GButton.tool_item  ~packing:toolbar#insert ()
 
(* Pack du milieu *)
let mil = GPack.hbox
  ~packing:vboxall#add ()
 
(* Pack de gauche *)
let vbox = GPack.vbox
        ~height: 600
  ~packing:mil#add ()
 
let separator = GMisc.separator `HORIZONTAL
        ~packing:(vbox#pack ~expand:false) ()
 
(* Image *)
 
let image = GMisc.image
        ~file: "image.jpg"
  ~packing:(vbox#pack ~expand:false) ()
 
(* Bouton pour up l'img *)
 
let image_print () =
                ignore (GMisc.image
                ~file: "image.jpg"
                ~packing:vbox#pack() )
 
let display = Gaux.may ~f:image#set_file
 
let affiche btn () = Gaux.may print_endline btn#filename
 
 
 
(* Pack de droite *)
 
let vbox2 = GPack.vbox
  ~spacing:10
  ~border_width:10
  ~packing:mil#add ()
 
let bbin = GButton.button
  ~label:"Binarisation"
        ~packing:(item3#add) ()
 
let bflitrelissage = GButton.button
  ~label:"N&B"
        ~packing:(vbox2#pack) ()
 
 
let brotation = GButton.button
  ~label:"Rotation"
        ~packing:(item4#add) ()
 
let bextraction = GButton.button
  ~label:"Extraction"
        ~packing:(item5#add) ()
 

 
(* Fonction àlakon *)
(*let print_hello () =
  let user = Glib.get_user_name () in
  Printf.printf "Bonjour %s !\n%!" (String.capitalize user)*)
 
 
let _ =
  window#connect#destroy ~callback:GMain.quit;
 
 
  window#show ();
  GMain.main ()
