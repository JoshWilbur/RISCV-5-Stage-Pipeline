.data
	 num: .word 997 # An integer number to be checked
	 .text
.text
.global main
main:

isPrime:
	la t0, num      # load address
	lw a0, (t0)     # load the input number
	li t1, 3
	blt a0, t1, YES # Less than 3 automatically prime
	nop
	ori a1, zero, 2

LOOP:  	jal modulo
	nop
	beq s0, zero, NO # If modulo is 0, then not prime
	nop
	addi a1, a1, 1   # Add one to divider
	bgt  a0, a1, LOOP         
	nop           

YES:    ori a0, zero, 1  # a Prime Number
	jal zero, EXIT                
	nop
      
NO: 	ori a0, zero, 0  # NOT a Prime Number

EXIT:   j EXIT # Dead Loop
	nop


modulo:           
	or  t2, a0, zero  # load x
	or  t1, a1, zero  # load y
loop2:
	sub t2, t2, t1    # Subtract test number
	bge t2, t1, loop2 # if x > y, loop
	nop
	or  s0, t2, zero  # save the modulo into $s0
	jr ra		  # Return
	nop

 
