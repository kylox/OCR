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
  ~style:`ICONS 
  ~packing:(vbox#pack ~expand:false) ()


let dialog =
  let dlg = GWindow.file_chooser_dialog 
  	~action:`SAVE () in
  	dlg#add_button_stock `CANCEL `CANCEL;
  	dlg#add_select_button_stock `SAVE `SAVE;
  	dlg

let save () =
  if dialog#run () = `SAVE then Gaux.may print_endline dialog#filename;
  dialog#misc#hide ()

let save_button =
  let button = GButton.tool_button 
  	~stock:`SAVE () 
  	~packing:toolbar#insert () in
  	button#connect#clicked save;
  	button



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


let aspect_frame = GBin.aspect_frame
  ~xalign:0.5
  ~yalign:0.5
  ~ratio:0.5
  ~label:"Image d'origine"
  ~packing:hbox#add ()


(*l'image*)
let image = GMisc.image
    ~file: "rot.jpg"
    ~packing:aspect_frame#add ()


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