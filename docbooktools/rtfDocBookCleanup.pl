# Script to clean up RTF output from DocBook and (open)jade. Nick Nicholas.
use strict;

while (<>)
{
	s/([^\\])'/$1\\rquote /g ;
	s/ \\'97 /\\'97/g;
	print $_;
}