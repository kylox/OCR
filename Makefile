INCDIRS= +sdl
OCAML= ocamlc
OCAMLFLAGS= -I +sdl -I +site-lib/sdl -I +lablgtk2
OCAMLLD= bigarray.cma sdl.cma sdlloader.cma lablgtk.cma gtkInit.cmo
DIRS= -I other/ -I pre_treatment/ -I post_treatment/ -I XYcut/
OTH= other/image_helper.ml pre_treatment/to_grey.ml other/histo.ml XYcut/box.ml XYcut/XYcut.ml xy_cut.ml
PRE= convolution.ml pre_treatment/median.ml pre_treatment/pre_treatment.ml
BIN= pre_treatment/binarize.ml
ROT= pre_treatment/rotation.ml
GUI= gui/test.ml
SRC= main.ml

ocr: ${OTH} ${PRE} ${BIN} ${ROT} ${SRC}
	    ${OCAML} ${OCAMLFLAGS} ${OCAMLLD} ${DIRS} -o ocr ${OTH} ${PRE} ${BIN} ${ROT} ${GUI} ${SRC} 
	     
clean:: $(OTH) $(PRE) $(BIN) $(ROT) $(SRC)
	    rm -rf  *.o *.cm? ocr 
