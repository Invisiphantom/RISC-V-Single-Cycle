riscv32-unknown-linux-gnu-gcc -Og -march=rv32id ROM.c -o ROM.o -T ROM.ld
riscv32-unknown-linux-gnu-objdump -d -j .text -M no-aliases ROM.o > ROM.S
rm ROM.o

python3 -u ROMPath.py
python3 -u ROM.py

iverilog -y $PWD arch.v -o bin/arch
cd bin && rm -f *.vcd
vvp arch && rm arch
gtkwave wave.vcd && cd ..