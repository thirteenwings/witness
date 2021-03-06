

	.FUNCT	THIS-IS-S-HE,PERSON
	SET	'P-HIM-HER,PERSON
	LOC	PERSON >P-HIM-HER-LOC
	RETURN	P-HIM-HER-LOC


	.FUNCT	I-PROMPT-1
	SET	'P-PROMPT,STR?140
	RFALSE	


	.FUNCT	I-PROMPT-2
	ZERO?	P-PROMPT /FALSE
	SET	'P-PROMPT,FALSE-VALUE
	CRLF	
	PRINTI	"(Aren't you getting tired of seeing "
	ZERO?	X-IS-LISTENING /?CND9
	PRINTI	"""(... is listening.)"" and "
?CND9:	PRINTI	"""What next?"" and ""You are now in the ....""? From here on, the prompt will be much shorter.)"
	CRLF	
	EQUAL?	PRSA,V?WAIT-UNTIL,V?WAIT-FOR,V?WAIT \?CND17
	CRLF	
?CND17:	CALL	INT,I-PROMPT-2
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	PARSER,PTR=P-LEXSTART,WRD,VAL=0,VERB=0,LEN,DIR=0,NW=0,LW=0,NUM,SCNT,CNT=-1
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	PUT	P-ITBL,CNT,0
	JUMP	?PRG1
?REP2:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	SET	'P-ADVERB,FALSE-VALUE
	SET	'P-MERGED,FALSE-VALUE
	PUT	P-PRSO,P-MATCHLEN,0
	PUT	P-PRSI,P-MATCHLEN,0
	PUT	P-BUTS,P-MATCHLEN,0
	ZERO?	QUOTE-FLAG \?CND8
	EQUAL?	WINNER,PLAYER /?CND8
	SET	'WINNER,PLAYER
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND8
	LOC	WINNER >HERE
?CND8:	ZERO?	P-CONT /?ELS18
	SET	'PTR,P-CONT
	SET	'P-CONT,FALSE-VALUE
	EQUAL?	PRSA,V?TELL /?CND16
	CRLF	
	JUMP	?CND16
?ELS18:	SET	'WINNER,PLAYER
	SET	'QUOTE-FLAG,FALSE-VALUE
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND25
	LOC	WINNER >HERE
?CND25:	SET	'SCNT,P-SPACE
?PRG28:	DLESS?	'SCNT,0 \?ELS32
	JUMP	?REP29
?ELS32:	CRLF	
	JUMP	?PRG28
?REP29:	ZERO?	P-PROMPT /?CND35
	ZERO?	P-OFLAG \?CND35
	ZERO?	QCONTEXT /?CND40
	SET	'X-IS-LISTENING,TRUE-VALUE
	PRINTI	"("
	PRINTD	QCONTEXT
	PRINTI	" is listening.)"
	CRLF	
?CND40:	PRINT	P-PROMPT
	CRLF	
?CND35:	PRINTI	">"
	READ	P-INBUF,P-LEXV
?CND16:	GETB	P-LEXV,P-LEXWORDS >P-LEN
	ZERO?	P-LEN \?ELS52
	PRINTI	"What?"
	CRLF	
	RFALSE	
?ELS52:	GET	P-LEXV,PTR >WRD
	EQUAL?	WRD,W?WHY,W?HOW,W?WHEN /?THN57
	EQUAL?	WRD,W?IS,W?DID,W?ARE \?CND50
?THN57:	PRINTI	"(Sorry, but this program can't handle questions like that. You should stick to questions like ""WHAT IS ..."" and ""WHERE IS ...."" Maybe you'd like to review your instruction manual.)"
	CRLF	
	RFALSE	
?CND50:	SET	'LEN,P-LEN
	SET	'P-DIR,FALSE-VALUE
	SET	'P-NCN,0
	SET	'P-GETFLAGS,0
	PUT	P-ITBL,P-VERBN,0
?PRG61:	DLESS?	'P-LEN,0 \?ELS65
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP62
?ELS65:	GET	P-LEXV,PTR >WRD
	ZERO?	WRD \?THN68
	CALL	NUMBER?,PTR >WRD
	ZERO?	WRD /?ELS67
?THN68:	EQUAL?	WRD,W?TO \?ELS72
	EQUAL?	VERB,ACT?TELL,ACT?ASK \?ELS72
	SET	'WRD,W?QUOTE
	JUMP	?CND70
?ELS72:	EQUAL?	WRD,W?THEN \?CND70
	ZERO?	VERB \?CND70
	PUT	P-ITBL,P-VERB,ACT?TELL
	PUT	P-ITBL,P-VERBN,0
	SET	'WRD,W?QUOTE
?CND70:	EQUAL?	WRD,W?PERIOD \?ELS81
	EQUAL?	LW,W?MRS,W?MR \?ELS81
	SET	'LW,0
	JUMP	?CND63
?ELS81:	EQUAL?	WRD,W?THEN,W?PERIOD /?THN86
	EQUAL?	WRD,W?QUOTE \?ELS85
?THN86:	EQUAL?	WRD,W?QUOTE \?CND88
	ZERO?	QUOTE-FLAG /?ELS93
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?CND88
?ELS93:	SET	'QUOTE-FLAG,TRUE-VALUE
?CND88:	ZERO?	P-LEN /?THN97
	ADD	PTR,P-LEXELEN >P-CONT
?THN97:	PUTB	P-LEXV,P-LEXWORDS,P-LEN
	JUMP	?REP62
?ELS85:	CALL	WT?,WRD,PS?DIRECTION,P1?DIRECTION >VAL
	ZERO?	VAL /?ELS100
	EQUAL?	LEN,1 /?THN103
	EQUAL?	LEN,2 \?ELS106
	EQUAL?	VERB,ACT?WALK /?THN103
?ELS106:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
	EQUAL?	NW,W?THEN,W?QUOTE \?ELS108
	GRTR?	LEN,2 /?THN103
?ELS108:	EQUAL?	NW,W?PERIOD \?ELS110
	GRTR?	LEN,1 /?THN103
?ELS110:	ZERO?	QUOTE-FLAG /?ELS112
	EQUAL?	LEN,2 \?ELS112
	EQUAL?	NW,W?QUOTE /?THN103
?ELS112:	GRTR?	LEN,2 \?ELS100
	EQUAL?	NW,W?COMMA,W?AND \?ELS100
?THN103:	SET	'DIR,VAL
	EQUAL?	NW,W?COMMA,W?AND \?CND115
	ADD	PTR,P-LEXELEN
	PUT	P-LEXV,STACK,W?THEN
?CND115:	GRTR?	LEN,2 /?CND63
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP62
?ELS100:	CALL	WT?,WRD,PS?VERB,P1?VERB >VAL
	ZERO?	VAL /?ELS122
	ZERO?	VERB /?THN125
	EQUAL?	VERB,ACT?WHAT \?ELS122
