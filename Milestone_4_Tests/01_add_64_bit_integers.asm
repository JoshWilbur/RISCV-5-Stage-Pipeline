	.data
    # Define the high and low parts of two 64-bit integers
    num1_high: .word 0x00000002  # Higher 32 bits of first number
    num1_low:  .word 0x1DBF12B7  # Lower 32 bits of first number
    num2_high: .word 0x00000003  # Higher 32 bits of second number
    num2_low:  .word 0xFA476D83  # Lower 32 bits of second number
    sum_high:  .word 0           # To store the higher 32 bits of the sum
    sum_low:   .word 0           # To store the lower 32 bits of the sum

     .text
    .globl _start

_start:
    # Load the lower 32 bits of the numbers
    la x5, num1_low
    lw x5, 0(x5)
    la x6, num2_low
    lw x6, 0(x6)

    # Add the lower 32 bits
    add x7, x5, x6

    # Check for carry from the lower 32-bit addition
    sltu x8, x7, x5

    # Load the higher 32 bits of the numbers
    la x9, num1_high
    lw x9, 0(x9)
    la x10, num2_high
    lw x10, 0(x10)

    # Add the higher 32 bits and include the carry
    add x11, x9, x10
    add x11, x11, x8

    # Store the results back into memory
    la x12, sum_low
    sw x7, 0(x12)
    la x13, sum_high
    sw x11, 0(x13)

    # Exit the program (using system call)
deadloop:
    beq zero, zero, deadloop # program stops here		
    nop
