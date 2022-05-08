	call &clear_reg; [absolute]
	call &clear_reg; [absolute]
	call &display_welcome; [absolute]
	bCall(GetKey)
	bCall(ClrLCDFull)
	call &label_3; [absolute]
	ld a, (&user_input)
	cp @0x20
	jr nz, %lose; [relative 10]
	call &verify_user_input; [absolute]
	ld a, (&label_7)
	cp @0x20
	jr z, %label_8; [relative 5]

lose:			;9DB8
	call &display_lose; [absolute]
	jr %label_10; [relative 3]

label_8:			;9DBD
	call &win; [absolute]

label_10:			;9DC0
	bCall(GetKey)
	bCall(ClrLCDFull)
	ret

clear_reg:			;9DC7
	ld a, @0x00
	ld b, @0x00
	ld c, @0x00
	ld d, @0x00
	ld e, @0x00
	ld h, @0x00
	ld l, @0x00
	ld ixh, @0x00
	ld ixl, @0x00
	ld (&label_7), a
	exx
	ret

label_77:			;9DE0
	ld a, b ; b = 0x50
	xor @0xC2
	cp (ix+@0x00) ; ix = '4'
	jr nz, %label_13; [relative 3]
	call &verify_step1_lose; [absolute]

label_13:			;9DEB
	inc ix
	xor @0x09
	cp (ix+@0x00) ; ix = 'B'
	jr nz, %label_15; [relative 3]
	call &verify_step1_lose; [absolute]

label_15:			;9DF7
	inc ix
	xor @0x0D
	cp (ix+@0x00) ; ix = '8'
	jr nz, %label_17; [relative 3]
	call &verify_step1_lose; [absolute]

label_17:			;9E03
	inc ix
	xor @0x0A
	cp (ix+@0x00) ; ix = 'C'
	jr nz, %label_19; [relative 3]
	call &verify_step1_lose; [absolute]

label_19:			;9E0F
	inc ix
	xor @0x07
	cp (ix+@0x00) ; ix = 'B'
	jr nz, %label_21; [relative 3]
	call &verify_step1_lose; [absolute]

label_21:			;9E1B
	inc ix
	xor @0x0C
	cp (ix+@0x00) ; ix = '9'
	jr nz, %label_23; [relative 3]
	call &verify_step1_lose; [absolute]
label_23:			;9E27
	inc ix
	xor @0x09
	cp (ix+@0x00) ; ix = 'E'
	jr nz, %label_25; [relative 3]
	call &verify_step1_lose; [absolute]
label_25:			;9E33
	inc ix
	xor @0x10
	cp (ix+@0x00) ; ix = '0'
	jr nz, %label_27; [relative 3]
	call &verify_step1_lose; [absolute]
label_27:			;9E3F
	inc ix
	xor @0x14
	cp (ix+@0x00) ; ix = 'A'
	jr nz, %label_29; [relative 3]
	call &verify_step1_lose; [absolute]
label_29:			;9E4B
	inc ix
	xor @0x07
	cp (ix+@0x00) ; ix = 'D'
	jr nz, %label_31; [relative 3]
	call &verify_step1_lose; [absolute]
label_31:			;9E57
	inc ix
	xor @0x06
	cp (ix+@0x00) ; ix = 'B'
	jr nz, %label_33; [relative 3]
	call &verify_step1_lose; [absolute]
label_33:			;9E63
	inc ix
	xor @0x0E
	cp (ix+@0x00) ; ix = '7'
	jr nz, %label_35; [relative 3]
	call &verify_step1_lose; [absolute]
label_35:			;9E6F
	inc ix
	xor @0x0A
	cp (ix+@0x00) ; ix = 'F'
	jr nz, %label_37; [relative 3]
	call &verify_step1_lose; [absolute]
label_37:			;9E7B
	inc ix
	xor @0x0F
	cp (ix+@0x00) ; ix = '2'
	jr nz, %label_39; [relative 3]
	call &verify_step1_lose; [absolute]
label_39:			;9E87
	inc ix
	xor @0x0B
	cp (ix+@0x00) ; ix = 'B'
	jr nz, %label_41; [relative 3]
	call &verify_step1_lose; [absolute]
label_41:			;9E93
	inc ix
	xor @0x0A
	cp (ix+@0x00) ; ix = '3'
	jr nz, %label_43; [relative 3]
	call &verify_step1_lose; [absolute]
label_43:			;9E9F
	ld b, a
	exx
	ret
label_78:			;9EA2
	exx
	ld a, b
	inc ix
	xor @0x0A
	cp (ix+@0x00) ; ix = 'B'
	jr nz, %label_45; [relative 3]
	call &verify_step1_lose; [absolute]
