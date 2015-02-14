all: mandelrs playc playmandel mandel.js

playmandel: playmandel.hs
	ghc $^ -O3 -o $@

run: playmandel
	time ./playmandel 140 50 100000


.PHONY: all
