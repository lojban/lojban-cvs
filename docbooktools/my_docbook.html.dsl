<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle SYSTEM "docbook.dsl" CDATA DSSSL>
]>

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

(declare-characteristic preserve-sdata?
  "UNREGISTERED::James Clark//Characteristic::preserve-sdata?" #t)

(define html-index #t)
(define %html-ext% 
  ;; Default extension for HTML output files
  ".html")

(define %may-format-variablelist-as-table% #t)

;;(define %html-header-tags% 
  ;; What additional HEAD tags should be generated?
;;  '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=UTF-8")))
;;)

(define %stylesheet%
  ;; Name of the stylesheet to use
  "lojbanLevel0.css")
(define %stylesheet-type%
  ;; The type of the stylesheet to use
  "text/css")

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
	($mono-seq$))

(define ($underline-seq$ #!optional (sosofo (process-children)))
  (make element gi: "U"
	attributes: (list
		     (list "CLASS" (gi)))
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
      (else ($italic-seq$)))))


(element foreignphrase
  (let ((lang (if (attribute-string (normalize "lang"))
		   (attribute-string (normalize "lang"))
		   (normalize "element"))))
    (cond
      ((equal? lang (normalize "art-lojban")) ($lojban-text$))
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

;;(element tip ($admonition$))
;;(element (tip title) (empty-sosofo))
;;(element (tip para) ($admonpara$))
;;(element (tip simpara) ($admonpara$))

(define ($vocab$)
  (let* ((title     (select-elements 
		     (children (current-node)) (normalize "title")))
	 (has-title (not (node-list-empty? title)))
	 (adm-title (if has-title 
			(make sequence
			  (with-mode title-sosofo-mode
			    (process-node-list (node-list-first title))))
			(literal
			 (gentext-element-name 
			  (gi (current-node))))))
	 (id     (attribute-string (normalize "id"))))
  (make element gi: "BLOCKQUOTE"
	attributes: (list
		     (list "CLASS" "vocab"))
				(make element gi: "P"
                (make element gi: "B"
				      (if id
					  (make element gi: "A"
						attributes: (list (list "NAME" id))
						(empty-sosofo))
					  (empty-sosofo))
				      adm-title))
	(process-children))))


;; Treat exercises separately
(element simplesect 
  (let ((role (if (attribute-string (normalize "role"))
		   (attribute-string (normalize "role"))
		   (normalize "element"))))
    (cond
      ((equal? role (normalize "exercise")) ($peril$))
      ((equal? role (normalize "excanswer")) ($peril$))
      ((equal? role (normalize "vocab")) ($vocab$))
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

(element tgroup
  (let* ((wrapper   (parent (current-node)))
	 (frameattr (attribute-string (normalize "frame") wrapper))
	 (pgwide    (attribute-string (normalize "pgwide") wrapper))
	 (footnotes (select-elements (descendants (current-node)) 
				     (normalize "footnote")))
;; added: NN
            (lastsib (if (last-sibling? (current-node)) #t #f))
;; end added
	 (border (if (equal? frameattr (normalize "none"))
		     '(("BORDER" "0"))
		     '(("BORDER" "1"))))
	 (width (if (equal? pgwide "1")
		    (list (list "WIDTH" ($table-width$)))
		    '()))
	 (head (select-elements (children (current-node)) (normalize "thead")))
	 (body (select-elements (children (current-node)) (normalize "tbody")))
	 (feet (select-elements (children (current-node)) (normalize "tfoot"))))
    (make element gi: "TABLE"
	  attributes: (append
		       border
		       width
		       (if %cals-table-class%
			   (list (list "CLASS" %cals-table-class%))
			   '()))
	  (process-node-list head)
	  (process-node-list body)
	  (process-node-list feet)
	  (make-table-endnotes)
;; added NN: add extra row at end of each group, for spacing
;;    (if lastsib (empty-sosofo) (make empty-element gi: "TR"))
;; end NN

)))


;; Redo tables: rowsep becomes hr

(define ($process-row$ row overhang)
  (let* ((tgroup (find-tgroup row))
;; added: NN
            (lastsib (if (last-sibling? row) #t #f))
;; end added
	 (rowcells (node-list-filter-out-pis (children row)))
	 (maxcol (string->number (attribute-string (normalize "cols") tgroup)))
	 (lastentry (node-list-last rowcells))
	 (table  (ancestor-member tgroup (list (normalize "table")
					       (normalize "informaltable"))))
	 (rowsep (if (attribute-string (normalize "rowsep") row)
		     (attribute-string (normalize "rowsep") row)
		     (if (attribute-string (normalize "rowsep") tgroup)
			 (attribute-string (normalize "rowsep") tgroup)
			 (if (attribute-string (normalize "rowsep") table)
			     (attribute-string (normalize "rowsep") table)
;;	NN		     %cals-rule-default%))))
                 "0"))))
	 (after-row-border (if rowsep
			       (> (string->number rowsep) 0)
			       #f)))
;; added:NN
    (make sequence
;; end added
    (make element gi: "TR"
	  (let loop ((cells rowcells)
		     (prevcell (empty-node-list)))
	    (if (node-list-empty? cells)
		(empty-sosofo)
		(make sequence
		  ($process-cell$ (node-list-first cells) 
				  prevcell overhang)  
		  (loop (node-list-rest cells) 
			(node-list-first cells)))))
	  
	  ;; add any necessary empty cells to the end of the row
	  (let loop ((colnum (overhang-skip overhang
					    (+ (cell-column-number 
						lastentry overhang)
					       (hspan lastentry)))))
	    (if (> colnum maxcol)
		(empty-sosofo)
		(make sequence
		  (make element gi: "TD"
			(make entity-ref name: "nbsp"))
		  (loop (overhang-skip overhang (+ colnum 1)))))))
;; added: NN
		(if (and lastsib (not (attribute-string (normalize "rowsep") row)))
;; insert dashed row at end of each tgroup
	(make element gi: "TR"
		(make element gi: "TD"
			(literal "--"))) 


		(empty-sosofo))

       (if (attribute-string (normalize "rowsep") row)
		(make sequence
		 (make element gi: "TR"
		   (make element gi: "TD" 
    			attributes: (list
		     		(list "COLSPAN" (attribute-string (normalize "cols") (find-tgroup row))))
		     (make empty-element gi: "HR"))) 
         )
		(empty-sosofo))
		)
;; end added: NN

))

(define ($process-cell$ entry preventry overhang)
  (let* ((colnum (cell-column-number entry overhang))
	 (lastcellcolumn (if (node-list-empty? preventry)
			     0
			     (- (+ (cell-column-number preventry overhang)
				   (hspan preventry))
				1)))
	 (lastcolnum (if (> lastcellcolumn 0)
			 (overhang-skip overhang lastcellcolumn)
			 0))
	 (htmlgi (if (have-ancestor? (normalize "tbody") entry)
		     "TD"
		     "TH")))
    (make sequence
      (if (node-list-empty? (preced entry))
	  (if (attribute-string (normalize "id") (parent entry))
	      (make empty-element gi: "A"
		    attributes: (list
				 (list
				  "NAME"
				  (attribute-string (normalize "id")
						    (parent entry)))))
	      (empty-sosofo))
	  (empty-sosofo))


      (if (attribute-string (normalize "id") entry)
	  (make empty-element gi: "A"
		attributes: (list
			     (list
			      "NAME"
			      (attribute-string (normalize "id") entry))))
	  (empty-sosofo))

      ;; This is a little bit complicated.  We want to output empty cells
      ;; to skip over missing data.  We start count at the column number
      ;; arrived at by adding 1 to the column number of the previous entry
      ;; and skipping over any MOREROWS overhanging entrys.  Then for each
      ;; iteration, we add 1 and skip over any overhanging entrys.
      (let loop ((count (overhang-skip overhang (+ lastcolnum 1))))
	(if (>= count colnum)
	    (empty-sosofo)
	    (make sequence
	      (make element gi: htmlgi
		    (make entity-ref name: "nbsp")
;;		  (literal (number->string lastcellcolumn) ", ")
;;		  (literal (number->string lastcolnum) ", ")
;;		  (literal (number->string (hspan preventry)) ", ")
;;		  (literal (number->string colnum ", "))
;;		  ($debug-pr-overhang$ overhang)
        (if (attribute-string (normalize "rowsep") entry)
		 (make empty-element gi: "HR") (empty-sosofo))
		    )
	      (loop (overhang-skip overhang (+ count 1))))))

;      (if (equal? (gi entry) (normalize "entrytbl"))
;	  (make element gi: htmlgi
;		(literal "ENTRYTBL not supported."))
	  (make element gi: htmlgi
		attributes: (append
			     (if (> (hspan entry) 1)
				 (list (list "COLSPAN" (number->string (hspan entry))))
				 '())
			     (if (> (vspan entry) 1)
				 (list (list "ROWSPAN" (number->string (vspan entry))))
				 '())
			     (if (equal? (cell-colwidth entry colnum) "")
				 '()
				 (list (list "WIDTH" (cell-colwidth entry colnum))))
			     (list (list "ALIGN" (cell-align entry colnum)))
			     (list (list "VALIGN" (cell-valign entry colnum))))
		(if (empty-cell? entry) 
		    (make entity-ref name: "nbsp")
		    (if (equal? (gi entry) (normalize "entrytbl"))
			(process-node-list entry)
			(process-node-list (children entry))))
;; added: NN
       (if (attribute-string (normalize "rowsep") entry)
		 (make empty-element gi: "HR") (empty-sosofo))
;; end added: NN
))))



;; (define %indent-literallayout-lines% "\U-2003\U-2003\U-2003")

(element informalexample ($indent-para-container$))

;; Returns the depth of auto TOC that should be made at the nd-level
(define (toc-depth nd)
  (if (string=? (gi nd) (normalize "book"))
      2
      1))


(define %use-id-as-filename%
  ;; Use ID attributes as name for component HTML files?
  #t)

</style-specification-body>
</style-specification>
<external-specification id="docbook" document="dbstyle">
</style-sheet>
