	.globl main 

	.text 		

main:
	li $t0, 5	#Array Size as t0
	li $t1, 7	#Search as t1
			
	sub $t7,$t0,1	#arraySize-1
	
	move  $a0, $t7	#load a1 arraysize-1
	move  $a1, $t1	#load a2 search

	jal arraySearch
	
	move $s0, $v0	#s0 is result
	
	beq $s0,-1, ElsePrint # If result ==-1 Goto ElsePrint
	
	li $v0, 4	# syscall to print
	la $a0, msg1	# load msg1
	syscall		# print message
	
	li $v0, 1	# syscall to print
	move $a0, $t1	# load search
	syscall		# print message
	
	li $v0, 4	# syscall to print
	la $a0, msg2	# load msg2
	syscall		# print message
	
	li $v0, 1	# syscall to print
	move $a0, $s0	# load result
	syscall		# print message
	
	li $v0, 4	# syscall to print
	la $a0, n	# load endline
	syscall		# Print endline
	 
	j exit		# Goto exit
ElsePrint:
	li $v0, 4	# Syscall to print
	la $a0, msg0	# Load msg0
	syscall		# Print endline
exit:					
	li  $v0, 10 	# Syscall to exit
	syscall 	# exit

	
arraySearch:

	addi $sp, $sp, -4	# Moves down in the Stack
	sw  $t2, 0($sp)		# Push arraysize-1 onto Stack
	addi $sp, $sp, -4	# Moves down in the Stack
	sw  $ra, 0($sp)		# Push return address onto Stack
	move  $t2, $a0		# Load t2 with array size-1
	
If:
	beq $t2,-1 Result1      # If arraySize==-1 Goto Result 1

ElseIf: 
	mul $t4,$t2,4		# Turn arraySize into bytes t4 becomes iterator
	lw  $t3, array($t4)	# array[arraySize] is t3
	
	beq $t3, $a1, Result2	# If array[arraySize]== Search Goto Result 2	
	
Else:

	sub $t5, $t2,1		# ArraySize--; t5 becomes decreased array size
	move $a0, $t5		# Load ArraySize-1 int a0
	
	jal arraySearch		# Call array search again
	move $v0, $t5		# return index
	j arraySearchEnd	# Goto end
Result1:
	li $v0,-1		# Return -1
	j arraySearchEnd	# Goto End

Result2:
	move $v0, $t2		# Return t2 as index
	j arraySearchEnd	# Goto End
	
arraySearchEnd:
	lw  $ra, 0($sp)		# Pop return address off Stack
	addi $sp, $sp, 4	# Moves up in Stack
	lw  $t2, 0($sp)		# Pop arraysize-1
	addi $sp, $sp, 4	# Moves up in Stack
	jr $ra			# Return

	.data
msg0: .asciiz "Search key not found"   #msg for result<-1
msg1: .asciiz "Element " 	       #msg for result found 1
msg2: .asciiz " found at array index " #msg for result found 2
n:    .asciiz "\n"		       # End Line

array: .word 2, 3, 5, 7, 11	       # Array given array[]={2,3,5,7,11}