all: play-bigloo play-racket play-gambit play-chicken

play-bigloo: play.scm
	bigloo -o play-bigloo play.scm

play-racket: play.scm
	raco exe -o play-racket play.scm

play-gambit: play.scm
	gambitc -exe play.scm

play-chicken: play.scm
	csc -O5 -u -static -o play-chicken play.scm