?THN125:	SET	'VERB,VAL
	PUT	P-ITBL,P-VERB,VAL
	PUT	P-ITBL,P-VERBN,P-VTBL
	PUT	P-VTBL,0,WRD
	MUL	PTR,2
	ADD	STACK,2 >NUM
	GETB	P-LEXV,NUM
	PUTB	P-VTBL,2,STACK
	ADD	NUM,1
	GETB	P-LEXV,STACK
	PUTB	P-VTBL,3,STACK
	JUMP	?CND63
?ELS122:	CALL	WT?,WRD,PS?PREPOSITION,0 >VAL
	ZERO?	VAL \?THN129
	EQUAL?	WRD,W?ONE,W?A /?THN133
	CALL	WT?,WRD,PS?ADJECTIVE
	ZERO?	STACK \?THN133
	CALL	WT?,WRD,PS?OBJECT
	ZERO?	STACK /?ELS128
?THN133:	SET	'VAL,0
?THN129:	GRTR?	P-LEN,0 \?ELS137
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?OF \?ELS137
	EQUAL?	VERB,ACT?ACCUSE,ACT?MAKE /?ELS137
	ZERO?	VAL \?ELS137
	EQUAL?	WRD,W?ONE,W?A /?ELS137
	JUMP	?CND63
?ELS137:	ZERO?	VAL /?ELS141
	ZERO?	P-LEN /?THN144
	ADD	PTR,2
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?THEN,W?PERIOD \?ELS141
?THN144:	LESS?	P-NCN,2 \?CND63
	PUT	P-ITBL,P-PREP1,VAL
	PUT	P-ITBL,P-PREP1N,WRD
	JUMP	?CND63
?ELS141:	EQUAL?	P-NCN,2 \?ELS150
	PRINTI	"(I found more than two nouns in that sentence!)"
	CRLF	
	RFALSE	
?ELS150:	INC	'P-NCN
	CALL	CLAUSE,PTR,VAL,WRD >PTR
	ZERO?	PTR /FALSE
	LESS?	PTR,0 \?CND63
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?REP62
?ELS128:	EQUAL?	WRD,W?CLOSELY \?ELS161
	SET	'P-ADVERB,W?CAREFULLY
	JUMP	?CND63
?ELS161:	EQUAL?	WRD,W?CAREFULLY,W?QUIETLY /?THN164
	EQUAL?	WRD,W?SLOWLY,W?QUICKLY,W?BRIEFLY \?ELS163
?THN164:	SET	'P-ADVERB,WRD
	JUMP	?CND63
?ELS163:	CALL	WT?,WRD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS167
	JUMP	?CND63
?ELS167:	CALL	CANT-USE,PTR
	RFALSE	
?ELS67:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND63:	SET	'LW,WRD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG61
?REP62:	ZERO?	DIR /?CND172
	SET	'PRSA,V?WALK
	SET	'PRSO,DIR
	RETURN	TRUE-VALUE
?CND172:	ZERO?	P-OFLAG /?CND176
	CALL	ORPHAN-MERGE
?CND176:	GET	P-ITBL,P-VERB
	ZERO?	STACK \?CND180
	PUT	P-ITBL,P-VERB,ACT?$CALL
?CND180:	CALL	SYNTAX-CHECK
	ZERO?	STACK /FALSE
	CALL	SNARF-OBJECTS
	ZERO?	STACK /FALSE
	CALL	TAKE-CHECK
	ZERO?	STACK /FALSE
	CALL	MANY-CHECK
	ZERO?	STACK /FALSE
	RTRUE


	.FUNCT	WT?,PTR,BIT,B1=5,OFFSET=P-P1OFF,TYP
	GETB	PTR,P-PSOFF >TYP
	BTST	TYP,BIT \FALSE
	GRTR?	B1,4 /TRUE
	BAND	TYP,P-P1BITS >TYP
	EQUAL?	TYP,B1 /?CND13
	INC	'OFFSET
?CND13:	GETB	PTR,OFFSET
	RSTACK	


	.FUNCT	CLAUSE,PTR,VAL,WRD,OFF,NUM,ANDFLG=0,FIRST??=1,NW,LW=0,?TMP1
	SUB	P-NCN,1
	MUL	STACK,2 >OFF
	ZERO?	VAL /?ELS3
	ADD	P-PREP1,OFF >NUM
	PUT	P-ITBL,NUM,VAL
	ADD	NUM,1
	PUT	P-ITBL,STACK,WRD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND1
?ELS3:	INC	'P-LEN
?CND1:	ZERO?	P-LEN \?CND6
	DEC	'P-NCN
	RETURN	-1
?CND6:	ADD	P-NC1,OFF >NUM
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,NUM,STACK
	GET	P-LEXV,PTR
	EQUAL?	STACK,W?THE,W?A,W?AN \?CND9
	GET	P-ITBL,NUM
	ADD	STACK,4
	PUT	P-ITBL,NUM,STACK
?CND9:	
?PRG12:	DLESS?	'P-LEN,0 \?CND14
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	-1
?CND14:	GET	P-LEXV,PTR >WRD
	ZERO?	WRD \?THN20
	CALL	NUMBER?,PTR >WRD
	ZERO?	WRD /?ELS19
?THN20:	ZERO?	P-LEN \?ELS24
	SET	'NW,0
	JUMP	?CND22
?ELS24:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
?CND22:	EQUAL?	WRD,W?OF \?CND27
	GET	P-ITBL,P-VERB
	EQUAL?	STACK,ACT?ACCUSE,ACT?MAKE \?CND27
	PUT	P-LEXV,PTR,W?WITH
	SET	'WRD,W?WITH
?CND27:	EQUAL?	WRD,W?PERIOD \?ELS34
	EQUAL?	LW,W?MRS,W?MR \?ELS34
	SET	'LW,0
	JUMP	?CND17
?ELS34:	EQUAL?	WRD,W?AND,W?COMMA \?ELS38
	SET	'ANDFLG,TRUE-VALUE
	JUMP	?CND17
?ELS38:	EQUAL?	WRD,W?ONE \?ELS40
	EQUAL?	NW,W?OF \?CND17
	DEC	'P-LEN
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND17
?ELS40:	EQUAL?	WRD,W?THEN,W?PERIOD /?THN46
	CALL	WT?,WRD,PS?PREPOSITION
	ZERO?	STACK /?ELS45
	ZERO?	FIRST?? \?ELS45
?THN46:	INC	'P-LEN
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	SUB	PTR,P-LEXELEN
	RETURN	STACK
?ELS45:	ZERO?	ANDFLG /?ELS51
	GET	P-ITBL,P-VERBN
	ZERO?	STACK /?THN54
	CALL	WT?,WRD,PS?DIRECTION
	ZERO?	STACK \?THN54
	CALL	WT?,WRD,PS?VERB
	ZERO?	STACK /?ELS51
