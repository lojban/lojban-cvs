DSSSLLOC=/sw/lib/sgml/DSSSL/DocBook
DOCBOOKTOOLS=../docbooktools
SOURCE=attit.doc.xml bradi.doc.xml brochure.doc.xml ckape.doc.xml diagsumm.doc.xml intro.doc.xml lingissues.doc.xml lorxu.doc.xml overview.doc.xml tech.doc.xml xtomathy.doc.xml xtomathyinfo.doc.xml
all: rtf paperback tex html unicode-html macpaperback macrtf

clean: lojbanLevel0.index.doc.xml
	openjade -E 0 -t rtf -o print/lojban.tmp.rtf -d $(DSSSLLOC)/print/my_clean.print.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.silenc.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < print/lojban.tmp.rtf > print/lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < print/lojban.tmp1.rtf > print/lojbanLevel0.paperback.clean.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"

paperback: lojbanLevel0.index.doc.xml
	openjade -E 0 -t rtf -o print/lojban.tmp.rtf -d $(DSSSLLOC)/print/my_docbook.paperback.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.silenc.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < print/lojban.tmp.rtf > print/lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < print/lojban.tmp1.rtf > print/lojbanLevel0.paperback.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"

macpaperback: lojbanLevel0.index.doc.xml
	openjade -E 0 -t rtf -o print/lojban.tmp.rtf -d $(DSSSLLOC)/print/my_docbook.paperback.mac.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.silenc.mac.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < print/lojban.tmp.rtf > print/lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < print/lojban.tmp1.rtf > print/lojban.tmp2.rtf
	perl $(DOCBOOKTOOLS)/rtf2mac.pl < print/lojban.tmp2.rtf > print/lojbanLevel0.paperback.mac.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"

rtf: lojbanLevel0.index.doc.xml
	openjade -E 0 -o print/lojban.tmp.rtf -t rtf -d $(DSSSLLOC)/print/my_docbook.print.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < print/lojban.tmp.rtf > print/lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < print/lojban.tmp1.rtf > print/lojbanLevel0.doc.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"

macrtf: lojbanLevel0.index.doc.xml
	openjade -E 0 -o print/lojban.tmp.rtf -t rtf -d $(DSSSLLOC)/print/my_docbook.print.mac.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.silenc.mac.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < print/lojban.tmp.rtf > print/lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < print/lojban.tmp1.rtf > print/lojban.tmp2.rtf
	perl $(DOCBOOKTOOLS)/rtf2mac.pl < print/lojban.tmp2.rtf > print/lojbanLevel0.doc.mac.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"



tex: lojbanLevel0.index.doc.xml
	openjade -E 0 -t tex -o print/lojban.doc.tex -d $(DSSSLLOC)/print/my_docbook.print.tex.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.doc.xml

html: lojbanLevel0.index.doc.xml 
	openjade -E 0 -t sgml -d $(DSSSLLOC)/html/my_docbook.html.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.html.doc.xml
	mv *.html html/

unicode-html: lojbanLevel0.index.doc.xml 
	openjade -b utf-8 -E 0 -t sgml -d $(DSSSLLOC)/html/my_docbook.html.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.htmluni.doc.xml
	mv *.html html-unicode/

lojbanLevel0.index.doc.xml: HTML.index
	perl $(DSSSLLOC)/bin/collateindex.pl -p -o lojbanLevel0.index.doc.xml HTML.index

HTML.index: $(SOURCE)
	perl $(DSSSLLOC)/bin/collateindex.pl -N -o lojbanLevel0.index.doc.xml
	openjade -E 0 -wno-valid -t sgml -d $(DSSSLLOC)/html/my_docbook.html.dsl -V html-index $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.doc.xml
	mv *.html html/

