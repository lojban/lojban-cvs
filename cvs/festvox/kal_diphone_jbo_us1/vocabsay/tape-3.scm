;;(save_waves_during_tts)
(load "jbo-vocab.scm")
(make-tape "vocab-words.scm" (lambda(R) (not (boogie-term? R))) "3")
;;(save_waves_during_tts_STOP)