label_45:			;9EB0
	inc ix
	xor @0x01
	cp (ix+@0x00) ; ix = 'A'
	jr nz, %label_47; [relative 3]
	call &verify_step1_lose; [absolute]
label_47:			;9EBC
	inc ix
	xor @0x08
	cp (ix+@0x00) ; ix = '4'
	jr nz, %label_49; [relative 3]
	call &verify_step1_lose; [absolute]
label_49:			;9EC8
	inc ix
	xor @0x0C
	cp (ix+@0x00) ; ix = 'E'
	jr nz, %label_51; [relative 3]
	call &verify_step1_lose; [absolute]
label_51:			;9ED4
	inc ix
	xor @0x0A
	cp (ix+@0x00) ; ix = '6'
	jr nz, %label_53; [relative 3]
	call &verify_step1_lose; [absolute]
label_53:			;9EE0
	inc ix
	xor @0x08
	cp (ix+@0x00) ; ix = 'C'
	jr nz, %label_55; [relative 3]
	call &verify_step1_lose; [absolute]
label_55:			;9EEC
	inc ix
	xor @0x07
	cp (ix+@0x00) ; ix = 'B'
	jr nz, %label_57; [relative 3]
	call &verify_step1_lose; [absolute]
label_57:			;9EF8
	inc ix
	xor @0x0E
	cp (ix+@0x00) ; ix = '7'
	jr nz, %label_59; [relative 3]
	call &verify_step1_lose; [absolute]
label_59:			;9F04
	inc ix
	xor @0x1A
	cp (ix+@0x00) ; ix = '1'
	jr nz, %label_61; [relative 3]
	call &verify_step1_lose; [absolute]
label_61:			;9F10
	inc ix
	xor @0x1C
	cp (ix+@0x00) ; ix = '5'
	jr nz, %label_63; [relative 3]
	call &verify_step1_lose; [absolute]
label_63:			;9F1C
	inc ix
	xor @0x07
	cp (ix+@0x00) ; ix = '6'
	jr nz, %label_65; [relative 3]
	call &verify_step1_lose; [absolute]
label_65:			;9F28
	inc ix
	xor @0x0B
	cp (ix+@0x00) ; ix = 'F'
	jr nz, %label_67; [relative 3]
	call &verify_step1_lose; [absolute]
label_67:			;9F34
	inc ix
	xor @0x10
	cp (ix+@0x00) ; ix = '1'
	jr nz, %label_69; [relative 3]
	call &verify_step1_lose; [absolute]
label_69:			;9F40
	inc ix
	xor @0x1F
	cp (ix+@0x00) ; ix = '2'
	jr nz, %label_71; [relative 3]
	call &verify_step1_lose; [absolute]
label_71:			;9F4C
	inc ix
	xor @0x02
	cp (ix+@0x00) ; ix = '4'
	jr nz, %label_73; [relative 3]
	call &verify_step1_lose; [absolute]
label_73:			;9F58
	inc ix
	xor @0x03
	cp (ix+@0x00) ; ix = '3'
	jr nz, %label_75; [relative 3]
	call &verify_step1_lose; [absolute]
label_75:			;9F64
	ret
verify_user_input:			;9F65
	ld c, @0x00
	ld ix, 0xA0A1 ; user_input
	inc ix
	ld b, @0x50
	call &label_77; [absolute]
	ld b, @0x50
	call &label_78; [absolute]
	ret
verify_step1_lose:			;9F78
	ld c, a
	ld a, (&label_7)
	inc a
	ld (&label_7), a
	ld a, @0x31
	bCall(PutC)
	ld a, c
	ret
win:			;9F87
	call &clear_display; [absolute]
	ld hl, &label_82
	bCall(PutS)
	bCall(NewLine)
	ld hl, &label_83
	bCall(PutS)
	bCall(NewLine)
	ld hl, &label_84
	bCall(PutS)
	ld c, @0x00
	ld hl, &user_input
	inc hl
label_89:			;9FA8
	ld a, c
	cp @0x20
	jr z, %label_86; [relative 18]
	ld a, (hl)
	cp @0x9A
	jr nc, %label_87; [relative 4]
	sub @0x5E; sub a, *
	jr %label_88; [relative 2]
label_87:			;9FB6
	sub @0x59; sub a, *
label_88:			;9FB8
	bCall(PutC)
	inc c
	inc hl
	jr %label_89; [relative -23]
label_86:			;9FBF
	ld a, @0x7D
	bCall(PutC)
	ret
display_lose:			;9FC5
	call &clear_display; [absolute]
	ld hl, &lose_string
	bCall(PutS)
	ret
label_3:			;9FCF
	call &clear_display; [absolute]
	ld hl, &label_93
	bCall(PutS)
	bCall(NewLine)
	call &get_string; [absolute]
