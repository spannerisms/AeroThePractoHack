lorom

arch 65816

;===================================================================================================

; mess up signature so that the real cart reinitializes 100% of the time
; ZERO!!
org $83FE9D : db "Z"

;===================================================================================================

; infinite lives
org $80879F : db $00

;===================================================================================================

; auto enable cheats
org $83FEE2
	STX.w $02DE
	DEX
	STX.w $02D9
	STX.w $02DC
	DEX

org $8088AA : LDX.b #$02 : NOP
org $848BEB : LDX.b #$02 : NOP

;===================================================================================================

; Make the timer count upwards from 00:00
org $808A4C
	STZ.w $0CC0

org $83F16F
	NOP : NOP

org $83F1A0
CountUpTimer:
	NOP : NOP

	SEP #$20

	SED
	LDA.w $0CC0
	CLC
	ADC.b #$01
	STA.w $0CC0

	CLD
	CMP.b #$60
	BNE ++

	LDA.b #$00
	STA.w $0CC0

	SED
	LDA.w $0CC1
	CLC
	ADC.b #$01
	STA.w $0CC1

	CLD

++	REP #$20

;===================================================================================================

; move hud numbers

; NMI DMA
org $00D324 : LDA.w #$302D
org $00D32A : LDA.w #$5317
org $00D330 : LDA.w #$0010
org $00D339 : LDA.w #$306D
org $00D33F : LDA.w #$5337
org $00D345 : LDA.w #$0010

; number positions
org $83F1C8 : STA.l $7E3033-6
org $83F1CC : STA.l $7E3073-6
org $83F1E2 : STA.l $7E3033-6
org $83F1EA : STA.l $7E3073-6
org $83F1FE : STA.l $7E3035-6
org $83F206 : STA.l $7E3075-6
org $83F20D : STA.l $7E3037-6
org $83F214 : STA.l $7E3077-6
org $83F226 : STA.l $7E3037-6
org $83F22A : STA.l $7E3077-6
org $83F23E : STA.l $7E3039-6
org $83F246 : STA.l $7E3079-6
org $83F25A : STA.l $7E303B-6
org $83F262 : STA.l $7E307B-6

;===================================================================================================

; add frame counter
org $83F266 : JSR AddFrameCounter

org $83FF60
AddFrameCounter:
	LDA.w #$2094 : STA.l $7E3037
	LDA.w #$2497 : STA.l $7E3077

	SEP #$10

	LDX.w $0CC2

	LDA.l .bcd_digits,X
	AND.w #$000F
	ASL
	ADC.w #$2080
	STA.l $7E303B

	INC
	ORA.w #$0400
	STA.l $7E307B

	LDA.l .bcd_digits,X
	AND.w #$00F0
	LSR : LSR : LSR

	ADC.w #$2080
	STA.l $7E3039

	INC
	ORA.w #$0400
	STA.l $7E3079

	REP #$10

	JMP.w $83F316

.bcd_digits
	db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09
	db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19
	db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29
	db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39
	db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49
	db $50, $51, $52, $53, $54, $55, $56, $57, $58, $59