?THN54:	SUB	PTR,4 >PTR
	ADD	PTR,2
	PUT	P-LEXV,STACK,W?THEN
	ADD	P-LEN,2 >P-LEN
	JUMP	?CND17
?ELS51:	CALL	WT?,WRD,PS?OBJECT
	ZERO?	STACK /?ELS57
	CALL	WT?,WRD,PS?ADJECTIVE,P1?ADJECTIVE
	ZERO?	STACK /?ELS60
	ZERO?	NW /?ELS60
	CALL	WT?,NW,PS?OBJECT
	ZERO?	STACK /?ELS60
	JUMP	?CND17
?ELS60:	ZERO?	ANDFLG \?ELS64
	EQUAL?	NW,W?BUT,W?EXCEPT /?ELS64
	EQUAL?	NW,W?AND,W?COMMA /?ELS64
	ADD	NUM,1 >?TMP1
	ADD	PTR,2
	MUL	STACK,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	PTR
?ELS64:	SET	'ANDFLG,FALSE-VALUE
	JUMP	?CND17
?ELS57:	CALL	WT?,WRD,PS?ADJECTIVE
	ZERO?	STACK \?CND17
	CALL	WT?,WRD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS70
	JUMP	?CND17
?ELS70:	CALL	WT?,WRD,PS?PREPOSITION
	ZERO?	STACK /?ELS74
	JUMP	?CND17
?ELS74:	CALL	CANT-USE,PTR
	RFALSE	
?ELS19:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND17:	SET	'LW,WRD
	SET	'FIRST??,FALSE-VALUE
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG12


	.FUNCT	NUMBER?,PTR,CNT,BPTR,CHR,SUM=0,TIM=0,?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,2 >CNT
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,3 >BPTR
?PRG1:	DLESS?	'CNT,0 \?ELS5
	JUMP	?REP2
?ELS5:	GETB	P-INBUF,BPTR >CHR
	EQUAL?	CHR,58 \?ELS10
	SET	'TIM,SUM
	SET	'SUM,0
	JUMP	?CND8
?ELS10:	GRTR?	SUM,9999 /FALSE
	LESS?	CHR,58 \FALSE
	GRTR?	CHR,47 \FALSE
	MUL	SUM,10 >?TMP1
	SUB	CHR,48
	ADD	?TMP1,STACK >SUM
?CND8:	INC	'BPTR
	JUMP	?PRG1
?REP2:	PUT	P-LEXV,PTR,W?INTNUM
	GRTR?	SUM,9999 /FALSE
	ZERO?	TIM /?CND19
	GRTR?	TIM,23 /FALSE
	GRTR?	TIM,19 \?ELS29
	JUMP	?CND25
?ELS29:	GRTR?	TIM,12 /FALSE
	GRTR?	TIM,7 \?ELS33
	JUMP	?CND25
?ELS33:	ADD	12,TIM >TIM
?CND25:	MUL	TIM,60
	ADD	SUM,STACK >SUM
?CND19:	SET	'P-NUMBER,SUM
	RETURN	W?INTNUM


	.FUNCT	ORPHAN-MERGE,CNT=-1,TEMP,VERB,BEG,END,ADJ=0,WRD,?TMP1
	SET	'P-OFLAG,FALSE-VALUE
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB /?ELS3
	GET	P-OTBL,P-VERB
	EQUAL?	VERB,STACK \FALSE
?ELS3:	EQUAL?	P-NCN,2 /FALSE
	GET	P-OTBL,P-NC1
	EQUAL?	STACK,1 \?ELS9
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP1
	EQUAL?	TEMP,STACK /?THN13
	ZERO?	TEMP \FALSE
?THN13:	ZERO?	ADJ /?ELS17
	ADD	P-LEXV,2
	PUT	P-OTBL,P-NC1,STACK
	ADD	P-LEXV,6
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND1
?ELS17:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC1,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND1
?ELS9:	GET	P-OTBL,P-NC2
	EQUAL?	STACK,1 \?ELS24
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP2
	EQUAL?	TEMP,STACK /?THN28
	ZERO?	TEMP \FALSE
?THN28:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC2,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC2L,STACK
	SET	'P-NCN,2
	JUMP	?CND1
?ELS24:	ZERO?	P-ACLAUSE /?CND1
	EQUAL?	P-NCN,1 /?ELS37
	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?ELS37:	GET	P-ITBL,P-NC1 >BEG
	GET	P-ITBL,P-NC1L >END
?PRG40:	EQUAL?	BEG,END \?ELS44
	ZERO?	ADJ /?ELS47
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND35
?ELS47:	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?ELS44:	ZERO?	ADJ \?ELS52
	GET	BEG,0 >WRD
	GETB	WRD,P-PSOFF
	BTST	STACK,PS?ADJECTIVE \?ELS52
	SET	'ADJ,WRD
	JUMP	?CND42
?ELS52:	GETB	WRD,P-PSOFF
	BTST	STACK,PS?OBJECT /?THN57
	EQUAL?	WRD,W?ONE \?CND42
?THN57:	EQUAL?	WRD,P-ANAM,W?ONE \FALSE
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND35
?CND42:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG40
?CND35:	
?CND1:	
?PRG64:	IGRTR?	'CNT,P-ITBLLEN \?ELS68
	SET	'P-MERGED,TRUE-VALUE
	RTRUE	
?ELS68:	GET	P-OTBL,CNT
	PUT	P-ITBL,CNT,STACK
	JUMP	?PRG64


	.FUNCT	ACLAUSE-WIN,ADJ
	SET	'P-CCSRC,P-OTBL
	ADD	P-ACLAUSE,1
	CALL	CLAUSE-COPY,P-ACLAUSE,STACK,ADJ
	GET	P-OTBL,P-NC2
	ZERO?	STACK /?ELS2
	SET	'P-NCN,2
?ELS2:	SET	'P-ACLAUSE,FALSE-VALUE
	RTRUE	


	.FUNCT	WORD-PRINT,CNT,BUF
?PRG1:	DLESS?	'CNT,0 /TRUE
	GETB	P-INBUF,BUF
	PRINTC	STACK
	INC	'BUF
	JUMP	?PRG1


	.FUNCT	UNKNOWN-WORD,PTR,BUF,MSG,?TMP1
	CALL	PICK-ONE,UNKNOWN-MSGS >MSG
	GET	MSG,0
	PRINT	STACK
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	GET	MSG,1
	PRINT	STACK
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	CANT-USE,PTR,BUF,?TMP1
	PRINTI	"(Sorry, but you can't use the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	PRINTI	""" in that sense.)"
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	SYNTAX-CHECK,SYN,LEN,NUM,OBJ,DRIVE1=0,DRIVE2=0,PREP,VERB,?TMP2,?TMP1
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB \?CND1
	PRINTI	"(I couldn't find a verb in that sentence!)"
	CRLF	
	RFALSE	
