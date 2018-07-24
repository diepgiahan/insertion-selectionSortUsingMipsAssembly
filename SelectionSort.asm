#	1651077 - Diep Gia Han
#	1651034	- Huynh Ha Mai Trinh
.include	"macro.asm"
.text
	input
	la	$t0, array	# t0 = array
	lw	$t7, n
	sll	$t7, $t7, 2
	add	$t7, $t0, $t7
	addi	$t0, $t0, -4
loop1:	addi	$t0, $t0, 4	# t0 = *array[i]
	beq	$t0, $t7, end
	lw	$t3, ($t0)	# t3 = current = array[i]
	move	$t4, $t0	# t4 = *array[j]
	lw	$t1, ($t4)	# t1 = min = array[i]
	move	$t6, $t4	# when already right
loop2:	lw	$t2, ($t4)	# t2 = array[j]
	blt	$t2, $t1, swMin1 # t1 = min(t2, t1)
cont:	addi	$t4, $t4, 4
	beq	$t4, $t7, swMin2
	j	loop2
swMin2:	sw	$t3, 0($t6)
	sw	$t1, 0($t0)
	j	loop1
swMin1:	move	$t6, $t4	# vi tri dat min
	lw	$t1, ($t4)
	j	cont
end:	output
	exit
