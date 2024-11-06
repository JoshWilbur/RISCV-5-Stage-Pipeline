# RISCV-5-Stage-Pipeline

Updates: I put back the decoder. I think it makes more sense, particularly with later milestones, to have the decoder and the controller separate for readabilities sake. We can feed some of the data fields like RD and imm into the controller and the controller can be dedicated to control signals. Added a mux in the mem section to select the write back data. Running into issues with r7 not being available in time for the r8 instruction to read it. IDK how to fix it.




Updates: I made some major changes to our decoder (now control) module. Since the VGA block is magic, we don't have a need to fully decode the instruction in one block. I made our decoder module into a control unit similar to the one found in the lecture 6 notes. I also have fleshed out the ALU more, I'm thinking a 4 bit number should suffice for function selecting. The program for Milestone 1a is now working. I haven't tested 1b, but I imagine it won't be hard to get that working. \

Milestone 1: \
Josh - Program 1a \
Liam - Program 1b \
