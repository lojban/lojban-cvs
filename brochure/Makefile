DSSSLLOC=../../dsssl/docbook
DOCBOOKTOOLS=../docbooktools
SOURCE=attit.doc.xml bradi.doc.xml brochure.doc.xml ckape.doc.xml diagsumm.doc.xml intro.doc.xml lingissues.doc.xml lorxu.doc.xml overview.doc.xml tech.doc.xml xtomathy.doc.xml xtomathyinfo.doc.xml
all: rtf paperback tex html

paperback: lojbanLevel0.index.doc.xml
	openjade -E 0 -t rtf -o lojban.tmp.rtf -d $(DSSSLLOC)/print/my_docbook.paperback.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.silencoding.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < lojban.tmp.rtf > lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < lojban.tmp1.rtf > lojbanLevel0.paperback.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"

rtf: lojbanLevel0.index.doc.xml
	openjade -E 0 -o lojban.tmp.rtf -t rtf -d $(DSSSLLOC)/print/my_docbook.print.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.doc.xml
	perl $(DOCBOOKTOOLS)/rtf2rtf.pl < lojban.tmp.rtf > lojban.tmp1.rtf
	perl $(DOCBOOKTOOLS)/rtfDocBookCleanup.pl < lojban.tmp1.rtf > lojbanLevel0.doc.rtf
	echo "Don't forget to index the text in Word (Ctrl-A, F9 on PC.)"


tex: lojbanLevel0.index.doc.xml
	openjade -E 0 -t tex -d $(DSSSLLOC)/print/my_docbook.print.tex.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.doc.xml

html: lojbanLevel0.index.doc.xml 
	openjade -E 0 -t sgml -d $(DSSSLLOC)/html/my_docbook.html.dsl $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.html.doc.xml

lojbanLevel0.index.doc.xml: HTML.index
	perl $(DSSSLLOC)/bin/collateindex.pl -p -o lojbanLevel0.index.doc.xml HTML.index

HTML.index: $(SOURCE)
	perl $(DSSSLLOC)/bin/collateindex.pl -N -o lojbanLevel0.index.doc.xml
	openjade -E 0 -wno-valid -t sgml -d $(DSSSLLOC)/html/my_docbook.html.dsl -V html-index $(DOCBOOKTOOLS)/xml.dcl lojbanLevel0.doc.xml

