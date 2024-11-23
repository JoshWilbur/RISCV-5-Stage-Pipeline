.text
.global main
main:

#call function
	li a1, 4
	jal fibonacci
	nop
	mv s1, a0 		#save return value to s1
	
exit:	j exit			# dead loop; program stops here
	nop
	
#function int fibonacci(int n)
fibonacci:
	addi sp,sp,-12
	sw ra, 8(sp)
	sw s0, 4(sp)
	sw s1, 0(sp)
	
	mv s0, a1  		#move argument into s0
	li a0,1  		#load 1 into return value 0
	addi t0,x0, 2
	ble s0, t0, fibonacciExit	# check terminal condition
	nop
	addi a1, s0, -1 	#set arguments for recursive call
	jal fibonacci
	nop
	mv    s1,a0		#store result of f(n-1) to s1
	addi  a1,s0, -2		# set args for recursive call to f(n-2)
	jal fibonacci
	nop
	add a0,s1,a0		# add result of f(n-1) to it
	
fibonacciExit:
	#restore previous values of ra, s0, s1
	lw ra,8(sp)
	lw s0,4(sp)
	lw s1,0(sp)
	addi sp, sp, 12
	jr ra
	nop
