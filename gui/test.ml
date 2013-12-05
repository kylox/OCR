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

(*les boite bouton*)
let bbox = GPack.button_box `HORIZONTAL
   	~spacing:5
    ~layout:`SPREAD
    ~packing:(vbox#pack ~expand:false) ()

(*bouton quit*)
let quit = 
  let button = GButton.button
    ~stock:`QUIT
    ~packing:bbox#add () in
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