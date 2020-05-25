(plugin-configure racket
  (:require (url-exists-in-path? "racket"))
  (:launch "racket -e ../racket/texmacs-racket-repl.rkt")
  (:session "Racket"))

