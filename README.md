# RISC-V-SIngle-Cycle
## Supported ISA:
- RV32I (without lui、auipc、ecall、ebreak)
## Reference Material:
- 《COD》(RISC-V version)
- [RISCV_CARD.pdf (sfu.ca)](https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf)
- [Online RISC-V Assembler (lucasteske.dev)](https://riscvasm.lucasteske.dev/#)
- [merledu/SIngle-Cycle-RISC-V-In-Verilog(github.com)](https://github.com/merledu/SIngle-Cycle-RISC-V-In-Verilog)

## Environment(with profile below):
- WSL2-Ubuntu22.04
- VS Code
- Core VS  Code Extensions:
WSL、Code Runner、TerosHDL
- Icarus Verilog
- GTKWave

## Contained Files:
- WSL-Verilog.code-profile (My VSCode verilog-workspace profile)
- ROM.txt (Binary RISC-V Instructions that will be read into InstructionMemory.v verilog module)
- arch_tb.v
- PC.v
- InstructionMemory.v
- PC4Add.v
- ShiftLeft1.v
- PCAdd.v
- BranchJudge.v
- Control.v
- Registers.v
- ImmGen.v
- ALUControl.v
- ALU.v
- DataMemory.v