#!/usr/bin/python3
# 将InstMem.v和PC.v中$readmemh()的ROM.bin路径替换为当前的绝对路径
import os
import re

# 将工作目录切换至当前文件所在目录
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# 替换InstMem.v中的$readmemh()路径
with open("InstMem.v", "r") as file:
    content = file.read()
content = re.sub(
    r'\$readmemh\(".*?ROM\.bin", inst_mem\);',
    f'$readmemh("{os.getcwd()}/ROM.bin", inst_mem);',
    content,
)
with open("InstMem.v", "w") as file:
    file.write(content)

# 替换PC.v中的$readmemh()路径
with open("PC.v", "r") as file:
    content = file.read()
content = re.sub(
    r'\$readmemh\(".*?ROM-PC\.bin", PCinitial\);',
    f'$readmemh("{os.getcwd()}/ROM-PC.bin", PCinitial);',
    content,
)
with open("PC.v", "w") as file:
    file.write(content)