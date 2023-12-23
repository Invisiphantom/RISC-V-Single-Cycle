
ROM.o:     file format elf32-littleriscv


Disassembly of section .text:

00000154 <_start>:
 154:	2839                	c.jal	172 <load_gp>
 156:	87aa                	c.mv	a5,a0
 158:	00000517          	auipc	a0,0x0
 15c:	09450513          	addi	a0,a0,148 # 1ec <main>
 160:	4582                	c.lwsp	a1,0(sp)
 162:	0050                	c.addi4spn	a2,sp,4
 164:	ff017113          	andi	sp,sp,-16
 168:	4681                	c.li	a3,0
 16a:	4701                	c.li	a4,0
 16c:	880a                	c.mv	a6,sp
 16e:	28c9                	c.jal	240 <_PROCEDURE_LINKAGE_TABLE_+0x20>
 170:	9002                	c.ebreak

00000172 <load_gp>:
 172:	00002197          	auipc	gp,0x2
 176:	b1a18193          	addi	gp,gp,-1254 # 1c8c <__global_pointer$>
 17a:	8082                	c.jr	ra
	...

0000017e <deregister_tm_clones>:
 17e:	90418793          	addi	a5,gp,-1788 # 1590 <__TMC_END__>
 182:	90418713          	addi	a4,gp,-1788 # 1590 <__TMC_END__>
 186:	00f70863          	beq	a4,a5,196 <deregister_tm_clones+0x18>
 18a:	00000793          	addi	a5,zero,0
 18e:	c781                	c.beqz	a5,196 <deregister_tm_clones+0x18>
 190:	90418513          	addi	a0,gp,-1788 # 1590 <__TMC_END__>
 194:	8782                	c.jr	a5
 196:	8082                	c.jr	ra

00000198 <register_tm_clones>:
 198:	90418793          	addi	a5,gp,-1788 # 1590 <__TMC_END__>
 19c:	90418593          	addi	a1,gp,-1788 # 1590 <__TMC_END__>
 1a0:	8d9d                	c.sub	a1,a5
 1a2:	4025d793          	srai	a5,a1,0x2
 1a6:	81fd                	c.srli	a1,0x1f
 1a8:	95be                	c.add	a1,a5
 1aa:	8585                	c.srai	a1,0x1
 1ac:	c599                	c.beqz	a1,1ba <register_tm_clones+0x22>
 1ae:	00000793          	addi	a5,zero,0
 1b2:	c781                	c.beqz	a5,1ba <register_tm_clones+0x22>
 1b4:	90418513          	addi	a0,gp,-1788 # 1590 <__TMC_END__>
 1b8:	8782                	c.jr	a5
 1ba:	8082                	c.jr	ra

000001bc <__do_global_dtors_aux>:
 1bc:	1141                	c.addi	sp,-16
 1be:	c422                	c.swsp	s0,8(sp)
 1c0:	9101c783          	lbu	a5,-1776(gp) # 159c <completed.0>
 1c4:	c606                	c.swsp	ra,12(sp)
 1c6:	e789                	c.bnez	a5,1d0 <__do_global_dtors_aux+0x14>
 1c8:	3f5d                	c.jal	17e <deregister_tm_clones>
 1ca:	4785                	c.li	a5,1
 1cc:	90f18823          	sb	a5,-1776(gp) # 159c <completed.0>
 1d0:	40b2                	c.lwsp	ra,12(sp)
 1d2:	4422                	c.lwsp	s0,8(sp)
 1d4:	0141                	c.addi	sp,16
 1d6:	8082                	c.jr	ra

000001d8 <frame_dummy>:
 1d8:	b7c1                	c.j	198 <register_tm_clones>
	...

000001dc <sub>:
 1dc:	40b50533          	sub	a0,a0,a1
 1e0:	00008067          	jalr	zero,0(ra)

000001e4 <sum>:
 1e4:	00b50533          	add	a0,a0,a1
 1e8:	00008067          	jalr	zero,0(ra)

000001ec <main>:
 1ec:	ff010113          	addi	sp,sp,-16
 1f0:	00112623          	sw	ra,12(sp)
 1f4:	00200593          	addi	a1,zero,2
 1f8:	00100513          	addi	a0,zero,1
 1fc:	fe9ff0ef          	jal	ra,1e4 <sum>
 200:	00100593          	addi	a1,zero,1
 204:	fd9ff0ef          	jal	ra,1dc <sub>
 208:	00c12083          	lw	ra,12(sp)
 20c:	01010113          	addi	sp,sp,16
 210:	00008067          	jalr	zero,0(ra)
