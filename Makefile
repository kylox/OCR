RESULT     = ocr
SOURCES    = image_helper.ml  median.ml post_treatment.ml pre_treatment.ml main.ml
LIBS       = bigarray sdl sdlloader
INCDIRS    = +sdl

include OCamlMakefile
