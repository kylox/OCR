module Aux =
struct
  	let load (image : GMisc.image) file =
    	let ich = open_in file in
    	let len = in_channel_length ich in
    	let buf = Buffer.create len in
      		Buffer.add_channel buf ich len;
      		close_in ich;
      		image#set_image (Buffer.contents buf)

  	let save (text : GText.view) file =
    	let och = open_out file in
      		output_string och (text#buffer#get_text ());
      		close_out och
end

let _ = GMain.init ()

(* Fenêtre principale de l'application. *)
let window =
  	let wnd = GWindow.window   
        		~height:700
                ~resizable:true
              	~position:`CENTER
              	~title:"CamlT'OCR" () in
    			ignore( wnd#connect#destroy GMain.quit);
    			wnd

let vbox = GPack.vbox
             ~spacing:5
             ~border_width:5
             ~packing:window#add ()

let bbox = GPack.button_box `HORIZONTAL
             ~spacing:5
             ~layout:`SPREAD
             ~packing:(vbox#pack ~expand:false) ()

(*message de fermeture *)
let confirm _ =
  let msg = GWindow.message_dialog
              ~message:"<b><big>Voulez-vous vraiment quitter ?</big>\n\n\
                        Attention :\nToutes les modifications non enregistrées seront perdues.</b>\n"
              ~parent:window
    ~destroy_with_parent:true
    ~use_markup:true
    ~message_type:`QUESTION
    ~position:`CENTER_ON_PARENT
    ~buttons:GWindow.Buttons.yes_no () in
  let res = msg#run () = `NO in
    msg#destroy ();
    res

(* Image *)
let image = GMisc.image
              ~file: "lena.jpg"
              ~packing:(vbox#pack ~expand:false) ()

(*Boite de texte*)
let text =
  let scroll = GBin.scrolled_window
                 ~hpolicy:`ALWAYS
                 ~vpolicy:`ALWAYS
                 ~shadow_type:`ETCHED_IN
                 ~packing:vbox#add () in
  let txt = GText.view ~packing:scroll#add () in
    txt#misc#modify_font_by_name "Monospace 10";
    txt


(*open and save (save marche pas bien)*)
let action_button stock event action =
  let dlg = GWindow.file_chooser_image
              ~action:`OPEN
              ~parent:window
              ~position:`CENTER_ON_PARENT
              ~destroy_with_parent:true () in
    dlg#add_button_stock `CANCEL `CANCEL;
    dlg#add_select_button_stock stock event;
    let btn = GButton.button ~stock ~packing:bbox#add () in
      ignore(GMisc.image ~stock ~packing:btn#set_image ());
      ignore(btn#connect#clicked (fun () ->
                             if dlg#run () = `OPEN then Gaux.may action dlg#filename;
                             dlg#misc#hide ()));
      btn

let open_button = action_button `OPEN `OPEN (Aux.load text)
let save_button = action_button `SAVE `SAVE (Aux.save text)

(*FIX ME*)
let transfer = GButton.button ~label:"transfert" ~packing:bbox#add ()

(*Sélection de couleur. *)
let color_picker =
  let dlg = GWindow.color_selection_dialog
              ~parent:window
              ~destroy_with_parent:true
              ~position:`CENTER_ON_PARENT () in
    ignore(dlg#ok_button#connect#clicked (fun () ->
                                     text#misc#modify_base [`NORMAL, `COLOR dlg#colorsel#color]));
    let btn = GButton.button ~label:"Arrière-plan" ~packing:bbox#add () in
      ignore(GMisc.image ~stock:`COLOR_PICKER ~packing:btn#set_image ());
      ignore (btn#connect#clicked (fun () -> ignore (dlg#run ()); dlg#misc#hide ()));
      btn

(*Sélection de fonte. *)
let font_button =
  let dlg = GWindow.font_selection_dialog
              ~parent:window
              ~destroy_with_parent:true
              ~position:`CENTER_ON_PARENT () in
    ignore(dlg#ok_button#connect#clicked (fun () ->
                                     text#misc#modify_font_by_name dlg#selection#font_name));
    let btn = GButton.button ~stock:`SELECT_FONT ~packing:bbox#add () in
      ignore(GMisc.image ~stock:`SELECT_FONT ~packing:btn#set_image ());
      ignore(btn#connect#clicked (fun () -> ignore (dlg#run ()); dlg#misc#hide ()));
      btn

let _ =
  ignore(window#event#connect#delete confirm);
  window#show ();
  GMain.main ()
