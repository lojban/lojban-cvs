ESTDIR=/usr

make_pm_wav=festvox/make_pm_wave

all: ljb_diphone.index pm

pm: wav/*.wav
	mkdir -p pm;
	$(make_pm_wav) wav/*.wav;
	touch pm;

ljb_diphone.index: ../praat/praat.Collection ljb_diphone_hand_timed.index ../util/TextGrid2index.pl
	../util/TextGrid2index.pl -l ljb_diphone_hand_timed.index \
	../praat/praat.Collection > ljb_diphone.index
clean:
	rm -rf pm;
	rm -rf tmp*.wav;
