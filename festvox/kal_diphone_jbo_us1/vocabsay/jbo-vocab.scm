
;; jbo-vocab.scm: lojban vocabulary training tape synthesizer

;; uses the Festival speech synthesis system with the
;; kal_diphone_jbo_us1 voice

;; This program could use some vocabulary list sorting features, but I
;; leave that as a nice feature which could be added in the future.

;; Define which voices to use for Lojban and English speech.
(set! lojban-voice-id 'kal_diphone_jbo_us1)
(define (lojban-voice) (voice_kal_diphone_jbo_us1))
(set! english-voice-id 'kal_diphone)
(define (english-voice) (voice_kal_diphone))

;; This is a list of ways to interperet characters in embedded English text
(set!
 symlist
 '(
   ("@" " keck ")
   ("?" " question mark ")
   ("," " comma ")
   (":" " colon ")
   ("/" " slash ")
   ("." " period ")
   ("(" " open parenthesis ")
   (")" " close parenthesis ")
   ("-" " dash ")
   ("+" " plus ")
   )
 ;; note the spaces... they simplify symbol expansion
 )

;; Each entry in the vocabulary is an a-list of the following...
'
((jbo "selma'o")            ; the word in Lojban
 (type 'lujvo)              ; the type of word, if known (optional)
 (from "se cmavo")          ; origin of combining form (conditional, optional)
 (enplex "whatever-idea")   ; English meaning of 'from (conditional, optional)
 (en 'unknown)              ; English meaning of 'jbo (optional, or 'unknown)
 (mark nil)                 ; Optional markings: used to mark words for study
 (note "uncertain")         ; Marginal notes regarding the entry (optional)
 (cat "house/kitchen")      ; vocabulary category: pick your own (optional)
 (sn "W0123AT.EV/ER")       ; any official LLG term serial no./code (optional)
 (num 123)                  ; any locally-assigned serial number (optional)
 (index 456)                ; any project-specific serial number (optional)
 (rafsi ("ri'a" "ra'i"))    ; list of rafsi as a list of strings
 (source "jbovlaste")       ; source of the definition (only one per word??!)
 (syn ("syn1" "syn2"))      ; list of any lojban synonyms of the lojban word
 )

;;
;; I like to use the following 'mark values for my vocabulary:
;; 
;; '(en) - have to learn jbo->en
;; '(x) - I know the English, but need to learn the places
;; '(en x) - have to learn jbo->en and places
;; '(jbo) - need to practice this en->jbo association
;; '(en x jbo) - have to learn jbo->en, en->jbo, and places
;; '() - I know this word,  nothing important left to learn
;; '(<other>) - any other fetures I wish to learn, i.e. 'from forms

;; Helper function for use in switching voices
(define (ensure-voice lang stretch)
  ;; Switch to a voice in language <lang> with Duration_Stretch
  ;; <stretch>.  If <stretch> is nil, leaves Duration_Stretch alone.
  ;; These a-lists should probably me moved into variables.
  (let ((ids (list
	      (list 'lojban lojban-voice-id)
	      (list 'english english-voice-id)
	      ))
	(langs (list
		(list 'lojban lojban-voice)
		(list 'english english-voice)
		))
	)
    ;; we have to use a double-let here because Festival does not have
    ;; a let*
    (let ((id (cadr (assoc lang ids)))
	  (vox-func (cadr (assoc lang langs)))
	  )
      (or (eq current-voice id) (vox-func))
      (and stretch (Parameter.set 'Duration_Stretch stretch))
      )
    )
  )

;; A function to return the Lojban spelling of a Lojban word.
(define (lojban-letter-spelling letter)
  (if (equal? (string-length letter) 1)
      (cond ((string-matches letter "[aeiouAEIOU]")
	     (string-append "." letter "bu "))
	    ((string-matches letter "[a-zA-Z]")
	     (string-append letter "y. "))
	    (t (string-append "zoi ly. " letter " ly. ")))
      "")
  )
(define (lojban-spelling word)
  (let ((len (string-length word)))
    (if (> len 1)
	(string-append
	 (lojban-letter-spelling (substring word 0 1))
	 (lojban-spelling (substring word 1 (- len 1))))
	(lojban-letter-spelling word)
	)
    )
  )
;; A function to return the English spelling of a word.
(define (english-spelling word)
  (let ((len (string-length word)))
    (string-replace-all
     "'" "apostrophe"
     (if (> len 1)
	 (string-append
	  (substring word 0 1)
	  ","
	  (english-spelling (substring word 1 (- len 1))))
	 (string-append word ",")
	 ))
    )
  )
;; A function to return the (aviators') phonetic spelling of a word.
(setq phonetic-alphabet
      ;; these phonetic letters are spelled phonetically :)
      '(("a" "alpha")
	("b" "bravo")
	("c" "charlie")
	("d" "delta")
	("e" "echo")
	("f" "fox trot")
	("g" "golf")
	("h" "house")
	("i" "indigo")
	("j" "juliet")
	("k" "keelo")
	("l" "lee,ma")
	("m" "mike")
	("n" "november")
	("o" "ohsker")
	("p" "pop uh")
	("q" "quebec")
	("r" "romeo")
	("s" "sierra")
	("t" "tango")
	("u" "uniform")
	("v" "victor")
	("w" "whiskey")
	("x" "x ray")
	("y" "yankee")
	("z" "zulu"))
      )
(define (phonetic-spelling word)
  (let ((len (string-length word)))
    (string-replace-all
     "'" "apostrophe"
     (if (> len 0)
	 (string-append
	  (let (letter spelling)
	    (setq letter (substring word 0 1))
	    (setq spelling (cadr (assoc letter phonetic-alphabet)))
	    (or spelling letter)
	    )
	  ","
	  (phonetic-spelling (substring word 1 (- len 1))))
	 (string-append word ",")
	 ))
    )
  )

;; Wrapper function to speak the spelling of a word.
(define (spell word lang stretch)
  (ensure-voice (or (and (eq lang 'phonetic) 'english) lang) stretch)
  (cond ((eq lang 'lojban)
	 (SayText (lojban-spelling word)))
	((eq lang 'english)
	 (SayText (english-spelling word)))
	((eq lang 'phonetic)
	 (SayText (phonetic-spelling word))))
  )
;; Wrapper function to speak a word.
(define (speak word lang stretch)
  (ensure-voice lang stretch)
  (SayText word)
  )

;; A simple busy loop, since I don't know how to sleep in Festival...
(define (short-sleep n)
  (or (<= n 0)
      (short-sleep (- n 1))
      )
  )
(define (long-sleep n)
  (system (string-append "sleep " (format nil "%d" n)))
  )

;; A simple string substitution function.
(define (string-contains substr instr)
  (let ((sum    (+ (string-length (string-before instr substr))
		   (string-length (string-after instr substr)))))
    (cond ((equal? sum 0) nil)
	  ((< sum (string-length instr)) t))
    )
  )
(define (string-replace-first patstr newstr instr)
  (if (string-contains patstr instr)
      (string-append
       (string-before instr patstr)
       newstr
       (string-after instr patstr))
      instr
      )
  )
(define (string-replace-all patstr newstr instr)
  (if (string-contains patstr instr)
      (string-append
       (string-before instr patstr)
       newstr
       (string-replace-all patstr newstr (string-after instr patstr)))
      instr
      )
  )
(define (expand-string str)
  (let ((sofar str))
    (mapcar (lambda(symassoc)
	      (set! sofar
		    (string-replace-all
		     (car symassoc)
		     (cadr symassoc)
		     sofar))
	      )
	    symlist)
    sofar
    )
  )

;; These functions are to make a training tape.
(define (make-tape vocab-file filter series)
  (set! vocabulary (load vocab-file t)) ; load file without evaluation
  (set! terms-processed nil) ; remember each word, for duplicate detection
  ;; Set up some basic function aliases for ease of use
  (set! filter-func (cond ((eq filter t) (lambda(X) t))
			  ((eq filter nil) (lambda(X) t))
			  ;; most other filters require environment
			  (t filter)))
  (set! number-terms (length vocabulary))
  (set! current-term 0)
  (set! intro (if series
		  (format nil "Here begins vocabulary segment %s" series)
		  "Here begins a vocabulary segment"))
  (format t "Vocabulary contains %d terms.\n" number-terms)
  ;; Announce the begining of the tape
  (speak intro 'english 1.2)
  (mapcar (lambda (entry)
	    (set! current-term (+ current-term 1))
	    (set! lojban-term (cadr (assoc 'jbo entry)))
	    ;; allow lambda-based selection of entries to include
	    (if
	     (filter-func entry)
	     (begin
	       (format t "Including term %d: %s\n" current-term lojban-term)
	       ;; Announce any repetetive entry
	       (if (member lojban-term terms-processed)
		   (speak "Oops, here comes a repetitious entry" 'english 1.2)
		   (short-sleep 200)
		   )
	       (tape-entry entry)
	       )
	     (format t "Excluding term %d: %s\n" current-term lojban-term)
	     )
	    (set! terms-processed (cons lojban-term terms-processed))
	    )
	  vocabulary)
  ;; Announce the end of the tape
  (speak "Ok \n\n That is all for now \n\n Thank you for listening \n\n
This segment is now over" 'english 1.2)
  )
;; This function makes a single entry for the tape.
(define (tape-entry entry)
  
  ;; Pick out vocabulary word attributes
  (set! lojban-term (cadr (assoc 'jbo entry)))
  (set! english-term (cadr (assoc 'en entry)))
  (and (eq english-term 'unknown)
       (set! english-term "English meaning unknown"))
  (set! from-phrase (cadr (assoc 'from entry)))
  (set! enplex-phrase (cadr (assoc 'enplex entry)))
  (set! note-phrase (cadr (assoc 'note entry)))
  (set! phrase-type (cadr (assoc 'type entry)))
  (set! pharse-cat (cadr (assoc 'cat entry)))
  
  ;; Say it in Lojban
  (speak lojban-term 'lojban 1.9)
  (short-sleep 100)
  ;; Spell it in English
  ;;(spell lojban-term 'english 2.5)
  ;; Spell it in the aviaton phonetic alphabet
  (spell lojban-term 'phonetic 1.0)
  (short-sleep 200)
  ;; Repeat it in Lojban
  (speak lojban-term 'lojban 1.9)
  (short-sleep 200)
  
  (and phrase-type (speak (expand-string phrase-type) 'lojban nil))
  
  (and from-phrase
       ;; yes, it's misspelled, but it sounds right!
       (speak "Frum" 'english 1.5)
       (speak (expand-string from-phrase) 'lojban 1.5)
       )
  
  ;; Say it in English (twice)
  (set! speed (if (< (string-length english-term) 15) 1.9 1.2))
  ;; expand embedded symbols
  (set! english-term (expand-string english-term))
  (speak english-term 'english speed)
  (short-sleep 200)
  (speak english-term 'english speed)
  
  ;; Say any English compound meaning
  (and enplex-phrase
       (speak "Meaning" 'english nil)
       (speak (expand-string enplex-phrase) 'english nil)
       )
  
  ;; Say any word notes
  (and note-phrase
       (speak "Word note" 'english nil)
       (speak (expand-string note-phrase) 'english 1.5)
       )
  
  ;; Say it again in Lojban
  (short-sleep 200)
  (speak lojban-term 'lojban 1.9)
  
  (long-sleep 1)
  )

;; Identify "boogie terms"--terms with unknown, unclear, or uncertain
;; meanings... usually for exclusion from the tape.
(define (boogie-term? entry)
  (or (eq (cadr (assoc 'en entry)) 'unknown)
      (eq (cadr (assoc 'note entry)) 'uncertain)
      ;; er... include those with "uncertain meaning"...
      ;;(equal? (cadr (assoc 'note entry)) "uncertain meaning")
      (eq (cadr (assoc 'note entry)) 'unclear)
      (equal? (cadr (assoc 'note entry)) "unclear meaning"))
  )

;; Simple function to dump just the 'jbo and 'en entries from a
;; vocabulary file
(define (dump-jbo2en vocab-file)
  (set! vocabulary (load vocab-file t)) ; load file without evaluation
  (mapcar (lambda (entry)
	    (set! lojban-term (cadr (assoc 'jbo entry)))
	    (set! english-term (cadr (assoc 'en entry)))
	    (format t "%l\n" (list (list 'jbo lojban-term)
				   (list 'en english-term)
				   ))
	    )
	  vocabulary)
  ;; now, when this is run through a text sort, the result should
  ;; approximate a text file lexicon suitable for download to a PDA
  ;; for Lojban-English lookup on the go
  )

;; Set up some missing lexical entries
(ensure-voice 'english nil)
(lex.add.entry '("Lojban" nil (((l ow zh) 1) ((b aa n) 0))))
(lex.add.entry '("Lojbanic" nil (((l ow zh) 0) ((b aa n) 1) ((ih k) 0))))
(lex.add.entry '("closable" nil (((k l ow) 1) ((s uh b) 0) ((uh l) 0))))

;; end

