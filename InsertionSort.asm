#	1651077 - Diep Gia Han
#	1651034	- Huynh Ha Mai Trinh
.include	"macro.asm"
.text
	input
	lw	$v0, n
	la	$t1, array
	sll	$t0, $v0, 2
	add	$t7, $t1, $t0
loops:	add	$t0, $zero, $t1
loop1:	addi	$t0, $t0, 4
	slt	$t3, $t0, $t7
	bne	$t3, $zero, loop2
	j	end
loop2:	lw	$t5, ($t0)
	addi	$t2, $t0, -4
condition1:
	sle	$t3, $t1, $t2
	bne	$t3, $zero, condition2
	j	statement
condition2:
	lw	$t6, ($t2)
	slt	$t3, $t5, $t6
	bne	$t3, $zero, loop3
	j	statement
loop3:	lw	$t6, ($t2)
	sw	$t6, 4($t2)
	addi	$t2, $t2, -4
	j	condition1
statement:
	sw	$t5, 4($t2)
	j	loop1
end:	output
	exit
