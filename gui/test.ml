let _ = GMain.init ()

(*fenètre principale*)
let window =
	let win = GWindow.window
	~title: "CamlT'OCR"
	~height:700
	~width:1200 ()
	~resizable:true in
	win#connect#destroy GMain.quit;
	win


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

(*traitement de l'image*)
let treatment = 
	let button = GButton.tool_button
		~label:"treatment"
    	~packing:toolbar#insert () in
  		button#connect#clicked(*fonction de traitement*);
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

(*l'image*)
let scroll = GBin.scrolled_window  (*barre de défillement*)
    	~hpolicy:`ALWAYS
    	~vpolicy:`ALWAYS
    	~shadow_type:`ETCHED_IN
    	~packing:hbox#add ()


let button = GFile.chooser_button
  ~title:"Browse"
  ~action:`OPEN
  ~packing:item#add ()

let image = GMisc.image 
  ~width:560 ~height:400
  ~packing:(scroll#add_with_viewport) ()

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

 
 (*message de fermeture*)
let confirm _ =
  let dialog = GWindow.message_dialog
    ~message:"<b><big>Voulez-vous vraiment quitter ?</big>\n\n\
      Attention :\nToutes les modifications seront perdues.</b>\n"
    ~parent:window
    ~destroy_with_parent:true
    ~use_markup:true
    ~message_type:`QUESTION
    ~position:`CENTER_ON_PARENT
    ~buttons:GWindow.Buttons.yes_no () in
  let res = dialog#run () = `NO in
  dialog#destroy ();
  res 

let _ =
	let display = Gaux.may ~f:image#set_file in
      button#connect#selection_changed (fun () -> display button#filename);
	window#event#connect#delete confirm;
  	window#show ();
  	GMain.main ()