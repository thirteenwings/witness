"COMPILE/LOAD FILE for WITNESS
Copyright (C) 1983 Infocom, Inc.  All rights reserved."

<COND (<GASSIGNED? PREDGEN>
       <SETG ZSTR-ON <SETG ZSTR-OFF ,TIME>>
       <PRINC "Compiling">
       <ID 0>)
      (T <PRINC "Loading">)>

<PRINC " WITNESS: An INTERLOGIC Mystery
">

<COND (<GASSIGNED? PREDGEN>
       <BLOAT 90000 0 0 3500 0 0 0 0 0 512>)>

<SET REDEFINE T>

<CONSTANT SERIAL 0>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<DIRECTIONS NORTH SOUTH EAST WEST NE NW SE SW UP DOWN IN OUT>

<IFILE "MACROS" T>
<IFILE "SYNTAX" T>

<IFILE "PLACES" T>
<IFILE "PEOPLE" T>
<IFILE "THINGS" T>

<ENDLOAD>
<IFILE "CLOCK" T>
<IFILE "MAIN" T>
<IFILE "PARSER" T>
<IFILE "VERBS" T>
<IFILE "EVENTS" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>

<GC-MON T>
<COND (<GASSIGNED? PREDGEN>
       <GC 0 T 5>)>