?CND1:	SUB	255,VERB
	GET	VERBS,STACK >SYN
	GETB	SYN,0 >LEN
	ADD	1,SYN >SYN
?PRG6:	GETB	SYN,P-SBITS
	BAND	STACK,P-SONUMS >NUM
	GRTR?	P-NCN,NUM \?ELS10
	JUMP	?CND8
?ELS10:	LESS?	NUM,1 /?ELS12
	ZERO?	P-NCN \?ELS12
	GET	P-ITBL,P-PREP1 >PREP
	ZERO?	PREP /?THN15
	GETB	SYN,P-SPREP1
	EQUAL?	PREP,STACK \?ELS12
?THN15:	SET	'DRIVE1,SYN
	JUMP	?CND8
?ELS12:	GETB	SYN,P-SPREP1 >?TMP1
	GET	P-ITBL,P-PREP1
	EQUAL?	?TMP1,STACK \?CND8
	EQUAL?	NUM,2 \?ELS21
	EQUAL?	P-NCN,1 \?ELS21
	SET	'DRIVE2,SYN
	JUMP	?CND8
?ELS21:	GETB	SYN,P-SPREP2 >?TMP1
	GET	P-ITBL,P-PREP2
	EQUAL?	?TMP1,STACK \?CND8
	CALL	SYNTAX-FOUND,SYN
	RTRUE	
?CND8:	DLESS?	'LEN,1 \?ELS28
	ZERO?	DRIVE1 \?REP7
	ZERO?	DRIVE2 /?ELS31
	JUMP	?REP7
?ELS31:	PRINTI	"(Sorry, but English is my second language. Please rephrase that.)"
	CRLF	
	RFALSE	
?ELS28:	ADD	SYN,P-SYNLEN >SYN
	JUMP	?PRG6
?REP7:	ZERO?	DRIVE1 /?ELS44
	GETB	DRIVE1,P-SFWIM1 >?TMP2
	GETB	DRIVE1,P-SLOC1 >?TMP1
	GETB	DRIVE1,P-SPREP1
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS44
	PUT	P-PRSO,P-MATCHLEN,1
	PUT	P-PRSO,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE1
	RSTACK	
?ELS44:	ZERO?	DRIVE2 /?ELS48
	GETB	DRIVE2,P-SFWIM2 >?TMP2
	GETB	DRIVE2,P-SLOC2 >?TMP1
	GETB	DRIVE2,P-SPREP2
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS48
	PUT	P-PRSI,P-MATCHLEN,1
	PUT	P-PRSI,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE2
	RSTACK	
?ELS48:	EQUAL?	VERB,ACT?FIND,ACT?WHAT \?ELS52
	PRINTI	"(Sorry, but I can't answer that question.)"
	CRLF	
	RFALSE	
?ELS52:	EQUAL?	WINNER,PLAYER \?ELS59
	CALL	ORPHAN,DRIVE1,DRIVE2
	PRINTI	"(What do you want to "
	JUMP	?CND57
?ELS59:	PRINTI	"(Your request was incomplete. Next time, say what you want "
	PRINTD	WINNER
	PRINTI	" to "
?CND57:	CALL	VERB-PRINT
	ZERO?	DRIVE2 /?CND66
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L
?CND66:	ZERO?	DRIVE1 /?ELS74
	GETB	DRIVE1,P-SPREP1
	JUMP	?CND70
?ELS74:	GETB	DRIVE2,P-SPREP2
?CND70:	CALL	PREP-PRINT,STACK
	EQUAL?	WINNER,PLAYER \?ELS80
	SET	'P-OFLAG,TRUE-VALUE
	PRINTI	"?)"
	CRLF	
	RFALSE	
?ELS80:	SET	'P-OFLAG,FALSE-VALUE
	PRINTI	".)"
	CRLF	
	RFALSE	


	.FUNCT	VERB-PRINT,TMP,?TMP1
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS5
	PRINTI	"tell"
	RTRUE	
?ELS5:	GETB	P-VTBL,2
	ZERO?	STACK \?ELS9
	GET	TMP,0
	PRINTB	STACK
	RTRUE	
?ELS9:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
	RTRUE	


	.FUNCT	ORPHAN,D1,D2,CNT=-1
	PUT	P-OCLAUSE,P-MATCHLEN,0
	SET	'P-CCSRC,P-ITBL
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	GET	P-ITBL,CNT
	PUT	P-OTBL,CNT,STACK
	JUMP	?PRG1
?REP2:	EQUAL?	P-NCN,2 \?CND8
	CALL	CLAUSE-COPY,P-NC2,P-NC2L
?CND8:	LESS?	P-NCN,1 /?CND11
	CALL	CLAUSE-COPY,P-NC1,P-NC1L
?CND11:	ZERO?	D1 /?ELS18
	GETB	D1,P-SPREP1
	PUT	P-OTBL,P-PREP1,STACK
	PUT	P-OTBL,P-NC1,1
	RTRUE	
?ELS18:	ZERO?	D2 /FALSE
	GETB	D2,P-SPREP2
	PUT	P-OTBL,P-PREP2,STACK
	PUT	P-OTBL,P-NC2,1
	RTRUE	


	.FUNCT	CLAUSE-PRINT,BPTR,EPTR,THE?=1,?TMP1
	GET	P-ITBL,BPTR >?TMP1
	GET	P-ITBL,EPTR
	CALL	BUFFER-PRINT,?TMP1,STACK,THE?
	RSTACK	


	.FUNCT	BUFFER-PRINT,BEG,END,CP,NOSP=0,WRD,FIRST??=1,PN=0,?TMP1
?PRG1:	EQUAL?	BEG,END /TRUE
	ZERO?	NOSP /?ELS10
	SET	'NOSP,FALSE-VALUE
	JUMP	?CND8
?ELS10:	PRINTI	" "
?CND8:	GET	BEG,0 >WRD
	EQUAL?	WRD,W?PERIOD \?ELS18
	SET	'NOSP,TRUE-VALUE
	JUMP	?CND3
?ELS18:	EQUAL?	WRD,W?MRS \?ELS20
	PRINTI	"Mrs."
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS20:	EQUAL?	WRD,W?MR \?ELS24
	PRINTI	"Mr."
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS24:	EQUAL?	WRD,W?LINDER,W?MONICA,W?PHONG /?THN29
	EQUAL?	WRD,W?STILES,W?DUFFY \?ELS28
?THN29:	CALL	CAPITALIZE,BEG
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?ELS28:	ZERO?	FIRST?? /?CND33
	ZERO?	PN \?CND33
	ZERO?	CP /?CND33
	PRINTI	"the "
?CND33:	ZERO?	P-OFLAG \?THN43
	ZERO?	P-MERGED /?ELS42
?THN43:	PRINTB	WRD
	JUMP	?CND40
