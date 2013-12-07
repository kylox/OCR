let _ = GMain.init ()

let x = ref ""

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
  ~style:`ICONS
  ~packing:vbox#pack ()

let item = GButton.tool_item ~packing:toolbar#insert ()
let item2 = GButton.tool_item ~packing:toolbar#insert ()

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



(*button save*)
let dialog =
  let dlg = GWindow.file_chooser_dialog ~action:`SAVE () in
  dlg#add_button_stock `CANCEL `CANCEL;
  dlg#add_select_button_stock `SAVE `SAVE;
  dlg

let may_save () =
  if dialog#run () = `SAVE then Gaux.may print_endline dialog#filename;
  dialog#misc#hide ()

let save =
let button = GButton.button
	~stock:`SAVE
	~packing:item2#add () in
	button#connect#clicked may_save;	
	button

(*bouton quit*)
let quit = 
  let button = GButton.tool_button
    ~stock:`QUIT
    ~packing:toolbar#insert () in
  	button#connect#clicked ~callback:GMain.quit;
  	button

(*l'image*)
let scroll = GBin.scrolled_window  (*barre de défillement*)
    	~hpolicy:`ALWAYS
    	~vpolicy:`ALWAYS
    	~shadow_type:`ETCHED_IN
    	~packing:hbox#add ()


let get_contents = function
  | Some x -> "%x"
  | _ -> raise Not_found

let may_print btn () = Gaux.may print_endline btn#filename

let open_button = 
  let button = GFile.chooser_button
    ~action:`OPEN
    ~packing:item#add () in
  	button#connect#selection_changed (may_print button);
  	button


let image = GMisc.image
  ~file: "rot.jpg"
  ~packing:scroll#add_with_viewport ()




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