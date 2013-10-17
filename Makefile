RESULT     = ocr
DIRS       = -Is other/ -Is pre_treatment/ -Is post_treatment/ -Is XYcut/
SOURCES    = other/image_helper.ml XYcut/box.ml  pre_treatment/median.ml pre_treatment/to_grey.ml  post_treatment/post_treatment.ml pre_treatment/pre_treatment.ml other/histo.ml XYcut/XYcut.ml pre_treatment/binarize.ml main.ml


LIBS       = bigarray sdl sdlloader
INCDIRS    = +sdl

include OCamlMakefile