?ELS42:	EQUAL?	WRD,W?IT \?ELS46
	EQUAL?	P-IT-LOC,HERE \?ELS46
	PRINTD	P-IT-OBJECT
	JUMP	?CND40
?ELS46:	EQUAL?	WRD,W?HIM,W?HER \?ELS50
	EQUAL?	P-HIM-HER-LOC,HERE \?ELS50
	PRINTD	P-HIM-HER
	JUMP	?CND40
?ELS50:	GETB	BEG,2 >?TMP1
	GETB	BEG,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND40:	SET	'FIRST??,FALSE-VALUE
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CAPITALIZE,PTR,?TMP1
	GETB	PTR,3
	GETB	P-INBUF,STACK
	SUB	STACK,32
	PRINTC	STACK
	GETB	PTR,2
	SUB	STACK,1 >?TMP1
	GETB	PTR,3
	ADD	STACK,1
	CALL	WORD-PRINT,?TMP1,STACK
	RSTACK	


	.FUNCT	PREP-PRINT,PREP,WRD
	ZERO?	PREP /FALSE
	PRINTI	" "
	CALL	PREP-FIND,PREP >WRD
	EQUAL?	WRD,W?AGAINST \?ELS10
	PRINTI	"against"
	JUMP	?CND8
?ELS10:	PRINTB	WRD
?CND8:	GET	P-ITBL,P-VERBN
	GET	STACK,0
	EQUAL?	W?SIT,STACK \FALSE
	EQUAL?	W?DOWN,WRD \FALSE
	PRINTI	" on"
	RTRUE	


	.FUNCT	CLAUSE-COPY,BPTR,EPTR,INSERT=0,BEG,END
	GET	P-CCSRC,BPTR >BEG
	GET	P-CCSRC,EPTR >END
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,BPTR,STACK
?PRG1:	EQUAL?	BEG,END \?ELS5
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,EPTR,STACK
	RTRUE	
?ELS5:	ZERO?	INSERT /?CND8
	GET	BEG,0
	EQUAL?	P-ANAM,STACK \?CND8
	CALL	CLAUSE-ADD,INSERT
?CND8:	GET	BEG,0
	CALL	CLAUSE-ADD,STACK
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CLAUSE-ADD,WRD,PTR
	GET	P-OCLAUSE,P-MATCHLEN
	ADD	STACK,2 >PTR
	SUB	PTR,1
	PUT	P-OCLAUSE,STACK,WRD
	PUT	P-OCLAUSE,PTR,0
	PUT	P-OCLAUSE,P-MATCHLEN,PTR
	RTRUE	


	.FUNCT	PREP-FIND,PREP,CNT=0,SIZE
	GET	PREPOSITIONS,0
	MUL	STACK,2 >SIZE
?PRG1:	IGRTR?	'CNT,SIZE /FALSE
	GET	PREPOSITIONS,CNT
	EQUAL?	STACK,PREP \?PRG1
	SUB	CNT,1
	GET	PREPOSITIONS,STACK
	RETURN	STACK


	.FUNCT	SYNTAX-FOUND,SYN
	SET	'P-SYNTAX,SYN
	GETB	SYN,P-SACTION >PRSA
	RETURN	PRSA


	.FUNCT	GWIM,GBIT,LBIT,PREP,OBJ
	EQUAL?	GBIT,RMUNGBIT \?CND1
	RETURN	ROOMS
?CND1:	SET	'P-GWIMBIT,GBIT
	SET	'P-SLOCBITS,LBIT
	PUT	P-MERGE,P-MATCHLEN,0
	CALL	GET-OBJECT,P-MERGE,FALSE-VALUE
	ZERO?	STACK /?ELS8
	SET	'P-GWIMBIT,0
	GET	P-MERGE,P-MATCHLEN
	EQUAL?	STACK,1 \FALSE
	GET	P-MERGE,1 >OBJ
	PRINTI	"("
	ZERO?	PREP /?CND16
	CALL	PREP-FIND,PREP
	PRINTB	STACK
	CALL	THE?,OBJ
	PRINTI	" "
?CND16:	FSET?	OBJ,PERSON \?ELS23
	FSET?	OBJ,TOUCHBIT /?ELS23
	GETP	OBJ,P?XDESC
	ZERO?	STACK /?ELS23
	PRINTI	"the "
	GETP	OBJ,P?XDESC
	PRINT	STACK
	PRINTI	")"
	CRLF	
	RETURN	OBJ
?ELS23:	PRINTD	OBJ
	PRINTI	")"
	CRLF	
	RETURN	OBJ
?ELS8:	SET	'P-GWIMBIT,0
	RFALSE	


	.FUNCT	SNARF-OBJECTS,PTR
	GET	P-ITBL,P-NC1 >PTR
	ZERO?	PTR /?CND1
	GETB	P-SYNTAX,P-SLOC1 >P-SLOCBITS
	GET	P-ITBL,P-NC1L
	CALL	SNARFEM,PTR,STACK,P-PRSO
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /?CND1
	CALL	BUT-MERGE,P-PRSO >P-PRSO
?CND1:	GET	P-ITBL,P-NC2 >PTR
	ZERO?	PTR /TRUE
	GETB	P-SYNTAX,P-SLOC2 >P-SLOCBITS
	GET	P-ITBL,P-NC2L
	CALL	SNARFEM,PTR,STACK,P-PRSI
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /TRUE
	GET	P-PRSI,P-MATCHLEN
	EQUAL?	STACK,1 \?ELS18
	CALL	BUT-MERGE,P-PRSO >P-PRSO
	RTRUE	
?ELS18:	CALL	BUT-MERGE,P-PRSI >P-PRSI
	RTRUE	


	.FUNCT	BUT-MERGE,TBL,LEN,BUTLEN,CNT=1,MATCHES=0,OBJ,NTBL
	GET	TBL,P-MATCHLEN >LEN
	PUT	P-MERGE,P-MATCHLEN,0
?PRG1:	DLESS?	'LEN,0 \?ELS5
	JUMP	?REP2
?ELS5:	GET	TBL,CNT >OBJ
	CALL	ZMEMQ,OBJ,P-BUTS
	ZERO?	STACK /?ELS7
	JUMP	?CND3
?ELS7:	ADD	MATCHES,1
	PUT	P-MERGE,STACK,OBJ
	INC	'MATCHES
?CND3:	INC	'CNT
	JUMP	?PRG1
?REP2:	PUT	P-MERGE,P-MATCHLEN,MATCHES
	SET	'NTBL,P-MERGE
	SET	'P-MERGE,TBL
	RETURN	NTBL


	.FUNCT	SNARFEM,PTR,EPTR,TBL,AND=0,BUT=0,LEN,WV,WRD,NW
	SET	'P-GETFLAGS,0
	SET	'P-CSPTR,PTR
	SET	'P-CEPTR,EPTR
	PUT	P-BUTS,P-MATCHLEN,0
	PUT	TBL,P-MATCHLEN,0
	GET	PTR,0 >WRD
