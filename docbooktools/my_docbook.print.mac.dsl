<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle SYSTEM "my_docbook.print.dsl" CDATA DSSSL>
]>

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

(define ($cyrillic-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "Constantin"
		sosofo))
		
(define ($unicode-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "SILSophiaIPA-Regular"
		sosofo))

;; ditto for Greek text: Mac rtf won't talk to Unicode Greek, and PC rtf disrupts
;; fonts
(define ($symbol-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "Symbol"
		sosofo))

(element foreignphrase
  (let ((lang (if (attribute-string (normalize "lang"))
		   (attribute-string (normalize "lang"))
		   (normalize "element"))))
    (cond
      ((equal? lang (normalize "art-lojban")) ($lojban-text$))
      ((equal? lang (normalize "art-klingon")) ($unicode-text$))
      ((equal? lang (normalize "ru")) ($cyrillic-text$))
      (else ($italic-seq$)))))

(element emphasis
  (let* ((role (if (attribute-string (normalize "role"))
		   (attribute-string (normalize "role"))
		   (normalize "element")))
  	(lang (if (attribute-string (normalize "lang"))
		   (attribute-string (normalize "lang"))
		   (normalize "element"))))
    (cond
      ((equal? role (normalize "bold")) ($bold-seq$))
      ((equal? role (normalize "strong")) 
        (if (equal? lang (normalize "ru")) ($italic-seq$) ($bold-seq$)))
      ((equal? role (normalize "sumti")) ($underline-seq$))
      ((equal? role (normalize "selbri")) ($italic-seq$))
      ((equal? role (normalize "placestruct")) ($italic-seq$))
      ((equal? role (normalize "ipa")) ($unicode-text$))
      ((equal? role (normalize "symbol")) ($symbol-text$))
      (else ($italic-seq$)))))


</style-specification-body>
</style-specification>
<external-specification id="docbook" document="dbstyle">
</style-sheet>
