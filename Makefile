#RESULT     = ocr
#DIRS       = -Is other/ -Is pre_treatment/ -Is post_treatment/ -Is XYcut/
#SOURCES    = other/image_helper.ml XYcut/box.ml  pre_treatment/median.ml pre_treatment/to_grey.ml  pre_treatment/rotation.ml post_treatment/post_treatment.ml pre_treatment/pre_treatment.ml other/histo.ml XYcut/XYcut.ml pre_treatment/binarize.ml main.ml

#LIBS       = bigarray sdl sdlloader
INCDIRS    = +sdl
OCAML=ocamlopt
OCAMLFLAGS= -I +sdl -I +site-lib/sdl 
OCAMLLD= bigarray.cmxa sdl.cmxa sdlloader.cmxa
DIRS= -I other/ -I pre_treatment/ -I post_treatment/ -I XYcut/
OTH= other/image_helper.ml pre_treatment/to_grey.ml other/histo.ml XYcut/box.ml XYcut/XYcut.ml
PRE= pre_treatment/median.ml pre_treatment/pre_treatment.ml
BIN= pre_treatment/binarize.ml
ROT= pre_treatment/rotation.ml
SRC= post_treatment/post_treatment.ml main.ml

ocr: ${OTH} ${PRE} ${BIN} ${ROT} ${SRC}
	    ${OCAML} ${OCAMLFLAGS} ${OCAMLLD} ${DIRS} -o ocr ${OTH} ${PRE} ${BIN} ${ROT} ${SRC} 
	     
clean::
	    rm -rf *~ *.o *.cm? ocr 

#include OCamlMakefile