?PRG1:	EQUAL?	PTR,EPTR \?ELS5
	ZERO?	BUT /?ORP9
	PUSH	BUT
	JUMP	?THN6
?ORP9:	PUSH	TBL
?THN6:	CALL	GET-OBJECT,STACK
	RETURN	STACK
?ELS5:	GET	PTR,P-LEXELEN >NW
	EQUAL?	WRD,W?BUT,W?EXCEPT \?ELS14
	ZERO?	BUT /?ORP20
	PUSH	BUT
	JUMP	?THN17
?ORP20:	PUSH	TBL
?THN17:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	SET	'BUT,P-BUTS
	PUT	BUT,P-MATCHLEN,0
	JUMP	?CND3
?ELS14:	EQUAL?	WRD,W?A,W?ONE \?ELS22
	ZERO?	P-ADJ \?ELS25
	SET	'P-GETFLAGS,P-ONE
	EQUAL?	NW,W?OF \?CND3
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND3
?ELS25:	SET	'P-NAM,P-ONEOBJ
	ZERO?	BUT /?ORP36
	PUSH	BUT
	JUMP	?THN33
?ORP36:	PUSH	TBL
?THN33:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	ZERO?	NW /TRUE
	JUMP	?CND3
?ELS22:	EQUAL?	WRD,W?AND,W?COMMA \?ELS40
	EQUAL?	NW,W?AND,W?COMMA /?ELS40
	ZERO?	BUT /?ORP48
	PUSH	BUT
	JUMP	?THN45
?ORP48:	PUSH	TBL
?THN45:	CALL	GET-OBJECT,STACK
	ZERO?	STACK \?CND12
	RFALSE	
?ELS40:	CALL	WT?,WRD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS50
	JUMP	?CND3
?ELS50:	EQUAL?	WRD,W?AND,W?COMMA \?ELS52
	JUMP	?CND3
?ELS52:	EQUAL?	WRD,W?OF \?ELS54
	ZERO?	P-GETFLAGS \?CND12
	SET	'P-GETFLAGS,P-INHIBIT
	JUMP	?CND12
?ELS54:	CALL	WT?,WRD,PS?ADJECTIVE,P1?ADJECTIVE >WV
	ZERO?	WV /?ELS59
	ZERO?	P-ADJ \?ELS59
	SET	'P-ADJ,WV
	SET	'P-ADJN,WRD
	JUMP	?CND3
?ELS59:	CALL	WT?,WRD,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?CND3
	SET	'P-NAM,WRD
	SET	'P-ONEOBJ,WRD
?CND12:	
?CND3:	EQUAL?	PTR,EPTR /?PRG1
	ADD	PTR,P-WORDLEN >PTR
	SET	'WRD,NW
	JUMP	?PRG1


	.FUNCT	GET-OBJECT,TBL,VRB=1,BITS,LEN,XBITS,TLEN,GCHECK=0,OLEN=0,OBJ
	SET	'XBITS,P-SLOCBITS
	GET	TBL,P-MATCHLEN >TLEN
	BTST	P-GETFLAGS,P-INHIBIT /TRUE
	ZERO?	P-NAM \?CND4
	ZERO?	P-ADJ /?CND4
	CALL	WT?,P-ADJN,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?CND4
	SET	'P-NAM,P-ADJN
	SET	'P-ADJ,FALSE-VALUE
?CND4:	ZERO?	P-NAM \?CND9
	ZERO?	P-ADJ \?CND9
	EQUAL?	P-GETFLAGS,P-ALL /?CND9
	ZERO?	P-GWIMBIT \?CND9
	ZERO?	VRB /FALSE
	PRINTI	"(I couldn't find enough nouns in that sentence!)"
	CRLF	
	RFALSE	
?CND9:	EQUAL?	P-GETFLAGS,P-ALL \?THN23
	ZERO?	P-SLOCBITS \?CND20
?THN23:	SET	'P-SLOCBITS,-1
?CND20:	SET	'P-TABLE,TBL
?PRG25:	ZERO?	GCHECK /?ELS29
	CALL	GLOBAL-CHECK,TBL
	JUMP	?CND27
?ELS29:	ZERO?	LIT /?CND33
	FCLEAR	PLAYER,TRANSBIT
	CALL	DO-SL,HERE,SOG,SIR
	FSET	PLAYER,TRANSBIT
?CND33:	CALL	DO-SL,PLAYER,SH,SC
?CND27:	GET	TBL,P-MATCHLEN
	SUB	STACK,TLEN >LEN
	BTST	P-GETFLAGS,P-ALL \?ELS39
	JUMP	?CND37
?ELS39:	BTST	P-GETFLAGS,P-ONE \?ELS41
	ZERO?	LEN /?ELS41
	EQUAL?	LEN,1 /?CND44
	RANDOM	LEN
	GET	TBL,STACK
	PUT	TBL,1,STACK
	PRINTI	"(How about the "
	GET	TBL,1
	PRINTD	STACK
	PRINTI	"?)"
	CRLF	
?CND44:	PUT	TBL,P-MATCHLEN,1
	JUMP	?CND37
?ELS41:	GRTR?	LEN,1 /?THN53
	ZERO?	LEN \?ELS52
	EQUAL?	P-SLOCBITS,-1 /?ELS52
?THN53:	EQUAL?	P-SLOCBITS,-1 \?ELS59
	SET	'P-SLOCBITS,XBITS
	SET	'OLEN,LEN
	GET	TBL,P-MATCHLEN
	SUB	STACK,LEN
	PUT	TBL,P-MATCHLEN,STACK
	JUMP	?PRG25
?ELS59:	ZERO?	LEN \?CND62
	SET	'LEN,OLEN
?CND62:	ZERO?	P-NAM /?ELS67
	EQUAL?	PRSA,V?DISEMBARK,V?MAKE /?THN70
	EQUAL?	PRSA,V?SEARCH-OBJECT-FOR,V?SEARCH,V?FIND /?THN70
	EQUAL?	PRSA,V?TAKE,V?ASK-CONTEXT-FOR,V?ASK-FOR /?THN70
	EQUAL?	PRSA,V?SGIVE,V?GIVE,V?WHAT /?THN70
	EQUAL?	PRSA,V?TELL-ME,V?ASK-CONTEXT-ABOUT,V?ASK-ABOUT \?ELS67
?THN70:	ADD	TLEN,1
	GET	TBL,STACK >OBJ
	ZERO?	OBJ /?ELS67
	GETP	OBJ,P?GENERIC
	CALL	STACK,OBJ >OBJ
	ZERO?	OBJ /?ELS67
	EQUAL?	OBJ,NOT-HERE-OBJECT /FALSE
	PUT	TBL,1,OBJ
	PUT	TBL,P-MATCHLEN,1
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	
?ELS67:	ZERO?	VRB /?ELS76
	ZERO?	P-NAM /?ELS76
	CALL	WHICH-PRINT,TLEN,LEN,TBL
	EQUAL?	TBL,P-PRSO \?ELS83
	PUSH	P-NC1
	JUMP	?CND79
