.PHONY: all clean ljb_diphone showdiff
all: ljb_diphone

ljb_diphone:
	$(MAKE) -C ljb_diphone/

showdiff:
	./util/TextGrid2index.pl -l ljb_diphone/ljb_diphone_template.index -d praat/*.Collection

clean: 
	$(MAKE) -C ljb_diphone/ clean
