	.data	# Data Section
	# Starting address of data memory is 0x10010000
aArray:  .word 0xDEADBEEF, 0xBAADF00D, 0xBADDCAFE, 0xFACEFEED, 0xFEEDBABE, 
               0xF00DBABE, 0xBAAAAAAD, 0xFEEDC0DE
bArray:	 .word 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 
	      4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 
	      1048576, 2097152, 4194304, 8388608, 16777216, 33554432, 67108864, 
	      134217728, 268435456, 536870912, 1073741824, 2147483648, 
aSize:   .word 32 
bSize:   .word 8 

cArray:	 .word 13, 6, 5, 10, 15, 19, 21, 17, 14, 3, 12, 18, 7, 4, 11, 20, 22, 23, 24, 2, 1, 8, 16, 9, 
cSize:   .word 24 

	.text	# Code Section
main:
	la x5, aArray	# pseudo instruction, 
	lw x10, 0(x5)
	lw x10, 0(x5)
	lw x10, 0(x5)
	lw x10, 0(x5)
	lw x10, 0(x5)	
	lw x11, 4(x5)	
	lw x12, 8(x5)	
	lw x13, 12(x5)	
	lw x14, 16(x5)						
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop				
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop
	addi x0,  x0,  0  # nop		
