# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jpriou <jpriou@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/07/20 17:42:24 by jpriou            #+#    #+#              #
#    Updated: 2018/10/17 06:58:43 by sclolus          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OCAMLMAKEFILE = OCamlMakefile

RESULT = linear_regression_train

MAIN = srcs/train.ml

ML_FILES = srcs/dataset.ml \
			srcs/linear_regression.ml \
			srcs/parsing.ml

MLI_FILES = $(foreach f, $(ML_FILES), $fi)

SOURCES = $(MLI_FILES) $(ML_FILES) $(MAIN)
GRAPHICS_LIB = 
LIBS= $(GRAPHICS_LIB) unix 
# INCDIRS=$(shell ls -d `ocamlfind query camlimages -i-format  | cut -d ' ' -f 2`/**/) (* Fuck that shit *)

all: delete_links
	make -C . nc
	mv $(RESULT) $(RESULT).opt
	make -C . bc
	mv $(RESULT) $(RESULT).byt
	ln -s $(RESULT).opt $(RESULT)

delete_links:
	rm -f $(RESULT).opt $(RESULT).byt
	rm -f $(RESULT)

fclean: cleanup delete_links

re: fclean all

include $(OCAMLMAKEFILE)
