run: mandel.jar
	time java -jar mandel.jar 140 50 100000

mandel.jar: src/mandel.kt src/pmap.kt
	kotlinc $^ -include-runtime -d $@

