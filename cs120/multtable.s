	# Kieran O'Connor
	.data
space:	.asciiz " "
newline:	.asciiz "\n"

	.text
main:	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $a0, 7
	li $a1, 9
	jal mt

	li $a0, 3
	li $a1, 4
	jal mt

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

mt:	# We'll use s0, s1, s2, s3 for the loops.
	# Need to save these, and RA too!
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)

	# Now the inner and outer loops
	# We'll use s1 to hold the "a0" argument,
	# and s3 to hold the "a1" argument
	move $s1, $a0
	move $s3, $a1

	# Outer loop - init
	move $s0, $0
oloop:	beq $s0, $s1, odone

	# Inner Loop - init
	move $s2, $0
iloop:	beq $s2, $s3, idone

	# Multiply, print the number
	mul $a0, $s0, $s2
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

	# Increment the inner loop
	addi $s2, $s2, 1
	j iloop

idone:
	# print a new line, increment the outer loop
	la $a0, newline
	li $v0, 4
	syscall

	addi $s0, $s0, 1
	j oloop

odone:	 # Now restore the registers
	lw $s3, 16($sp)
	lw $s2, 12($sp)
	lw $s1, 8($sp)
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 20
	jr $ra
	