?ELS83:	PUSH	P-NC2
?CND79:	SET	'P-ACLAUSE,STACK
	SET	'P-AADJ,P-ADJ
	SET	'P-ANAM,P-NAM
	CALL	ORPHAN,FALSE-VALUE,FALSE-VALUE
	SET	'P-OFLAG,TRUE-VALUE
	JUMP	?CND65
?ELS76:	ZERO?	VRB /?CND65
	PRINTI	"(I couldn't find enough nouns in that sentence!)"
	CRLF	
?CND65:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?ELS52:	ZERO?	LEN \?ELS92
	ZERO?	GCHECK /?ELS92
	ZERO?	VRB /?CND95
	ZERO?	LIT /?ELS101
	CALL	OBJ-FOUND,NOT-HERE-OBJECT,TBL
	SET	'P-XNAM,P-NAM
	SET	'P-XADJ,P-ADJ
	SET	'P-XADJN,P-ADJN
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	SET	'P-ADJN,FALSE-VALUE
	RTRUE	
?ELS101:	PRINTI	"(It's too dark to see!)"
	CRLF	
?CND95:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?ELS92:	ZERO?	LEN \?CND37
	SET	'GCHECK,TRUE-VALUE
	JUMP	?PRG25
?CND37:	SET	'P-SLOCBITS,XBITS
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	


	.FUNCT	MOBY-FIND,TBL,FOO,LEN
	SET	'P-SLOCBITS,-1
	SET	'P-NAM,P-XNAM
	SET	'P-ADJ,P-XADJ
	PUT	TBL,P-MATCHLEN,0
	FIRST?	ROOMS >FOO /?KLU17
?KLU17:	
?PRG1:	ZERO?	FOO \?ELS5
	JUMP	?REP2
?ELS5:	CALL	SEARCH-LIST,FOO,TBL,P-SRCALL
	NEXT?	FOO >FOO /?KLU18
?KLU18:	JUMP	?PRG1
?REP2:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND8
	CALL	DO-SL,LOCAL-GLOBALS,1,1
?CND8:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND11
	CALL	DO-SL,ROOMS,1,1
?CND11:	GET	TBL,P-MATCHLEN >LEN
	EQUAL?	LEN,1 \?CND14
	GET	TBL,1 >P-MOBY-FOUND
	RETURN	LEN
?CND14:	RETURN	LEN


	.FUNCT	WHICH-PRINT,TLEN,LEN,TBL,OBJ,RLEN
	SET	'RLEN,LEN
	PRINTI	"(Which"
	ZERO?	P-OFLAG \?THN6
	ZERO?	P-MERGED /?ELS5
?THN6:	PRINTI	" "
	PRINTB	P-NAM
	JUMP	?CND3
?ELS5:	EQUAL?	TBL,P-PRSO \?ELS11
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L,FALSE-VALUE
	JUMP	?CND3
?ELS11:	CALL	CLAUSE-PRINT,P-NC2,P-NC2L,FALSE-VALUE
?CND3:	PRINTI	" do you mean,"
?PRG16:	INC	'TLEN
	GET	TBL,TLEN >OBJ
	CALL	THE?,OBJ
	PRINTI	" "
	PRINTD	OBJ
	EQUAL?	LEN,2 \?ELS22
	EQUAL?	RLEN,2 /?CND23
	PRINTI	","
?CND23:	PRINTI	" or"
	JUMP	?CND20
?ELS22:	GRTR?	LEN,2 \?CND20
	PRINTI	","
?CND20:	DLESS?	'LEN,1 \?PRG16
	PRINTR	"?)"


	.FUNCT	GLOBAL-CHECK,TBL,LEN,RMG,RMGL,CNT=0,OBJ,OBITS,FOO
	GET	TBL,P-MATCHLEN >LEN
	SET	'OBITS,P-SLOCBITS
	GETPT	HERE,P?GLOBAL >RMG
	ZERO?	RMG /?CND1
	PTSIZE	RMG
	SUB	STACK,1 >RMGL
?PRG4:	GETB	RMG,CNT >OBJ
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND6
	CALL	OBJ-FOUND,OBJ,TBL
?CND6:	IGRTR?	'CNT,RMGL \?PRG4
?CND1:	GETPT	HERE,P?PSEUDO >RMG
	ZERO?	RMG /?CND12
	PTSIZE	RMG
	DIV	STACK,4
	SUB	STACK,1 >RMGL
	SET	'CNT,0
?PRG15:	MUL	CNT,2
	GET	RMG,STACK
	EQUAL?	P-NAM,STACK \?ELS19
	MUL	CNT,2
	ADD	STACK,1
	GET	RMG,STACK
	PUTP	PSEUDO-OBJECT,P?ACTION,STACK
	GETPT	PSEUDO-OBJECT,P?ACTION
	SUB	STACK,5 >FOO
	GET	P-NAM,0
	PUT	FOO,0,STACK
	GET	P-NAM,1
	PUT	FOO,1,STACK
	CALL	OBJ-FOUND,PSEUDO-OBJECT,TBL
	JUMP	?CND12
?ELS19:	IGRTR?	'CNT,RMGL \?PRG15
?CND12:	GET	TBL,P-MATCHLEN
	EQUAL?	STACK,LEN \FALSE
	SET	'P-SLOCBITS,-1
	SET	'P-TABLE,TBL
	CALL	DO-SL,GLOBAL-OBJECTS,1,1
	SET	'P-SLOCBITS,OBITS
	GET	TBL,P-MATCHLEN
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?WALK-TO,V?THROUGH,V?SEARCH-OBJECT-FOR /?THN37
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?DROP /?THN37
	EQUAL?	PRSA,V?FOLLOW,V?FIND,V?EXAMINE \FALSE
?THN37:	CALL	DO-SL,ROOMS,1,1
	RSTACK	


	.FUNCT	DO-SL,OBJ,BIT1,BIT2,BITS
	ADD	BIT1,BIT2
	BTST	P-SLOCBITS,STACK \?ELS5
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCALL
	RSTACK	
?ELS5:	BTST	P-SLOCBITS,BIT1 \?ELS12
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCTOP
	RSTACK	
?ELS12:	BTST	P-SLOCBITS,BIT2 \TRUE
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCBOT
	RSTACK	


	.FUNCT	SEARCH-LIST,OBJ,TBL,LVL,FLS
	FIRST?	OBJ >OBJ \FALSE
?PRG6:	EQUAL?	LVL,P-SRCBOT /?CND8
	GETPT	OBJ,P?SYNONYM
	ZERO?	STACK /?CND8
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND8
	CALL	OBJ-FOUND,OBJ,TBL
