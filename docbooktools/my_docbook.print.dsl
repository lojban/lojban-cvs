<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle SYSTEM "docbook.dsl" CDATA DSSSL>
]>

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

(define %show-ulinks% #f)

(define %ss-shift-factor% 0.3)

(define %title-font-family% 
  ;; The font family used in titles
  "Times New Roman")

(define %admon-font-family%
	;; Exercises, notes
	"Trebuchet MS")

(define %may-format-variablelist-as-table% #t)

;; force table vertical compacting
(define %cals-cell-before-row-margin% 0pt)

(define %cals-cell-after-row-margin% 0pt)

(define %default-variablelist-termlength%
  ;; Default term length on variablelists
  10)

(define bop-footnotes
  ;; Make "bottom-of-page" footnotes?
  #t)
(define %body-start-indent% 
  ;; Default indent of body text
  1pi)

(define ($lojban-text$ #!optional (sosofo (process-children)))
	(make sequence
        hyphenate?: #f
		font-family-name: "Andale Mono"
		font-size: (* (inherited-font-size) 
						(if %verbatim-size-factor%
							%verbatim-size-factor%
							1.0))
		sosofo))

;; you may have to change this to a non-unicode font if in RTF; 
;; cf. paperback stylesheet, *.silencoding.doc.xml entities
(define ($unicode-text$ #!optional (sosofo (process-children)))
	(make sequence
		font-family-name: "Code2000"
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

;; More distinctive
(element firstterm ($bold-seq$))

(element emphasis
  (let* ((role (if (attribute-string (normalize "role"))
		   (attribute-string (normalize "role"))
		   (normalize "element")))
  	(lang (if (attribute-string (normalize "lang"))
		   (attribute-string (normalize "lang"))
		   (normalize "element"))))
    (cond
      ((equal? role (normalize "bold")) ($bold-seq$))
      ((equal? role (normalize "strong")) ($bold-seq$))
      ((equal? role (normalize "sumti")) ($underline-seq$))
      ((equal? role (normalize "selbri")) ($italic-seq$))
      ((equal? role (normalize "placestruct")) ($italic-seq$))
      ((equal? role (normalize "ipa")) ($unicode-text$))
      (else ($italic-seq$)))))


(element foreignphrase
  (let ((lang (if (attribute-string (normalize "lang"))
		   (attribute-string (normalize "lang"))
		   (normalize "element"))))
    (cond
      ((equal? lang (normalize "art-lojban")) ($lojban-text$))
      ((equal? lang (normalize "art-klingon")) ($unicode-text$))
      (else ($italic-seq$)))))

;; based on $peril$, but no box
(define ($exercise$)
  (let* ((title     (select-elements 
		     (children (current-node)) (normalize "title")))
	 (has-title (not (node-list-empty? title)))
	 (adm-title (if has-title 
			(make sequence
			  (with-mode title-sosofo-mode
			    (process-node-list (node-list-first title))))
			(literal
			 (gentext-element-name 
			  (current-node)))))
	 (hs (HSIZE 2)))
  (if %admon-graphics%
      ($graphical-admonition$)
      (make display-group
	space-before: %block-sep%
	space-after: %block-sep%
	font-family-name: %admon-font-family%
	font-size: (- %bf-size% 1pt)
	font-weight: 'medium
	font-posture: 'upright
	line-spacing: (* (- %bf-size% 1pt) %line-spacing-factor%)
;;	(make box
;;	  display?: #t
;;	  box-type: 'border
;;	  line-thickness: 2pt
;;	  start-indent: (+ (inherited-start-indent) (* 2 (ILSTEP)) 2pt)
;;	  end-indent: (inherited-end-indent)
	  (make paragraph
	    space-before: %para-sep%
	    space-after: %para-sep%
	    start-indent: 1em
	    end-indent: 1em
	    font-family-name: %title-font-family%
	    font-weight: 'bold
	    font-size: hs
	    line-spacing: (* hs %line-spacing-factor%)
	    quadding: 'center
	    keep-with-next?: #t
	    adm-title)
	  (process-children)))))
;;)


;; Treat exercises separately
(element simplesect 
  (let ((role (if (attribute-string (normalize "role"))
		   (attribute-string (normalize "role"))
		   (normalize "element"))))
    (cond
      ((equal? role (normalize "exercise")) ($exercise$))
      ((equal? role (normalize "excanswer")) ($exercise$))
      ((equal? role (normalize "vocab")) ($exercise$))
      (else ($section$)))))

;; Provide for scare quote and gloss quote (single)
(element quote
  (let* 
	((role (if (attribute-string (normalize "role"))
		   (attribute-string (normalize "role"))
           (normalize "element")))
	(hnr   (hierarchical-number-recursive (normalize "quote") 
					       (current-node)))
	 (depth (length hnr)))
;;inserted there
  (cond
      ((equal? role (normalize "gloss")) 
		(make sequence (literal (dingbat "lsquo")) (process-children) (literal (dingbat "rsquo"))))
      ((equal? role (normalize "socalled")) 
        (make sequence (literal (dingbat "lsquo")) (process-children) (literal (dingbat "rsquo"))))
  (else
;;end insert
    (if (equal? (modulo depth 2) 1)
	(make sequence
      (literal (gentext-start-nested-quote))
	  (process-children)
	  (literal (gentext-end-nested-quote)))
	(make sequence
	  (literal (gentext-start-quote))
	  (process-children)
	  (literal (gentext-end-quote))))))
))

;; (define %indent-literallayout-lines% "\U-2003\U-2003\U-2003")

(element informalexample
  (make paragraph
    space-before: %block-sep%
    space-after: %block-sep%
    start-indent: (+ (inherited-start-indent) 2em)
    end-indent: 1em
    (process-children)))

;; modified linespecific-display (used in literallayout) to keep lines together.
(define ($linespecific-display$ indent line-numbers?)
  (let ((vspace (if (INBLOCK?)
		   0pt
		   (if (INLIST?) 
		       %para-sep% 
		       %block-sep%))))
    (make paragraph
      use: linespecific-style
      keep: 'page ;; Added
      space-before: (if (and (string=? (gi (parent)) (normalize "entry"))
 			     (absolute-first-sibling?))
			0pt
			vspace)
      space-after:  (if (and (string=? (gi (parent)) (normalize "entry"))
 			     (absolute-last-sibling?))
			0pt
			vspace)
      start-indent: (if (INBLOCK?)
			(inherited-start-indent)
			(+ %block-start-indent% (inherited-start-indent)))
      (if (or indent line-numbers?)
	  ($linespecific-line-by-line$ indent line-numbers?)
	  (process-children)))))

;; Depth of TOC changed to 2
;; Returns the depth of auto TOC that should be made at the nd-level
(define (toc-depth nd)
  (if (string=? (gi nd) (normalize "book"))
      2
      1))

;; done for spacing
(define ($make-empty-row$ cols)
;;  (let* 
;;	 (
;;(tgroup (ancestor-member (current-node) (list (normalize "tgroup"))))
;;	 (cols   (string->number (attribute-string (normalize "cols") tgroup))))
;;    (if (last-sibling? (tgroup)) 
;;	(empty-sosofo)
	(make table-row
	  (make table-cell
	    n-columns-spanned: cols
       cell-before-row-margin: %cals-cell-before-row-margin%
	    cell-after-row-margin: %cals-cell-after-row-margin%
	    cell-before-column-margin: %cals-cell-before-column-margin%
	    cell-after-column-margin: %cals-cell-after-column-margin%
	    start-indent: %cals-cell-content-start-indent%
	    end-indent: %cals-cell-content-end-indent%
		(literal " ")
	))
;;))
)




(element tgroup
  (let* ((frame-attribute (if (inherited-attribute-string (normalize "frame"))
			     (inherited-attribute-string (normalize "frame"))
			     ($cals-frame-default$)))
;;added NN
			(lastsib (if (last-sibling? (current-node)) #t #f))
			(cols   (string->number (attribute-string (normalize "cols") (current-node))))
;; end added: NN
		)
    (make table
      ;; These values are used for the outer edges (well, the top, bottom
      ;; and left edges for sure; I think the right edge actually comes
      ;; from the cells in the last column
;; added: NN
		keep: #t
;; end added: NN
;; NOTE: as a result of un-pin-down-able brain damage, no empty 'entry's may 
;; be allowed in tables: the empty paras that get inserted as a result do *not* inherit
;; the 'keep' property
      before-row-border:  (if (cond
			       ((equal? frame-attribute (normalize "all")) #t)
			       ((equal? frame-attribute (normalize "sides")) #f)
			       ((equal? frame-attribute (normalize "top")) #t)
			       ((equal? frame-attribute (normalize "bottom")) #f)
			       ((equal? frame-attribute (normalize "topbot")) #t)
			       ((equal? frame-attribute (normalize "none")) #f)
			       (else #f))
			      calc-table-before-row-border
			      #f)
      after-row-border:   (if (cond
			       ((equal? frame-attribute (normalize "all")) #t)
			       ((equal? frame-attribute (normalize "sides")) #f)
			       ((equal? frame-attribute (normalize "top")) #f)
			       ((equal? frame-attribute (normalize "bottom")) #t)
			       ((equal? frame-attribute (normalize "topbot")) #t)
			       ((equal? frame-attribute (normalize "none")) #f)
			       (else #f))
			      calc-table-after-row-border
			      #f)
      before-column-border: (if (cond
				 ((equal? frame-attribute (normalize "all")) #t)
				 ((equal? frame-attribute (normalize "sides")) #t)
				 ((equal? frame-attribute (normalize "top")) #f)
				 ((equal? frame-attribute (normalize "bottom")) #f)
				 ((equal? frame-attribute (normalize "topbot")) #f)
				 ((equal? frame-attribute (normalize "none")) #f)
				 (else #f))
				calc-table-before-column-border
				#f)
      after-column-border:  (if (cond
				 ((equal? frame-attribute (normalize "all")) #t)
				 ((equal? frame-attribute (normalize "sides")) #t)
				 ((equal? frame-attribute (normalize "top")) #f)
				 ((equal? frame-attribute (normalize "bottom")) #f)
				 ((equal? frame-attribute (normalize "topbot")) #f)
				 ((equal? frame-attribute (normalize "none")) #f)
				 (else #f))
				calc-table-after-column-border
				#f)
      display-alignment: %cals-display-align%
      (make table-part
	content-map: '((thead header)
		       (tbody #f)
		       (tfoot footer))
	($process-colspecs$ (current-node))
	(process-children)
;; added NN: add extra row at end of each group, for spacing
    (if lastsib (empty-sosofo) ($make-empty-row$ cols))
;; end NN
	(make-table-endnotes)
)

)))




;; following indexing code (made to cope with ranges) courtesy of Jiri Kosek,
;; see http://sources.redhat.com/ml/docbook-apps/2001-q2/msg00127.html
(element (indexterm)

         (make sequence

               ;; start of range
               (if (equal? (attribute-string "class") "startofrange")
                   (make sequence
                         (literal "#bs ")
                         (literal (attribute-string "id"))
                         (literal "#")
                         )
                 (literal "")
                 )

               ;; end of range does not produce index entry
               (if (equal? (attribute-string "class") "endofrange")
                   (make sequence
                         (literal "#be ")
                         (literal (attribute-string "startref"))
                         (literal "#")
                         )
                 (make sequence
                       ;; common
                       (literal "#xe #")
                       (literal (data-of (select-elements (children
(current-node))(normalize "primary"))))
                       ;; handle secondary index
                  (if (node-list-empty? 
                       (select-elements 
                        (children (current-node))(normalize "secondary")))
                      (literal "")
                    (make sequence
                          (literal ":::")
                          (literal 
                           (data-of (select-elements 
                                     (children (current-node))(normalize "secondary")))))
                    )

                  ;; handle see
                  (if (node-list-empty? 
                       (select-elements 
                        (children (current-node))(normalize "see")))
                      (literal "")
                    (make sequence
                          (literal "#txe See ")
                          (literal 
                           (data-of (select-elements 
                                     (children (current-node))(normalize "see")))))
                    )

                  ;; inserted (NN): handle seealso (lamely)
                  (if (node-list-empty? 
                       (select-elements 
                        (children (current-node))(normalize "seealso")))
                      (literal "")
                    (make sequence
                          (literal "#txe See also ")
                          (literal 
                           (data-of (select-elements 
                                     (children (current-node))(normalize "seealso")))))
                    )

                  ;; handle start of range (make reference to it)
                  (if (equal? (attribute-string "class") "startofrange")
                      (make sequence
                            (literal "#rxe ")
                            (literal (attribute-string "id"))
                            )
                    (literal "")
                    )
                  
;; added NN: process preferred entries in bold
				(if (equal? (attribute-string "significance") "preferred")
					(literal "#bb")
                 (literal "")
                 )
;; end NN

                  ;; common end
                  (literal "##")
                  )
                 )
                )
              
         
         )

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
      (make paragraph
               (literal "#index#")))
    (make-endnotes)))


;; modified to shrink font for vocab
(element variablelist
  (let* ((termlength (if (attribute-string (normalize "termlength"))
			 (string->number 
			  (attribute-string (normalize "termlength")))
			 %default-variablelist-termlength%))
	 (maxlen     (if (> termlength %default-variablelist-termlength%)
			    termlength
			    %default-variablelist-termlength%))
	 (too-long?  (variablelist-term-too-long? termlength)))
    (make display-group
      start-indent: (if (INBLOCK?)
			(inherited-start-indent)
			(+ %block-start-indent% (inherited-start-indent)))
      space-before: (if (INLIST?) %para-sep% %block-sep%)
      space-after:  (if (INLIST?) %para-sep% %block-sep%)
;; added: NN
	  font-size: (if (equal? (inherited-attribute-string (normalize "role")) (normalize "vocabulary"))
		(* %bf-size% %smaller-size-factor%) (inherited-font-size))  
      line-spacing: (if (equal? (inherited-attribute-string (normalize "role")) (normalize "vocabulary"))
        (* %bf-size% %line-spacing-factor% %smaller-size-factor%)
		(inherited-line-spacing))
;; end added

      (if (and (or (and termlength (not too-long?))
		   %always-format-variablelist-as-table%)
	       (or %may-format-variablelist-as-table%
		   %always-format-variablelist-as-table%))
	  (make table
	    space-before: (if (INLIST?) %para-sep% %block-sep%)
	    space-after:  (if (INLIST?) %para-sep% %block-sep%)
	    start-indent: (if (INBLOCK?)
			      (inherited-start-indent)
			      (+ %block-start-indent% 
				 (inherited-start-indent)))

;; Calculate the width of the column containing the terms...
;;
;; maxlen       in        (inherited-font-size)     72pt
;;        x ---------- x ----------------------- x ------ = width
;;           12 chars              10pt              in
;;
	    (make table-column
	      column-number: 1
	      width: (* (* (/ maxlen 12) (/ (inherited-font-size) 10pt)) 72pt))
	    (with-mode variablelist-table
	      (process-children)))
	  (process-children)))))




;; modified to obligatorily vertically squash
(mode variablelist-table
  (element varlistentry
    (let* ((terms      (select-elements (children (current-node))
					(normalize "term")))
	   (listitem   (select-elements (children (current-node))
					(normalize "listitem")))
	   (termlen    (if (attribute-string (normalize "termlength")
					     (parent (current-node)))
			   (string->number (attribute-string
					    (normalize "termlength")
					    (parent (current-node))))
			   %default-variablelist-termlength%))
	   (too-long? (varlistentry-term-too-long? (current-node) termlen)))
      (if too-long?
	  (make sequence
	    (make table-row
	      cell-before-row-margin: 0pt

	      (make table-cell
		column-number: 1
		n-columns-spanned: 2
		n-rows-spanned: 1
		(process-node-list terms)))
	    (make table-row
	      (make table-cell
		column-number: 1
		n-columns-spanned: 1
		n-rows-spanned: 1
		;; where terms would have gone
		(empty-sosofo))
	      (make table-cell
		column-number: 2
		n-columns-spanned: 1
		n-rows-spanned: 1
		(process-node-list listitem))))
	  (make table-row
	    cell-before-row-margin: 0pt

	    (make table-cell
	      column-number: 1
	      n-columns-spanned: 1
	      n-rows-spanned: 1
	      (process-node-list terms))
	    (make table-cell
	      column-number: 2
	      n-columns-spanned: 1
	      n-rows-spanned: 1
	      (process-node-list listitem))))))
  
  (element (varlistentry term)
;; added NN
	(make paragraph
		start-indent: 0pt
        first-line-start-indent: 0pt
;; end NN
    (make sequence
      (process-children-trim)
      (if (not (last-sibling?))
	  (literal ", ")
	  (empty-sosofo))))
)

  (element (varlistentry listitem)
    (make display-group
      start-indent: 0pt
      (process-children)))

;; added NN
   (element (listitem para)
          (make paragraph
			first-line-start-indent: 0pt
			space-before: 0pt
			space-after: 0pt
			quadding: %default-quadding%
			hyphenate?: %hyphenation%
			(process-children)))
	
;; end NN

  ;; Suggested by Nick NICHOLAS, nicholas@uci.edu
  (element (variablelist title)
    (make table-row
      cell-before-row-margin: 0pt
      (make table-cell
	column-number: 1
	n-columns-spanned: 2
	n-rows-spanned: 1
	(make paragraph
	  use: title-style
;; added: NN
		keep-with-next?: #t
;; end added NN
	  start-indent: 0pt
	  (process-children)))))

)

;; modified to squish vocab
(element informaltable

	(make display-group
      font-size: (if (equal? (inherited-attribute-string (normalize "role")) (normalize "vocabulary"))
		(* %bf-size% %smaller-size-factor%) (inherited-font-size))  
      line-spacing: (if (equal? (inherited-attribute-string (normalize "role")) (normalize "vocabulary"))
        (* %bf-size% %line-spacing-factor% %smaller-size-factor%)
		(inherited-line-spacing))
	  hyphenate?: (if (equal? (inherited-attribute-string (normalize "role")) (normalize "vocabulary"))
		#t %hyphenation%)
  ($informal-object$ %informaltable-rules% %informaltable-rules%)))

(define ($title-header-footer$)
  (let* ((title (if (equal? (gi) (normalize "refentry"))
		   ($refentry-header-footer-element$)
		   ($title-header-footer-element$))))
    (make sequence
      font-posture: 'italic
;; added NN: shrink it
        font-size: (* (inherited-font-size) 
						%smaller-size-factor%)
;; end NN
      (with-mode hf-mode 
	(process-node-list title)))))

;; force keep with next for formalpara title followed by example or table

(element (formalpara title) 
    (let* (
		(informalexample (node-list-first (select-elements (descendants (parent (current-node))) 
			(normalize "informalexample"))))
        (example (node-list-first (select-elements (descendants (parent (current-node))) 
			(normalize "example"))))
        (informaltable (node-list-first (select-elements (descendants (parent (current-node))) 
			(normalize "informaltable"))))
        (table (node-list-first (select-elements (descendants (parent (current-node))) 
			(normalize "table"))))
	)
	(if (and (node-list-empty? informalexample)
            (node-list-empty? example)
            (node-list-empty? informaltable)
            (node-list-empty? table)
	     ) 

	($runinhead$) ($lowtitle$ 2 4))

))


</style-specification-body>
</style-specification>
<external-specification id="docbook" document="dbstyle">
</style-sheet>
