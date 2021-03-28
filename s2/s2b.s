	.data
result: .word 0
num:	.byte '7'

	.text
	.globl main
main:

	la $t0, result
	la $t1, num
	lb $t1, 0($t1)

if1:
	li $t2, 'a'
	blt $t1, $t2, if2
	li $t2, 'z'
	ble $t1, $t2, exe

if2:	
	li $t2, 'A'
	blt $t1, $t2, else
	li $t2, 'Z'
	ble $t1, $t2, exe
	
else:
	li $t2, '9'
	bgt $t1, $t2, nope
	li $t2, '0'
	blt $t1, $t2, nope
	subu $t1, $t1, $t2
	b exe

nope:
	li $t1, -1
	
exe: 
	sw $t1, 0($t0)

	jr $ra

