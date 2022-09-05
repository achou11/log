(bagatto/set-output-dir! "site")

(def- index-path "index.html")
(def- about-path "about.html")
(def- logs-path "logs.html")
(def- log-path (bagatto/%p "logs" '%i :slug '% ".html"))

(def data {:config {:attrs {:title "Andrew's log"
                            :description "Andrew Chou's log"
                            :nav-items [["Home" index-path]
                                        ["About" about-path]
                                        ["Logs" logs-path]]}}
           :about {:src "./about.md" :attrs bagatto/parse-mago}
           :logs {:src (bagatto/slurp-* "log/*.md")
                  :attrs bagatto/parse-mago
                  :transform (bagatto/attr-sorter :idx)}
           :css {:src (bagatto/slurp-* "static/*.css")
                 :attrs bagatto/parse-base}})

(def site {:index {:dest index-path
                   :out (bagatto/renderer "/templates/base")}
           :about {:dest about-path
                   # TODO: Is there a better way to construct the :_back path?
                   :out (bagatto/renderer "/templates/about" {:_back {:path (string "./" index-path) :name "index"}})}
           :logs {:dest logs-path
                  # TODO: Is there a better way to construct the :_back path?
                  :out (bagatto/renderer "/templates/logs" {:_back {:path (string "./" index-path) :name "index"}})}
           :log {:each :logs
                 :dest log-path
                 # TODO: Is there a better way to construct the :_back path?
                 :out (bagatto/renderer "/templates/log" {:_back {:path (string "../" logs-path) :name "logs"}})}
           # TODO: Minify css   
           :css {:each :css
                 :dest (bagatto/path-copier "static")}})
