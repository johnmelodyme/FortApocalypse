
00010 *
00020 * FILE: FORT1.S
00030 *
00040 *
00050 START    SEI
00060          CLD
00070          LDX #Z2.LEN
00080 .3       LDA Z2,X
00090          STA RAM2.STUFF,X
00100          DEX
00110          BNE .3
00120          LDA #%00111110
00130          STA SDMCTL
00140          LDA #$14
00150          STA PRIOR
00160          LDA #%00000011
00170          STA GRACTL
00180 ;        LDA #3
00190          STA SKCTL
00200          LDA /PLAYER
00210          STA PMBASE
00220          LDA /CHR.SET1
00230          STA CHBAS
00240          LDX #0
00250          STX AUDCTL
00260          STX COLOR4
00270          STX TIM6.VAL
00280 *
00290          STX PILOT.SKILL
00300          STX GRAV.SKILL
00310          INX         X=1
00320          STX ELEVATOR.DX
00330          INX         X=2
00340          STX CHOPS
00350          LDA #LINE1
00360          STA VDSLST
00370          LDA /LINE1
00380          STA VDSLST+1
00390          JSR M.START
00400          LDA #TITLE.MODE
00410          STA MODE
00420 *
00430 SET.FONTS
00440 ;        LDA #CHR.SET1
00450 ;        STA ADR1
00460 ;        LDA /CHR.SET1
00470 ;        STA ADR1+1
00480 *
00490 ;1       LDY #0
00500 ;        TYA
00510 ;2       STA (ADR1),Y
00520 ;        INY
00530 ;        BNE .2
00540 ;        INC ADR1+1
00550 ;        LDA ADR1+1
00560 ;        CMP /CHR.SET1+$800
00570 ;        BNE .1
00580 *
00590          LDX #0
00600 .3       LDA FNT1,X
00610          STA CHR.SET1+15,X
00620          LDA FNT1+$100-15,X
00630          STA CHR.SET1+$100,X
00640          LDA FNT1+$200-15,X
00650          STA CHR.SET1+$200,X
00660 *
00670          LDA FNT2,X
00680          STA CHR.SET2+$100+8,X
00690          LDA FNT2+$100-8,X
00700          STA CHR.SET2+$200,X
00710          LDA FNT2+$200-8,X
00720          STA CHR.SET2+$300,X
00730          INX
00740          BNE .3
00750 *
00760          LDX #Z1.LEN
00770 .4       LDA Z1,X
00780          STA RAM1.STUFF,X
00790          DEX
00800          BPL .4
00810 *
00820          LDA #$40
00830          STA NMIEN
00840          CLI
00850 * TITLE
00860 TITLE
00870          LDX #$FF
00880          TXS
00890          LDA #$43
00900          STA COLOR0
00910          LDA #$0F
00920          STA COLOR1
00930          LDA #$83
00940          STA COLOR2
00950          JSR SCREEN.OFF
00960          LDA #DSP.LST3
00970          STA SDLST
00980          LDA /DSP.LST3
00990          STA SDLST+1
01000          LDA #$3B
01010          STA TEMP3
01020          LDY #0
01030          STY TEMP1.I
01040 .1       LDA TEMP3
01050          STA PLAY.SCRN,Y
01060          JSR INC.CHR
01070          INY
01080          CPY #40
01090          BNE .1
01100          LDA #PLAY.SCRN+39
01110          STA ADR1
01120          LDA /PLAY.SCRN+39
01130          STA ADR1+1
01140          LDA #$3B
01150          STA TEMP3
01160          LDX #17
01170          LDY #0
01180 .2       LDA TEMP3
01190          STA (ADR1),Y
01200          INY
01210          JSR INC.CHR
01220          STA (ADR1),Y
01230          DEY
01240          LDA ADR1
01250          CLC
01260          ADC #40
01270          STA ADR1
01280          LDA ADR1+1
01290          ADC #0
01300          STA ADR1+1
01310          DEX
01320          BPL .2
01330 *
01340          LDA #T2
01350          STA VVBLKD
01360          LDA /T2
01370          STA VVBLKD+1
01380 *
01390          LDX #5
01400          STX TEMP1
01410          DEX         X=4
01420          STX TEMP2
01430          LDX #T.1
01440          LDY /T.1
01450          JSR PRINT
01460          INC TEMP1   =6
01470          LDA #6
01480          STA TEMP2
01490          LDX #T.2
01500          LDY /T.2
01510          JSR PRINT
01520          LDA #10
01530          STA TEMP2
01540          LDX #T.3
01550          LDY /T.3
01560          JSR PRINT
01570          LDX #7
01580 .3       LDA T.5,X
01590          STA PLAY.SCRN+426,X
01600          DEX
01610          BPL .3
01620          LDA #4
01630          STA TEMP1
01640          LDA #12
01650          STA TEMP2
01660          LDX #T.4
01670          LDY /T.4
01680          JSR PRINT
01690 *
01700 T1
01710          LDA VCOUNT
01720          ASL
01730          STA WSYNC
01740          STA COLPF3
01750          JMP T1
01760 *
01770 T2
01780          LDA FRAME
01790          AND #3
01800          BNE .1
01810          LDA COLOR2
01820          PHA
01830          LDA COLOR1
01840          STA COLOR2
01850          LDA COLOR0
01860          STA COLOR1
01870          PLA
01880          STA COLOR0
01890 *
01900 .1       LDA FRAME
01910          AND #7
01920          BNE .2
01930          INC TEMP1.I
01940 *
01950 .2       LDA #$AF
01960          STA AUDC1
01970          STA AUDC2
01980          LDA #$FF
01990          SEC
02000          SBC TEMP1.I
02010          STA AUDF1
02020          TAX
02030          DEX
02040          STX AUDF2
02050 *
02060          LDA TEMP1.I
02070          CMP #$F3
02080          BEQ .4
02090          LDX #START.MODE
02100          LDA TRIG0
02110          BEQ .3
02120          LDA CONSOL
02130          CMP #6
02140          BEQ .3
02150          LDX #OPTION.MODE
02160          CMP #7
02170          BNE .3
02180 *
02190          JMP VVBLKD.RET
02200 .3       STX MODE
02210          LDX #0
02220          STX OPT.NUM
02230          INX         X=1
02240 .5       STX DEMO.STATUS
02250          JMP T3
02260 .4       LDX #-1     START DEMO
02270          BNE .5      FORCED
02280 *
02290 INC.CHR
02300          INC TEMP3
02310          LDA TEMP3
02320          CMP #$3E
02330          BNE .1
02340          LDA #$3B
02350 .1       STA TEMP3
02360          RTS
02370 *
02380 T.1
02390  .AT -/FORT/
02400  .AT /  /
02410  .AT -/APOCALYPSE/
02420  .HS FF
02430 T.2
02440  .AT -/BY/
02450  .AT /  /
02460  .AT -/STEVE/
02470  .AT /  /
02480  .AT -/HALES/
02490  .HS FF
02500 T.3
02510  .AT -/COPYRIGHT/
02520  .HS FF
02530 T.4
02540  .AT -/SYNAPSE/
02550  .AT /  /
02560  .AT -/SOFTWARE/
02570  .HS FF
02580 *
02590 T3       SEI
02600          LDA #$A     LASER BLOCK
02610          STA COLOR1
02620          LDA #$94    LASERS,HOUSE
02630          STA COLOR2
02640          LDA #$9A    LETTERS
02650          STA COLOR3
02660          LDA #VERTBLKD
02670          STA VVBLKD
02680          LDA /VERTBLKD
02690          STA VVBLKD+1
02700          JSR SCREEN.OFF
02710 .1       LDA VCOUNT
02720          BNE .1
02730          LDA #$C0
02740          STA NMIEN
02750          CLI
02760 *
02770 MAIN
02780          LDA MODE
02790          CMP #GO.MODE
02800          BEQ .2
02810          LDA FRAME
02820 .1       CMP FRAME
02830          BEQ .1
02840 .2
02850 *
02860          LDA MODE
02870          CMP #GO.MODE
02880          BNE .6
02890          JSR MOVE.PODS
02900          JSR MOVE.TANKS
02910          JSR MOVE.CRUISE.MISSILES
02920          JSR MOVE.SLAVES
02930          JSR SET.SCANNER
02940          JSR CHECK.FUEL.BASE
02950          JSR CHECK.FORT
02960          JSR CHECK.LEVEL
02970 *
02980 .6       JSR CHECK.HYPER.CHAMBER
02990          JSR CHECK.MODES
03000          JSR READ.USER
03010 *
03020          LDA DEMO.STATUS
03030          BPL .3
03040          INC DEMO.STATUS   =0
03050          LDA #START.MODE
03060          STA MODE
03070 *
03080 .3       LDA MODE
03090          CMP #TITLE.MODE
03100          BEQ .5
03110          CMP #OPTION.MODE
03120          BNE .4
03130 .5       LDA FRAME
03140          AND #%00000100
03150          BEQ .4
03160          DEC TIM6.VAL
03170          BNE .4
03180          JMP TITLE
03190 *
03200 .4       JMP MAIN
03210 *
03220 CHECK.LEVEL
03230          LDA LEVEL
03240 ;        CMP #0
03250          BEQ DO.LEVEL.1
03260          CMP #1
03270          BNE .1
03280          JMP DO.LEVEL.2
03290 .1       JMP DO.LEVEL.3
03300 .2       RTS
03310 *
03320 DO.LEVEL.1
03330          LDA CHOPPER.STATUS
03340          CMP #LAND
03350          BNE .1
03360          LDA CHOP.Y
03370          CMP #35
03380          BLT .1
03390          LDA CHOP.X
03400          CMP #130
03410          BLT .1
03420          CMP #130+6+1
03430          BGE .1
03440          LDA SLAVES.LEFT
03450          BNE PSL
03460          INC LEVEL   =1
03470          JSR GIVE.BONUS
03480          JSR CLEAR.INFO
03490          JSR CLEAR.SOUNDS
03500          LDA #STOP.MODE
03510          STA MODE
03520          LDA #130
03530          STA TEMP1
03540          LDA #40
03550          STA TEMP2
03560          JSR COMPUTE.MAP.ADR
03570          LDA ADR1
03580          STA TEMP3
03590          LDA ADR1+1
03600          STA TEMP4
03610          LDA #3
03620          STA TEMP2
03630 .2       JSR MOVE.RAMP
03640          LDY #5
03650 .3       LDX #5
03660          JSR WAIT.FRAME
03670          JSR HOVER
03680          INC CHOPPER.Y
03690          DEY
03700          BPL .3
03710          LDA TEMP3
03720          STA ADR1
03730          LDA TEMP4
03740          STA ADR1+1
03750          DEC TEMP2
03760          BNE .2
03770          DEC MAIN+32         PROT
03780          LDA #NEW.LEVEL.MODE
03790          STA MODE
03800 .1       RTS
03810 *
03820 PSL      JMP PRINT.SLAVES.LEFT
03830 *
03840 MOVE.RAMP
03850          LDX #4
03860 .1       LDA ADR1
03870          STA ADR2
03880          LDY ADR1+1
03890          DEY
03900          STY ADR2+1
03910          LDY #5
03920 .2       LDA (ADR2),Y
03930          STA (ADR1),Y
03940          DEY
03950          BPL .2
03960          DEC ADR1+1
03970          DEX
03980          BPL .1
03990          RTS
04000 *
04010 DO.LEVEL.2
04020          LDA FORT.STATUS
04030          CMP #OFF
04040          BNE .1
04050          LDA CHOP.Y
04060          CMP #2
04070          BGE .1
04080          LDA CHOP.X
04090          CMP #130
04100          BLT .1
04110          CMP #130+4+1
04120          BGE .1
04130          LDA SLAVES.LEFT
04140          BNE PSL
04150          INC LEVEL   =2
04160          JSR GIVE.BONUS
04170          ASL M.NEW.PLAYER    PROT
04180          LDA #NEW.LEVEL.MODE
04190          STA MODE
04200 .1       RTS
04210 *
04220 DO.LEVEL.3
04230          LDA CHOPPER.STATUS
04240          CMP #LAND
04250          BNE .1
04260          LDA CHOP.Y
04270          CMP #13
04280          BGE .1
04290          LDA CHOP.X
04300          CMP #$17
04310          BLT .1
04320          CMP #$F4
04330          BGE .1
04340          JSR GIVE.BONUS
04350          INC LEVEL   =3
04360          DEC M.GAME.OVER
04370          LDA #GAME.OVER.MODE
04380          STA MODE
04390 .1       RTS
04400 *
04410 UNPACK
04420 .0       JSR GET.BYTE
04430          LDY #0
04440          LDX TEMP4
04450          BNE .10
04460 .1       CMP CHR1,Y
04470          BEQ .2
04480          INY
04490          CPY #CHR1.L
04500          BNE .1
04510 .9       LDX #1
04520          BNE .3      FORCED
04530 .10      CMP CHR2,Y
04540          BEQ .2
04550          INY
04560          CPY #CHR2.L
04570          BNE .10
04580          BEQ .9      FORCED
04590 .2       STA TEMP1
04600          JSR GET.BYTE
04610          TAX
04620          LDA TEMP1
04630 .3       LDY #0
04640          STA (ADR2),Y
04650          INC ADR2
04660          BNE .4
04670          INC ADR2+1
04680 .4       DEX
04690          BNE .3
04700          LDA ADR2
04710          CMP TEMP2
04720          LDA ADR2+1
04730          SBC TEMP3
04740          BCC .0
04750          RTS
04760 *
04770 GET.BYTE
04780          LDY #0
04790          LDA (ADR1),Y
04800          INC ADR1
04810          BNE .1
04820          INC ADR1+1
04830 .1       RTS
04840 *
04850 CHR1
04860  .AT " a./01*+,-#'?st"
04870  .HS 41444858595AD8
04880  .DA #$47+128
04890 CHR1.L .EQ *-CHR1
04900 *
04910 CHR2
04920  .HS 0055AAFF
04930 CHR2.L .EQ *-CHR2
04940 *
04950 PACK.ADR
04960 * LEVEL.1
04970  .DA PACKED.MAP+$000
04980 * LEVEL.2
04990  .DA PACKED.MAP+$62B
05000 * LEVEL.1
05010  .DA PACKED.MAP+$000
05020 *
05030 CHECK.MODES
05040          LDA MODE
05050 .1       CMP #START.MODE
05060          BNE .2
05070          JMP M.START
05080 .2       CMP #GAME.OVER.MODE
05090          BNE .3
05100          JMP M.GAME.OVER
05110 .3       CMP #NEW.LEVEL.MODE
05120          BNE .4
05130          JMP M.NEW.LEVEL
05140 .4       CMP #NEW.PLAYER.MODE
05150          BNE .30
05160          JMP M.NEW.PLAYER
05170 *
05180 .30      ROL CHECK.MODES     PROT
05190          RTS
05200 *
05210 M.START
05220          JSR SCREEN.OFF
05230          LDX #0
05240          STX LEVEL
05250          STX SCORE1
05260          STX SCORE2
05270          STX SCORE3
05280          STX BONUS1
05290          STX BONUS2
05300          STX TIM1.VAL
05310          STX FUEL1
05320          STX FUEL2
05330          STX GAME.POINTS
05340          STX SLAVES.SAVED
05350          INX         X=1
05360          STX ELEVATOR.TIM
05370          STX TANK.SPD
05380          STX MISSILE.SPD
05390          LDA #128
05400          STA TIM2.VAL
05410          LDA #ON
05420          STA FORT.STATUS
05430          STA LASER.STATUS
05440          LDA #EMPTY
05450          STA FUEL.STATUS
05460          LDA #OFF
05470          STA R.STATUS
05480          LDX GRAV.SKILL
05490          LDA GRAV.TAB,X
05500          STA GRAV.SKL
05510          LDX CHOPS
05520          LDA CHOP.TAB,X
05530          LDY DEMO.STATUS
05540 ;        CPY #0      ON
05550          BNE .0
05560          LDA #2
05570 .0       STA MAIN            PROT
05580          STA CHOP.LEFT
05590          LDX PILOT.SKILL
05600          LDA LASER.TAB,X
05610          STA LASER.SPD
05620          LDA POD.TAB,X
05630          STA START.PODS
05640          LDA ROBOT.TAB,X
05650          STA ROBOT.SPD
05660          LDA TANK.TAB,X
05670          STA TANK.SPEED
05680          LDA MISSILE.TAB,X
05690          STA MISSILE.SPEED
05700          LDA ELEVATOR.TAB,X
05710          STA ELEVATOR.SPD
05720          LDX #7
05730          LDA #0
05740 .1       STA WINDOW.1,X
05750          STA WINDOW.2,X
05760          DEX
05770          BPL .1
05780          LDX #7
05790          LDA #$55
05800          LDY RANDOM
05810          BMI .3
05820 .2       STA WINDOW.1,X
05830          DEX
05840          BPL .2
05850          BMI .4      FORCED
05860 .3       STA WINDOW.2,X
05870          DEX
05880          BPL .3
05890 .4       LDA #NEW.LEVEL.MODE
05900          STA MODE
05910          RTS
05920 *
05930 GRAV.TAB
05940  .DA #$F,#7
05950 ROBOT.TAB
05960  .DA #3,#1,#0
05970 CHOP.TAB
05980  .DA #$7,#$9,#$11
05990 LASER.TAB
06000  .DA #4,#8,#16
06010 POD.TAB
06020  .DA #13-1,#26-1,#MAX.PODS-1
06030 TANK.TAB
06040  .DA #4
06050 MISSILE.TAB
06060  .DA #3,#2,#1
06070 ELEVATOR.TAB
06080  .DA #37+25,#37+10,#37+0
06090 *
06100 M.NEW.PLAYER
06110          JSR SCREEN.OFF
06120          SED
06130          LDA CHOP.LEFT
06140          SEC
06150          SBC #1
06160          STA CHOP.LEFT
06170          CLD
06180 ;        LDA CHOP.LEFT
06190          CMP #$99
06200          BNE .1
06210          LDA #GAME.OVER.MODE
06220          STA MODE
06230          RTS
06240 *
06250 .1       LDA #$1F    CHOPPER CLR
06260          STA PCOLR0
06270          STA PCOLR1
06280          LDA FUEL.STATUS
06290          CMP #EMPTY
06300          BNE .10
06310          DEC UPDATE.CHOPPER  PROT
06320          LDA #FULL
06330          STA FUEL.STATUS
06340          LDX #0
06350          STX FUEL1
06360          INX         X=1
06370          STX FUEL2
06380 .10      LDA #4
06390          STA TEMP1
06400          LDA #8
06410          STA TEMP2
06420          LDX #NEW.PILOT
06430          LDY /NEW.PILOT
06440          JSR PRINT
06450          LDA #5
06460          STA TEMP1
06470          LDA #10
06480          STA TEMP2
06490          LDX #PILOTS.LEFT
06500          LDY /PILOTS.LEFT
06510          JSR PRINT
06520          LDA #PLAY.SCRN+428
06530          STA S.ADR
06540          LDA /PLAY.SCRN+428
06550          STA S.ADR+1
06560          LDX #0
06570          STX S.FLG
06580          STX DEMO.COUNT
06590          INX         X=1
06600          LDA CHOP.LEFT
06610          JSR DDIG
06620 *
06630          JSR DO.CHECKSUM2
06640          LDX #75
06650          JSR WAIT.FRAME
06660 *
06670          LDA LAND.X
06680          STA SX
06690          LDA LAND.Y
06700          STA SY
06710          LDA LAND.FX
06720          STA SX.F
06730          LDA LAND.FY
06740          STA SY.F
06750          LDA LAND.CHOP.X
06760          STA CHOPPER.X
06770          LDA LAND.CHOP.Y
06780          STA CHOPPER.Y
06790          LDA LAND.CHOP.ANGLE
06800          STA CHOPPER.ANGLE
06810          LDA #0
06820          STA CHOPPER.COL
06830          JSR SCREEN.ON
06840          LDA #BEGIN
06850          STA CHOPPER.STATUS
06860          LDA #GO.MODE
06870          STA MODE
06880          RTS
06890 *
06900 NEW.PILOT
06910  .AT -/GET/
06920  .AT /  /
06930  .AT -/READY/
06940  .AT /  /
06950  .AT -/PILOT/
06960  .HS FF
06970 PILOTS.LEFT
06980  .AT -/PILOTS/
06990  .AT /  /
07000  .AT -/LEFT/
07010  .HS FF
07020 *
07030 M.NEW.LEVEL
07040          JSR SCREEN.OFF
07050          LDA #12
07060          STA TEMP1
07070          LDA #6
07080          STA TEMP2
07090          LDX #ENTER
07100          LDY /ENTER
07110          JSR PRINT
07120          LDA #2
07130          STA TEMP1
07140          LDA #8
07150          STA TEMP2
07160          LDY LEVEL
07170          DEY         Y=0
07180          BEQ .0
07190 .5       LDX #LVL.1
07200          LDY /LVL.1
07210          JSR PRINT
07220          JMP .1
07230 .0       LDX #LVL.2
07240          LDY /LVL.2
07250          JSR PRINT
07260 .1       LDX LEVEL
07270          LDA LEVEL.COLOR,X
07280          STA BAK.COLOR
07290          STA COLOR0
07300          TXA
07310          ASL
07320          TAX
07330          LDA LEVEL.START,X
07340          STA SX
07350          LDA LEVEL.START+1,X
07360          STA SY
07370          LDA LEVEL.CHOP.START,X
07380          STA CHOPPER.X
07390          LDA LEVEL.CHOP.START+1,X
07400          STA CHOPPER.Y
07410          LDA #0
07420          STA SX.F
07430          LDY LEVEL
07440          CPY #2
07450          BEQ .4
07460          LDA #7
07470 .4       STA SY.F
07480          LDA #8
07490          STA CHOPPER.ANGLE
07500          JSR SAVE.POS
07510          JSR DO.CHECKSUM3
07520          LDA #$99
07530          STA BONUS1
07540          STA BONUS2
07550 *
07560          LDX #MAX.TANKS-1
07570 .2       LDY LEVEL
07580          DEY
07590          BEQ .91
07600          LDA TANK.START.X.L1,X
07610          STA TANK.START.X,X
07620          LDA TANK.START.Y.L1,X
07630          BNE .92     FORCED
07640 .91      LDA TANK.START.X.L2,X
07650          STA TANK.START.X,X
07660          LDA TANK.START.Y.L2,X
07670 .92      STA TANK.START.Y,X
07680          LDA #BEGIN
07690          STA TANK.STATUS,X
07700          LDA #OFF
07710          STA CM.STATUS,X
07720          DEX
07730          BPL .2
07740 *
07750 ;        LDA #OFF
07760          STA R.STATUS
07770 *
07780          LDX #MAX.PODS-1
07790 ;        LDA #OFF
07800 .6       STA POD.STATUS,X
07810          DEX
07820          BPL .6
07830          LDX START.PODS
07840          LDA #BEGIN
07850 .7       STA POD.STATUS,X
07860          DEX
07870          BPL .7
07880          LDA #0
07890          STA POD.NUM
07900          STA SLAVE.NUM
07910 *
07920          LDA LEVEL
07930          ASL
07940          TAX
07950          LDA PACK.ADR,X
07960          STA ADR1
07970          LDA PACK.ADR+1,X
07980          STA ADR1+1
07990          LDA #MAP
08000          STA ADR2
08010          LDA /MAP
08020          STA ADR2+1
08030          LDA #MAP+$2800
08040          STA TEMP2
08050          LDA /MAP+$2800
08060          STA TEMP3
08070          LDA #0
08080          STA TEMP4
08090          JSR UNPACK
08100 *
08110 MAKE.CONTURE
08120          LDA #MAP
08130          STA ADR1
08140          LDA /MAP
08150          STA ADR1+1
08160          LDY #0
08170 .1       LDA (ADR1),Y
08180          CMP #$73    's'
08190          BNE .3
08200 .2       LDA RANDOM
08210          AND #3
08220 ;        CMP #0
08230          BEQ .2
08240          CLC
08250          ADC #$62-1
08260          BNE .5      FORCED
08270 .3       CMP #$74    't'
08280          BNE .5
08290 .4       LDA RANDOM
08300          AND #3
08310 ;        CMP #0
08320          BEQ .4
08330          CLC
08340          ADC #$65-1
08350 .5       STA (ADR1),Y
08360          INY
08370          BNE .1
08380          INC ADR1+1
08390          LDA ADR1+1
08400          CMP /MAP+$2800
08410          BNE .1
08420 *
08430          LDA #MAP
08440          STA ADR1
08450          LDA /MAP
08460          STA ADR1+1
08470          LDA #MAP+255-40
08480          STA ADR2
08490          LDA /MAP+255-40
08500          STA ADR2+1
08510          LDX #0
08520 .6       LDY #0
08530 .7       LDA (ADR1),Y
08540          STA (ADR2),Y
08550          INY
08560          CPY #40
08570          BNE .7
08580          INC ADR1+1
08590          INC ADR2+1
08600          INX
08610          CPX #40
08620          BNE .6
08630 *
08640          LDY LEVEL
08650          CPY #2
08660          BNE .71
08670 *
08680          LDA #$7E
08690          STA TEMP1
08700          LDA #$13
08710          STA TEMP2
08720          JSR COMPUTE.MAP.ADR
08730          LDX #2
08740 .69      LDY #$D
08750          LDA #0
08760 .70      STA (ADR1),Y
08770          DEY
08780          BPL .70
08790          INC ADR1+1
08800          DEX
08810          BPL .69
08820 .71
08830 *
08840          LDA LEVEL
08850          ASL
08860          TAX
08870          LDA SCAN.INFO,X
08880          STA ADR1
08890          LDA SCAN.INFO+1,X
08900          STA ADR1+1
08910          LDA #SCANNER
08920          STA ADR2
08930          LDA /SCANNER
08940          STA ADR2+1
08950          LDA #SCANNER+1600
08960          STA TEMP2
08970          LDA /SCANNER+1600
08980          STA TEMP3
08990          LDA #1
09000          STA TEMP4
09010          JSR UNPACK
09020 *
09030          LDA #SCANNER
09040          STA ADR1
09050          LDA /SCANNER
09060          STA ADR1+1
09070          LDA #SCANNER+$1B
09080          STA ADR2
09090          LDA /SCANNER+$1B
09100          STA ADR2+1
09110          LDX #39
09120 .50      LDY #12
09130 .51      LDA (ADR1),Y
09140          STA (ADR2),Y
09150          DEY
09160          BPL .51
09170          LDA ADR1
09180          CLC
09190          ADC #40
09200          STA ADR1
09210          BCC .52
09220          INC ADR1+1
09230 .52      LDA ADR2
09240          CLC
09250          ADC #40
09260          STA ADR2
09270          BCC .53
09280          INC ADR2+1
09290 .53      DEX
09300          BPL .50
09310          INC MAIN            PROT
09320 *
09330 S.BEGIN
09340          LDX #8
09350          STX SLAVES.LEFT
09360          DEX         X=7
09370          LDA #OFF
09380 .1       STA SLAVE.STATUS,X
09390          DEX
09400          BPL .1
09410          LDA LEVEL
09420          CMP #2
09430          BEQ .12
09440          LDX #7
09450 .9       LDA #MAP
09460          STA ADR1
09470          LDA /MAP
09480          STA ADR1+1
09490 *
09500          LDY #0
09510 .10      LDA (ADR1),Y
09520          CMP #$48    '^H'
09530          BNE .11
09540          INY
09550          LDA (ADR1),Y
09560          DEY
09570          CMP #$48
09580          BNE .11
09590          DEC ADR1+1
09600          LDA (ADR1),Y
09610          INC ADR1+1
09620          CMP #$1F    '?'
09630          BNE .11
09640          LDA RANDOM
09650          CMP #10
09660          BLT .11
09670          CMP #50
09680          BGE .11
09690          TYA
09700          CLC
09710          ADC #5
09720          STA SLAVE.X,X
09730          LDA ADR1+1
09740          SEC
09750          SBC /MAP
09760          STA SLAVE.Y,X
09770          LDA #1
09780          STA (ADR1),Y
09790          LDA #ON
09800          STA SLAVE.STATUS,X
09810          LDA #$10
09820          STA SLAVE.DX,X
09830          DEX
09840          BMI .12
09850 .11      INY
09860          BNE .10
09870          INC ADR1+1
09880          LDA ADR1+1
09890          CMP /MAP+$2800
09900          BNE .10
09910          TXA
09920          BPL .9
09930 *
09940 .12
09950          LDA #NEW.PLAYER.MODE
09960          STA MODE
09970          RTS
09980 *
09990 LEVEL.COLOR
10000  .HS 42
10010  .HS C2
10020  .HS 42
10030 LEVEL.CHOP.START
10040  .DA #90,#100
10050  .DA #119,#100
10060  .DA #116,#170
10070 LEVEL.START
10080  .HS 02FF
10090  .HS 6DFF
10100  .HS 6E18
10110 SCAN.INFO
10120  .DA PACKED.SCAN+0     LVL 1
10130  .DA PACKED.SCAN+$1E9  LVL 2
10140  .DA PACKED.SCAN+0     LVL 1
10150 TANK.START.X.L1
10160  .HS 536390A059AE
10170 TANK.START.Y.L1
10180  .HS 121212122626
10190 TANK.START.X.L2
10200  .HS 5065A0B53D54
10210 TANK.START.Y.L2
10220  .HS 0C0C0C0C2626
10230 *
10240 ENTER
10250  .AT -/ENTERING/
10260  .HS FF
10270 LVL.1
10280  .AT -/VAULTS/
10290  .AT /  /
10300  .AT -/OF/
10310  .AT /  /
10320  .AT -/DRACONIS/
10330  .HS FF
10340 LVL.2
10350  .AT -/CRYSTALLINE/
10360  .AT /  /
10370  .AT -/CAVES/
10380  .HS FF
10390 *
10400 INC.GAME.POINTS
10410          CLC
10420          ADC GAME.POINTS
10430          STA GAME.POINTS
10440          RTS
10450 *
10460 M.TAB
10470  .DA #-2,#-1,#0
10480 *
10490 M.GAME.OVER
10500          JSR SCREEN.OFF
10510 *
10520          LDA SLAVES.SAVED
10530          LSR
10540          LSR
10550          JSR INC.GAME.POINTS
10560          LDA FORT.STATUS
10570          CMP #OFF
10580          BNE .1
10590          LDA #3
10600          JSR INC.GAME.POINTS
10610 .1       LDA LEVEL
10620          CMP #3
10630          BNE .2
10640          INC GAME.POINTS
10650 .2       JSR INC.GAME.POINTS
10660          LDA SCORE3
10670          JSR INC.GAME.POINTS
10680 *
10690          LDX GRAV.SKILL
10700          LDA M.TAB,X
10710          JSR INC.GAME.POINTS
10720          LDA #2
10730          CLC
10740          SBC CHOPS
10750          EOR #-1
10760          JSR INC.GAME.POINTS
10770          LDX PILOT.SKILL
10780          LDA M.TAB,X
10790          JSR INC.GAME.POINTS
10800 *
10810          LDA GAME.POINTS
10820          BPL .3
10830          LDA #0
10840 .3       CMP #16
10850          BLT .4
10860          LDA #15
10870 .4       STA GAME.POINTS
10880 *
10890          LDA SCORE3
10900          CMP HI3
10910          BNE .51
10920          LDA SCORE2
10930          CMP HI2
10940          BNE .51
10950          LDA SCORE1
10960          CMP HI1
10970          BLT .52
10980 .53      LDA SCORE1
10990          STA HI1
11000          LDA SCORE2
11010          STA HI2
11020          LDA SCORE3
11030          STA HI3
11040          JMP .52
11050 .51      BGE .53
11060 *
11070 .52      LDA #2
11080          STA TEMP1
11090          LDA #0
11100          STA TEMP2
11110          STA S.FLG
11120          LDX #HS
11130          LDY /HS
11140          JSR PRINT
11150          LDA #PLAY.SCRN+24
11160          STA S.ADR
11170          LDA /PLAY.SCRN+24
11180          STA S.ADR+1
11190          LDX #5
11200          LDA HI3
11210          JSR DDIG
11220          LDA HI2
11230          JSR DDIG
11240          LDA HI1
11250          JSR DDIG
11260 *
11270          LDA #3
11280          STA TEMP1
11290          LDA #5
11300          STA TEMP2
11310          LDX #G.1    YOUR
11320          LDY /G.1    MISSION
11330          JSR PRINT
11340          LDA #21
11350          STA TEMP1
11360          LDX #G.A    ABORTED
11370          LDY /G.A
11380          LDA LEVEL
11390          CMP #3
11400          BNE .5
11410          LDX #G.C    COMPLETED
11420          LDY /G.C
11430 .5       JSR PRINT
11440 *
11450          LDX #7
11460          STX TEMP1
11470          INX         X=8
11480          STX TEMP2
11490          LDX #G.2    YOUR
11500          LDY /G.2    RANK
11510          JSR PRINT
11520          LDA #21
11530          STA TEMP1
11540          LDA #10
11550          STA TEMP2
11560          LDX #G.3    CLASS
11570          LDY /G.3
11580          JSR PRINT
11590          LDA GAME.POINTS
11600          AND #3
11610          EOR #3
11620          CLC
11630          ADC #1
11640          LDY #12
11650          ORA #$10+$80
11660          STA (ADR1),Y
11670          CMP #$10+128
11680          BNE .6
11690          LDA #$A+128
11700 .6       INY
11710          AND #$8F
11720          STA (ADR1),Y
11730          LDA #3
11740          STA TEMP1
11750          LDA GAME.POINTS
11760          LSR
11770          LSR
11780          AND #3
11790          ASL
11800          TAY
11810          LDX RATING,Y
11820          LDA RATING+1,Y
11830          TAY
11840          JSR PRINT
11850          LDA #-1
11860          STA TIM6.VAL
11870          ROR SCREEN.OFF      PROT
11880          LDA #TITLE.MODE
11890          STA MODE
11900 ;        LDA #1
11910          STA DEMO.STATUS
11920          RTS
11930 *
11940 G.1
11950  .AT /MISSION/
11960  .HS FF
11970 G.A
11980  .AT /ABORTED/
11990  .HS FF
12000 G.C
12010  .AT /COMPLETED/
12020  .HS FF
12030 G.2
12040  .AT /YOUR  RANK  IS/
12050  .HS FF
12060 G.3
12070  .AT -/CLASS/
12080  .HS FF
12090 RATING
12100  .DA R.1,R.2,R.3,R.4
12110 R.1
12120  .AT -/SPARROW/
12130  .HS FF
12140 R.2
12150  .AT -/CONDOR/
12160  .HS FF
12170 R.3
12180  .AT -/HAWK/
12190  .HS FF
12200 R.4
12210  .AT -/EAGLE/
12220  .HS FF
12230 HS
12240  .AT -/HIGH/
12250  .AT /  /
12260  .AT -/SCORE/
12270  .HS FF
12280 *
12290 * EOF
12300 *
