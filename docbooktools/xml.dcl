<!SGML -- SGML Declaration for valid XML documents --
     "ISO 8879:1986 (WWW)"

     CHARSET
  BASESET "ISO Registration Number 177//CHARSET
           ISO/IEC 10646-1:1993 UCS-4 with implementation level 3
           //ESC 2/5 2/15 4/6"
         DESCSET
                0       9       UNUSED
                9       2       9
                11      2       UNUSED
                13      1       13
                14      18      UNUSED
                32      95      32
                127     1       UNUSED
                128     32      UNUSED
           	160 65535 160
    CAPACITY SGMLREF
        -- Capacities are not restricted in XML --
        TOTALCAP    99999999
        ENTCAP      99999999
        ENTCHCAP    99999999
        ELEMCAP     99999999
        GRPCAP      99999999
        EXGRPCAP    99999999
        EXNMCAP     99999999
        ATTCAP      99999999
        ATTCHCAP    99999999
        AVGRPCAP    99999999
        NOTCAP      99999999
        NOTCHCAP    99999999
        IDCAP       99999999
        IDREFCAP    99999999
        MAPCAP      99999999
        LKSETCAP    99999999
        LKNMCAP     99999999

     SCOPE DOCUMENT

     SYNTAX
         SHUNCHAR NONE
        BASESET "ISO 646-1983//CHARSET 
                 International Reference Version (IRV)
                 //ESC 2/5 4/0"
         DESCSET
--             0 1114112 0    --
            0 128 0
         FUNCTION
             RE    13
             RS    10
             SPACE 32
             TAB   SEPCHAR 9

        NAMING
            -- '-' is an allowed name start character in XML --
            LCNMSTRT    "-"
            UCNMSTRT    "-"
            LCNMCHAR    "."    -- Moved '-' to LCNMSTRT --
            UCNMCHAR    "."    -- Moved '-' to UCNMSTRT --
            NAMECASE
                GENERAL     NO
                ENTITY      NO
         DELIM
             GENERAL SGMLREF
                HCRO "&#38;#x" -- 38 is the number for ampersand --
             NESTC "/"
             NET ">"
             PIC "?>"
             SHORTREF NONE

         NAMES
             SGMLREF

        QUANTITY SGMLREF
            -- Quantities are not restricted in XML --
            ATTCNT      99999999
            ATTSPLEN    99999999
            -- BSEQLEN          NOT USED --
            -- DTAGLEN          NOT USED --
            -- DTEMPLEN         NOT USED --
            ENTLVL      99999999
            GRPCNT      99999999
            GRPGTCNT    99999999
            GRPLVL      99999999
            LITLEN      99999999
            NAMELEN     99999999
            -- NORMSEP          NO NEED TO CHANGE IT --
            PILEN       99999999
            TAGLEN      99999999
            TAGLVL      99999999

         ENTITIES
             "amp" 38
             "lt" 60
             "gt" 62
             "quot" 34
             "apos" 39

     FEATURES
         MINIMIZE
             DATATAG NO
             OMITTAG NO
             RANK NO
             SHORTTAG
                 STARTTAG
                     EMPTY NO
                     UNCLOSED NO 
                     NETENABL IMMEDNET
                 ENDTAG
                     EMPTY NO 
                     UNCLOSED NO
                 ATTRIB
                     DEFAULT YES
                     OMITNAME NO
                     VALUE NO
             EMPTYNRM YES
             IMPLYDEF
                 ATTLIST NO
                 DOCTYPE NO
                 ELEMENT NO
                 ENTITY NO
                 NOTATION NO
         LINK
             SIMPLE NO
             IMPLICIT NO
             EXPLICIT NO
         OTHER
             CONCUR NO
             SUBDOC NO
             FORMAL NO
             URN NO
             KEEPRSRE YES
             VALIDITY TYPE
             ENTITIES
                 REF ANY
                 INTEGRAL YES
     APPINFO NONE
--     SEEALSO "ISO 8879:1986//NOTATION          --
--            Extensible Markup Language (XML) 1.0//EN"       --
>
