INCDIRS    = +sdl
OCAML=ocamlopt
OCAMLFLAGS= -I +sdl -I +site-lib/sdl 
OCAMLLD= bigarray.cmxa sdl.cmxa sdlloader.cmxa
DIRS= -I other/ -I pre_treatment/ -I post_treatment/ -I XYcut/
OTH= other/image_helper.ml pre_treatment/to_grey.ml other/histo.ml XYcut/box.ml XYcut/XYcut.ml xy_cut.ml
PRE= pre_treatment/median.ml pre_treatment/pre_treatment.ml convolution.ml
BIN= pre_treatment/binarize.ml
ROT= pre_treatment/rotation.ml
SRC= post_treatment/post_treatment.ml main.ml

ocr: ${OTH} ${PRE} ${BIN} ${ROT} ${SRC}
	    ${OCAML} ${OCAMLFLAGS} ${OCAMLLD} ${DIRS} -o ocr ${OTH} ${PRE} ${BIN} ${ROT} ${SRC} 
	     
clean:: $(OTH) $(PRE) $(BIN) $(ROT) $(SRC)
	    rm -rf  *.o *.cm? ocr 
