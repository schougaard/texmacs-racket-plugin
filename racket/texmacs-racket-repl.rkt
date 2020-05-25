(module texmacs-plugin racket)

; Based on
; Interfacing TeXmacs with other programs
; http://www.texmacs.org/tmweb/manual/webman-write-itf.en.html

;#define DATA_BEGIN   ((char) 2)
;#define DATA_END     ((char) 5)
;#define DATA_ESCAPE  ((char) 27)

; FIXME
(define texmacs-data-begin "")
(define texmacs-data-end "")

(display (string-append texmacs-data-begin "verbatim:" "TeXmacs Racket Plugin v0.0" texmacs-data-end))
(flush-output)


(define (texmacs-display-exception exception)
  (display
   (string-append texmacs-data-begin "verbatim:" (exn-message exception) texmacs-data-end)
  )
)
 
(define (texmacs-prompt-input)
  (begin
    (display (string-append texmacs-data-begin "prompt#racket> " texmacs-data-end))
    (flush-output) ; necessary to get correct prompt before input
    (read)
  )
)

(define (texmacs-format output)
  (if (void? output)
      ""
      (format "~s" output) ; output as write would; "a", not a.
  )
)  

(define (texmacs-repl)
  (begin
    (with-handlers
      ((exn:fail? texmacs-display-exception))
      (display
       (string-append
        texmacs-data-begin "verbatim:"
        (texmacs-format (eval (texmacs-prompt-input)))
        texmacs-data-end)
      )
    )
    (flush-output) ; after eval or exception
    (texmacs-repl)
  )
)

; Start the repl
(texmacs-repl)

