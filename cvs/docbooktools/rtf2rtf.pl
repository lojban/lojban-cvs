# Script for converting fake index entries in RTF to proper RTF index commands
# (c) Jirka Kosek, 1998-2001
# Translated into perl by Nick Nicholas

use strict;

while (<>)
{

  # rejstøík
  s/#([^:#]*):::([^#]*)#/#$1\\:$2#/g;
  # next two added by NN: force italicisation 
  s/#xe #([^#]*)#txe See also ([^#]*)##/{\\v\\b0\\i0{\\xe {}{$1}{\\txe {\\i See also }{}{$2}}{}}}/g;
  s/#xe #([^#]*)#txe See ([^#]*)##/{\\v\\b0\\i0{\\xe {}{$1}{}{\\txe {\\i See }$2}{}}}/g;
  s/#xe #([^#]*)#txe ([^#]*)##/{\\v\\b0\\i0{\\xe {}{$1}{}{\\txe $2}{}}}/g;
  s/#xe #([^#]*)#rxe ([^#]*)##/{\\v\\b0\\i0{\\xe {}{$1}{}{\\rxe $2}}}/g;
  s/#xe #([^#]*)##/{\\v\\b0\\i0{\\xe {}{$1}}}/g;
  # next two added by NN to deal with indexterm significance="preferred"
  s/#xe #([^#]*)#rxe ([^#]*)#bb##/{\\v\\b0\\i0{\\xe {}{$1}{}{\\rxe $2}\\bxe }}/g;
  s/#xe #([^#]*)#bb##/{\\v\\b0\\i0{\\xe {}{$1\\bxe }}}/g;
#  $l = EReg_Replace('#([^:#]*):([^#]*)#', '#\1\\:\2#', $l);
#  $l = EReg_Replace('#xe #([^#]*)#txe ([^#]*)##', '{\\v\\b0\\i0{\\xe {\1}{\\txe \2}{}}}', $l);
#  $l = EReg_Replace('#xe #([^#]*)#rxe ([^#]*)##', '{\\v\\b0\\i0{\\xe {\1}{\\rxe \2}}}', $l);
#  $l = EReg_Replace('#xe #([^#]*)##', '{\\v\\b0\\i0{\\xe {\1}}}', $l);
  
  # bookmarky
  s/#bs ([^#]*)#/{\\*\\bkmkstart $1}/g;
  s/#be ([^#]*)#/{\\*\\bkmkend $1}/g;
#  $l = EReg_Replace('#bs ([^#]*)#', '{\\*\\bkmkstart \1}', $l);
#  $l = EReg_Replace('#be ([^#]*)#', '{\\*\\bkmkend \1}', $l);

  # vložení rejstøíku
  s/#index#/{\\field{\\*\\fldinst { INDEX \\\\c "2" }}}/g;
#  $l = EReg_Replace('#index#', '{\\field{\\*\\fldinst { INDEX \\\\c "2" }}}', $l);
  
  print $_;
}
