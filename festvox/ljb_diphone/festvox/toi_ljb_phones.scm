;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                     ;;;
;;;                     Carnegie Mellon University                      ;;;
;;;                  and Alan W Black and Kevin Lenzo                   ;;;
;;;                      Copyright (c) 1998-2000                        ;;;
;;;                        All Rights Reserved.                         ;;;
;;;                                                                     ;;;
;;; Permission is hereby granted, free of charge, to use and distribute ;;;
;;; this software and its documentation without restriction, including  ;;;
;;; without limitation the rights to use, copy, modify, merge, publish, ;;;
;;; distribute, sublicense, and/or sell copies of this work, and to     ;;;
;;; permit persons to whom this work is furnished to do so, subject to  ;;;
;;; the following conditions:                                           ;;;
;;;  1. The code must retain the above copyright notice, this list of   ;;;
;;;     conditions and the following disclaimer.                        ;;;
;;;  2. Any modifications must be clearly marked as such.               ;;;
;;;  3. Original authors' names are not deleted.                        ;;;
;;;  4. The authors' names are not used to endorse or promote products  ;;;
;;;     derived from this software without specific prior written       ;;;
;;;     permission.                                                     ;;;
;;;                                                                     ;;;
;;; CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK        ;;;
;;; DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING     ;;;
;;; ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT  ;;;
;;; SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE     ;;;
;;; FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES   ;;;
;;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN  ;;;
;;; AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,         ;;;
;;; ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF      ;;;
;;; THIS SOFTWARE.                                                      ;;;
;;;                                                                     ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Phoneset definition 
;;;

(defPhoneSet
  toi_ljb
  ;;;  Phone Features
  (;; vowel or consonant
   (vc + -)  

   ;; vowel length: short long dipthong schwa
   (vlng s l d a 0)

   ;; vowel height: high mid low
   (vheight 1 2 3 0)

   ;; vowel frontness: front mid back
   (vfront 1 2 3 0)

   ;; lip rounding
   (vrnd + - 0)

   ;; consonant type: stop fricative affricative nasal liquid
   (ctype s f a n l 0)
   ;; place of articulation: labial alveolar palatal labio-dental
   ;;                         dental velar
   (cplace l a p b d v g 0)
   ;; consonant voicing
   (cvox + - 0)
   )
  (
   ;(uh  +   s   2   3   -   0   0   0)
   (y   +   a   2   2   -   0   0   0)

   (e   +   l   2   1   -   0   0   0)
   (a   +   l   3   1   -   0   0   0)
   (o   +   l   2   3   +   0   0   0)
   (i   +   l   1   1   -   0   0   0)
   (u   +   l   1   3   +   0   0   0)

   (ai  +   d   3   1   -   0   0   0)
   (ei  +   d   2   1   -   0   0   0)
   (oi  +   d   2   3   +   0   0   0)
   (au  +   d   3   2   +   0   0   0)

   (ie  +   d   2   1   -   0   0   0)
   (ia  +   d   3   1   -   0   0   0)
   (io  +   d   2   3   +   0   0   0)
   (ii  +   d   1   1   -   0   0   0)
   (iu  +   d   1   3   +   0   0   0)

   (ue  +   d   2   1   -   0   0   0)
   (ua  +   d   3   1   -   0   0   0)
   (uo  +   d   2   3   +   0   0   0)
   (ui  +   d   1   1   -   0   0   0)
   (uu  +   d   1   3   +   0   0   0)

   (iy  +   d   2   1   -   0   0   0)
   (uy  +   d   2   3   +   0   0   0)

   (p   -   0   0   0   0   s   l   -)
   (t   -   0   0   0   0   s   a   -)
   (k   -   0   0   0   0   s   v   -)
   (b   -   0   0   0   0   s   l   +)
   (d   -   0   0   0   0   s   a   +)
   (g   -   0   0   0   0   s   v   +)

   (s   -   0   0   0   0   f   a   -)
   (z   -   0   0   0   0   f   a   +)
   (c   -   0   0   0   0   f   p   -)
   (j   -   0   0   0   0   f   p   +)
   (f   -   0   0   0   0   f   b   -)
   (v   -   0   0   0   0   f   b   +)

;   (tc  -   0   0   0   0   a   p   -)
;   (dj  -   0   0   0   0   a   p   +)

   (h   -   0   0   0   0   f   g   -)
   (x   -   0   0   0   0   f   g   -)
   (m   -   0   0   0   0   n   l   +)
   (n   -   0   0   0   0   n   a   +)
   (l   -   0   0   0   0   l   a   +)
;   (y   -   0   0   0   0   l   p   +)
   (r   -   0   0   0   0   l   a   +)
;   (w   -   0   0   0   0   l   l   +)

   (#   -   0   0   0   0   0   0   -) ; Silence. Also referenced below....
;   (##  +   a   0   0   0   0   0   -) ; Glottal stop.

  )
)
(PhoneSet.silences '(#))

(provide 'toi_ljb_phones)
