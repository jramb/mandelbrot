all: mandelrs playc playmandel mandel.js

mandelrs: mandelrs.rs

playc: playc.c

%: %.c
	gcc $^ -O2 -o $@

playmandel: playmandel.hs
	ghc $^ -O3 -o $@

%: %.rs
	rustc $^ -O

%.js: %.ls
	lsc -c $^

.PHONY: all
