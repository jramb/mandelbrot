run:
	clj -m cljs.main -c mandel.core --repl

mandel.js: src/mandel/core.cljc
	clj -m cljs.main --target node --output-to mandel.js -c mandel.core

node: mandel.js
	node mandel.js

adv:
	clj -m cljs.main --target node --output-to mandel.js --optimizations advanced -c mandel.core

simple:
	clj -m cljs.main --target node --output-to mandel.js --optimizations simple -c mandel.core
