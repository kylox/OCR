let _ = GMain.init ()

(*fenètre principale*)
let window = GWindow.window
	~title: "OCR"
	~height:700
	~width:1200 ()
	~resizable:true

(*boite principal à rangement vertical*)
let vbox = GPack.vbox
	~spacing:10
	~packing:window#add ()

(*toolbar*)
let toolbar = GButton.toolbar  
  ~orientation:`HORIZONTAL
  ~packing:(vbox#pack ~expand:false) ()


(*boite horizontal*)
let hbox = GPack.hbox 
  ~spacing:10
  ~packing:vbox#add ()


let treatment = 
	let button = GButton.tool_button
		~label:"treatment"
    	~packing:toolbar#insert () in
  		button#connect#clicked (*~callback: fonction de traitement*);
  		button



(*bouton quit*)
let quit = 
  let button = GButton.tool_button
    ~stock:`QUIT
    ~packing:toolbar#insert () in
  	button#connect#clicked ~callback:GMain.quit;
  	button


(*boite horizontal*)
let hbox = GPack.hbox 
  ~spacing:10
  ~packing:vbox#add ()

let may_print btn () = Gaux.may print_endline btn#filename

(*l'image*)
let open_button = 
  let button = GFile.chooser_button
    ~action:`OPEN
    ~packing:(vbox#pack ~expand:false) () in
  button#connect#selection_changed (may_print button);
  button

  let get_contents = function
  | Some x -> "%x"
  | _ -> raise Not_found

let scroll = GBin.scrolled_window  (*barre de défillement*)
    	~hpolicy:`ALWAYS
    	~vpolicy:`ALWAYS
    	~shadow_type:`ETCHED_IN
    	~packing:hbox#add ()


let image = GMisc.image
  ~filename: get_contents open_button
  ~packing:(scroll#add_with_viewport)


(*le texte*)
let text =
  let scroll = GBin.scrolled_window  (*barre de défillement*)
    ~hpolicy:`ALWAYS
    ~vpolicy:`ALWAYS
    ~shadow_type:`ETCHED_IN
    ~packing:hbox#add () in
  let txt = GText.view 				(*zone de texte*)
  	~packing:scroll#add () in
    	txt#misc#modify_font_by_name "Monospace 10";
    txt

 
let _ =
	window#connect#destroy ~callback:GMain.quit;
  	window#show ();
  	GMain.main ()