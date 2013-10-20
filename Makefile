RESULT     = ocr
DIRS       = -Is other/ -Is pre_treatment/ -Is post_treatment/ -Is XYcut/
SOURCES    = other/image_helper.ml XYcut/box.ml  pre_treatment/median.ml pre_treatment/to_grey.ml  pre_treatment/rotation.ml post_treatment/post_treatment.ml pre_treatment/pre_treatment.ml other/histo.ml XYcut/XYcut.ml pre_treatment/binarize.ml main.ml

LIBS       = bigarray sdl sdlloader
INCDIRS    = +sdl

#OCAML=ocr
#OCAMLFLAGS= -I +sdl -I +site-lib/sdl 
#OCAMLLD= bigarray.cmxa sdl.cmxa sdlloader.cmxa
 
#ocr: main.ml
#	    ${OCAML} ${OCAMLFLAGS} ${OCAMLLD} -o ocr main.ml
	     
#clean::
#	    rm -f *~ *.o *.cm? ocr 


include OCamlMakefile

