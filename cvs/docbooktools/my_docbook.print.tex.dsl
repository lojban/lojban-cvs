<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle SYSTEM "my_docbook.print.dsl" CDATA DSSSL>
]>

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

(define %title-font-family% "cmr")
(define %mono-font-family% "cmr")
(define %admon-font-family% "cmr")
(define %body-font-family% "cmr")

(define ($lojban-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "ecdh"
		;;font-weight: 'bold
		sosofo))

(define ($unicode-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "tipa"
		sosofo))

(define ($underline-seq$ #!optional (sosofo (process-children)))
	(make score
		type: 'after
		sosofo))

(define ($double-underline-seq$ #!optional (sosofo (process-children)))
	(make score
		type: 1
		linerepeat: 2
		sosofo))

;; reinstate Docbook-default indexing
(element index
  (make simple-page-sequence
    page-number-restart?: (or %page-number-restart% 
			      (book-start?) 
			      (first-chapter?))
    page-number-format: ($page-number-format$)
    use: default-text-style
    left-header:   ($left-header$)
    center-header: ($center-header$)
    right-header:  ($right-header$)
    left-footer:   ($left-footer$)
    center-footer: ($center-footer$)
    right-footer:  ($right-footer$)
    start-indent: %body-start-indent%
    input-whitespace-treatment: 'collapse
    quadding: %default-quadding%
    page-n-columns: 2
    (make sequence
      ($component-title$)
      (process-children))
    (make-endnotes)))

(element indexterm
  ;; This is different than (empty-sosofo) alone because the backend
  ;; will hang an anchor off the empty sequence.  This allows the index
  ;; to point to the indexterm (but only if the indexterm has an ID).
  (make sequence (empty-sosofo)))


</style-specification-body>
</style-specification>
<external-specification id="docbook" document="dbstyle">
</style-sheet>
