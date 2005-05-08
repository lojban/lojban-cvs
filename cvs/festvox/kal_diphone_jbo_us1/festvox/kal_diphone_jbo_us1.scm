
'kal_diphone_jbo_us1-license "
;; kal_diphone_jbo_us1.scm: Lojban voice for Festival speech synthesis system
;; Copyright (C) 2004  Harold McBride
;; 
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;;
"

;;
;; Version 0.1.0, written 2004.12.06-2004.12.10.  The author of this
;; software may be reached by mail sent to P.O. Box 1424, Dover, NH
;; 03821, or e-mail sent to aluminumsulfate@earthlink.net.
;; 
;; If you release modified versions of this code, it's asked that you:
;; 
;;  1. Include in your code all credits included in this file, and
;;  
;;  2. Use at least a slightly different name for your version of this
;;  voice, perhaps increasing its minor version by one, or choosing a
;;  new name for the voice altogether. i.e.: use kal_diphone_jbo_us1A,
;;  kal_diphone_jbo_us2, kal_diphone_joes_lojban, or somesuch.
;;

;;
;; Acknowledgements:
;; 
;;   Information used in the creation of this voice was obtained from
;;   several sources.
;;   
;;   General information about the functioning of Festival was
;;   obtained from The Festival Manual Edition 1.4, by Alan W Black,
;;   Paul Taylor, and Richard Caley, available at
;;   http://www.cstr.ed.ac.uk/projects/festival/manual/, written for
;;   Festival Version 1.4.0.
;;   
;;   Chapter 24, "Voices", in the Festival Manual, with contributions
;;   by Alistair Conkie, was helpful in structuring some parts of this
;;   code.
;;   
;;   The voice_kal_diphone function in festvox/kal_diphone.scm,
;;   Copyright (c) 1998 by Alan W Black and Kevin Lenzo, included in
;;   the Festival 1.4.3 distribution was used to learn about some of
;;   the more obscure methods and parameters in Festival, as well as
;;   how to set up the UniSyn module.
;;   
;;   Information concerning the mapping of Lojban phonemes to English
;;   phonemes was obtained from the "Phonology" section
;;   (http://www.lojban.org/en/publications/level0/brochure/phonol.html)
;;   of Chapter 2 of the "What is Lojban?" publication of the Logical
;;   Language Group. http://www.lojban.org/en/publications/level0.html
;;   
;;   The lojban_diphone.scm file by Steve Pomeroy, available at
;;   http://staticfree.info/projects/lojban_festvox, was used for
;;   <fill this in&&&>.
;;

;;
;; About Festival
;; 
;; Festival is a computer speech synthesis system developed by The
;; Centre for Speech Technology Research (CSTR) at the University of
;; Edinburgh.  It utilizes the Edinburgh Speech Tools Library and is
;; distributed under an X11-like license.  Festival is designed to be
;; useful as an end-user application, as a tool for speech synthesis
;; research, and as a library for development of speech-synthesizing
;; applications.  Festival is written in C++ and can be used as a
;; command-line utility, from an Emacs buffer, as a library, or
;; through its built-in SIOD-based Scheme interpereter.  Festival has
;; a modular design which allows it to be flexible and extensible.
;; Using Festival's existing features, and adding new ones, can easily
;; be done in both Scheme and C++.
;; 
;; The Festival hamepage is at
;; http://www.cstr.ed.ac.uk/projects/festival/. Additional Festival
;; resources can be found at Carnegie Mellon's FestVox project at
;; http://www.festvox.org.
;;

;;
;; About Lojban
;; 
;; Lojban (ISO 639 language code "jbo") is a expressive,
;; culture-neutral constructed spoken language with an unambiguous
;; grammar, morphology, phonology, and orthography.  (This basically
;; means that, when spoken or written, it can only be interpereted in
;; one way.)  Lojban, a member of the Loglan family of languages
;; invented by Dr. James Cooke Brown in the latter half of the 1950's,
;; has been developed and maintained by the Logical Language Group
;; since its creation in 1987.
;; 
;; The sounds, grammar, and semantics of Lojban were chosen from among
;; languages all over the world.  Due to its culture-neutrality,
;; Lojban has the potential to become an international auxiliary
;; language.  Because its grammar is flexible and unambiguous, Lojban
;; permits the expression of ideas which are difficult to express
;; (clearly) in natural languages (such as English).  Thus, it is
;; speculated that Lojban may also help to free the human mind's
;; creative processes and promote undistorted communication between
;; individuals.  Because Lojban has a machine-parsable grammar, Lojban
;; is nearly ideal for computerized language processing.  And, for all
;; of these reasons, Lojban is a powerful tool for use in research
;; linguistics. (Perhaps the most notable of Lojban's potential
;; research applications is in testing of the Sapir-Whorf hypothesis.)
;; 
;; For more information about Lojban, e-mail lojban@lojban.org, visit
;; http://www.lojban.org or write to: The Logical Language Group, Inc.
;; 2904 Beau Lane Fairfax, VA 22031 U.S.A.  (+1 703) 385-0273.
;;

;;
;; Festival Voice Development Resources
;; 
;; If you wish to do your own development of Festival voices, you
;; should at least read the "Voices" section
;; (http://www.cstr.ed.ac.uk/projects/festival/manual/festival_24.html#SEC97)
;; of The Festival Manual (current version 1.4.0) at
;; http://www.cstr.ed.ac.uk/projects/festival/manual/.
;; 
;; I would recommend reading at least the following sections: 1
;; Abstract, 5 Overview, 7 Quick start, 9 TTS, 12 Phonesets, 13
;; Lexicons, 14 Utterances, 15 Text analysis, 16 POS tagging, 17
;; Phrase breaks, 18 Intonation, and 19 Duration. You may also,
;; depending on your aims, want to read: 8 Scheme and 10 XML/SGML
;; mark-up.
;; 
;; In addition, the above-cited chapter on Voices provides reference
;; to more in-depth literature: "A much more detailed document on
;; building voices in Festival has been written and is recommend
;; reading for any one attempting to add a new voice to Festival
;; black99."
;; 
;; The definition of utterance type Text in synthesis.scm, which shows
;; which modules are called for that utterance type, can serve as a
;; convenient check list of behaviors which should be defined during
;; voice creation.
;; 
;; And don't forget, of course, to check out the Carnegie Mellon's
;; FestVox project at http://www.festvox.org.
;;

;;;
;;; Quick Installation Instructions
;;; 
;;;  For those of you unfamiliar with Festival and/or Scheme:
;;;  
;;;  To install this file, place it in a Festival directory named
;;;  voices/lojban/kal_diphone_jbo_us1/festvox/ (usually under
;;;  /usr/lib/festival or /usr/share/festival) and name the file
;;;  kal_diphone_jbo_us1.scm.  Then, create a "ln -s kal_diphone
;;;  kal_diphone_jbo_us1" symlink in the voices/ directory.
;;;  
;;;  In festival, type: (voice_kal_diphone_jbo_us1)
;;;  
;;;  > unix$ festival
;;;  > Festival Speech Synthesis System 1.4.3:release Jan 2003
;;;  > Copyright (C) University of Edinburgh, 1996-2003. All rights reserved.
;;;  > For details type `(festival_warranty)'
;;;  > festival> (voice_kal_diphone_jbo_us1)
;;;  > kal_diphone_jbo_us1
;;;  
;;;  The new voice is now the current voice and can be used as normal.
;;;  
;;;  > festival> (SayText ".i la lojban mo")
;;;  > #<Utterance 0x8ab58c34>
;;;  
;;;  And you should hear the synthesized text spoken.  It's that easy!
;;;

;;
;; Known Bugs
;; 
;;	Until we have Lieutenant Data-like androids running around on
;;	our spaceships, voices will always have bugs in them.  As far
;;	as I know, this voice will not cause Festival to crash.  As of
;;	this writing, however, there appears to be a bug in the stock
;;	diphone synthesizer code which causes festival to segfault if
;;	an attempt is made to synthesize a Phones utterance containing
;;	less than two phones. This is part of Festival, as provided,
;;	and is not due to this Lojbanization of kal_diphone.
;;

(define kal_diphone_jbo_us1-properties
  (list
   '(version (0 1 0))
   ;; &&& fill-in here
   )
  )

;;
;; General Approach
;;
;; There are several ways in which a Lojban voice could be implemented
;; for Festival.  Among them are the following:
;; 
;;   1. Translating Lojban text into homophonic English text.  This
;;   would involve writing a filter (probably in a language like Perl)
;;   to parse the Lojban phonemes and output their English phonetic
;;   equivalents.  Preliminary testing has show this approach to be
;;   insufficient, resulting in undesired pause and intonation
;;   patterns.  The conversion of word-final letter "a" to schwa is
;;   particularly problematic for Lojban speech.  This is "the wrong
;;   way" to do this.
;;   
;;   2. Translating Lojban text into one of the various utterance
;;   types.  This would involve parsing Lojban text (again, probably
;;   with a script in a language like Perl) and constructing Words,
;;   Phrases, Segments, or Phones utterances corresponding to the
;;   sounds of the Lojban text.  Using utterances of type Words would
;;   allow specification of features like word intonation.  Using
;;   those of type Phrase would additionally permit specification of
;;   phrase breaks.  Both of these mechanisms, while they may allow
;;   specification of parameters such as ToBI intonations, are still
;;   bound by English pronunciation rules and would require the kind
;;   of phonetic interpertation discussed in the previous option.
;;   Using Segments utterances would allow direct specification of the
;;   phones to use (which would make phonetic translation a tractable
;;   approach), but the Segments utterance type requires that phone
;;   duration be specified.  Calculating phone durations ourselves,
;;   besides being a hastle, would be duplicating functionality
;;   already built-into Festival.  Use of Phones type utterances also
;;   seemed promising, but preliminary testing revealed that Festival
;;   couldn't properly synthesize certian combinations of phones used
;;   in Lojban, and often crashed during waveform synthesis.  Clearly,
;;   this too is "the wrong way" to approach this.
;;
;;   3. Define a new Festival voice, from the ground up, but using a
;;   suitable English phone database.  This would require Scheme code
;;   to define the new voice and map the Lojban phoneset to the
;;   English phones.  Though this may still not solve the phone pairing
;;   problem seen while sythesizing Phones utterance types, this is
;;   the approach which I have elected to take.  This voice is based on
;;   the kal_diphone ("Kevin") voice.  This makes possible several
;;   improvements over the ked version, including better Lojban diphones.
;;   
;;   4. "The right way".  The "right" way to get Festival to speak
;;   Lojban would be to define a new voice and associate it with a new
;;   database of specifically Lojban phones.  According to information
;;   accessible through the site
;;   http://staticfree.info/projects/lojban_festvox, a Lojban phoneset
;;   is supposedly in the works.  I don't know its current status, or
;;   how to get access to it.  As creating a phone database is a
;;   rather involved process (the "Voices" section of the Festival
;;   Manual has some information on this), I have decided not to
;;   proceed in this manner.  Should this phoneset ever be completed,
;;   it would be relatively easy to replace the phoneset in this voice
;;   with a Lojban one.  This is because the other (tokenization,
;;   phrasing, and intonation) parameters of the voice will already
;;   have been defined.  And that would be doing this "the right way".
;;

;; Define a function to save globals settings which we alter.
(defvar saved-vars nil)
(define (save-var var)
  ;; Use a simple a-list.
  (set! saved-vars (cons (list var (eval var)) saved-vars))
  )
;; Do the same for "Parameter" variables, since they're in their own
;; namespace.
(defvar saved-params nil)
(define (save-param var)
  ;; Use a simple a-list.
  (set! saved-params (cons (list var (Parameter.get var)) saved-params))
  )

;;;;
;;;; Feature Break-down and Constant Definitions
;;;; 
;;;; Here, we go over the implementation details of each voice feature
;;;; and define any constants we want defined when the file is loaded.
;;;;

;;
;; Tokenization (Text module?)
;; 
;; The first thing to do when doing Lojban TTS, is to achieve proper
;; tokenization of the Lojban text.  The default tokenization scheme
;; treats punctuation marks as utterance delimeters (which is not the
;; case in Lojban) and removes them (making punctuation implicitly
;; silent, meaning that audible punctuation like ".i" cannot be used).
;; The default tokenizer also assumes that all punctuation strings are
;; one character in length.  Thus, the default tokenization scheme
;; must be bypassed.  There are two basic ways to go about this:
;; 
;;   1. Strip-out all non-Lojban printable letters and collapse
;;   whitespace.  This ensures that the resulting string and sequence
;;   of tokens correctly corresponds to the sounds of the Lojban
;;   utterance.  This approach, however, would not permit the the use
;;   of non-Lojban sounds in Lojban speech--something which is, under
;;   certain circumstances, desirable.
;;   
;;   2. Leave some or all non-Lojban characters in the text, and
;;   assign some of the printable ones to non-Lojban sounds.  This
;;   would permit, for example, use of a non-Lojban vowel sound to
;;   break-up long, difficult-to-pronounce, consonant clusters.  The
;;   remaining non-Lojban characters may then be treated as null
;;   phones, just as whitespace is.  This is the approach used here.
;; 
;; Note: It doesn't matter much whether non-Lojban characters
;; (whitespace included) are treated as token separators.  Because
;; Lojban employs an unambiguous phonology, marking the boundaries
;; between words is redundant.  Thus, it does not matter if the text
;; to be synthesized is parsed as a single token, a series of tokens,
;; or, for that matter, one character per token.  Indeed, the very
;; notion of a typographical "word" in Lojban is an ambiguous one: how
;; many words, for example, would "lenu" (with no spaces) be?  Before
;; any mechanisms in Festival could properly make use of a Lojban word
;; abstraction, these semantics would have to be defined.  And I don't
;; feel like doing that, right now.
;;

;;
;; Utterance Chunking (Text module?)
;; 
;; This is a technique used to break speech into parts for individual
;; synthesis.  In most speech, it is desirable to do this at phrase
;; boundaries, so that utterances which have undergone refinement
;; don't sound out of place.  Utterance chunking of Lojban would
;; properly be done using a decision tree to match against grammatical
;; features such as audible punctuation and terminator cmavo.  Because
;; we defined no punctuation characters (above), the default eou_tree
;; (which checks "punc" features) will not get in our way.  This
;; chunking should, however, be done more properly.
;;

;;
;; Token POS-tagging (Token_POS module)
;; 
;; Token POS tags with a token_pos feature things like numbers with
;; their part of speech and is used for homograph disambiguation.
;; It's probably safe to say that this isn't necessary for Lojban.
;; Token_POS appears to be defined internally to Festival (i.e., in
;; the C++ portion).  Since I don't know how to disable it entirely,
;; we just set token_pos_cart_trees to nil during voice setup.  It
;; doesn't *seem* to break anything.
;; 

;;
;; Translating Tokens to Words (Token module)
;; 
;; Installing a token-to-word translator should only be necessary in
;; the event that we wish to break-up run-together words like "lenu"
;; into their component parts.  As stated above, this is not a current
;; concern, so we simply remove the default t2w translator and replace
;; it with a trivial function. This is done just like installing a new
;; text mode, as described in section 9 TTS of the Festival Manual.
;;

(define (lojban_us_1_token_to_words token name)
  "(token_to_words token name) trivial function, simply returns a list
containing name"
  (list name)
  )

;;
;; Part of Speech Tagging (POS module)
;; 
;; The fact that Lojban has an unambiguous grammar and more or less
;; stable vocabulary means that the precise syntax and approximate
;; semantics of Lojban utterances can be used to determine certain
;; features of the speech to be synthesized. (The technical term for
;; this is feature prediction.) This could be particularly useful for
;; determining prosodic phrasing, duration, and intonation.
;; 
;; However, for now, this feature is omitted and POS tagging disabled.
;;

;;
;; Phrase Breaks (Phrasify module)
;; 
;; In Lojban, phrase identification and POS tagging are pretty much
;; one and the same a process.  So, we define a null Phrasify_Method.
;; 

(define (Null_Phrasify utt)
  utt
  )

;; um, but it may not work to do that. so we create a trivial
;; phrasificiation CART tree...

(defvar nb_phrase_cart_tree
  '((R:Token.parent.punc in ("?" "." ":"))
    ((NB))
    ((NB))
    )
  )

;;
;; Syllable/Segment Construction (Word module)
;; 
;; I don't have much of an idea what this module does, so I'll just
;; define and install an identity function (yet again), and cross my
;; fingers (yet again).
;; 

(define (Null_Word utt)
  utt
  )
;; &&& maybe this should call syllabify and post-process the results...

;;
;; Pause Insertion (Pauses module)
;; 
;; This is one place where tagging of Lojban grammar (currently not
;; implemented) could be used.  For now, we just leave the
;; 'Classic_Pauses Pauses_Method set by voice_reset and hope it
;; functions acceptably.
;;

;;
;; Syllabic Intonation (Intonation module)
;; 
;; This is where we assign intonation to individual parts of an
;; utterance.
;;
;; There are a few ways to go about this:
;; 
;;        1. Stress any syllable which contains one or more capital
;;        letters.  This means that something like kLamA ends up with
;;        both syllables stressed.  In the absence of capitalization,
;;        stress the penultimate syllable.  In one-syllable words,
;;        use no stress. (Does this produce correct Lojban stress?)
;;        
;;        2. Associate capitalized normal vowels with
;;        lex.syllabify.phstress type numbered vowels in the phoneset.
;;        All other letters (including "y") would have to be
;;        lowercased.  This would stress the indicated syllables and
;;        prevent "y" from being emphasized.  How, though, would any
;;        applicable penultimate stress be applied?
;; 
;; This assigns intonation features (accents and boundary tones) to
;; segments.  There are several choices.
;; 
;; The Int_Method Intonation_Default, according to the Festival
;; Manual, preforms no intonation.  My experimentation with Festival
;; suggests that this is true.  According to the comments in
;; intonation.scm, however, this method is supposed to apply a simple
;; falling intonation.  I suspect the latter claim to be technically
;; incorrect.  For some reason, those who coded Festival decided to
;; abbreviate "default" as "duff".  When the intonation module
;; receives an Int_Method which it doesn't recognize or which returns
;; nil when called, it calls the Intonation_Default method.  Thus, the
;; symbol 'DuffInt is conventionally used to select the
;; Intonation_Default Int_Method.  Because Lojban speech may require
;; stress, this method isn't used.
;; 
;; Int_Method 'Simple uses the CART tree in int_accent_cart_tree to
;; assign IntEvents to syllables for which the CART tree does not
;; return the symbol 'NONE.  This seems to be the simplest and easiest
;; choice for creating a rudementary Lojban voice.
;; 
;; Int_Method 'ToBI selects a method which uses a tree to predict ToBI
;; accents.  Since we're not using ToBI, we don't use this method.
;; FYI, ToBI appears to make use of the int_tone_cart_tree variable.
;; 
;; Int_Method 'General behaves identically to Int_Method 'Simple.
;; 
;; The Festival Manual refers to a Tilt intonation, but neither it nor
;; the code says anything else about it.
;;

;; if the simple_accent_cart_tree defined in intonation.scm proves
;; insufficient, we'll have to define our own CART tree here... &&&

;;
;; Phoneset
;; 
;; A phoneset is required to be defined before many other voice
;; features, so we do that now.  This phoneset is essentially a copy
;; of that of the kal_diphone voice.
;;

(defPhoneSet
  lojban_us_1				; phoneset name
  
  ;;  Phone features
  ((vc + -)				; vowel or consonant
   ;; vowel length: short long diphthong schwa
   (vlng s l d a 0)
   (vheight 1 2 3 0)			; vowel height: high mid low
   (vfront 1 2 3 0)			; vowel frontness: front mid back
   (vrnd + - 0)				; lip rounding
   ;; consonant type: stop fricative affricative nasal liquid (r?)
   (ctype s f a n l r 0)
   ;; place of articulation: labial alveolar palatal labio-dental dental velar
   ;; (glottal?)
   (cplace l a p b d v g 0)
   (cvox + - 0))			; consonant voicing
  
  ;; Phone set members
  ((aa + l 3 3 - 0 0 0)
   (ae + s 3 1 - 0 0 0)
   (ah + s 2 2 - 0 0 0)
   (ao + l 3 3 + 0 0 0)
   (aw + d 3 2 - 0 0 0)
   (ax + a 2 2 - 0 0 0)
   (axr + a 2 2 - r a +)
   (ay + d 3 2 - 0 0 0)
   (b - 0 0 0 0 s l +)
   (ch - 0 0 0 0 a p -)
   (d - 0 0 0 0 s a +)
   (dh - 0 0 0 0 f d +)
   (dx - a 0 0 0 s a +)
   (eh + s 2 1 - 0 0 0)
   (el + s 0 0 0 l a +)
   (em + s 0 0 0 n l +)
   (en + s 0 0 0 n a +)
   (er + a 2 2 - r 0 0)
   (ey + d 2 1 - 0 0 0)
   (f - 0 0 0 0 f b -)
   (g - 0 0 0 0 s v +)
   (hh - 0 0 0 0 f g -)
   (hv - 0 0 0 0 f g +)
   (ih + s 1 1 - 0 0 0)
   (iy + l 1 1 - 0 0 0)
   (jh - 0 0 0 0 a p +)
   (k - 0 0 0 0 s v -)
   (l - 0 0 0 0 l a +)
   (m - 0 0 0 0 n l +)
   (n - 0 0 0 0 n a +)
   (nx - 0 0 0 0 n d +)
   (ng - 0 0 0 0 n v +)
   (ow + d 2 3 + 0 0 0)
   (oy + d 2 3 + 0 0 0)
   (p - 0 0 0 0 s l -)
   (r - 0 0 0 0 r a +)
   (s - 0 0 0 0 f a -)
   (sh - 0 0 0 0 f p -)
   (t - 0 0 0 0 s a -)
   (th - 0 0 0 0 f d -)
   (uh + s 1 3 + 0 0 0)
   (uw + l 1 3 + 0 0 0)
   (v - 0 0 0 0 f b +)
   (w - 0 0 0 0 r l +)
   (y - 0 0 0 0 r p +)
   (z - 0 0 0 0 f a +)
   (zh - 0 0 0 0 f p +)
   (pau - 0 0 0 0 0 0 -)
   (h# - 0 0 0 0 0 0 -)
   (brth - 0 0 0 0 0 0 -))
  ;; It would be great if we had a phone in here for the Lojban "x",
  ;; but we don't....
  )
(PhoneSet.silences '(pau h# brth))

;;
;; Letter-to-Sound Rules
;;

;; Note: The non-Lojban letters (h,w,q) have been mapped to phones in
;; this ruleset.  The "h" functions identically to "'".  The "q" maps
;; to the short English "i" for use in breaking-up difficult consonant
;; clusters.  The "w" in the sequence "wq" maps to its normal English
;; sound, so that a non-Lojban consonant sound is available.

(lts.ruleset
 lojban_us_1				;  Name of rule set
 
 ;; Sets used in the rules
 (
  (AEIOU a e i o u )			; we don't really use these, but...
  (AEIOUY a e i o u y)			; we don't really use these, but...
  )
 
 ;; Rules
 (
  
  ;; Vowels
  
  ;; Rising diphthongs
  ( [ a i ] = ay  )
  ( [ a "," i ] = aa iy )
  ( [ A I ] = ay1 )
  ( [ A "," I ] = aa1 iy1 )
  ( [ a u ] = aw  )
  ( [ a "," u ] = aa uw )
  ( [ A U ] = aw1 )
  ( [ A "," U ] = aa1 uw1)
  ( [ e i ] = ey  )
  ( [ e "," i ] = eh iy )
  ( [ E I ] = ey1 )
  ( [ E "," I ] = eh1 iy1)
  ( [ o i ] = oy  )
  ( [ o "," i ] = ow iy )
  ( [ O I ] = oy1 )
  ( [ O "," I ] = ow1 iy1)
  ;; Falling diphthongs
  ( [ i a ] = y aa  )
  ( [ i "," a ] = iy aa )
  ( [ I A ] = y aa1 )
  ( [ I "," A ] = iy1 aa1)
  ( [ i e ] = y eh  )
  ( [ i "," e ] = iy eh )
  ( [ I E ] = y eh1 )
  ( [ I "," E ] = iy1 eh1 )
  ( [ i i ] = y iy  ) ; I think...
  ( [ i "," i ] = iy iy )
  ( [ I I ] = y iy1 )
  ( [ I "," I ] = iy1 iy1 )
  ( [ i o ] = y ow  ) ; I think...
  ( [ i "," o ] = iy ow )
  ( [ I O ] = y ow1 )
  ( [ I "," O ] = iy1 ow1 )
  ( [ i u ] = y uw )
  ( [ i "," u ] = iy uw )
  ( [ I U ] = y uw1 )
  ( [ I "," U ] = iy1 uw1 )
  ( [ u a ] = w aa  )
  ( [ u "," a ] = uw aa )
  ( [ U A ] = w aa1 )
  ( [ U "," A ] = uw1 aa1 )
  ( [ u e ] = w eh  )
  ( [ u "," e ] = uw eh )
  ( [ U E ] = w eh1 )
  ( [ U "," E ] = uw1 eh1 )
  ( [ u i ] = w iy  )
  ( [ u "," i ] = uw iy )
  ( [ U I ] = w iy1 )
  ( [ U "," I ] = uw1 iy1 )
  ( [ u o ] = w ow  )
  ( [ u "," o ] = uw ow )
  ( [ U O ] = w ow1 )
  ( [ U "," O ] = uw1 ow1 )
  ( [ u u ] = w uw  ) ; I think...
  ( [ u "," u ] = uw uw )
  ( [ U U ] = w uw1 )
  ( [ U "," U ] = uw1 uw1 )
  ;; Normal vowels
  ( [ a ] = aa  )
  ( [ A ] = aa1 )
  ( [ e ] = eh  )
  ( [ E ] = eh1 )
  ( [ i ] = iy  )
  ( [ I ] = iy1 )
  ( [ o ] = ow  )
  ( [ O ] = ow1 )
  ( [ u ] = uw  )
  ( [ U ] = uw1 )
  ;; Special vowel
  ( [ y ] = uh  ) ; I think...
  ( [ Y ] = uh1 ) ; I don't think the schwa ever really gets stressed, but...
  
  ;; Consonants
  
  ;; Two affricatives
  ( [ t c ] = ch )
  ( [ T C ] = ch )
  ( [ d j ] = jh )
  ( [ D J ] = jh )
  ;; Two fricatives
  ( [ c ] = sh )
  ( [ C ] = sh )
  ( [ j ] = zh )
  ( [ J ] = zh )
  ;; Unvoiced consonants
  ( [ p ] = p )				; stop
  ( [ P ] = p )
  ( [ f ] = f )				; fricative
  ( [ F ] = f )
  ( [ t ] = t )				; stop
  ( [ T ] = t )
  ( [ s ] = s )				; fricative
  ( [ S ] = s )
  ( [ k ] = k )				; stop
  ( [ K ] = k )
  ;; Voiced consonants
  ( [ b ] = b )				; stop
  ( [ B ] = b )
  ( [ v ] = v )				; fricative
  ( [ V ] = v )
  ( [ d ] = d )				; stop
  ( [ D ] = d )
  ( [ z ] = z )				; fricative
  ( [ Z ] = z )
  ( [ g ] = g )				; stop
  ( [ G ] = g )
  ;; Syllabic/Non-syllabic consonants
  ( [ l ] = l )
  ( [ L ] = l )
  ( [ m ] = m )
  ( [ M ] = m )
  ( [ n ] = n )
  ( [ N ] = n )
  ( [ r ] = r )
  ( [ R ] = r )
  ;; Problem consonant: x
  ;; "x" is an unvoiced fricative version of unvoiced stop "k"
  ;; We might want to use the English phones k, hh, k h, or so.
  ( [ x ] = k ) ; &&& sorry, this is quite bad...
  ( [ X ] = k )
  
  ;; Apostrophe, Period, and Comma between consonants
  ( [ "'" ] = hh )
  ( [ "." ] = pau )
  ( [ "," ] = )
  
  ;; Non-Lojban sounds
  ( [ q ] = ih )
  ( [ Q ] = ih1 )
  ( [ w q ] = w ih )
  ( [ W Q ] = w ih1 )
  ;; Note: It is not enough to just specify "w" here, since a "w"
  ;; occuring immediately prior to a Lojban vowel could be mistaken
  ;; for a u-initial diphthong.
  )
 )
;; &&& we may need to put ALL non-Lojban characters in here...!
;; &&& we could append numbers to these vowels, if phstress is called...

(define (lojban_us_1_lts word features)
  ;; This is to define R:SylStructure.parent.R:Token.parent.EMPH. But
  ;; this probably isn't the proper place to generate stresses.... dunno.
  ;; This approach also fails to break syllables at commas. &&&
  "(lojban_us_1_lts WORD FEATURES)
Using letter to sound rules build a Lojban pronunciation of WORD."
  (let ((syllform (lex.syllabify.phstress (lts.apply word 'lojban_us_1)))
	(stresscount 0)
	(stress 1)
	)
    ;; count the stress volume of explicitly stressed syllables
    (mapcar (lambda (syl)
	      (set! stresscount (+ stresscount (cadr syl))))
	    syllform)
    ;; if no stress was marked, stress the penultimate syllable
    (and (eq? stresscount 0)
	 ;; find the penultimate syllable
	 (let ((non-schwa-sylls 0)
	       (revunstressed (reverse (copy-list syllform)))
	       (revstressed nil)
	       )
	   (set! revstressed
		 (mapcar (lambda (syl)
			   (or (member 'uh (car syl))
			       (set! non-schwa-sylls (+ non-schwa-sylls 1))
			       )
			   ;; if we found the penult syll, stress it
			   (or (and (eq? non-schwa-sylls 2)
				    (list (car syl) stress))
			       syl)
			   ) ; lambda
			 revunstressed)
		 )
	   ;; replace the lex with the (possibly) penult stressed result
	   (set! syllform (reverse (copy-list revstressed)))
	   )
	 )
    (list word
	  nil
	  syllform)
    )
  ;; that should do it!
  )

;;
;; Build a lexicon for Lojban.  We just include letter-to-sound rules.
;; 
;; The lexicon is used to look-up word pronunciation.  Because Lojban
;; is a phonetic language, no lexicon will generally be needed. (This
;; can save a good deal of disk space and effort!)  If any exceptions
;; to this general rule are found, additions can always be made to the
;; lexicon addenda, as described below.
;;

(lex.create "lojban_us_1")
(lex.set.phoneset "lojban_us_1")
(lex.set.lts.ruleset 'lojban_us_1) ; the ruleset or function to use
(lex.set.lts.method 'lojban_us_1_lts)
;;(lex.set.lts.method 'lts_rules)

;; If, for some reason, you need to add Lojban pronunciations,
;; they can be added to the lexicon addenda like this.
;;(lex.add.entry '( "cdgrspageti" n ((( s d ) 0) (( j r ) 0)
;; (( s p ah ) 0) (( g eh ) 1) (( t ee ) 0))))

;;
;; Post-Lexical Processing (PostLex module)
;; 
;; We probably don't want any post-lexical processing (as is done for
;; English) to be done for Lojban.
;; 
;; The apply_methods function in festival.scm, called by PostLex on
;; the PostLex_Method, considers nil methods to be in error.  So,
;; we'll just define an identity method to be installed.
;;

(define (Null_PostLex utt)
  utt
  )

;;
;; Durations (Duration module)
;; 
;; I don't have much of an idea how durations should be assigned for
;; Lojban.  But there are some choices.
;; 
;; The Duration_Method 'Default makes each 0.1 seconds in duration.
;; This is likely unsuitable for Lojban. (Though trying it out might
;; be fun!)
;; 
;; The Duration_Method 'Averages uses average phoneme durations stored
;; in the a-list phoneme_durations.  We copy ours from the middle
;; column of the kal_durs a-list set in kaldurtreeZ.scm.
;; 
;; The Duration_Method 'Tree uses the CART tree in duration_cart_tree
;; to determine durations for each segment.
;; 
;; The Duration_Method 'Tree_ZScores uses the 'Tree CART tree to
;; decide zscores.  The means and standard deviations stored in the
;; a-list in the variable duration_ph_info are applied to determine
;; segment duration.
;; 
;; The Duration_Method 'Klatt is roughly a specialized case of
;; 'Tree_ZScores which, among other things, uses the variable
;; duration_klatt_params instead of duration_ph_info.  Other
;; Klatt-like duration methods can also be implemented using
;; 'Tree_ZScores.
;; 
;; We could stick with the 'Averages Duration_Method for now.  I
;; have, however, imported the spanish_dur_tree from the "Voices"
;; chapter of the Festival Manual because using it sounds better.
;; Token duration is also multiplied by the product of the token
;; feature dur_stretch and parameter 'Duration_Stretch.
;;

(defvar
 lojban_us_1_durs
 '(
   (uh 0.067)
   (hh 0.061)
   (ao 0.138)
   (hv 0.053)
   (v  0.051)
   (ih 0.058)
   (el 0.111)
   (ey 0.132)
   (em 0.080)
   (jh 0.094)
   (w  0.054)
   (uw 0.107)
   (ae 0.120)
   (en 0.117)
   (k  0.089)
   (y  0.048)
   (axr 0.147)
   (l  0.066)
   (ng 0.064)
   (zh 0.071)
   (z  0.079)
   (brth 0.246)
   (m  0.069)
   (iy 0.097)
   (n  0.059)
   (ah 0.087)
   (er 0.086)
   (b  0.069)
   (pau 0.200)
   (aw 0.166)
   (p  0.088)
   (ch 0.115)
   (ow 0.134)
   (dh 0.031)
   (nx 0.049)
   (d  0.048)
   (ax 0.046)
   (h# 0.060)
   (r  0.053)
   (eh 0.095)
   (ay 0.137)
   (oy 0.183)
   (f  0.095)
   (sh 0.108)
   (s  0.102)
   (g  0.064)
   (dx 0.031)
   (th 0.093)
   (aa 0.094)
   (t  0.070)
   )
 )

(set! spanish_dur_tree
 '
   ((R:SylStructure.parent.R:Syllable.p.syl_break > 1 ) ;; clause initial
    ((R:SylStructure.parent.stress is 1)
     ((1.5))
     ((1.2)))
    ((R:SylStructure.parent.syl_break > 1)   ;; clause final
     ((R:SylStructure.parent.stress is 1)
      ((2.0))
      ((1.5)))
     ((R:SylStructure.parent.stress is 1)
      ((1.2))
      ((1.0))))))

(set! lojban_sigma_data
      ;; just generate the data from the lojban_us_1_durs list above
      (mapcar (lambda(entry)
		(list (car entry) 0.0 (cadr entry))
		)
	      lojban_us_1_durs)
      )

;;
;; Intonation Targets (Int_Targets module)
;; 
;; When Int_Targets receives an Int_Target_Method which returns nil
;; when called, it chooses the intonation target function
;; corresponding to the current Int_Method.
;; 
;; If no such Int_Method is recognized, Int_Targets calls the
;; Int_Targets_Default method which, according to documentation, is
;; supposed to create a bounded time-linear intonation.  The
;; parameters for this intonation method are in the a-list stored in
;; the variable duffint_params (see above for an explanation of the
;; unusual name).  In theory, this could be used to apply rising,
;; falling, or monotone intonation.  But I have only been able to
;; achieve monotone intonation using this method.  Use of
;; 'Int_Targets_Default and duffint_params may be suitable for flat,
;; boring Lojban speech.
;; 
;; The 'Int_Targets_Simple Int_Target_Method uses parameters in the
;; a-list stored in the int_simple_params variable to construct an
;; intonation pattern, described in the Festival Manual, consisting of
;; a linear intonation with a falling final syllable and superimposed
;; syllabic stresses.  This method is not likely unsuitable for our
;; voice.
;; 
;; The 'Tree Int_Targets_Method uses a Linear Regression (LR) model
;; to determine syllable tone---whatever that means.
;; 
;; The 'General Int_Targets_Method calls a function, stored in the
;; a-list stored in the variable int_general_params, which returns a
;; list of target points for a syllable.  (set! int_general_params
;; (list (list 'targ_func desired_func))) This method could be used if
;; intonational stress of Lojban grammar is desired.  Sensitivity to
;; Lojban grammar, however, has not yet been implemented.
;; 
;; There also appears to be an undocumented Int_Targets_LR
;; Int_Target_Method which uses linear regression and variables with
;; "lr" in their names.
;; 
;; For now, we'll stick with the 'Simple Int_Target
;;

(set! lojban_us_1_int_simple_params '((f0_mean 90) (f0_std 30)))

;;
;; Waveform Synthesizer (Wave_Synth module)
;; 
;; Since the diphone database which we are using, kal_diphone, is a
;; UniSyn LPC database, we use identical synthesizer settings to those
;; used for kal_diphone.
;;

(require_module 'UniSyn)

;;;;
;;;; Set up the Voice
;;;; 
;;;; Now, we go through each of the above features, and activate our
;;;; choices.
;;;;

(define (voice_kal_diphone_jbo_us1)
  "(voice_kal_diphone_jbo_us1) Set the current voice to be a male
American English, Kevin, -approximated Lojban voice using the standard
diphone code."
  
  (voice_reset)				; insert, commented, what's reset
  ;; &&&
  
  ;; Set up Phoneset
  (Parameter.set 'PhoneSet 'lojban_us_1)
  (PhoneSet.select 'lojban_us_1)
  
  ;; Set up Tokenization
  (save-var 'token.punctuation)
  (set! token.punctuation "")
  (save-var 'token.prepunctuation)
  (set! token.prepunctuation "")
  ;; we leave token.whitespace alone
  
  ;; Set up Utterance Chunking
  ;; this should be able to get by without change...
  ;; (save-var eou_tree)
  ;; (defvar eou_tree '(some better tree))
  
  ;; Set up Token POS-tagging
  (save-var 'token_pos_cart_trees)
  (set! token_pos_cart_trees nil)
  
  ;; Set up Translating Tokens to Words
  (save-var 'token_to_words)
  (set! token_to_words lojban_us_1_token_to_words)
  ;; Setting an undefined Token_Method will cause Token_Any to be used.
  (Parameter.set 'Token_Method 'Plain_Token_Method) ; in voice_reset
  
  ;; Set up Part of Speech Tagging
  (save-var 'pos_lex_name)
  (set! pos_lex_name nil) ; this disables POS tagging
  
  ;; Set up Phrase Breaks
  ;; (Parameter.set 'Phrasify_Method Null_Phrasify)
  ;;(save-var phrase_cart_tree)
  (set! phrase_cart_tree nb_phrase_cart_tree)
  (Parameter.set 'Phrasify_Method 'cart_tree) ; in voice_reset
  (Parameter.set 'Phrase_Method nil) ; ?? &&&
  ;; (set! phr_break_params nil) ; unnecessary for 'cart_tree Phrasify_Method
  
  ;; Syllable/Segment Construction
  ;;&&&(Parameter.set 'Word_Method Null_Word) ; in voice_reset
  
  ;; Set up Pause Insertion
  ;; nothing to do
  
  ;; Set up Syllabic Intonation
  (save-var 'int_accent_cart_tree)
  (set! int_accent_cart_tree simple_accent_cart_tree)
  (save-param 'Int_Method)
  (Parameter.set 'Int_Method 'Simple)
  
  ;; Set up Post-Lexical Processing
  (set! postlex_rules_hooks nil)
  (Parameter.set 'PostLex_Method Null_PostLex)
  
  ;; Set up Durations
  ;;;;(save-var 'phoneme_durations)
  ;;(set! phoneme_durations lojban_us_1_durs)
  ;;(save-param 'Duration_Method)
  ;;(Parameter.set 'Duration_Method 'Averages)
  (set! duration_cart_tree spanish_dur_tree)
  (set! duration_ph_info lojban_sigma_data)
  (Parameter.set 'Duration_Method 'Tree_ZScores)
  
  ;; Set up Intonation Targets
  ;; (save-var duffint_params)
  ;; (set! duffint_params '((start 150) (end 150))) ; F0 boundary conditions
  ;; (save-param 'Int_Target_Method)
  ;; (Parameter.set 'Int_Target_Method Int_Targets_Default) ; time-linear tone
  ;;(save-var int_simple_params)
  (set! int_simple_params lojban_us_1_int_simple_params)
  (save-param 'Int_Target_Method)
  (Parameter.set 'Int_Target_Method Int_Targets_Simple)
  
  ;; Set up Waveform Synthesizer
  ;; These were pretty much copied from the Festival Manual and
  ;; voices.scm.  I'm really not sure what they're up to.
  
  (cond
   ((or kal_di_16k kal_di_8k)
    (Parameter.set 'Synth_Method Diphone_Synthesize)
    (Diphone.select 'kal))
   (t
    (set! UniSyn_module_hooks nil) ; (list kal_diphone_const_clusters)
    (set! us_abs_offset 0.0)
    (set! window_factor 1.0)
    (set! us_rel_offset 0.0)
    (set! us_gain 0.9)
    (Parameter.set 'Synth_Method 'UniSyn)
    (Parameter.set 'us_sigpr 'lpc)
    (or kal_lpc_group
	(set! kal_lpc_group
	      (list
	       '(name "kal_lpc_group")
	       (list 'index_file 
	       ;; voice-path defaults to (path-append load-path "voices/")
		     (path-append
		      voice-path
		      "english/kal_diphone/group/kallpc16k.group")
		     )
	       '(grouped "true")
	       '(default_diphone "#-#"))
	      )
	(set! kal_db_name (us_diphone_init kal_lpc_group))
	)
    (us_db_select kal_db_name)

    ;; this is copied from kal_diphone.scm, because otherwise the
    ;; sound comes out at low volume
    (set! after_synth_hooks 
	  (lambda (utt) 
	    (utt.wave.rescale utt 2.6)))
    )
   )
  
  ;; Set up Lexicon
  (lex.select "lojban_us_1")
  
  (set! current_voice_reset jbo_us1_voice_reset)
  (set! current-voice 'kal_diphone_jbo_us1)
  )

;; The function current_voice_reset will be called by voice_reset, if
;; non-nil. voice_reset sets current_voice_reset to nil, after calling
;; it.

(define (jbo_us1_voice_reset)
  ;; &&& define this
  ;; go through saved-vars and saved-params and restore saved values
  )

(proclaim_voice
 'kal_diphone_jbo_us1
 '((language lojban)
   (gender male)
   (dialect american)
   (description
    "This voice provides an American Lojban male voice using the
American English male voice which uses a residual excited LPC diphone
synthesis method.  Intonation is determined by simple penultimate
stress and capitalization on top of a simple bilinear F0 contour."
    )
   )
 )

'kal_diphone-license "
;;;                    Alan W Black and Kevin Lenzo                       ;;
;;;                         Copyright (c) 1998                            ;;
;;;                        All Rights Reserved.                           ;;
;;;                                                                       ;;
;;;  Permission is hereby granted, free of charge, to use and distribute  ;;
;;;  this software and its documentation without restriction, including   ;;
;;;  without limitation the rights to use, copy, modify, merge, publish,  ;;
;;;  distribute, sublicense, and/or sell copies of this work, and to      ;;
;;;  permit persons to whom this work is furnished to do so, subject to   ;;
;;;  the following conditions:                                            ;;
;;;   1. The code must retain the above copyright notice, this list of    ;;
;;;      conditions and the following disclaimer.                         ;;
;;;   2. Any modifications must be clearly marked as such.                ;;
;;;   3. Original authors' names are not deleted.                         ;;
;;;   4. The authors' names are not used to endorse or promote products   ;;
;;;      derived from this software without specific prior written        ;;
;;;      permission.                                                      ;;
;;;                                                                       ;;
;;;  THE AUTHORS OF THIS WORK DISCLAIM ALL WARRANTIES WITH REGARD TO      ;;
;;;  THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY   ;;
;;;  AND FITNESS, IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY         ;;
;;;  SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES            ;;
;;;  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ;;
;;;  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ;;
;;;  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ;;
;;;  THIS SOFTWARE.                                                       ;;
"

(provide 'kal_diphone_jbo_us1)

;; end

