ESTDIR=/usr

make_pm_wav=festvox/make_pm_wave

all: pm

pm: wav/*.wav
	mkdir pm;
	$(make_pm_wav) wav/*.wav;

clean:
	rm -rf pm;
	rm -rf tmp*.wav;