?CND8:	EQUAL?	LVL,P-SRCTOP \?THN18
	FSET?	OBJ,SEARCHBIT /?THN18
	FSET?	OBJ,SURFACEBIT \?CND13
?THN18:	FIRST?	OBJ \?CND13
	EQUAL?	OBJ,PLAYER,LOCAL-GLOBALS /?CND13
	FSET?	OBJ,SURFACEBIT \?ELS24
	PUSH	P-SRCALL
	JUMP	?CND20
?ELS24:	FSET?	OBJ,SEARCHBIT \?ELS26
	PUSH	P-SRCALL
	JUMP	?CND20
?ELS26:	PUSH	P-SRCTOP
?CND20:	CALL	SEARCH-LIST,OBJ,TBL,STACK >FLS
?CND13:	NEXT?	OBJ >OBJ /?PRG6
	RTRUE	


	.FUNCT	THIS-IT?,OBJ,TBL,SYNS,?TMP1
	FSET?	OBJ,INVISIBLE /FALSE
	ZERO?	P-NAM /?ELS5
	GETPT	OBJ,P?SYNONYM >SYNS
	PTSIZE	SYNS
	DIV	STACK,2
	SUB	STACK,1
	CALL	ZMEMQ,P-NAM,SYNS,STACK
	ZERO?	STACK /FALSE
?ELS5:	ZERO?	P-ADJ /?ELS9
	GETPT	OBJ,P?ADJECTIVE >SYNS
	ZERO?	SYNS /FALSE
	PTSIZE	SYNS
	SUB	STACK,1
	CALL	ZMEMQB,P-ADJ,SYNS,STACK
	ZERO?	STACK /FALSE
?ELS9:	ZERO?	P-GWIMBIT /TRUE
	FSET?	OBJ,P-GWIMBIT /TRUE
	RFALSE	


	.FUNCT	OBJ-FOUND,OBJ,TBL,PTR
	GET	TBL,P-MATCHLEN >PTR
	ADD	PTR,1
	PUT	TBL,STACK,OBJ
	ADD	PTR,1
	PUT	TBL,P-MATCHLEN,STACK
	RTRUE	


	.FUNCT	TAKE-CHECK
	GETB	P-SYNTAX,P-SLOC1
	CALL	ITAKE-CHECK,P-PRSO,STACK
	ZERO?	STACK /FALSE
	GETB	P-SYNTAX,P-SLOC2
	CALL	ITAKE-CHECK,P-PRSI,STACK
	RSTACK	


	.FUNCT	ITAKE-CHECK,TBL,BITS,PTR,OBJ,TAKEN
	GET	TBL,P-MATCHLEN >PTR
	ZERO?	PTR /TRUE
	BTST	BITS,SHAVE /?THN8
	BTST	BITS,STAKE \TRUE
?THN8:	
?PRG10:	DLESS?	'PTR,0 /TRUE
	ADD	PTR,1
	GET	TBL,STACK >OBJ
	EQUAL?	OBJ,IT \?ELS19
	SET	'OBJ,P-IT-OBJECT
	JUMP	?CND17
?ELS19:	EQUAL?	OBJ,HIM-HER \?CND17
	SET	'OBJ,P-HIM-HER
?CND17:	CALL	HELD?,OBJ
	ZERO?	STACK \?PRG10
	SET	'PRSO,OBJ
	FSET?	OBJ,TRYTAKEBIT \?ELS27
	SET	'TAKEN,TRUE-VALUE
	JUMP	?CND25
?ELS27:	EQUAL?	WINNER,PLAYER /?ELS29
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND25
?ELS29:	BTST	BITS,STAKE \?ELS31
	CALL	ITAKE,FALSE-VALUE
	EQUAL?	STACK,TRUE-VALUE \?ELS31
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND25
?ELS31:	SET	'TAKEN,TRUE-VALUE
?CND25:	ZERO?	TAKEN /?ELS38
	BTST	BITS,SHAVE \?ELS38
	PRINTI	"(You don't have"
	EQUAL?	OBJ,NOT-HERE-OBJECT \?ELS45
	PRINTI	" that!)"
	CRLF	
	RFALSE	
?ELS45:	CALL	THE?,OBJ
	PRINTI	" "
	PRINTD	OBJ
	PRINTI	"!)"
	CRLF	
	RFALSE	
?ELS38:	ZERO?	TAKEN \?PRG10
	EQUAL?	WINNER,PLAYER \?PRG10
	PRINTI	"(taken)"
	CRLF	
	JUMP	?PRG10


	.FUNCT	MANY-CHECK,LOSS=0,TMP,?TMP1
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,1 \?ELS3
	GETB	P-SYNTAX,P-SLOC1
	BTST	STACK,SMANY /?ELS3
	SET	'LOSS,1
	JUMP	?CND1
?ELS3:	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,1 \?CND1
	GETB	P-SYNTAX,P-SLOC2
	BTST	STACK,SMANY /?CND1
	SET	'LOSS,2
?CND1:	ZERO?	LOSS /TRUE
	PRINTI	"(You can't use multiple "
	EQUAL?	LOSS,2 \?CND18
	PRINTI	"in"
?CND18:	PRINTI	"direct objects with """
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS27
	PRINTI	"tell"
	JUMP	?CND25
?ELS27:	ZERO?	P-OFLAG /?ELS31
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND25
?ELS31:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND25:	PRINTI	"""!)"
	CRLF	
	RFALSE	


	.FUNCT	ZMEMQ,ITM,TBL,SIZE=-1,CNT=1
	ZERO?	TBL /FALSE
	LESS?	SIZE,0 /?ELS6
	SET	'CNT,0
	JUMP	?CND4
?ELS6:	GET	TBL,0 >SIZE
?CND4:	
?PRG9:	GET	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG9
	RFALSE	


	.FUNCT	ZMEMQB,ITM,TBL,SIZE,CNT=0
?PRG1:	GETB	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG1
	RFALSE	


	.FUNCT	PRSO-PRINT,PTR
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,0 /?THN6
	ZERO?	P-MERGED \?THN6
	GET	P-ITBL,P-NC1 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?ELS5
?THN6:	PRINTI	" "
	PRINTD	PRSO
	RTRUE	
?ELS5:	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,PTR,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	THE-PRSO-PRINT
	CALL	THE?,PRSO
	CALL	PRSO-PRINT
	RSTACK	


	.FUNCT	PRSI-PRINT,PTR
	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,0 /?THN6
	ZERO?	P-MERGED \?THN6
	GET	P-ITBL,P-NC2 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?ELS5
?THN6:	PRINTI	" "
	PRINTD	PRSI
	RTRUE	
?ELS5:	GET	P-ITBL,P-NC2L
	CALL	BUFFER-PRINT,PTR,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	THE-PRSI-PRINT
	CALL	THE?,PRSI
	CALL	PRSI-PRINT
	RSTACK	

	.ENDI
