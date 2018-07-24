#	1651077 - Diep Gia Han
#	1651034	- Huynh Ha Mai Trinh
.data	
	array:	.word	0:1000
	n:	.word	0
	sp:	.byte	' '
	str1:	.space	11000
	str2:	.space	11000
	fin:	.asciiz	"input.txt"
	fout:	.asciiz "output.txt"
.macro	input_n
	la	$s0, str1
	li	$t1, 0
	li	$t2, 10
loop:	lb	$t0, ($s0)
	addi	$s0, $s0, 1
	beq	$t0, '\n', fin
	mul	$t1, $t1, $t2
	addi	$t0, $t0, -48
	add	$t1, $t1, $t0
	j	loop
fin:	sw	$t1, n
.end_macro

.macro	input_array
	move	$t9, $s0 # !!!
	la	$s1, array
	li	$t1, 0
	li	$t2, 10
loop:	lb	$t0, ($s0)
	addi	$s0, $s0, 1
	beq	$t0, 32, store
	beq	$t0, 0, fin
	mul	$t1, $t1, $t2
	addi	$t0, $t0, -48
	add	$t1, $t1, $t0
	j	loop
store:	sw	$t1, ($s1)
	addi	$s1, $s1, 4
	li	$t1, 0
	j	loop
fin:	sw	$t1, ($s1)
	sub	$t9, $s0, $t9 # !!!
.end_macro

.macro	input
open:	li	$v0, 13
	la	$a0, fin
	li	$a1, 0
	li	$a2, 0
	syscall
	bltz	$v0, openError
	move	$s0, $v0
read:	li	$v0, 14
	move	$a0, $s0
	la	$a1, str1
	li	$a2, 11000
	syscall             
	bltz	$v0, readError
close:	li	$v0, 16
	move	$a0, $s0
	syscall
	input_n
	input_array
.end_macro

.macro	output_str
	lw	$t3, n
	sll	$t3, $t3, 2
	la	$t1, array
	addi	$t1, $t1, -4 ##
	add	$t2, $t1, $t3
	lb	$t3, sp
	la	$t5, str2
	add	$t5, $t5, $t9
	sb	$0, ($t5)
	addi	$t5, $t5, -1
loop_print:
	lw	$t0, ($t2)
	sb	$t3, 0($t5)
	addi	$t5, $t5, -1
loop_num:
	div	$t0, $t0, 10
	mfhi	$t4		# remainder
	mflo	$t0
	addi	$t4, $t4, 48
	sb	$t4, 0($t5)
	addi	$t5, $t5, -1
	bne	$t0, 0, loop_num
	addi	$t2, $t2, -4
	bne	$t1, $t2, loop_print
	addi	$t5, $t5, 1
.end_macro

.macro out_file
open:	li	$v0, 13
	la	$a0, fout
	li	$a1, 1		# flag
	li	$a2, 0		# mode is ignored
	syscall
	move	$s6, $v0	# save file descriptor($v0)
write:	li	$v0, 15
	move	$a0, $s6	# file descriptor 
	move	$a1, $t5
	move	$a2, $t9	# hardcoded buffer length	!!!
	syscall
close:	li	$v0, 16
	move	$a0, $s6	# file descriptor to close
	syscall
.end_macro

.macro	output
	output_str # make to str2
	out_file
.end_macro

.macro	exit
	li	$v0, 10
	syscall
.end_macro

openError:
readError:
	exit