display_welcome:			;9FDE
	call &clear_display; [absolute]
	bCall(NewLine)
	bCall(NewLine)
	ld hl, &label_96
	bCall(PutS)
	bCall(NewLine)
	ld hl, &label_97
	bCall(PutS)
	bCall(NewLine)
	ld hl, &label_98
	bCall(PutS)
	ret
get_string:			;A000
	res 2, (iy+@0x12)
	bCall(DisableApd)
get_string_loop:			;A007
	ld a, (&user_input)
	cp @0x20
	jr z, %get_string_end; [relative 36]
	res 4, (iy+@0x09)
	ei
	bCall(GetKey)
	res 4, (iy+@0x09)
	cp @0x05
	jr z, %get_string_end; [relative 20]
	cp @0xA0
	jr nc, %get_string_loop; [relative -27]
	cp @0x9A
	call nc, &label_103; [absolute]
	cp @0x98
	jr nc, %get_string_loop; [relative -36]
	cp @0x8E
	call nc, &label_105; [absolute]
	jr %get_string_loop; [relative -43]
get_string_end:			;A032
	ret
label_103:			;A033
	ld b, a
	sub @0x59; sub a, *
	bCall(PutC)
	ld hl, &user_input
	ld a, (hl)
	ld e, a
	ld d, @0x00
	add hl, de
	inc hl
	ld (hl), b
	ld a, (&user_input)
	inc a
	ld (&user_input), a
	ret
label_105:			;A04B
	ld b, a
	sub @0x5E; sub a, *
	bCall(PutC)
	ld hl, &user_input
	ld a, (hl)
	ld e, a
	ld d, @0x00
	add hl, de
	inc hl
	ld (hl), b
	ld a, (&user_input)
	inc a
	ld (&user_input), a
	ret
clear_display:			;A063
	push af
	bCall(ClrLCDFull)
	bCall(RunIndicOff)
	ld a, @0x00
	ld (0x844B), a
	ld (0x844C), a
	pop af
	ret
label_96:			;A074
	jr nz, %label_115; [relative 32]
	ld b, d
	ld l, c
	ld h, l
	ld l, (hl)
	halt
	ld h, l
	ld l, (hl)
	ld (hl), l
	ld h, l
	jr nz, %label_116; [relative 97]
	ld (hl), l
	nop
label_97:			;A083
	jr nz, %label_117; [relative 67]
	ld (hl), d
	ld h, c
	ld h, e
	ld l, e
	ld l, l
	ld h, l
	jr nz, %label_118; [relative 84]
label_124:			;A08D
	ld c, c
	dec l
	jr c, %label_119; [relative 51]
	dec hl
	nop
label_98:			;A093
	jr nz, %label_120; [relative 32]
	ld h, h
label_115:			;A096
	ld (hl), l
	jr nz, %label_121; [relative 70]
	ld b, e
	ld d, e
	ld b, e
	jr nz, %label_122; [relative 58]
	dec l
	add hl, hl
	nop
user_input:			;A0A1
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
label_120:			;A0B5
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
label_93:			;A0C2
	jr nz, %label_123; [relative 32]
label_119:			;A0C4
	ld b, l
	ld l, (hl)
	ld (hl), h
	ld (hl), d
label_117:			;A0C8
	sub (hl)
	ld h, l
	jr nz, %label_124; [relative -63]
	jr nc, %label_125; [relative 45]
	ld b, (hl)
	ld e, l
	jr nz, %label_126; [relative 32]
	jr z, %label_127; [relative 51]
	ld (0x6320), a
	ld h, c
label_122:			;A0D8
	ld (hl), d
	ld h, c
	ld h, e
	ld (hl), h
	sub a
	ld (hl), d
	ld h, l
label_121:			;A0DF
	ld (hl), e
	add hl, hl
label_118:			;A0E1
	.db @0x3A
label_116:			;A0E2
	.db @0x00
lose_string:			;A0E3
	.db @0x50
label_123:			;A0E4
	ld h, l
	ld (hl), d
	ld h, h
	ld (hl), l
	jr nz, @0x21; [relative 33]
	nop
label_82:			;A0EB
	ld b, d
	ld (hl), d
	ld h, c
	halt
	ld l, a
	jr nz, @0x21; [relative 33]
label_126:			;A0F2
	nop
label_83:			;A0F3
	ld c, h
	ld h, l
	jr nz, @0x66; [relative 102]
	ld l, h
	ld h, c
	ld h, a
	.db @0x20
label_125:			;A0FB
	.db @0x65
	ld (hl), e
	ld (hl), h
	.db @0x3A
	.db @0x00
label_84:			;A100
	.db @0x46
	ld b, e
	ld d, e
	ld b, e
	ld a, e
	nop
label_7:			;A106
	nop
label_127:			;A107
	nop
	nop
