	.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
	addiu $sp, $sp, -60 #guardem les variables locals i les que volem salvar
	sw $a0, 48($sp) #@ de w
	sw $a1, 52($sp)	#31
	sw $ra, 56($sp)
	
	li $t0, 0 #k = 0
	li $t1, 11 #k' = 10
	#char max = '0' ---> fer un sw
	move $t2, $sp #t2 = @sp (que no és el vector histo)
	addiu $t2, $t2, 4 #ara sí és l'adreça del vector histo)
for:
	ble $t1, $t0, end
	sw $zero, 0($t2)
	addiu $t2, $t2, 4 #ens movem al histo (següent posició)
	addiu $t1, $t1, -1 
	b for

end:
	li $s3, '0'
	move $s0, $a0 #guardem l'adreça de w
	move $s1, $a1 #guardem 31
	move $s2, $t0 #guardem $t0 = k

for2:
	bge $s2, $s1, end2
	
	addiu $a0, $t2, -40
	addu $a1, $s0, $s2
	
	lb $a1, 0($a1)
	
	addiu $a1, $a1, -48
	addiu $a2, $s3, -48
	
	jal update
	
	addiu $s3, $v0, '0'
	addiu $s2, $s2, 1
	
	b for2
	
end2:

	move $v0, $s3 #return de max que es troba a s3
	lw $a0, 48($sp) 
	lw $a1, 52($sp)	
	lw $ra, 56($sp)


update:
	
	addiu $sp, $sp, -16
	sw $s0, 0($sp) #@ de w
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	
	move $s0, $a0
	move $s1, $a1 
	move $s2, $a2
	
	jal nofares
	
	sll $t0, $s1, 2
	addu $t0, $s0, $t0
	lw $t1, 0($t0)
	addiu $t1, $t1, 1
	sw $t1, 0($t0)
	
	sll $t2, $s2, 2
	addu $t2, $s0, $t2
	lw $t2, 0($t2)
	
	ble $t1, $t2, else
	move $v0, $s1
	
	b end3
	
else:
	move $v0, $s2
	
end3:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	
	addiu $sp, $sp, 16
	
	jr $ra



