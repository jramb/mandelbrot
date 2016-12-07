run: mandel.n
	/usr/sbin/time neko mandel.n 140 50 1000

mandel.n: Mandel.hx
	haxe build.hxml

all:
	haxe -main Mandel -neko   mandel.n
	haxe -main Mandel -js     mandel.js
	haxe -main Mandel -python mandel.py
	haxe -main Mandel -lua    mandel.lua

