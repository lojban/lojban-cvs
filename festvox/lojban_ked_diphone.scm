;;; an attempt at a Lojban voice based on the ked diphones. It's not the best
;;; solution, certainly, but it's much better than nothing. Hopefully,
;;; some day, someone will record official lojban phones. 

;;; Steve Pomeroy <steve@staticfree.info>

;; $Revision$

;;; load up the ked diphone files
(defvar ked_diphone_dir (cdr (assoc 'ked_diphone voice-locations))
  "ked_diphone_dir
  The default directory for the ked diphone database.")
(set! load-path (cons (path-append ked_diphone_dir "festvox/") load-path))

(if (probe_file (path-append ked_diphone_dir "group/kedlpc16k.group"))
    (defvar ked_index_file 
      (path-append ked_diphone_dir "group/kedlpc16k.group"))
    (defvar ked_index_file 
      (path-append ked_diphone_dir "group/kedlpc8k.group")))

(require 'radio_phones)
(require_module 'UniSyn)

(lex.set.phoneset "radio")

(set! token.whitespace " \t\n\r")
(set! token.punctuation ".\",:;!?(){}[]")
(set! token.prepunctuation ".\"({[")

(lex.create "lojban")

;; non-standard things
(lex.add.entry '("." punc nil))
(lex.add.entry '("i" punc (((pau) 0) ((iy) 0))))
(lex.add.entry '("'i" nil (((hh) 0) ((iy) 0))))
;(lex.add.entry '("'" punc nil))

(lts.ruleset
;; Name of rule set
  lojban
;; Sets used in the rules
(
;  (LNS l n s )
  (AEIOUY a e i o u y )
;  (AEO a e o )
;  (EI e i )
;  (BDGLMN b d g l m n )
)
;; radio
(
; ( [ h ] AEIOUY = hh )
 ( [ a ] = aa )
 ( [ e i ] = ey )
 ( [ e ] # = eh hh ) ;; so the e doesn't get cut off
 ( [ e ] = eh )
 ( [ i ] = iy )
 ( [ o ] = ow )
 ( [ u ] = uw )
 ( [ b ] = b )
 ( [ c ] = sh )
 ( [ d j ] = jh )
 ( [ d ] = d )
 ( [ f ] = f )
 ( [ g ] = g )
 ( [ h ] = hh )
 ( [ j ] = sh ) ;; the best we can do with these diphones
 ( [ k ] = k )
 ( [ l ] = l )
 ( [ m ] = m )
 ( [ n ] = n )
 ( [ p ] = p )
 ( [ r ] = r )
 ( [ s ] = s )
 ( [ t c ] = sh )
 ( [ t ] = t )
 ( [ v ] = v )
 ( [ x ] = hh ) ;; a horrid approximation
 ( [ y ] = ax )
 ( [ z ] = z )
))

(lex.set.lts.ruleset 'lojban)

(set! lojban_phone_data
'(
   (pau 0.0 0.250)
   (aa 0.0 0.080)
   (ax 0.0 0.130)
   (eh 0.0 0.080)
   (ey 0.0 0.080)
   (iy 0.0 0.070)
   (ih 0.0 0.070)
   (ow 0.0 0.080)
   (uw 0.0 0.070)
   (b 0.0 0.065)
   (ch 0.0 0.135)
   (d 0.0 0.060)
   (dx 0.0 0.060)
   (f 0.0 0.100)
   (g 0.0 0.080)
   (hh 0.0 0.030)
   (j 0.0 0.100)
   (k 0.0 0.100)
   (l 0.0 0.080)
   (ll 0.0 0.105)
   (m 0.0 0.070)
   (n 0.0 0.080)
   (ny 0.0 0.110)
   (p 0.0 0.100)
   (r 0.0 0.030)
   (rr 0.0 0.080)
   (s 0.0 0.110)
   (jh 0.0 0.135)
   (sh 0.0 0.135)
   (t 0.0 0.085)
   (th 0.0 0.100)
   (v 0.0 0.100)
   (y 0.0 0.080)
   (w 0.0 0.100)
   (x 0.0 0.130)
   (z 0.0 0.110)
))

(set! lojban_lpc_group 
      (list
       '(name "lojban_lpc_group")
       (list 'index_file ked_index_file)
       '(grouped "true")
       '(alternates_left ((ah ax)))
       '(alternates_right (($p p) ($k k) ($g g) ($d d) ($b b) ($t t)
				  (aor ao) (y ih) (ax ah) ))

       '(default_diphone "pau-pau")))


; ;; Go ahead and set up the diphone db
 (us_diphone_init lojban_lpc_group)

(define (lojban_lts word feats)
  "(lojban_lts WORD FEATURES) Using letter to sound rules build
a lojban pronunciation of WORD."
  (require 'lts)
;;DEBUG  (print word)
  (list word
        nil
        (lex.syllabify.phstress (lts.apply (downcase word) 'lojban))))

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
     ((1.5))
     ((1.2)))
    ((R:SylStructure.parent.syl_break > 1)   ;; clause final
     ((R:SylStructure.parent.stress is 1)
      ((1.5))
      ((1.2)))
     ((R:SylStructure.parent.stress is 1)
      ((ph_vc is +)
       ((1.2))
       ((1.0)))
      ((1.0))))))



(set! lojban_phrase_cart_tree
'
((lisp_token_end_punc in ("?" "i" ":"))
  ((BB))
  ((lisp_token_end_punc in ("'" "\"" "," ";"))
   ((B))
   ((n.name is 0)  ;; end of utterance
    ((BB))
    ((NB))))))

(set! lojban_int_simple_params
    '((f0_mean 120) (f0_std 30)))


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
    (builtin_english_token_to_words token (string-before name "."))
    ;(list '((name hh)(pbreak_scale 1.0)))
    (builtin_english_token_to_words token (string-after name "."))))
  (t
   (builtin_english_token_to_words token name))
))


;;;  Full voice definition 
(define (voice_lojban_diphone)
"(voice_lojban_diphone)
Set up synthesis for Male Lojban speaker"
  (voice_reset)
  (Parameter.set 'Language 'lojban)
  ;; Phone set
  (Parameter.set 'PhoneSet 'radio)
  (PhoneSet.select 'radio)

  (set! token_to_words lojban_token_to_words)

  ;; No pos prediction (get it from lexicon)
  (set! pos_lex_name nil)
  ;; Phrase break prediction by punctuation
  (set! pos_supported nil) ;; well not real pos anyhow
  ;; Phrasing
  (Parameter.set 'Phrase_Method 'cart_tree)
  (set! phrase_cart_tree lojban_phrase_cart_tree)
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
;  (set! us_abs_offset 0.0)
;  (set! window_factor 1.0)
;  (set! us_rel_offset 0.0)
;  (set! us_gain 0.9)

  (Parameter.set 'Synth_Method 'UniSyn)
  (Parameter.set 'us_sigpr 'lpc)
  (us_db_select 'lojban_lpc_group)

  (set! current-voice 'lojban_diphone)
)

(proclaim_voice
 'lojban_diphone
 '((language lojban)
   (gender male)
   (dialect american)
   (description
    "An attempt at a lojban voice based on existing diphones. The 
\"x\" and \"j\" sounds are a bit off, but most other sounds are correct.")))

(provide 'lojban_diphone)
