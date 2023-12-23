#!/usr/bin/python3
# 将ROM.S中的汇编指令转换为机器码写入ROM.bin中
# 将main函数的地址写入ROM-PC.bin中
import os

# 读取ROM.S文件
with open("ROM.S", "r") as f:
    lines = f.readlines()

hex_main_addr = ""
with open("ROM.bin", "w") as f:
    # 首先写入2048字节的00
    ROM_content = ["00000000" for _ in range(int(2048 / 4))]
    # 从第70行开始读取ROM.S文件
    for line in lines[70:]:
        add_inst = line. split(":")
        if add_inst[0].endswith("<main>"):
            hex_main_addr = add_inst[0].strip().split(" ")[0]
        if len(add_inst) != 2 or add_inst[0].endswith(">"):
            continue
        hex_addr = add_inst[0].strip()
        hex_inst = add_inst[1].strip().split(" ")[0]
        dec_addr = int(hex_addr, 16)
        # 在ROM_content中的对应地址位置覆盖写入指令
        ROM_content[int(dec_addr / 4)] = hex_inst

    # 将ROM_content中的指令写入ROM.bin文件中
    f.write("\n".join(ROM_content))


with open("ROM-PC.bin", "w") as f:
    # 将main函数的地址写入ROM-PC.bin文件中
    f.write(hex_main_addr)