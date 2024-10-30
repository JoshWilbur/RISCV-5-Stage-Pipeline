# RISCV-5-Stage-Pipeline

Liam's Log: 10/29/24
I don't know how in the world he wants us to dynamically change the "your name" section of the display
	its hardcoded into the block

I added the decoding for Rd, RS1, RS2, Imm, func7 and func3, separated by instruction type
I also make decoder - Copy.v, which is functionally the same (in theory) as decoder.v, but with syntax that I like better. If you don't like it, we don't have to keep it.

Also changed a lot of 1'hX to 3'hX, because they need to be 3 bits