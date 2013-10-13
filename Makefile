RESULT     = ocr
DIRS       = -Is other/ -Is pre_treatment/ -Is post_treatment/ 
SOURCES    = other/image_helper.ml pre_treatment/median.ml post_treatment/post_treatment.ml pre_treatment/pre_treatment.ml other/histo.ml pre_treatment/binarize.ml main.ml

LIBS       = bigarray sdl sdlloader
INCDIRS    = +sdl

include OCamlMakefile

