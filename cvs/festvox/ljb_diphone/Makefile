make_pm_wav=festvox/make_pm_wave

wav_files=$(wildcard wav/*.wav)

pm_files=$(shell echo $(wav_files)|sed 's/wav/pm/g')

all: ljb_diphone.index $(pm_files)

$(pm_files): pm pm/%.pm: wav/%.wav
	$(make_pm_wav) $<;

pm: 
	mkdir pm

ljb_diphone.index: ../praat/*.Collection ljb_diphone_template.index ../util/TextGrid2index.pl
	../util/TextGrid2index.pl -l ljb_diphone_template.index \
	../praat/*.Collection > ljb_diphone.index
clean:
	rm -rf pm;
	rm -rf tmp*.wav;
