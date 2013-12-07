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


(* let dialog =
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
  	button *)
let extension = function
    e::_ -> if (e == 'j') || (e == 'b') || (e == 'g') || (e == 'p')
      then true
      else false
  | _ -> false

let rec extension_verif ext l = match (ext,l) with
    ([],[]) -> true
  | ([],e::_) -> false
  | (e::_,[]) -> false
  | (e1::l1,e2::l2) when e1 = e2 -> extension_verif l1 l2
  | (e1::_,e2::_) when e1 <> e2 -> false
  | _ -> false

let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
    exp (String.length s - 1) []

let verif_file s ext =
  let rec list = explode s and verif = function
      [] -> false
    | e::l when e = '.' -> (match ext with
    "img" -> extension l
  | "txt" -> extension_verif (explode "txt") l
  | _ -> false
      )
    | _::l -> verif l
  in
    verif list


let file_dialog ~title ~callback ?filename filter () =
  let sel =
    GWindow.file_selection ~title ~modal:true ?filename () in
    sel#complete filter ;
    sel#cancel_button#connect#clicked ~callback:sel#destroy;
    sel#ok_button#connect#clicked ~callback:
      begin (fun () -> let name = sel#filename in
      sel#destroy ();
      callback name)
    end;
  sel#show ()


let xpm_label_box ~file ~text ~packing () =
  if not (Sys.file_exists file) then failwith (file ^ " does not exist");

  let box = GPack.hbox ~border_width:2 ~packing () in
  let pixmap = GDraw.pixmap_from_xpm ~file () in
  GMisc.pixmap pixmap ~packing:(box#pack ~padding:3) ();
  GMisc.label ~text ~packing:(box#pack ~padding:3) ()

let bouton image str titre =
  let window5 = GWindow.window ~title:titre ~border_width:10 () in
    window5#event#connect#delete ~callback:(fun _ -> window5#destroy (); true);
    let button = GButton.button ~packing:window5#add () in
      button#connect#clicked ~callback:(fun () -> window5#destroy ());
      xpm_label_box ~file:image ~text:str ~packing:button#add ();
      window5#show ()


class interface vbox av ?packing ?show () = 
  object (self)
  val text = GText.view ?packing ?show ()
  val buffer = GText.buffer ()
  val mutable filename = None
  val mutable fichier_img = "aucun"
  val mutable img_app = "aucun"
  val mutable txt_app = "aucun"
  val mutable profil_app = "aucun"
  val mutable trait = 0
  val mutable extract = 0
  val mutable export = 0
  val pack = GPack.notebook ~tab_pos:`TOP ~width:800 ~height:550 ~packing:vbox#add ()
  val pbar = GRange.progress_bar


method open_image () =
  file_dialog ~title:"Charger une image" ~callback:self#load_image "*.jpg" ();


method load_image name =
    if not (verif_file name "img") then
      bouton "img/jpg.gif" "Le fichier n'est pas une image" "Erreur lors du chargement"
    else
      begin  (* FOUS GRAVE LA MAYRDE *)
  if trait = 1 then Gc.full_major ();
  self#affichage 100 "Image chargée";
  pack#remove_page pack#current_page;
  pack#remove_page pack#current_page;
  pack#remove_page pack#current_page;
  pack#remove_page pack#current_page;
  (* self#onglet "Image à utiliser" name; *)
  fichier_img <- name;
  trait <- 0;
  extract <- 0;
  export <- 0
      end

method set_text () =
	


method affichage pourcentage txt_av =
    begin
      pbar#set_text (txt_av ^ " : " ^ string_of_int pourcentage ^ "%");
      pbar#set_fraction (float_of_int pourcentage /. 100.);
      ();
    end

end

let interface = new interface vbox ()

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

let image_open =
	let button = GButton.tool_button
		~stock:`OPEN
		~packing:toolbar#insert () in
		button#connect#clicked interface#open_image;
		button

(*boite horizontal*)
let hbox = GPack.hbox 
  ~spacing:10
  ~packing:vbox#add ()



let scroll = GBin.scrolled_window  (*barre de défillement*)
    	~hpolicy:`ALWAYS
    	~vpolicy:`ALWAYS
    	~shadow_type:`ETCHED_IN
    	~packing:hbox#add ()

(*l'image*)
let img = GMisc.image
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