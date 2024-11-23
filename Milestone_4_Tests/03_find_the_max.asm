.data	# Data Section
Array:	.word 1 2 3 4 5 16 7 8 9 10 11 32 9 7 5 17 14
size:   .word 17

.text
.global main

main:

	la a5, Array       # a5 := &Array
	lw a0, (a5)        # a0 (largest) := Array[0]
	
	la    t3, size     #
	lw    t4, 0(t3)    # t4 = size
    
	li    a1, 1 # a1 (i) := 1
	addi  t1, zero, 0  # i = 0
    
for:
	bge   a1, t4, deadloop   # if i >= 10, then exit the loop (end label)
	slli  t1, a1, 2    # t1 := i * 4
	add   t2, a5, t1   # t2 := &Array + i*4
	lw    t3, (t2)     # t3 := Array[i]
	blt   t3, a0, skip # if Array[i] < largest, then skip
	mv    a0, t3       # update largest
skip:
	addi a1, a1, 1 # i := i + 1
	j for
    
  
deadloop:
	beq zero, zero, deadloop # program stops here		
	nop