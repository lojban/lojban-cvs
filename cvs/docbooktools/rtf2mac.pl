use strict;

while (<>)
{

  s/\[\[softsign\]\]/\'/g;
  s/\[\[phi\]\]/\\u8719\'/g;
  s/\[\[erzh\]\]/\\u8486\'/g;
  
  print $_;
}
