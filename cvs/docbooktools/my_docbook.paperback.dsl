<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle SYSTEM "my_docbook.print.dsl" CDATA DSSSL>
]>

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

;; Need to avoid Unicode proper, because of BRAINDAMAGE somewhere between 
;; [open]jade and Word
(define ($unicode-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "SILSophiaIPA"
		sosofo))


(define %paper-type% "TradePaperback")
(define %page-width% 5.5in)
(define %page-height% 8.5in)
(define %left-margin% 0.5in)
(define %right-margin% 0.5in)
(define %top-margin% 0.75in)
(define %bottom-margin% 1in)
(define %hsize-bump-factor% 1.15)
(define %ss-size-factor% 0.7)
(define %ss-shift-factor% 0.3)
(define %line-spacing-factor% 1.15)

(declare-initial-value page-width %page-width%)
(declare-initial-value page-height %page-height%)
(declare-initial-value left-margin %left-margin%)
(declare-initial-value right-margin %right-margin%)
(declare-initial-value top-margin %top-margin%)
(declare-initial-value bottom-margin %bottom-margin%)

</style-specification-body>
</style-specification>
<external-specification id="docbook" document="dbstyle">
</style-sheet>
