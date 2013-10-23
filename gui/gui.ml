let _ = GMain.init ()
 
(* Fenêtre principale de l'application. *)
let window = GWindow.window
  ~title:"CamlT'OCR"
  ~height:700
  ~width:700 ()
 
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
let item6 = GButton.tool_item  ~packing:toolbar#insert ()
 
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
        ~file: "lena.jpg"
  ~packing:(vbox#pack ~expand:false) ()
 
(* Bouton pour up l'img *)
 
let image_print () =
                ignore (GMisc.image
                ~file: "lena.jpg"
                ~packing:vbox#pack() )
 
let display = Gaux.may ~f:image#set_file
 
let affiche btn () = Gaux.may print_endline btn#filename
 
 
 
(* Pack de droite *)
 
let vbox2 = GPack.vbox
  ~spacing:10
  ~border_width:10
  ~packing:mil#add ()
 
let bopen =GButton.button
	~label:"open"
		~packing:item#add ()

let bgrey = GButton.button
	 ~label:"To Grey"
		~packing:item2#add () 
             
let bnb = GButton.button
  ~label:"N&B"
        ~packing:(item3#add) ()
 
let bbina = GButton.button
	~label:"Binarisation"
		~packing:item4#add ()
 
let brotation = GButton.button
  ~label:"Rotation"
        ~packing:(item5#add) ()
 
let bmedian = GButton.button
  ~label:"Filtre mediant"
        ~packing:(item6#add) ()
 

 
(* Fonction àlakon *)
(*let print_hello () =
  let user = Glib.get_user_name () in
  Printf.printf "Bonjour %s !\n%!" (String.capitalize user)*)
 
 
let _ =
  ignore(window#connect#destroy ~callback:GMain.quit);
 
 
  window#show ();
  GMain.main ()
