(defproject mandel "0.1.0-SNAPSHOT"
  :description "Mandelbrot in Clojure"
  :url "https://github.com/jramb/mandelbrot/tree/master/Clojure"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]]
  :main mandel.play
  :profiles {
             :uberjar {:aot :all}
             }
  )
