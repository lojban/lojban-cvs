;;;               Lojban diphone

;;; This voice uses a diphone corpus recorded by 
;;;    Candide Kemmler <candide@fractals.be>

;;; Hand-timing done by Arnt Richard Johansen <arj@nvg.org>
;;;    and Steve Pomeroy <steve@staticfree.info>

;;; this file was brutally hacked into existence from the sample voice 
;;; definitions and the el_diphone.scm file by Steve Pomeroy

;; $Revision$

;;; load up the ljb diphone files
(defvar ljb_diphone_dir "/home/arj/festvox/ljb_diphone/" 

  "ljb_diphone_dir
  The default directory for the lojban diphone database.")
(set! load-path (cons (path-append ljb_diphone_dir "festvox/") load-path))

(require_module 'UniSyn)
(require 'toi_ljb_phones)

(lex.set.phoneset "toi_ljb")

(set! token.whitespace " \t\n\r")
(set! token.punctuation "\",:;!?<>(){}[]")
(set! token.prepunctuation "\"({[<")

;; Lexicon for testing purposes.
;; We need to have this until we can predict stress automatically.
;; In the production version, we will do only letter-to-sound.
(lex.create "lojban")
;(lex.compile "/home/arj/festvox/ljb_diphone/lojbanlex.txt" "/home/arj/festvox/ljb_diphone/lojbanlex.out")
;(lex.set.compile.file "/home/arj/festvox/ljb_diphone/lojbanlex.out")

;; non-standard things
(lex.add.entry '("." punc (((#) 0))))

(lex.add.entry '("(" punc (((#) 0))))
(lex.add.entry '(")" punc (((#) 0))))

(lex.add.entry '("<" punc (((#) 0))))
(lex.add.entry '(">" punc (((#) 0))))

(lex.add.entry '("{" punc (((#) 0))))
(lex.add.entry '("}" punc (((#) 0))))

(lts.ruleset
;; Name of rule set
  lojban
;; Sets used in the rules
(
  (AEIOUY a e i o u y )
)
;; lojban
(
;; dipthongs
 ( [ a i ] = ai )
 ( [ e i ] = ei )
 ( [ o i ] = oi )
 ( [ a u ] = au )

 ( [ i e ] = ie )
 ( [ i a ] = ia )
 ( [ i o ] = io )
 ( [ i i ] = ii )
 ( [ i u ] = iu )

 ( [ u e ] = ue )
 ( [ u a ] = ua )
 ( [ u o ] = uo )
 ( [ u i ] = ui )
 ( [ u u ] = uu )

 ( [ i y ] = iy )
 ( [ u y ] = uy )

;; vowels
 ( [ a ] = a )
 ( [ e ] = e )
 ( [ i ] = i )
 ( [ o ] = o )
 ( [ u ] = u )
 ( [ y ] = y )

;; consonants
 ( [ b ] = b )
 ( [ c ] = c )
 ( [ d ] = d )
 ( [ f ] = f )
 ( [ g ] = g )
 ( [ h ] = h )
 ( [ j ] = j )
 ( [ k ] = k )
 ( [ l ] = l )
 ( [ m ] = m )
 ( [ n ] = n )
 ( [ p ] = p )
 ( [ r ] = r )
 ( [ s ] = s )
 ( [ t ] = t )
 ( [ v ] = v )
 ( [ x ] = x )
 ( [ z ] = z )
))

(lex.set.lts.ruleset 'lojban)

(set! lojban_phone_data
'(
   (# 0.0 0.050) ;; the sound of silence

   (e 0.0 0.080)
   (a 0.0 0.080)
   (o 0.0 0.080)
   (i 0.0 0.080)
   (u 0.0 0.070)
   (y 0.0 0.080)

   (ai 0.0 0.120)
   (ei 0.0 0.120)
   (oi 0.0 0.120)
   (au 0.0 0.120)

   (ie 0.0 0.120)
   (ia 0.0 0.120)
   (io 0.0 0.120)
   (ii 0.0 0.120)
   (iu 0.0 0.120)

   (ue 0.0 0.120)
   (ua 0.0 0.120)
   (uo 0.0 0.120)
   (ui 0.0 0.120)
   (uu 0.0 0.120)

   (iy 0.0 0.120)
   (uy 0.0 0.120)

   (p 0.0 0.100) 
   (t 0.0 0.085)
   (k 0.0 0.100)
   (b 0.0 0.065)
   (d 0.0 0.060)
   (g 0.0 0.080)

   (s 0.0 0.110)
   (z 0.0 0.110)
   (c 0.0 0.110)
   (j 0.0 0.100)
   (f 0.0 0.100)
   (v 0.0 0.100)

   (h 0.0 0.030)
   (x 0.0 0.130)   (m 0.0 0.070)
   (n 0.0 0.040)
   (l 0.0 0.080)
   (r 0.0 0.030)
))

(set! lojban_lpc_group 
      (list
       '(name "lojban_lpc_group")
       '(coef_ext ".pm")
       '(sig_ext ".wav")
       (list 'index_file (path-append ljb_diphone_dir "ljb_diphone.index"))
       (list 'coef_dir (path-append ljb_diphone_dir "pm/"))
       (list 'sig_dir (path-append ljb_diphone_dir "wav/"))
       '(grouped "false")
;       '(alternates_left ((ah ax)))
;       '(alternates_right (($p p) ($k k) ($g g) ($d d) ($b b) ($t t)
;				  (aor ao) (y ih) (ax ah) (ll l)))

       '(default_diphone "#-#")))


; ;; Go ahead and set up the diphone db
 (us_diphone_init lojban_lpc_group)


;; Here we define the routines that are used to predict stress.
;; All penultimate syllables get stress, monosyllabic words also get stress.
;; TODO:
;; -- cmavo should not get stress at all. Separate between parts of speech.
;; -- syllables in which the vowel is upper-case should get the stress instead
;;    off the syllable that would otherwise get it; override the default stress
;;    handling.

;; Helper functions for string handling
(define (string-car str)
  (substring str 0 1)
)

(define (string-cdr str)
  (substring str 1 (length str))
)

(define (is_consonant letter)
  (member letter '("b" "c" "d" "f" "g" "j" "k" "l" "m" "n" "p" "r" "s" "t" "v" "x" "z"))
)

(define (is_vowel letter)
  (member letter '("a", "e", "i", "o", "u", "y"))
)

(define (has_consonant_cluster word)
  (if (> (length word) 2 )
      ;; Go on recursing
      (or
       (has_consonant_cluster (substring word 0 2 ))
       (has_consonant_cluster (string-cdr word))
       )
      ;; Degenerate case
      (and (is_consonant (substring word 0 1)) (is_consonant (substring word 1 1)) )
  )
)


(define (has_initial_vowel word)
  (is_vowel (substring word 0 1))
)

(define (has_final_consonant word)
  (is_consonant (substring word (- (length word) 1) 1))
)

(define (is_content_word sylstruc)
  (or (has_final_consonant sylstruc) (has_consonant_cluster sylstruc))
)

(define (apply_stress syllable)
  (cons (car syllable) (cons 1))
)

(define (lojban_penultimate sylstruc)
    (if (> (length sylstruc) 2)
	;; Chop off first and recurse with the rest
	(cons (car sylstruc) (lojban_penultimate (cdr sylstruc)))
	;; Apply the stress to the first syllable remaining
	(cons (apply_stress (car sylstruc)) (cdr sylstruc)) )
)

(define (lojban_assign_stress sylstruc)
;; Since we are here, we are not dealing with a cmavo.
;; We should add handling of upper-case indication of stress eventually.
    (lojban_penultimate sylstruc)
)

(define (lojban_pos_predict word feats)
  (cons
   word
   (if
    (or (has_final_consonant word) (has_consonant_cluster word))
    (cons 'content)
    '(nil)
    )
   )
)

(define (lojban_apply_period word feats)
  (cons
    (if (has_final_consonant word)
	(string-append word "." ) ; Add period at end
	(if (has_initial_vowel word)
	    (string-append "." word ) ; Add period at beginning
	    word)
	 nil)
   (cons feats)
  )
)

;(define (lojban_apply_period word feats)
;  (cons word (cons feats))
;)

(define (lojban_lts word feats)
  "(lojban_lts WORD FEATURES) Using letter to sound rules build
a lojban pronunciation of WORD."
  (require 'lts)
;(print word) ;; DEBUG
;(print feats)
  (list word
        nil
	(if feats
	    ;; If it is a content word
          (lojban_assign_stress
	    (lex.syllabify.phstress (lts.apply (downcase word) 'lojban)))
	    ;; Else leave the stress alone
	  (lex.syllabify.phstress (lts.apply (downcase word) 'lojban))
	)
  )
)

(lex.set.pre_hooks lojban_pos_predict lojban_apply_period)
(lex.set.lts.method 'lojban_lts)

;;; Intonation
(set! lojban_accent_cart_tree
  '
  (
   (R:SylStructure.parent.gpos is content)
    ( (stress is 1)
       ((Accented))
       ((NONE))
    )
  )
)


;;; Duration 
(set! lojban_dur_tree
 '
   ((R:SylStructure.parent.R:Syllable.p.syl_break > 1 ) ;; clause initial
    ((R:SylStructure.parent.stress is 1)
     ((2.5))
     ((1.0)))
    ((R:SylStructure.parent.syl_break > 1)   ;; clause final
     ((R:SylStructure.parent.stress is 1)
      ((2.5))
      ((1.0)))
     ((R:SylStructure.parent.stress is 1)
      ((ph_vc is +)
       ((1.0))
       ((2.5)))
      ((1.0))))))



; (set! lojban_phrase_cart_tree
; '
; ((lisp_token_end_punc in ("?" "i" ".i" ".ije" "ni'o" ">" ")" "}" ":"))
;   ((BB))
;   ((lisp_token_end_punc in ("\"" ";"))
;    ((B))
;    ((n.name is 0)  ;; end of utterance
;     ((BB))
;     ((NB))))))

(set! simple_phrase_cart_tree
'
((R:Token.parent.name in ("i" ".i" "ije" ".ije"))
  ((BB))
  ((R:Token.parent.name in ("noi" "poi" "goi" "je" "ja" "jo" "ju" "la" "le" "lo" "li" "lu"))
   ((B))
   ((n.name is 0)
    ((BB))
    ((NB))))))

(set! lojban_int_simple_params
    '((f0_mean 140) (f0_std 50)))


(define (lojban_token_to_words token name)
"(lojban_token_to_words TOKEN NAME)
Returns a list of words for NAME from TOKEN.  This allows the
user to customize various non-local, multi-word, context dependent
translations of tokens into words.  If this function is unset only
the builtin translation rules are used, if this is set the builtin
rules are not used unless explicitly called. [see Token to word rules]"
 (cond
  ;;; turn "go'i" into "gohi"
  ((string-matches name ".+\\'.+")
  (lojban_token_to_words token (string-append (string-before name "'") "h" (string-after name "'"))))

  ;;; seperates vowels next to each other eg: "a.o"
  ((string-matches name ".*\\..*")
   (append
    (lojban_token_to_words token (string-before name "."))
    (builtin_english_token_to_words token ".")
    (lojban_token_to_words token (string-after name "."))))
  (t
   (builtin_english_token_to_words token name))
))


;;;  Full voice definition 
(define (voice_lojban_diphone)
"(voice_lojban_diphone)
Set up synthesis for a male Lojban speaker"
  (voice_reset)
  (Parameter.set 'Language 'lojban)
  ;; Phone set
  (Parameter.set 'PhoneSet 'toi_ljb)
  (PhoneSet.select 'toi_ljb)

  (set! token_to_words lojban_token_to_words)

  ;; No pos prediction (get it from lexicon)
  (set! pos_lex_name nil)
  ;; Phrase break prediction by punctuation
  (set! pos_supported nil) ;; well not real pos anyhow
  ;; Phrasing
  (Parameter.set 'Phrase_Method 'cart_tree)
  (set! phrase_cart_tree simple_phrase_cart_tree)
  ;; Lexicon selection
  (lex.select "lojban")

  ;; Accent and tone prediction
  (set! int_accent_cart_tree lojban_accent_cart_tree)

  (set! int_simple_params lojban_int_simple_params)
  (Parameter.set 'Int_Method 'Simple)

  ;; Duration prediction
  (set! duration_cart_tree lojban_dur_tree)
  (set! duration_ph_info lojban_phone_data)
 (Parameter.set 'Duration_Method 'Tree_ZScores)

  ;; Waveform synthesizer: diphones
;  (set! UniSyn_module_hooks (list el_diphone_fix))
  (set! us_abs_offset 0.0)
  (set! window_factor 1.0)
  (set! us_rel_offset 0.0)
  (set! us_gain 1.0)
  
;; If this is above 1.0, it will slow down the synthesizer
;; (may help with the intelligibility)
  (Parameter.set 'Duration_Stretch 1.0)


  (Parameter.set 'Synth_Method 'UniSyn)
  (Parameter.set 'us_sigpr 'psola)
  (us_db_select 'lojban_lpc_group)

  (set! current-voice 'lojban_diphone)
)

(proclaim_voice
 'lojban_diphone
 '((language lojban)
   (gender male)
   (dialect lojbanic)
   (description
    "A lojbanic male voice using Candide Kemmler's recordings.")))

(provide 'lojban_diphone)
