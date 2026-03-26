
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	f852                	sd	s4,48(sp)
       e:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
      10:	00007797          	auipc	a5,0x7
      14:	66878793          	addi	a5,a5,1640 # 7678 <malloc+0x2490>
      18:	638c                	ld	a1,0(a5)
      1a:	6790                	ld	a2,8(a5)
      1c:	6b94                	ld	a3,16(a5)
      1e:	6f98                	ld	a4,24(a5)
      20:	fab43423          	sd	a1,-88(s0)
      24:	fac43823          	sd	a2,-80(s0)
      28:	fad43c23          	sd	a3,-72(s0)
      2c:	fce43023          	sd	a4,-64(s0)
      30:	739c                	ld	a5,32(a5)
      32:	fcf43423          	sd	a5,-56(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      36:	fa840493          	addi	s1,s0,-88
      3a:	fd040a13          	addi	s4,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      3e:	20100993          	li	s3,513
      42:	0004b903          	ld	s2,0(s1)
      46:	85ce                	mv	a1,s3
      48:	854a                	mv	a0,s2
      4a:	4ef040ef          	jal	4d38 <open>
    if(fd >= 0){
      4e:	00055d63          	bgez	a0,68 <copyinstr1+0x68>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      52:	04a1                	addi	s1,s1,8
      54:	ff4497e3          	bne	s1,s4,42 <copyinstr1+0x42>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      exit(1);
    }
  }
}
      58:	60e6                	ld	ra,88(sp)
      5a:	6446                	ld	s0,80(sp)
      5c:	64a6                	ld	s1,72(sp)
      5e:	6906                	ld	s2,64(sp)
      60:	79e2                	ld	s3,56(sp)
      62:	7a42                	ld	s4,48(sp)
      64:	6125                	addi	sp,sp,96
      66:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      68:	862a                	mv	a2,a0
      6a:	85ca                	mv	a1,s2
      6c:	00005517          	auipc	a0,0x5
      70:	27450513          	addi	a0,a0,628 # 52e0 <malloc+0xf8>
      74:	0bc050ef          	jal	5130 <printf>
      exit(1);
      78:	4505                	li	a0,1
      7a:	47f040ef          	jal	4cf8 <exit>

000000000000007e <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      7e:	0000a797          	auipc	a5,0xa
      82:	4ea78793          	addi	a5,a5,1258 # a568 <uninit>
      86:	0000d697          	auipc	a3,0xd
      8a:	bf268693          	addi	a3,a3,-1038 # cc78 <buf>
    if(uninit[i] != '\0'){
      8e:	0007c703          	lbu	a4,0(a5)
      92:	e709                	bnez	a4,9c <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      94:	0785                	addi	a5,a5,1
      96:	fed79ce3          	bne	a5,a3,8e <bsstest+0x10>
      9a:	8082                	ret
{
      9c:	1141                	addi	sp,sp,-16
      9e:	e406                	sd	ra,8(sp)
      a0:	e022                	sd	s0,0(sp)
      a2:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      a4:	85aa                	mv	a1,a0
      a6:	00005517          	auipc	a0,0x5
      aa:	25a50513          	addi	a0,a0,602 # 5300 <malloc+0x118>
      ae:	082050ef          	jal	5130 <printf>
      exit(1);
      b2:	4505                	li	a0,1
      b4:	445040ef          	jal	4cf8 <exit>

00000000000000b8 <opentest>:
{
      b8:	1101                	addi	sp,sp,-32
      ba:	ec06                	sd	ra,24(sp)
      bc:	e822                	sd	s0,16(sp)
      be:	e426                	sd	s1,8(sp)
      c0:	1000                	addi	s0,sp,32
      c2:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      c4:	4581                	li	a1,0
      c6:	00005517          	auipc	a0,0x5
      ca:	25250513          	addi	a0,a0,594 # 5318 <malloc+0x130>
      ce:	46b040ef          	jal	4d38 <open>
  if(fd < 0){
      d2:	02054263          	bltz	a0,f6 <opentest+0x3e>
  close(fd);
      d6:	44b040ef          	jal	4d20 <close>
  fd = open("doesnotexist", 0);
      da:	4581                	li	a1,0
      dc:	00005517          	auipc	a0,0x5
      e0:	25c50513          	addi	a0,a0,604 # 5338 <malloc+0x150>
      e4:	455040ef          	jal	4d38 <open>
  if(fd >= 0){
      e8:	02055163          	bgez	a0,10a <opentest+0x52>
}
      ec:	60e2                	ld	ra,24(sp)
      ee:	6442                	ld	s0,16(sp)
      f0:	64a2                	ld	s1,8(sp)
      f2:	6105                	addi	sp,sp,32
      f4:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f6:	85a6                	mv	a1,s1
      f8:	00005517          	auipc	a0,0x5
      fc:	22850513          	addi	a0,a0,552 # 5320 <malloc+0x138>
     100:	030050ef          	jal	5130 <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	3f3040ef          	jal	4cf8 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     10a:	85a6                	mv	a1,s1
     10c:	00005517          	auipc	a0,0x5
     110:	23c50513          	addi	a0,a0,572 # 5348 <malloc+0x160>
     114:	01c050ef          	jal	5130 <printf>
    exit(1);
     118:	4505                	li	a0,1
     11a:	3df040ef          	jal	4cf8 <exit>

000000000000011e <truncate2>:
{
     11e:	7179                	addi	sp,sp,-48
     120:	f406                	sd	ra,40(sp)
     122:	f022                	sd	s0,32(sp)
     124:	ec26                	sd	s1,24(sp)
     126:	e84a                	sd	s2,16(sp)
     128:	e44e                	sd	s3,8(sp)
     12a:	1800                	addi	s0,sp,48
     12c:	89aa                	mv	s3,a0
  unlink("truncfile");
     12e:	00005517          	auipc	a0,0x5
     132:	24250513          	addi	a0,a0,578 # 5370 <malloc+0x188>
     136:	413040ef          	jal	4d48 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13a:	60100593          	li	a1,1537
     13e:	00005517          	auipc	a0,0x5
     142:	23250513          	addi	a0,a0,562 # 5370 <malloc+0x188>
     146:	3f3040ef          	jal	4d38 <open>
     14a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     14c:	4611                	li	a2,4
     14e:	00005597          	auipc	a1,0x5
     152:	23258593          	addi	a1,a1,562 # 5380 <malloc+0x198>
     156:	3c3040ef          	jal	4d18 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     15a:	40100593          	li	a1,1025
     15e:	00005517          	auipc	a0,0x5
     162:	21250513          	addi	a0,a0,530 # 5370 <malloc+0x188>
     166:	3d3040ef          	jal	4d38 <open>
     16a:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     16c:	4605                	li	a2,1
     16e:	00005597          	auipc	a1,0x5
     172:	21a58593          	addi	a1,a1,538 # 5388 <malloc+0x1a0>
     176:	8526                	mv	a0,s1
     178:	3a1040ef          	jal	4d18 <write>
  if(n != -1){
     17c:	57fd                	li	a5,-1
     17e:	02f51563          	bne	a0,a5,1a8 <truncate2+0x8a>
  unlink("truncfile");
     182:	00005517          	auipc	a0,0x5
     186:	1ee50513          	addi	a0,a0,494 # 5370 <malloc+0x188>
     18a:	3bf040ef          	jal	4d48 <unlink>
  close(fd1);
     18e:	8526                	mv	a0,s1
     190:	391040ef          	jal	4d20 <close>
  close(fd2);
     194:	854a                	mv	a0,s2
     196:	38b040ef          	jal	4d20 <close>
}
     19a:	70a2                	ld	ra,40(sp)
     19c:	7402                	ld	s0,32(sp)
     19e:	64e2                	ld	s1,24(sp)
     1a0:	6942                	ld	s2,16(sp)
     1a2:	69a2                	ld	s3,8(sp)
     1a4:	6145                	addi	sp,sp,48
     1a6:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a8:	862a                	mv	a2,a0
     1aa:	85ce                	mv	a1,s3
     1ac:	00005517          	auipc	a0,0x5
     1b0:	1e450513          	addi	a0,a0,484 # 5390 <malloc+0x1a8>
     1b4:	77d040ef          	jal	5130 <printf>
    exit(1);
     1b8:	4505                	li	a0,1
     1ba:	33f040ef          	jal	4cf8 <exit>

00000000000001be <createtest>:
{
     1be:	7139                	addi	sp,sp,-64
     1c0:	fc06                	sd	ra,56(sp)
     1c2:	f822                	sd	s0,48(sp)
     1c4:	f426                	sd	s1,40(sp)
     1c6:	f04a                	sd	s2,32(sp)
     1c8:	ec4e                	sd	s3,24(sp)
     1ca:	e852                	sd	s4,16(sp)
     1cc:	0080                	addi	s0,sp,64
  name[0] = 'a';
     1ce:	06100793          	li	a5,97
     1d2:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     1d6:	fc040523          	sb	zero,-54(s0)
     1da:	03000493          	li	s1,48
    fd = open(name, O_CREATE|O_RDWR);
     1de:	fc840a13          	addi	s4,s0,-56
     1e2:	20200993          	li	s3,514
  for(i = 0; i < N; i++){
     1e6:	06400913          	li	s2,100
    name[1] = '0' + i;
     1ea:	fc9404a3          	sb	s1,-55(s0)
    fd = open(name, O_CREATE|O_RDWR);
     1ee:	85ce                	mv	a1,s3
     1f0:	8552                	mv	a0,s4
     1f2:	347040ef          	jal	4d38 <open>
    close(fd);
     1f6:	32b040ef          	jal	4d20 <close>
  for(i = 0; i < N; i++){
     1fa:	2485                	addiw	s1,s1,1
     1fc:	0ff4f493          	zext.b	s1,s1
     200:	ff2495e3          	bne	s1,s2,1ea <createtest+0x2c>
  name[0] = 'a';
     204:	06100793          	li	a5,97
     208:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     20c:	fc040523          	sb	zero,-54(s0)
     210:	03000493          	li	s1,48
    unlink(name);
     214:	fc840993          	addi	s3,s0,-56
  for(i = 0; i < N; i++){
     218:	06400913          	li	s2,100
    name[1] = '0' + i;
     21c:	fc9404a3          	sb	s1,-55(s0)
    unlink(name);
     220:	854e                	mv	a0,s3
     222:	327040ef          	jal	4d48 <unlink>
  for(i = 0; i < N; i++){
     226:	2485                	addiw	s1,s1,1
     228:	0ff4f493          	zext.b	s1,s1
     22c:	ff2498e3          	bne	s1,s2,21c <createtest+0x5e>
}
     230:	70e2                	ld	ra,56(sp)
     232:	7442                	ld	s0,48(sp)
     234:	74a2                	ld	s1,40(sp)
     236:	7902                	ld	s2,32(sp)
     238:	69e2                	ld	s3,24(sp)
     23a:	6a42                	ld	s4,16(sp)
     23c:	6121                	addi	sp,sp,64
     23e:	8082                	ret

0000000000000240 <bigwrite>:
{
     240:	711d                	addi	sp,sp,-96
     242:	ec86                	sd	ra,88(sp)
     244:	e8a2                	sd	s0,80(sp)
     246:	e4a6                	sd	s1,72(sp)
     248:	e0ca                	sd	s2,64(sp)
     24a:	fc4e                	sd	s3,56(sp)
     24c:	f852                	sd	s4,48(sp)
     24e:	f456                	sd	s5,40(sp)
     250:	f05a                	sd	s6,32(sp)
     252:	ec5e                	sd	s7,24(sp)
     254:	e862                	sd	s8,16(sp)
     256:	e466                	sd	s9,8(sp)
     258:	1080                	addi	s0,sp,96
     25a:	8caa                	mv	s9,a0
  unlink("bigwrite");
     25c:	00005517          	auipc	a0,0x5
     260:	15c50513          	addi	a0,a0,348 # 53b8 <malloc+0x1d0>
     264:	2e5040ef          	jal	4d48 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     268:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26c:	20200b93          	li	s7,514
     270:	00005a17          	auipc	s4,0x5
     274:	148a0a13          	addi	s4,s4,328 # 53b8 <malloc+0x1d0>
     278:	4b09                	li	s6,2
      int cc = write(fd, buf, sz);
     27a:	0000d997          	auipc	s3,0xd
     27e:	9fe98993          	addi	s3,s3,-1538 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     282:	6a8d                	lui	s5,0x3
     284:	1c9a8a93          	addi	s5,s5,457 # 31c9 <subdir+0x4af>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     288:	85de                	mv	a1,s7
     28a:	8552                	mv	a0,s4
     28c:	2ad040ef          	jal	4d38 <open>
     290:	892a                	mv	s2,a0
    if(fd < 0){
     292:	04054463          	bltz	a0,2da <bigwrite+0x9a>
     296:	8c5a                	mv	s8,s6
      int cc = write(fd, buf, sz);
     298:	8626                	mv	a2,s1
     29a:	85ce                	mv	a1,s3
     29c:	854a                	mv	a0,s2
     29e:	27b040ef          	jal	4d18 <write>
      if(cc != sz){
     2a2:	04951663          	bne	a0,s1,2ee <bigwrite+0xae>
    for(i = 0; i < 2; i++){
     2a6:	3c7d                	addiw	s8,s8,-1
     2a8:	fe0c18e3          	bnez	s8,298 <bigwrite+0x58>
    close(fd);
     2ac:	854a                	mv	a0,s2
     2ae:	273040ef          	jal	4d20 <close>
    unlink("bigwrite");
     2b2:	8552                	mv	a0,s4
     2b4:	295040ef          	jal	4d48 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2b8:	1d74849b          	addiw	s1,s1,471
     2bc:	fd5496e3          	bne	s1,s5,288 <bigwrite+0x48>
}
     2c0:	60e6                	ld	ra,88(sp)
     2c2:	6446                	ld	s0,80(sp)
     2c4:	64a6                	ld	s1,72(sp)
     2c6:	6906                	ld	s2,64(sp)
     2c8:	79e2                	ld	s3,56(sp)
     2ca:	7a42                	ld	s4,48(sp)
     2cc:	7aa2                	ld	s5,40(sp)
     2ce:	7b02                	ld	s6,32(sp)
     2d0:	6be2                	ld	s7,24(sp)
     2d2:	6c42                	ld	s8,16(sp)
     2d4:	6ca2                	ld	s9,8(sp)
     2d6:	6125                	addi	sp,sp,96
     2d8:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2da:	85e6                	mv	a1,s9
     2dc:	00005517          	auipc	a0,0x5
     2e0:	0ec50513          	addi	a0,a0,236 # 53c8 <malloc+0x1e0>
     2e4:	64d040ef          	jal	5130 <printf>
      exit(1);
     2e8:	4505                	li	a0,1
     2ea:	20f040ef          	jal	4cf8 <exit>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2ee:	86aa                	mv	a3,a0
     2f0:	8626                	mv	a2,s1
     2f2:	85e6                	mv	a1,s9
     2f4:	00005517          	auipc	a0,0x5
     2f8:	0f450513          	addi	a0,a0,244 # 53e8 <malloc+0x200>
     2fc:	635040ef          	jal	5130 <printf>
        exit(1);
     300:	4505                	li	a0,1
     302:	1f7040ef          	jal	4cf8 <exit>

0000000000000306 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     306:	7139                	addi	sp,sp,-64
     308:	fc06                	sd	ra,56(sp)
     30a:	f822                	sd	s0,48(sp)
     30c:	f426                	sd	s1,40(sp)
     30e:	f04a                	sd	s2,32(sp)
     310:	ec4e                	sd	s3,24(sp)
     312:	e852                	sd	s4,16(sp)
     314:	e456                	sd	s5,8(sp)
     316:	e05a                	sd	s6,0(sp)
     318:	0080                	addi	s0,sp,64
  int assumed_free = 600;
  
  unlink("junk");
     31a:	00005517          	auipc	a0,0x5
     31e:	0e650513          	addi	a0,a0,230 # 5400 <malloc+0x218>
     322:	227040ef          	jal	4d48 <unlink>
     326:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     32a:	20100a93          	li	s5,513
     32e:	00005997          	auipc	s3,0x5
     332:	0d298993          	addi	s3,s3,210 # 5400 <malloc+0x218>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     336:	4b05                	li	s6,1
     338:	5a7d                	li	s4,-1
     33a:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     33e:	85d6                	mv	a1,s5
     340:	854e                	mv	a0,s3
     342:	1f7040ef          	jal	4d38 <open>
     346:	84aa                	mv	s1,a0
    if(fd < 0){
     348:	04054d63          	bltz	a0,3a2 <badwrite+0x9c>
    write(fd, (char*)0xffffffffffL, 1);
     34c:	865a                	mv	a2,s6
     34e:	85d2                	mv	a1,s4
     350:	1c9040ef          	jal	4d18 <write>
    close(fd);
     354:	8526                	mv	a0,s1
     356:	1cb040ef          	jal	4d20 <close>
    unlink("junk");
     35a:	854e                	mv	a0,s3
     35c:	1ed040ef          	jal	4d48 <unlink>
  for(int i = 0; i < assumed_free; i++){
     360:	397d                	addiw	s2,s2,-1
     362:	fc091ee3          	bnez	s2,33e <badwrite+0x38>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     366:	20100593          	li	a1,513
     36a:	00005517          	auipc	a0,0x5
     36e:	09650513          	addi	a0,a0,150 # 5400 <malloc+0x218>
     372:	1c7040ef          	jal	4d38 <open>
     376:	84aa                	mv	s1,a0
  if(fd < 0){
     378:	02054e63          	bltz	a0,3b4 <badwrite+0xae>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     37c:	4605                	li	a2,1
     37e:	00005597          	auipc	a1,0x5
     382:	00a58593          	addi	a1,a1,10 # 5388 <malloc+0x1a0>
     386:	193040ef          	jal	4d18 <write>
     38a:	4785                	li	a5,1
     38c:	02f50d63          	beq	a0,a5,3c6 <badwrite+0xc0>
    printf("write failed\n");
     390:	00005517          	auipc	a0,0x5
     394:	09050513          	addi	a0,a0,144 # 5420 <malloc+0x238>
     398:	599040ef          	jal	5130 <printf>
    exit(1);
     39c:	4505                	li	a0,1
     39e:	15b040ef          	jal	4cf8 <exit>
      printf("open junk failed\n");
     3a2:	00005517          	auipc	a0,0x5
     3a6:	06650513          	addi	a0,a0,102 # 5408 <malloc+0x220>
     3aa:	587040ef          	jal	5130 <printf>
      exit(1);
     3ae:	4505                	li	a0,1
     3b0:	149040ef          	jal	4cf8 <exit>
    printf("open junk failed\n");
     3b4:	00005517          	auipc	a0,0x5
     3b8:	05450513          	addi	a0,a0,84 # 5408 <malloc+0x220>
     3bc:	575040ef          	jal	5130 <printf>
    exit(1);
     3c0:	4505                	li	a0,1
     3c2:	137040ef          	jal	4cf8 <exit>
  }
  close(fd);
     3c6:	8526                	mv	a0,s1
     3c8:	159040ef          	jal	4d20 <close>
  unlink("junk");
     3cc:	00005517          	auipc	a0,0x5
     3d0:	03450513          	addi	a0,a0,52 # 5400 <malloc+0x218>
     3d4:	175040ef          	jal	4d48 <unlink>

  exit(0);
     3d8:	4501                	li	a0,0
     3da:	11f040ef          	jal	4cf8 <exit>

00000000000003de <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3de:	711d                	addi	sp,sp,-96
     3e0:	ec86                	sd	ra,88(sp)
     3e2:	e8a2                	sd	s0,80(sp)
     3e4:	e4a6                	sd	s1,72(sp)
     3e6:	e0ca                	sd	s2,64(sp)
     3e8:	fc4e                	sd	s3,56(sp)
     3ea:	f852                	sd	s4,48(sp)
     3ec:	f456                	sd	s5,40(sp)
     3ee:	1080                	addi	s0,sp,96
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     3f0:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3f2:	07a00993          	li	s3,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     3f6:	fa040913          	addi	s2,s0,-96
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     3fa:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
     3fe:	40000a93          	li	s5,1024
    name[0] = 'z';
     402:	fb340023          	sb	s3,-96(s0)
    name[1] = 'z';
     406:	fb3400a3          	sb	s3,-95(s0)
    name[2] = '0' + (i / 32);
     40a:	41f4d71b          	sraiw	a4,s1,0x1f
     40e:	01b7571b          	srliw	a4,a4,0x1b
     412:	009707bb          	addw	a5,a4,s1
     416:	4057d69b          	sraiw	a3,a5,0x5
     41a:	0306869b          	addiw	a3,a3,48
     41e:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     422:	8bfd                	andi	a5,a5,31
     424:	9f99                	subw	a5,a5,a4
     426:	0307879b          	addiw	a5,a5,48
     42a:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     42e:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     432:	854a                	mv	a0,s2
     434:	115040ef          	jal	4d48 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     438:	85d2                	mv	a1,s4
     43a:	854a                	mv	a0,s2
     43c:	0fd040ef          	jal	4d38 <open>
    if(fd < 0){
     440:	00054763          	bltz	a0,44e <outofinodes+0x70>
      // failure is eventually expected.
      break;
    }
    close(fd);
     444:	0dd040ef          	jal	4d20 <close>
  for(int i = 0; i < nzz; i++){
     448:	2485                	addiw	s1,s1,1
     44a:	fb549ce3          	bne	s1,s5,402 <outofinodes+0x24>
     44e:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     450:	07a00913          	li	s2,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     454:	fa040a13          	addi	s4,s0,-96
  for(int i = 0; i < nzz; i++){
     458:	40000993          	li	s3,1024
    name[0] = 'z';
     45c:	fb240023          	sb	s2,-96(s0)
    name[1] = 'z';
     460:	fb2400a3          	sb	s2,-95(s0)
    name[2] = '0' + (i / 32);
     464:	41f4d71b          	sraiw	a4,s1,0x1f
     468:	01b7571b          	srliw	a4,a4,0x1b
     46c:	009707bb          	addw	a5,a4,s1
     470:	4057d69b          	sraiw	a3,a5,0x5
     474:	0306869b          	addiw	a3,a3,48
     478:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     47c:	8bfd                	andi	a5,a5,31
     47e:	9f99                	subw	a5,a5,a4
     480:	0307879b          	addiw	a5,a5,48
     484:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     488:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     48c:	8552                	mv	a0,s4
     48e:	0bb040ef          	jal	4d48 <unlink>
  for(int i = 0; i < nzz; i++){
     492:	2485                	addiw	s1,s1,1
     494:	fd3494e3          	bne	s1,s3,45c <outofinodes+0x7e>
  }
}
     498:	60e6                	ld	ra,88(sp)
     49a:	6446                	ld	s0,80(sp)
     49c:	64a6                	ld	s1,72(sp)
     49e:	6906                	ld	s2,64(sp)
     4a0:	79e2                	ld	s3,56(sp)
     4a2:	7a42                	ld	s4,48(sp)
     4a4:	7aa2                	ld	s5,40(sp)
     4a6:	6125                	addi	sp,sp,96
     4a8:	8082                	ret

00000000000004aa <copyin>:
{
     4aa:	7175                	addi	sp,sp,-144
     4ac:	e506                	sd	ra,136(sp)
     4ae:	e122                	sd	s0,128(sp)
     4b0:	fca6                	sd	s1,120(sp)
     4b2:	f8ca                	sd	s2,112(sp)
     4b4:	f4ce                	sd	s3,104(sp)
     4b6:	f0d2                	sd	s4,96(sp)
     4b8:	ecd6                	sd	s5,88(sp)
     4ba:	e8da                	sd	s6,80(sp)
     4bc:	e4de                	sd	s7,72(sp)
     4be:	e0e2                	sd	s8,64(sp)
     4c0:	fc66                	sd	s9,56(sp)
     4c2:	0900                	addi	s0,sp,144
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     4c4:	00007797          	auipc	a5,0x7
     4c8:	1b478793          	addi	a5,a5,436 # 7678 <malloc+0x2490>
     4cc:	638c                	ld	a1,0(a5)
     4ce:	6790                	ld	a2,8(a5)
     4d0:	6b94                	ld	a3,16(a5)
     4d2:	6f98                	ld	a4,24(a5)
     4d4:	f6b43c23          	sd	a1,-136(s0)
     4d8:	f8c43023          	sd	a2,-128(s0)
     4dc:	f8d43423          	sd	a3,-120(s0)
     4e0:	f8e43823          	sd	a4,-112(s0)
     4e4:	739c                	ld	a5,32(a5)
     4e6:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     4ea:	f7840913          	addi	s2,s0,-136
     4ee:	fa040c93          	addi	s9,s0,-96
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4f2:	20100b13          	li	s6,513
     4f6:	00005a97          	auipc	s5,0x5
     4fa:	f3aa8a93          	addi	s5,s5,-198 # 5430 <malloc+0x248>
    int n = write(fd, (void*)addr, 8192);
     4fe:	6a09                	lui	s4,0x2
    n = write(1, (char*)addr, 8192);
     500:	4c05                	li	s8,1
    if(pipe(fds) < 0){
     502:	f7040b93          	addi	s7,s0,-144
    uint64 addr = addrs[ai];
     506:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     50a:	85da                	mv	a1,s6
     50c:	8556                	mv	a0,s5
     50e:	02b040ef          	jal	4d38 <open>
     512:	84aa                	mv	s1,a0
    if(fd < 0){
     514:	06054a63          	bltz	a0,588 <copyin+0xde>
    int n = write(fd, (void*)addr, 8192);
     518:	8652                	mv	a2,s4
     51a:	85ce                	mv	a1,s3
     51c:	7fc040ef          	jal	4d18 <write>
    if(n >= 0){
     520:	06055d63          	bgez	a0,59a <copyin+0xf0>
    close(fd);
     524:	8526                	mv	a0,s1
     526:	7fa040ef          	jal	4d20 <close>
    unlink("copyin1");
     52a:	8556                	mv	a0,s5
     52c:	01d040ef          	jal	4d48 <unlink>
    n = write(1, (char*)addr, 8192);
     530:	8652                	mv	a2,s4
     532:	85ce                	mv	a1,s3
     534:	8562                	mv	a0,s8
     536:	7e2040ef          	jal	4d18 <write>
    if(n > 0){
     53a:	06a04b63          	bgtz	a0,5b0 <copyin+0x106>
    if(pipe(fds) < 0){
     53e:	855e                	mv	a0,s7
     540:	7c8040ef          	jal	4d08 <pipe>
     544:	08054163          	bltz	a0,5c6 <copyin+0x11c>
    n = write(fds[1], (char*)addr, 8192);
     548:	8652                	mv	a2,s4
     54a:	85ce                	mv	a1,s3
     54c:	f7442503          	lw	a0,-140(s0)
     550:	7c8040ef          	jal	4d18 <write>
    if(n > 0){
     554:	08a04263          	bgtz	a0,5d8 <copyin+0x12e>
    close(fds[0]);
     558:	f7042503          	lw	a0,-144(s0)
     55c:	7c4040ef          	jal	4d20 <close>
    close(fds[1]);
     560:	f7442503          	lw	a0,-140(s0)
     564:	7bc040ef          	jal	4d20 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     568:	0921                	addi	s2,s2,8
     56a:	f9991ee3          	bne	s2,s9,506 <copyin+0x5c>
}
     56e:	60aa                	ld	ra,136(sp)
     570:	640a                	ld	s0,128(sp)
     572:	74e6                	ld	s1,120(sp)
     574:	7946                	ld	s2,112(sp)
     576:	79a6                	ld	s3,104(sp)
     578:	7a06                	ld	s4,96(sp)
     57a:	6ae6                	ld	s5,88(sp)
     57c:	6b46                	ld	s6,80(sp)
     57e:	6ba6                	ld	s7,72(sp)
     580:	6c06                	ld	s8,64(sp)
     582:	7ce2                	ld	s9,56(sp)
     584:	6149                	addi	sp,sp,144
     586:	8082                	ret
      printf("open(copyin1) failed\n");
     588:	00005517          	auipc	a0,0x5
     58c:	eb050513          	addi	a0,a0,-336 # 5438 <malloc+0x250>
     590:	3a1040ef          	jal	5130 <printf>
      exit(1);
     594:	4505                	li	a0,1
     596:	762040ef          	jal	4cf8 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
     59a:	862a                	mv	a2,a0
     59c:	85ce                	mv	a1,s3
     59e:	00005517          	auipc	a0,0x5
     5a2:	eb250513          	addi	a0,a0,-334 # 5450 <malloc+0x268>
     5a6:	38b040ef          	jal	5130 <printf>
      exit(1);
     5aa:	4505                	li	a0,1
     5ac:	74c040ef          	jal	4cf8 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5b0:	862a                	mv	a2,a0
     5b2:	85ce                	mv	a1,s3
     5b4:	00005517          	auipc	a0,0x5
     5b8:	ecc50513          	addi	a0,a0,-308 # 5480 <malloc+0x298>
     5bc:	375040ef          	jal	5130 <printf>
      exit(1);
     5c0:	4505                	li	a0,1
     5c2:	736040ef          	jal	4cf8 <exit>
      printf("pipe() failed\n");
     5c6:	00005517          	auipc	a0,0x5
     5ca:	eea50513          	addi	a0,a0,-278 # 54b0 <malloc+0x2c8>
     5ce:	363040ef          	jal	5130 <printf>
      exit(1);
     5d2:	4505                	li	a0,1
     5d4:	724040ef          	jal	4cf8 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5d8:	862a                	mv	a2,a0
     5da:	85ce                	mv	a1,s3
     5dc:	00005517          	auipc	a0,0x5
     5e0:	ee450513          	addi	a0,a0,-284 # 54c0 <malloc+0x2d8>
     5e4:	34d040ef          	jal	5130 <printf>
      exit(1);
     5e8:	4505                	li	a0,1
     5ea:	70e040ef          	jal	4cf8 <exit>

00000000000005ee <copyout>:
{
     5ee:	7135                	addi	sp,sp,-160
     5f0:	ed06                	sd	ra,152(sp)
     5f2:	e922                	sd	s0,144(sp)
     5f4:	e526                	sd	s1,136(sp)
     5f6:	e14a                	sd	s2,128(sp)
     5f8:	fcce                	sd	s3,120(sp)
     5fa:	f8d2                	sd	s4,112(sp)
     5fc:	f4d6                	sd	s5,104(sp)
     5fe:	f0da                	sd	s6,96(sp)
     600:	ecde                	sd	s7,88(sp)
     602:	e8e2                	sd	s8,80(sp)
     604:	e4e6                	sd	s9,72(sp)
     606:	1100                	addi	s0,sp,160
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     608:	00007797          	auipc	a5,0x7
     60c:	07078793          	addi	a5,a5,112 # 7678 <malloc+0x2490>
     610:	7788                	ld	a0,40(a5)
     612:	7b8c                	ld	a1,48(a5)
     614:	7f90                	ld	a2,56(a5)
     616:	63b4                	ld	a3,64(a5)
     618:	67b8                	ld	a4,72(a5)
     61a:	f6a43823          	sd	a0,-144(s0)
     61e:	f6b43c23          	sd	a1,-136(s0)
     622:	f8c43023          	sd	a2,-128(s0)
     626:	f8d43423          	sd	a3,-120(s0)
     62a:	f8e43823          	sd	a4,-112(s0)
     62e:	6bbc                	ld	a5,80(a5)
     630:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     634:	f7040913          	addi	s2,s0,-144
     638:	fa040c93          	addi	s9,s0,-96
    int fd = open("README", 0);
     63c:	00005b17          	auipc	s6,0x5
     640:	eb4b0b13          	addi	s6,s6,-332 # 54f0 <malloc+0x308>
    int n = read(fd, (void*)addr, 8192);
     644:	6a89                	lui	s5,0x2
    if(pipe(fds) < 0){
     646:	f6840c13          	addi	s8,s0,-152
    n = write(fds[1], "x", 1);
     64a:	4a05                	li	s4,1
     64c:	00005b97          	auipc	s7,0x5
     650:	d3cb8b93          	addi	s7,s7,-708 # 5388 <malloc+0x1a0>
    uint64 addr = addrs[ai];
     654:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     658:	4581                	li	a1,0
     65a:	855a                	mv	a0,s6
     65c:	6dc040ef          	jal	4d38 <open>
     660:	84aa                	mv	s1,a0
    if(fd < 0){
     662:	06054863          	bltz	a0,6d2 <copyout+0xe4>
    int n = read(fd, (void*)addr, 8192);
     666:	8656                	mv	a2,s5
     668:	85ce                	mv	a1,s3
     66a:	6a6040ef          	jal	4d10 <read>
    if(n > 0){
     66e:	06a04b63          	bgtz	a0,6e4 <copyout+0xf6>
    close(fd);
     672:	8526                	mv	a0,s1
     674:	6ac040ef          	jal	4d20 <close>
    if(pipe(fds) < 0){
     678:	8562                	mv	a0,s8
     67a:	68e040ef          	jal	4d08 <pipe>
     67e:	06054e63          	bltz	a0,6fa <copyout+0x10c>
    n = write(fds[1], "x", 1);
     682:	8652                	mv	a2,s4
     684:	85de                	mv	a1,s7
     686:	f6c42503          	lw	a0,-148(s0)
     68a:	68e040ef          	jal	4d18 <write>
    if(n != 1){
     68e:	07451f63          	bne	a0,s4,70c <copyout+0x11e>
    n = read(fds[0], (void*)addr, 8192);
     692:	8656                	mv	a2,s5
     694:	85ce                	mv	a1,s3
     696:	f6842503          	lw	a0,-152(s0)
     69a:	676040ef          	jal	4d10 <read>
    if(n > 0){
     69e:	08a04063          	bgtz	a0,71e <copyout+0x130>
    close(fds[0]);
     6a2:	f6842503          	lw	a0,-152(s0)
     6a6:	67a040ef          	jal	4d20 <close>
    close(fds[1]);
     6aa:	f6c42503          	lw	a0,-148(s0)
     6ae:	672040ef          	jal	4d20 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     6b2:	0921                	addi	s2,s2,8
     6b4:	fb9910e3          	bne	s2,s9,654 <copyout+0x66>
}
     6b8:	60ea                	ld	ra,152(sp)
     6ba:	644a                	ld	s0,144(sp)
     6bc:	64aa                	ld	s1,136(sp)
     6be:	690a                	ld	s2,128(sp)
     6c0:	79e6                	ld	s3,120(sp)
     6c2:	7a46                	ld	s4,112(sp)
     6c4:	7aa6                	ld	s5,104(sp)
     6c6:	7b06                	ld	s6,96(sp)
     6c8:	6be6                	ld	s7,88(sp)
     6ca:	6c46                	ld	s8,80(sp)
     6cc:	6ca6                	ld	s9,72(sp)
     6ce:	610d                	addi	sp,sp,160
     6d0:	8082                	ret
      printf("open(README) failed\n");
     6d2:	00005517          	auipc	a0,0x5
     6d6:	e2650513          	addi	a0,a0,-474 # 54f8 <malloc+0x310>
     6da:	257040ef          	jal	5130 <printf>
      exit(1);
     6de:	4505                	li	a0,1
     6e0:	618040ef          	jal	4cf8 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     6e4:	862a                	mv	a2,a0
     6e6:	85ce                	mv	a1,s3
     6e8:	00005517          	auipc	a0,0x5
     6ec:	e2850513          	addi	a0,a0,-472 # 5510 <malloc+0x328>
     6f0:	241040ef          	jal	5130 <printf>
      exit(1);
     6f4:	4505                	li	a0,1
     6f6:	602040ef          	jal	4cf8 <exit>
      printf("pipe() failed\n");
     6fa:	00005517          	auipc	a0,0x5
     6fe:	db650513          	addi	a0,a0,-586 # 54b0 <malloc+0x2c8>
     702:	22f040ef          	jal	5130 <printf>
      exit(1);
     706:	4505                	li	a0,1
     708:	5f0040ef          	jal	4cf8 <exit>
      printf("pipe write failed\n");
     70c:	00005517          	auipc	a0,0x5
     710:	e3450513          	addi	a0,a0,-460 # 5540 <malloc+0x358>
     714:	21d040ef          	jal	5130 <printf>
      exit(1);
     718:	4505                	li	a0,1
     71a:	5de040ef          	jal	4cf8 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     71e:	862a                	mv	a2,a0
     720:	85ce                	mv	a1,s3
     722:	00005517          	auipc	a0,0x5
     726:	e3650513          	addi	a0,a0,-458 # 5558 <malloc+0x370>
     72a:	207040ef          	jal	5130 <printf>
      exit(1);
     72e:	4505                	li	a0,1
     730:	5c8040ef          	jal	4cf8 <exit>

0000000000000734 <truncate1>:
{
     734:	711d                	addi	sp,sp,-96
     736:	ec86                	sd	ra,88(sp)
     738:	e8a2                	sd	s0,80(sp)
     73a:	e4a6                	sd	s1,72(sp)
     73c:	e0ca                	sd	s2,64(sp)
     73e:	fc4e                	sd	s3,56(sp)
     740:	f852                	sd	s4,48(sp)
     742:	f456                	sd	s5,40(sp)
     744:	1080                	addi	s0,sp,96
     746:	8a2a                	mv	s4,a0
  unlink("truncfile");
     748:	00005517          	auipc	a0,0x5
     74c:	c2850513          	addi	a0,a0,-984 # 5370 <malloc+0x188>
     750:	5f8040ef          	jal	4d48 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     754:	60100593          	li	a1,1537
     758:	00005517          	auipc	a0,0x5
     75c:	c1850513          	addi	a0,a0,-1000 # 5370 <malloc+0x188>
     760:	5d8040ef          	jal	4d38 <open>
     764:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     766:	4611                	li	a2,4
     768:	00005597          	auipc	a1,0x5
     76c:	c1858593          	addi	a1,a1,-1000 # 5380 <malloc+0x198>
     770:	5a8040ef          	jal	4d18 <write>
  close(fd1);
     774:	8526                	mv	a0,s1
     776:	5aa040ef          	jal	4d20 <close>
  int fd2 = open("truncfile", O_RDONLY);
     77a:	4581                	li	a1,0
     77c:	00005517          	auipc	a0,0x5
     780:	bf450513          	addi	a0,a0,-1036 # 5370 <malloc+0x188>
     784:	5b4040ef          	jal	4d38 <open>
     788:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     78a:	02000613          	li	a2,32
     78e:	fa040593          	addi	a1,s0,-96
     792:	57e040ef          	jal	4d10 <read>
  if(n != 4){
     796:	4791                	li	a5,4
     798:	0af51863          	bne	a0,a5,848 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     79c:	40100593          	li	a1,1025
     7a0:	00005517          	auipc	a0,0x5
     7a4:	bd050513          	addi	a0,a0,-1072 # 5370 <malloc+0x188>
     7a8:	590040ef          	jal	4d38 <open>
     7ac:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     7ae:	4581                	li	a1,0
     7b0:	00005517          	auipc	a0,0x5
     7b4:	bc050513          	addi	a0,a0,-1088 # 5370 <malloc+0x188>
     7b8:	580040ef          	jal	4d38 <open>
     7bc:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     7be:	02000613          	li	a2,32
     7c2:	fa040593          	addi	a1,s0,-96
     7c6:	54a040ef          	jal	4d10 <read>
     7ca:	8aaa                	mv	s5,a0
  if(n != 0){
     7cc:	e949                	bnez	a0,85e <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     7ce:	02000613          	li	a2,32
     7d2:	fa040593          	addi	a1,s0,-96
     7d6:	8526                	mv	a0,s1
     7d8:	538040ef          	jal	4d10 <read>
     7dc:	8aaa                	mv	s5,a0
  if(n != 0){
     7de:	e155                	bnez	a0,882 <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     7e0:	4619                	li	a2,6
     7e2:	00005597          	auipc	a1,0x5
     7e6:	e0658593          	addi	a1,a1,-506 # 55e8 <malloc+0x400>
     7ea:	854e                	mv	a0,s3
     7ec:	52c040ef          	jal	4d18 <write>
  n = read(fd3, buf, sizeof(buf));
     7f0:	02000613          	li	a2,32
     7f4:	fa040593          	addi	a1,s0,-96
     7f8:	854a                	mv	a0,s2
     7fa:	516040ef          	jal	4d10 <read>
  if(n != 6){
     7fe:	4799                	li	a5,6
     800:	0af51363          	bne	a0,a5,8a6 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     804:	02000613          	li	a2,32
     808:	fa040593          	addi	a1,s0,-96
     80c:	8526                	mv	a0,s1
     80e:	502040ef          	jal	4d10 <read>
  if(n != 2){
     812:	4789                	li	a5,2
     814:	0af51463          	bne	a0,a5,8bc <truncate1+0x188>
  unlink("truncfile");
     818:	00005517          	auipc	a0,0x5
     81c:	b5850513          	addi	a0,a0,-1192 # 5370 <malloc+0x188>
     820:	528040ef          	jal	4d48 <unlink>
  close(fd1);
     824:	854e                	mv	a0,s3
     826:	4fa040ef          	jal	4d20 <close>
  close(fd2);
     82a:	8526                	mv	a0,s1
     82c:	4f4040ef          	jal	4d20 <close>
  close(fd3);
     830:	854a                	mv	a0,s2
     832:	4ee040ef          	jal	4d20 <close>
}
     836:	60e6                	ld	ra,88(sp)
     838:	6446                	ld	s0,80(sp)
     83a:	64a6                	ld	s1,72(sp)
     83c:	6906                	ld	s2,64(sp)
     83e:	79e2                	ld	s3,56(sp)
     840:	7a42                	ld	s4,48(sp)
     842:	7aa2                	ld	s5,40(sp)
     844:	6125                	addi	sp,sp,96
     846:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     848:	862a                	mv	a2,a0
     84a:	85d2                	mv	a1,s4
     84c:	00005517          	auipc	a0,0x5
     850:	d3c50513          	addi	a0,a0,-708 # 5588 <malloc+0x3a0>
     854:	0dd040ef          	jal	5130 <printf>
    exit(1);
     858:	4505                	li	a0,1
     85a:	49e040ef          	jal	4cf8 <exit>
    printf("aaa fd3=%d\n", fd3);
     85e:	85ca                	mv	a1,s2
     860:	00005517          	auipc	a0,0x5
     864:	d4850513          	addi	a0,a0,-696 # 55a8 <malloc+0x3c0>
     868:	0c9040ef          	jal	5130 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     86c:	8656                	mv	a2,s5
     86e:	85d2                	mv	a1,s4
     870:	00005517          	auipc	a0,0x5
     874:	d4850513          	addi	a0,a0,-696 # 55b8 <malloc+0x3d0>
     878:	0b9040ef          	jal	5130 <printf>
    exit(1);
     87c:	4505                	li	a0,1
     87e:	47a040ef          	jal	4cf8 <exit>
    printf("bbb fd2=%d\n", fd2);
     882:	85a6                	mv	a1,s1
     884:	00005517          	auipc	a0,0x5
     888:	d5450513          	addi	a0,a0,-684 # 55d8 <malloc+0x3f0>
     88c:	0a5040ef          	jal	5130 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     890:	8656                	mv	a2,s5
     892:	85d2                	mv	a1,s4
     894:	00005517          	auipc	a0,0x5
     898:	d2450513          	addi	a0,a0,-732 # 55b8 <malloc+0x3d0>
     89c:	095040ef          	jal	5130 <printf>
    exit(1);
     8a0:	4505                	li	a0,1
     8a2:	456040ef          	jal	4cf8 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8a6:	862a                	mv	a2,a0
     8a8:	85d2                	mv	a1,s4
     8aa:	00005517          	auipc	a0,0x5
     8ae:	d4650513          	addi	a0,a0,-698 # 55f0 <malloc+0x408>
     8b2:	07f040ef          	jal	5130 <printf>
    exit(1);
     8b6:	4505                	li	a0,1
     8b8:	440040ef          	jal	4cf8 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8bc:	862a                	mv	a2,a0
     8be:	85d2                	mv	a1,s4
     8c0:	00005517          	auipc	a0,0x5
     8c4:	d5050513          	addi	a0,a0,-688 # 5610 <malloc+0x428>
     8c8:	069040ef          	jal	5130 <printf>
    exit(1);
     8cc:	4505                	li	a0,1
     8ce:	42a040ef          	jal	4cf8 <exit>

00000000000008d2 <writetest>:
{
     8d2:	715d                	addi	sp,sp,-80
     8d4:	e486                	sd	ra,72(sp)
     8d6:	e0a2                	sd	s0,64(sp)
     8d8:	fc26                	sd	s1,56(sp)
     8da:	f84a                	sd	s2,48(sp)
     8dc:	f44e                	sd	s3,40(sp)
     8de:	f052                	sd	s4,32(sp)
     8e0:	ec56                	sd	s5,24(sp)
     8e2:	e85a                	sd	s6,16(sp)
     8e4:	e45e                	sd	s7,8(sp)
     8e6:	0880                	addi	s0,sp,80
     8e8:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     8ea:	20200593          	li	a1,514
     8ee:	00005517          	auipc	a0,0x5
     8f2:	d4250513          	addi	a0,a0,-702 # 5630 <malloc+0x448>
     8f6:	442040ef          	jal	4d38 <open>
  if(fd < 0){
     8fa:	08054f63          	bltz	a0,998 <writetest+0xc6>
     8fe:	89aa                	mv	s3,a0
     900:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     902:	44a9                	li	s1,10
     904:	00005a17          	auipc	s4,0x5
     908:	d54a0a13          	addi	s4,s4,-684 # 5658 <malloc+0x470>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     90c:	00005b17          	auipc	s6,0x5
     910:	d84b0b13          	addi	s6,s6,-636 # 5690 <malloc+0x4a8>
  for(i = 0; i < N; i++){
     914:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     918:	8626                	mv	a2,s1
     91a:	85d2                	mv	a1,s4
     91c:	854e                	mv	a0,s3
     91e:	3fa040ef          	jal	4d18 <write>
     922:	08951563          	bne	a0,s1,9ac <writetest+0xda>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     926:	8626                	mv	a2,s1
     928:	85da                	mv	a1,s6
     92a:	854e                	mv	a0,s3
     92c:	3ec040ef          	jal	4d18 <write>
     930:	08951963          	bne	a0,s1,9c2 <writetest+0xf0>
  for(i = 0; i < N; i++){
     934:	2905                	addiw	s2,s2,1
     936:	ff5911e3          	bne	s2,s5,918 <writetest+0x46>
  close(fd);
     93a:	854e                	mv	a0,s3
     93c:	3e4040ef          	jal	4d20 <close>
  fd = open("small", O_RDONLY);
     940:	4581                	li	a1,0
     942:	00005517          	auipc	a0,0x5
     946:	cee50513          	addi	a0,a0,-786 # 5630 <malloc+0x448>
     94a:	3ee040ef          	jal	4d38 <open>
     94e:	84aa                	mv	s1,a0
  if(fd < 0){
     950:	08054463          	bltz	a0,9d8 <writetest+0x106>
  i = read(fd, buf, N*SZ*2);
     954:	7d000613          	li	a2,2000
     958:	0000c597          	auipc	a1,0xc
     95c:	32058593          	addi	a1,a1,800 # cc78 <buf>
     960:	3b0040ef          	jal	4d10 <read>
  if(i != N*SZ*2){
     964:	7d000793          	li	a5,2000
     968:	08f51263          	bne	a0,a5,9ec <writetest+0x11a>
  close(fd);
     96c:	8526                	mv	a0,s1
     96e:	3b2040ef          	jal	4d20 <close>
  if(unlink("small") < 0){
     972:	00005517          	auipc	a0,0x5
     976:	cbe50513          	addi	a0,a0,-834 # 5630 <malloc+0x448>
     97a:	3ce040ef          	jal	4d48 <unlink>
     97e:	08054163          	bltz	a0,a00 <writetest+0x12e>
}
     982:	60a6                	ld	ra,72(sp)
     984:	6406                	ld	s0,64(sp)
     986:	74e2                	ld	s1,56(sp)
     988:	7942                	ld	s2,48(sp)
     98a:	79a2                	ld	s3,40(sp)
     98c:	7a02                	ld	s4,32(sp)
     98e:	6ae2                	ld	s5,24(sp)
     990:	6b42                	ld	s6,16(sp)
     992:	6ba2                	ld	s7,8(sp)
     994:	6161                	addi	sp,sp,80
     996:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     998:	85de                	mv	a1,s7
     99a:	00005517          	auipc	a0,0x5
     99e:	c9e50513          	addi	a0,a0,-866 # 5638 <malloc+0x450>
     9a2:	78e040ef          	jal	5130 <printf>
    exit(1);
     9a6:	4505                	li	a0,1
     9a8:	350040ef          	jal	4cf8 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     9ac:	864a                	mv	a2,s2
     9ae:	85de                	mv	a1,s7
     9b0:	00005517          	auipc	a0,0x5
     9b4:	cb850513          	addi	a0,a0,-840 # 5668 <malloc+0x480>
     9b8:	778040ef          	jal	5130 <printf>
      exit(1);
     9bc:	4505                	li	a0,1
     9be:	33a040ef          	jal	4cf8 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     9c2:	864a                	mv	a2,s2
     9c4:	85de                	mv	a1,s7
     9c6:	00005517          	auipc	a0,0x5
     9ca:	cda50513          	addi	a0,a0,-806 # 56a0 <malloc+0x4b8>
     9ce:	762040ef          	jal	5130 <printf>
      exit(1);
     9d2:	4505                	li	a0,1
     9d4:	324040ef          	jal	4cf8 <exit>
    printf("%s: error: open small failed!\n", s);
     9d8:	85de                	mv	a1,s7
     9da:	00005517          	auipc	a0,0x5
     9de:	cee50513          	addi	a0,a0,-786 # 56c8 <malloc+0x4e0>
     9e2:	74e040ef          	jal	5130 <printf>
    exit(1);
     9e6:	4505                	li	a0,1
     9e8:	310040ef          	jal	4cf8 <exit>
    printf("%s: read failed\n", s);
     9ec:	85de                	mv	a1,s7
     9ee:	00005517          	auipc	a0,0x5
     9f2:	cfa50513          	addi	a0,a0,-774 # 56e8 <malloc+0x500>
     9f6:	73a040ef          	jal	5130 <printf>
    exit(1);
     9fa:	4505                	li	a0,1
     9fc:	2fc040ef          	jal	4cf8 <exit>
    printf("%s: unlink small failed\n", s);
     a00:	85de                	mv	a1,s7
     a02:	00005517          	auipc	a0,0x5
     a06:	cfe50513          	addi	a0,a0,-770 # 5700 <malloc+0x518>
     a0a:	726040ef          	jal	5130 <printf>
    exit(1);
     a0e:	4505                	li	a0,1
     a10:	2e8040ef          	jal	4cf8 <exit>

0000000000000a14 <writebig>:
{
     a14:	7139                	addi	sp,sp,-64
     a16:	fc06                	sd	ra,56(sp)
     a18:	f822                	sd	s0,48(sp)
     a1a:	f426                	sd	s1,40(sp)
     a1c:	f04a                	sd	s2,32(sp)
     a1e:	ec4e                	sd	s3,24(sp)
     a20:	e852                	sd	s4,16(sp)
     a22:	e456                	sd	s5,8(sp)
     a24:	e05a                	sd	s6,0(sp)
     a26:	0080                	addi	s0,sp,64
     a28:	8b2a                	mv	s6,a0
  fd = open("big", O_CREATE|O_RDWR);
     a2a:	20200593          	li	a1,514
     a2e:	00005517          	auipc	a0,0x5
     a32:	cf250513          	addi	a0,a0,-782 # 5720 <malloc+0x538>
     a36:	302040ef          	jal	4d38 <open>
  if(fd < 0){
     a3a:	06054a63          	bltz	a0,aae <writebig+0x9a>
     a3e:	8a2a                	mv	s4,a0
     a40:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     a42:	0000c997          	auipc	s3,0xc
     a46:	23698993          	addi	s3,s3,566 # cc78 <buf>
    if(write(fd, buf, BSIZE) != BSIZE){
     a4a:	40000913          	li	s2,1024
  for(i = 0; i < MAXFILE; i++){
     a4e:	10c00a93          	li	s5,268
    ((int*)buf)[0] = i;
     a52:	0099a023          	sw	s1,0(s3)
    if(write(fd, buf, BSIZE) != BSIZE){
     a56:	864a                	mv	a2,s2
     a58:	85ce                	mv	a1,s3
     a5a:	8552                	mv	a0,s4
     a5c:	2bc040ef          	jal	4d18 <write>
     a60:	07251163          	bne	a0,s2,ac2 <writebig+0xae>
  for(i = 0; i < MAXFILE; i++){
     a64:	2485                	addiw	s1,s1,1
     a66:	ff5496e3          	bne	s1,s5,a52 <writebig+0x3e>
  close(fd);
     a6a:	8552                	mv	a0,s4
     a6c:	2b4040ef          	jal	4d20 <close>
  fd = open("big", O_RDONLY);
     a70:	4581                	li	a1,0
     a72:	00005517          	auipc	a0,0x5
     a76:	cae50513          	addi	a0,a0,-850 # 5720 <malloc+0x538>
     a7a:	2be040ef          	jal	4d38 <open>
     a7e:	8a2a                	mv	s4,a0
  n = 0;
     a80:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a82:	40000993          	li	s3,1024
     a86:	0000c917          	auipc	s2,0xc
     a8a:	1f290913          	addi	s2,s2,498 # cc78 <buf>
  if(fd < 0){
     a8e:	04054563          	bltz	a0,ad8 <writebig+0xc4>
    i = read(fd, buf, BSIZE);
     a92:	864e                	mv	a2,s3
     a94:	85ca                	mv	a1,s2
     a96:	8552                	mv	a0,s4
     a98:	278040ef          	jal	4d10 <read>
    if(i == 0){
     a9c:	c921                	beqz	a0,aec <writebig+0xd8>
    } else if(i != BSIZE){
     a9e:	09351b63          	bne	a0,s3,b34 <writebig+0x120>
    if(((int*)buf)[0] != n){
     aa2:	00092683          	lw	a3,0(s2)
     aa6:	0a969263          	bne	a3,s1,b4a <writebig+0x136>
    n++;
     aaa:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     aac:	b7dd                	j	a92 <writebig+0x7e>
    printf("%s: error: creat big failed!\n", s);
     aae:	85da                	mv	a1,s6
     ab0:	00005517          	auipc	a0,0x5
     ab4:	c7850513          	addi	a0,a0,-904 # 5728 <malloc+0x540>
     ab8:	678040ef          	jal	5130 <printf>
    exit(1);
     abc:	4505                	li	a0,1
     abe:	23a040ef          	jal	4cf8 <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     ac2:	8626                	mv	a2,s1
     ac4:	85da                	mv	a1,s6
     ac6:	00005517          	auipc	a0,0x5
     aca:	c8250513          	addi	a0,a0,-894 # 5748 <malloc+0x560>
     ace:	662040ef          	jal	5130 <printf>
      exit(1);
     ad2:	4505                	li	a0,1
     ad4:	224040ef          	jal	4cf8 <exit>
    printf("%s: error: open big failed!\n", s);
     ad8:	85da                	mv	a1,s6
     ada:	00005517          	auipc	a0,0x5
     ade:	c9650513          	addi	a0,a0,-874 # 5770 <malloc+0x588>
     ae2:	64e040ef          	jal	5130 <printf>
    exit(1);
     ae6:	4505                	li	a0,1
     ae8:	210040ef          	jal	4cf8 <exit>
      if(n != MAXFILE){
     aec:	10c00793          	li	a5,268
     af0:	02f49763          	bne	s1,a5,b1e <writebig+0x10a>
  close(fd);
     af4:	8552                	mv	a0,s4
     af6:	22a040ef          	jal	4d20 <close>
  if(unlink("big") < 0){
     afa:	00005517          	auipc	a0,0x5
     afe:	c2650513          	addi	a0,a0,-986 # 5720 <malloc+0x538>
     b02:	246040ef          	jal	4d48 <unlink>
     b06:	04054d63          	bltz	a0,b60 <writebig+0x14c>
}
     b0a:	70e2                	ld	ra,56(sp)
     b0c:	7442                	ld	s0,48(sp)
     b0e:	74a2                	ld	s1,40(sp)
     b10:	7902                	ld	s2,32(sp)
     b12:	69e2                	ld	s3,24(sp)
     b14:	6a42                	ld	s4,16(sp)
     b16:	6aa2                	ld	s5,8(sp)
     b18:	6b02                	ld	s6,0(sp)
     b1a:	6121                	addi	sp,sp,64
     b1c:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     b1e:	8626                	mv	a2,s1
     b20:	85da                	mv	a1,s6
     b22:	00005517          	auipc	a0,0x5
     b26:	c6e50513          	addi	a0,a0,-914 # 5790 <malloc+0x5a8>
     b2a:	606040ef          	jal	5130 <printf>
        exit(1);
     b2e:	4505                	li	a0,1
     b30:	1c8040ef          	jal	4cf8 <exit>
      printf("%s: read failed %d\n", s, i);
     b34:	862a                	mv	a2,a0
     b36:	85da                	mv	a1,s6
     b38:	00005517          	auipc	a0,0x5
     b3c:	c8050513          	addi	a0,a0,-896 # 57b8 <malloc+0x5d0>
     b40:	5f0040ef          	jal	5130 <printf>
      exit(1);
     b44:	4505                	li	a0,1
     b46:	1b2040ef          	jal	4cf8 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b4a:	8626                	mv	a2,s1
     b4c:	85da                	mv	a1,s6
     b4e:	00005517          	auipc	a0,0x5
     b52:	c8250513          	addi	a0,a0,-894 # 57d0 <malloc+0x5e8>
     b56:	5da040ef          	jal	5130 <printf>
      exit(1);
     b5a:	4505                	li	a0,1
     b5c:	19c040ef          	jal	4cf8 <exit>
    printf("%s: unlink big failed\n", s);
     b60:	85da                	mv	a1,s6
     b62:	00005517          	auipc	a0,0x5
     b66:	c9650513          	addi	a0,a0,-874 # 57f8 <malloc+0x610>
     b6a:	5c6040ef          	jal	5130 <printf>
    exit(1);
     b6e:	4505                	li	a0,1
     b70:	188040ef          	jal	4cf8 <exit>

0000000000000b74 <unlinkread>:
{
     b74:	7179                	addi	sp,sp,-48
     b76:	f406                	sd	ra,40(sp)
     b78:	f022                	sd	s0,32(sp)
     b7a:	ec26                	sd	s1,24(sp)
     b7c:	e84a                	sd	s2,16(sp)
     b7e:	e44e                	sd	s3,8(sp)
     b80:	1800                	addi	s0,sp,48
     b82:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b84:	20200593          	li	a1,514
     b88:	00005517          	auipc	a0,0x5
     b8c:	c8850513          	addi	a0,a0,-888 # 5810 <malloc+0x628>
     b90:	1a8040ef          	jal	4d38 <open>
  if(fd < 0){
     b94:	0a054f63          	bltz	a0,c52 <unlinkread+0xde>
     b98:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b9a:	4615                	li	a2,5
     b9c:	00005597          	auipc	a1,0x5
     ba0:	ca458593          	addi	a1,a1,-860 # 5840 <malloc+0x658>
     ba4:	174040ef          	jal	4d18 <write>
  close(fd);
     ba8:	8526                	mv	a0,s1
     baa:	176040ef          	jal	4d20 <close>
  fd = open("unlinkread", O_RDWR);
     bae:	4589                	li	a1,2
     bb0:	00005517          	auipc	a0,0x5
     bb4:	c6050513          	addi	a0,a0,-928 # 5810 <malloc+0x628>
     bb8:	180040ef          	jal	4d38 <open>
     bbc:	84aa                	mv	s1,a0
  if(fd < 0){
     bbe:	0a054463          	bltz	a0,c66 <unlinkread+0xf2>
  if(unlink("unlinkread") != 0){
     bc2:	00005517          	auipc	a0,0x5
     bc6:	c4e50513          	addi	a0,a0,-946 # 5810 <malloc+0x628>
     bca:	17e040ef          	jal	4d48 <unlink>
     bce:	e555                	bnez	a0,c7a <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd0:	20200593          	li	a1,514
     bd4:	00005517          	auipc	a0,0x5
     bd8:	c3c50513          	addi	a0,a0,-964 # 5810 <malloc+0x628>
     bdc:	15c040ef          	jal	4d38 <open>
     be0:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be2:	460d                	li	a2,3
     be4:	00005597          	auipc	a1,0x5
     be8:	ca458593          	addi	a1,a1,-860 # 5888 <malloc+0x6a0>
     bec:	12c040ef          	jal	4d18 <write>
  close(fd1);
     bf0:	854a                	mv	a0,s2
     bf2:	12e040ef          	jal	4d20 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     bf6:	660d                	lui	a2,0x3
     bf8:	0000c597          	auipc	a1,0xc
     bfc:	08058593          	addi	a1,a1,128 # cc78 <buf>
     c00:	8526                	mv	a0,s1
     c02:	10e040ef          	jal	4d10 <read>
     c06:	4795                	li	a5,5
     c08:	08f51363          	bne	a0,a5,c8e <unlinkread+0x11a>
  if(buf[0] != 'h'){
     c0c:	0000c717          	auipc	a4,0xc
     c10:	06c74703          	lbu	a4,108(a4) # cc78 <buf>
     c14:	06800793          	li	a5,104
     c18:	08f71563          	bne	a4,a5,ca2 <unlinkread+0x12e>
  if(write(fd, buf, 10) != 10){
     c1c:	4629                	li	a2,10
     c1e:	0000c597          	auipc	a1,0xc
     c22:	05a58593          	addi	a1,a1,90 # cc78 <buf>
     c26:	8526                	mv	a0,s1
     c28:	0f0040ef          	jal	4d18 <write>
     c2c:	47a9                	li	a5,10
     c2e:	08f51463          	bne	a0,a5,cb6 <unlinkread+0x142>
  close(fd);
     c32:	8526                	mv	a0,s1
     c34:	0ec040ef          	jal	4d20 <close>
  unlink("unlinkread");
     c38:	00005517          	auipc	a0,0x5
     c3c:	bd850513          	addi	a0,a0,-1064 # 5810 <malloc+0x628>
     c40:	108040ef          	jal	4d48 <unlink>
}
     c44:	70a2                	ld	ra,40(sp)
     c46:	7402                	ld	s0,32(sp)
     c48:	64e2                	ld	s1,24(sp)
     c4a:	6942                	ld	s2,16(sp)
     c4c:	69a2                	ld	s3,8(sp)
     c4e:	6145                	addi	sp,sp,48
     c50:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c52:	85ce                	mv	a1,s3
     c54:	00005517          	auipc	a0,0x5
     c58:	bcc50513          	addi	a0,a0,-1076 # 5820 <malloc+0x638>
     c5c:	4d4040ef          	jal	5130 <printf>
    exit(1);
     c60:	4505                	li	a0,1
     c62:	096040ef          	jal	4cf8 <exit>
    printf("%s: open unlinkread failed\n", s);
     c66:	85ce                	mv	a1,s3
     c68:	00005517          	auipc	a0,0x5
     c6c:	be050513          	addi	a0,a0,-1056 # 5848 <malloc+0x660>
     c70:	4c0040ef          	jal	5130 <printf>
    exit(1);
     c74:	4505                	li	a0,1
     c76:	082040ef          	jal	4cf8 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c7a:	85ce                	mv	a1,s3
     c7c:	00005517          	auipc	a0,0x5
     c80:	bec50513          	addi	a0,a0,-1044 # 5868 <malloc+0x680>
     c84:	4ac040ef          	jal	5130 <printf>
    exit(1);
     c88:	4505                	li	a0,1
     c8a:	06e040ef          	jal	4cf8 <exit>
    printf("%s: unlinkread read failed", s);
     c8e:	85ce                	mv	a1,s3
     c90:	00005517          	auipc	a0,0x5
     c94:	c0050513          	addi	a0,a0,-1024 # 5890 <malloc+0x6a8>
     c98:	498040ef          	jal	5130 <printf>
    exit(1);
     c9c:	4505                	li	a0,1
     c9e:	05a040ef          	jal	4cf8 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ca2:	85ce                	mv	a1,s3
     ca4:	00005517          	auipc	a0,0x5
     ca8:	c0c50513          	addi	a0,a0,-1012 # 58b0 <malloc+0x6c8>
     cac:	484040ef          	jal	5130 <printf>
    exit(1);
     cb0:	4505                	li	a0,1
     cb2:	046040ef          	jal	4cf8 <exit>
    printf("%s: unlinkread write failed\n", s);
     cb6:	85ce                	mv	a1,s3
     cb8:	00005517          	auipc	a0,0x5
     cbc:	c1850513          	addi	a0,a0,-1000 # 58d0 <malloc+0x6e8>
     cc0:	470040ef          	jal	5130 <printf>
    exit(1);
     cc4:	4505                	li	a0,1
     cc6:	032040ef          	jal	4cf8 <exit>

0000000000000cca <linktest>:
{
     cca:	1101                	addi	sp,sp,-32
     ccc:	ec06                	sd	ra,24(sp)
     cce:	e822                	sd	s0,16(sp)
     cd0:	e426                	sd	s1,8(sp)
     cd2:	e04a                	sd	s2,0(sp)
     cd4:	1000                	addi	s0,sp,32
     cd6:	892a                	mv	s2,a0
  unlink("lf1");
     cd8:	00005517          	auipc	a0,0x5
     cdc:	c1850513          	addi	a0,a0,-1000 # 58f0 <malloc+0x708>
     ce0:	068040ef          	jal	4d48 <unlink>
  unlink("lf2");
     ce4:	00005517          	auipc	a0,0x5
     ce8:	c1450513          	addi	a0,a0,-1004 # 58f8 <malloc+0x710>
     cec:	05c040ef          	jal	4d48 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     cf0:	20200593          	li	a1,514
     cf4:	00005517          	auipc	a0,0x5
     cf8:	bfc50513          	addi	a0,a0,-1028 # 58f0 <malloc+0x708>
     cfc:	03c040ef          	jal	4d38 <open>
  if(fd < 0){
     d00:	0c054f63          	bltz	a0,dde <linktest+0x114>
     d04:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d06:	4615                	li	a2,5
     d08:	00005597          	auipc	a1,0x5
     d0c:	b3858593          	addi	a1,a1,-1224 # 5840 <malloc+0x658>
     d10:	008040ef          	jal	4d18 <write>
     d14:	4795                	li	a5,5
     d16:	0cf51e63          	bne	a0,a5,df2 <linktest+0x128>
  close(fd);
     d1a:	8526                	mv	a0,s1
     d1c:	004040ef          	jal	4d20 <close>
  if(link("lf1", "lf2") < 0){
     d20:	00005597          	auipc	a1,0x5
     d24:	bd858593          	addi	a1,a1,-1064 # 58f8 <malloc+0x710>
     d28:	00005517          	auipc	a0,0x5
     d2c:	bc850513          	addi	a0,a0,-1080 # 58f0 <malloc+0x708>
     d30:	028040ef          	jal	4d58 <link>
     d34:	0c054963          	bltz	a0,e06 <linktest+0x13c>
  unlink("lf1");
     d38:	00005517          	auipc	a0,0x5
     d3c:	bb850513          	addi	a0,a0,-1096 # 58f0 <malloc+0x708>
     d40:	008040ef          	jal	4d48 <unlink>
  if(open("lf1", 0) >= 0){
     d44:	4581                	li	a1,0
     d46:	00005517          	auipc	a0,0x5
     d4a:	baa50513          	addi	a0,a0,-1110 # 58f0 <malloc+0x708>
     d4e:	7eb030ef          	jal	4d38 <open>
     d52:	0c055463          	bgez	a0,e1a <linktest+0x150>
  fd = open("lf2", 0);
     d56:	4581                	li	a1,0
     d58:	00005517          	auipc	a0,0x5
     d5c:	ba050513          	addi	a0,a0,-1120 # 58f8 <malloc+0x710>
     d60:	7d9030ef          	jal	4d38 <open>
     d64:	84aa                	mv	s1,a0
  if(fd < 0){
     d66:	0c054463          	bltz	a0,e2e <linktest+0x164>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d6a:	660d                	lui	a2,0x3
     d6c:	0000c597          	auipc	a1,0xc
     d70:	f0c58593          	addi	a1,a1,-244 # cc78 <buf>
     d74:	79d030ef          	jal	4d10 <read>
     d78:	4795                	li	a5,5
     d7a:	0cf51463          	bne	a0,a5,e42 <linktest+0x178>
  close(fd);
     d7e:	8526                	mv	a0,s1
     d80:	7a1030ef          	jal	4d20 <close>
  if(link("lf2", "lf2") >= 0){
     d84:	00005597          	auipc	a1,0x5
     d88:	b7458593          	addi	a1,a1,-1164 # 58f8 <malloc+0x710>
     d8c:	852e                	mv	a0,a1
     d8e:	7cb030ef          	jal	4d58 <link>
     d92:	0c055263          	bgez	a0,e56 <linktest+0x18c>
  unlink("lf2");
     d96:	00005517          	auipc	a0,0x5
     d9a:	b6250513          	addi	a0,a0,-1182 # 58f8 <malloc+0x710>
     d9e:	7ab030ef          	jal	4d48 <unlink>
  if(link("lf2", "lf1") >= 0){
     da2:	00005597          	auipc	a1,0x5
     da6:	b4e58593          	addi	a1,a1,-1202 # 58f0 <malloc+0x708>
     daa:	00005517          	auipc	a0,0x5
     dae:	b4e50513          	addi	a0,a0,-1202 # 58f8 <malloc+0x710>
     db2:	7a7030ef          	jal	4d58 <link>
     db6:	0a055a63          	bgez	a0,e6a <linktest+0x1a0>
  if(link(".", "lf1") >= 0){
     dba:	00005597          	auipc	a1,0x5
     dbe:	b3658593          	addi	a1,a1,-1226 # 58f0 <malloc+0x708>
     dc2:	00005517          	auipc	a0,0x5
     dc6:	c3e50513          	addi	a0,a0,-962 # 5a00 <malloc+0x818>
     dca:	78f030ef          	jal	4d58 <link>
     dce:	0a055863          	bgez	a0,e7e <linktest+0x1b4>
}
     dd2:	60e2                	ld	ra,24(sp)
     dd4:	6442                	ld	s0,16(sp)
     dd6:	64a2                	ld	s1,8(sp)
     dd8:	6902                	ld	s2,0(sp)
     dda:	6105                	addi	sp,sp,32
     ddc:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     dde:	85ca                	mv	a1,s2
     de0:	00005517          	auipc	a0,0x5
     de4:	b2050513          	addi	a0,a0,-1248 # 5900 <malloc+0x718>
     de8:	348040ef          	jal	5130 <printf>
    exit(1);
     dec:	4505                	li	a0,1
     dee:	70b030ef          	jal	4cf8 <exit>
    printf("%s: write lf1 failed\n", s);
     df2:	85ca                	mv	a1,s2
     df4:	00005517          	auipc	a0,0x5
     df8:	b2450513          	addi	a0,a0,-1244 # 5918 <malloc+0x730>
     dfc:	334040ef          	jal	5130 <printf>
    exit(1);
     e00:	4505                	li	a0,1
     e02:	6f7030ef          	jal	4cf8 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e06:	85ca                	mv	a1,s2
     e08:	00005517          	auipc	a0,0x5
     e0c:	b2850513          	addi	a0,a0,-1240 # 5930 <malloc+0x748>
     e10:	320040ef          	jal	5130 <printf>
    exit(1);
     e14:	4505                	li	a0,1
     e16:	6e3030ef          	jal	4cf8 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     e1a:	85ca                	mv	a1,s2
     e1c:	00005517          	auipc	a0,0x5
     e20:	b3450513          	addi	a0,a0,-1228 # 5950 <malloc+0x768>
     e24:	30c040ef          	jal	5130 <printf>
    exit(1);
     e28:	4505                	li	a0,1
     e2a:	6cf030ef          	jal	4cf8 <exit>
    printf("%s: open lf2 failed\n", s);
     e2e:	85ca                	mv	a1,s2
     e30:	00005517          	auipc	a0,0x5
     e34:	b5050513          	addi	a0,a0,-1200 # 5980 <malloc+0x798>
     e38:	2f8040ef          	jal	5130 <printf>
    exit(1);
     e3c:	4505                	li	a0,1
     e3e:	6bb030ef          	jal	4cf8 <exit>
    printf("%s: read lf2 failed\n", s);
     e42:	85ca                	mv	a1,s2
     e44:	00005517          	auipc	a0,0x5
     e48:	b5450513          	addi	a0,a0,-1196 # 5998 <malloc+0x7b0>
     e4c:	2e4040ef          	jal	5130 <printf>
    exit(1);
     e50:	4505                	li	a0,1
     e52:	6a7030ef          	jal	4cf8 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e56:	85ca                	mv	a1,s2
     e58:	00005517          	auipc	a0,0x5
     e5c:	b5850513          	addi	a0,a0,-1192 # 59b0 <malloc+0x7c8>
     e60:	2d0040ef          	jal	5130 <printf>
    exit(1);
     e64:	4505                	li	a0,1
     e66:	693030ef          	jal	4cf8 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e6a:	85ca                	mv	a1,s2
     e6c:	00005517          	auipc	a0,0x5
     e70:	b6c50513          	addi	a0,a0,-1172 # 59d8 <malloc+0x7f0>
     e74:	2bc040ef          	jal	5130 <printf>
    exit(1);
     e78:	4505                	li	a0,1
     e7a:	67f030ef          	jal	4cf8 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e7e:	85ca                	mv	a1,s2
     e80:	00005517          	auipc	a0,0x5
     e84:	b8850513          	addi	a0,a0,-1144 # 5a08 <malloc+0x820>
     e88:	2a8040ef          	jal	5130 <printf>
    exit(1);
     e8c:	4505                	li	a0,1
     e8e:	66b030ef          	jal	4cf8 <exit>

0000000000000e92 <validatetest>:
{
     e92:	7139                	addi	sp,sp,-64
     e94:	fc06                	sd	ra,56(sp)
     e96:	f822                	sd	s0,48(sp)
     e98:	f426                	sd	s1,40(sp)
     e9a:	f04a                	sd	s2,32(sp)
     e9c:	ec4e                	sd	s3,24(sp)
     e9e:	e852                	sd	s4,16(sp)
     ea0:	e456                	sd	s5,8(sp)
     ea2:	e05a                	sd	s6,0(sp)
     ea4:	0080                	addi	s0,sp,64
     ea6:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     ea8:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
     eaa:	00005997          	auipc	s3,0x5
     eae:	b7e98993          	addi	s3,s3,-1154 # 5a28 <malloc+0x840>
     eb2:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     eb4:	6a85                	lui	s5,0x1
     eb6:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
     eba:	85a6                	mv	a1,s1
     ebc:	854e                	mv	a0,s3
     ebe:	69b030ef          	jal	4d58 <link>
     ec2:	01251f63          	bne	a0,s2,ee0 <validatetest+0x4e>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     ec6:	94d6                	add	s1,s1,s5
     ec8:	ff4499e3          	bne	s1,s4,eba <validatetest+0x28>
}
     ecc:	70e2                	ld	ra,56(sp)
     ece:	7442                	ld	s0,48(sp)
     ed0:	74a2                	ld	s1,40(sp)
     ed2:	7902                	ld	s2,32(sp)
     ed4:	69e2                	ld	s3,24(sp)
     ed6:	6a42                	ld	s4,16(sp)
     ed8:	6aa2                	ld	s5,8(sp)
     eda:	6b02                	ld	s6,0(sp)
     edc:	6121                	addi	sp,sp,64
     ede:	8082                	ret
      printf("%s: link should not succeed\n", s);
     ee0:	85da                	mv	a1,s6
     ee2:	00005517          	auipc	a0,0x5
     ee6:	b5650513          	addi	a0,a0,-1194 # 5a38 <malloc+0x850>
     eea:	246040ef          	jal	5130 <printf>
      exit(1);
     eee:	4505                	li	a0,1
     ef0:	609030ef          	jal	4cf8 <exit>

0000000000000ef4 <bigdir>:
{
     ef4:	711d                	addi	sp,sp,-96
     ef6:	ec86                	sd	ra,88(sp)
     ef8:	e8a2                	sd	s0,80(sp)
     efa:	e4a6                	sd	s1,72(sp)
     efc:	e0ca                	sd	s2,64(sp)
     efe:	fc4e                	sd	s3,56(sp)
     f00:	f852                	sd	s4,48(sp)
     f02:	f456                	sd	s5,40(sp)
     f04:	f05a                	sd	s6,32(sp)
     f06:	ec5e                	sd	s7,24(sp)
     f08:	1080                	addi	s0,sp,96
     f0a:	8baa                	mv	s7,a0
  unlink("bd");
     f0c:	00005517          	auipc	a0,0x5
     f10:	b4c50513          	addi	a0,a0,-1204 # 5a58 <malloc+0x870>
     f14:	635030ef          	jal	4d48 <unlink>
  fd = open("bd", O_CREATE);
     f18:	20000593          	li	a1,512
     f1c:	00005517          	auipc	a0,0x5
     f20:	b3c50513          	addi	a0,a0,-1220 # 5a58 <malloc+0x870>
     f24:	615030ef          	jal	4d38 <open>
  if(fd < 0){
     f28:	0c054463          	bltz	a0,ff0 <bigdir+0xfc>
  close(fd);
     f2c:	5f5030ef          	jal	4d20 <close>
  for(i = 0; i < N; i++){
     f30:	4901                	li	s2,0
    name[0] = 'x';
     f32:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     f36:	fa040a13          	addi	s4,s0,-96
     f3a:	00005997          	auipc	s3,0x5
     f3e:	b1e98993          	addi	s3,s3,-1250 # 5a58 <malloc+0x870>
  for(i = 0; i < N; i++){
     f42:	1f400b13          	li	s6,500
    name[0] = 'x';
     f46:	fb540023          	sb	s5,-96(s0)
    name[1] = '0' + (i / 64);
     f4a:	41f9571b          	sraiw	a4,s2,0x1f
     f4e:	01a7571b          	srliw	a4,a4,0x1a
     f52:	012707bb          	addw	a5,a4,s2
     f56:	4067d69b          	sraiw	a3,a5,0x6
     f5a:	0306869b          	addiw	a3,a3,48
     f5e:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     f62:	03f7f793          	andi	a5,a5,63
     f66:	9f99                	subw	a5,a5,a4
     f68:	0307879b          	addiw	a5,a5,48
     f6c:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     f70:	fa0401a3          	sb	zero,-93(s0)
    if(link("bd", name) != 0){
     f74:	85d2                	mv	a1,s4
     f76:	854e                	mv	a0,s3
     f78:	5e1030ef          	jal	4d58 <link>
     f7c:	84aa                	mv	s1,a0
     f7e:	e159                	bnez	a0,1004 <bigdir+0x110>
  for(i = 0; i < N; i++){
     f80:	2905                	addiw	s2,s2,1
     f82:	fd6912e3          	bne	s2,s6,f46 <bigdir+0x52>
  unlink("bd");
     f86:	00005517          	auipc	a0,0x5
     f8a:	ad250513          	addi	a0,a0,-1326 # 5a58 <malloc+0x870>
     f8e:	5bb030ef          	jal	4d48 <unlink>
    name[0] = 'x';
     f92:	07800993          	li	s3,120
    if(unlink(name) != 0){
     f96:	fa040913          	addi	s2,s0,-96
  for(i = 0; i < N; i++){
     f9a:	1f400a13          	li	s4,500
    name[0] = 'x';
     f9e:	fb340023          	sb	s3,-96(s0)
    name[1] = '0' + (i / 64);
     fa2:	41f4d71b          	sraiw	a4,s1,0x1f
     fa6:	01a7571b          	srliw	a4,a4,0x1a
     faa:	009707bb          	addw	a5,a4,s1
     fae:	4067d69b          	sraiw	a3,a5,0x6
     fb2:	0306869b          	addiw	a3,a3,48
     fb6:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     fba:	03f7f793          	andi	a5,a5,63
     fbe:	9f99                	subw	a5,a5,a4
     fc0:	0307879b          	addiw	a5,a5,48
     fc4:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     fc8:	fa0401a3          	sb	zero,-93(s0)
    if(unlink(name) != 0){
     fcc:	854a                	mv	a0,s2
     fce:	57b030ef          	jal	4d48 <unlink>
     fd2:	e531                	bnez	a0,101e <bigdir+0x12a>
  for(i = 0; i < N; i++){
     fd4:	2485                	addiw	s1,s1,1
     fd6:	fd4494e3          	bne	s1,s4,f9e <bigdir+0xaa>
}
     fda:	60e6                	ld	ra,88(sp)
     fdc:	6446                	ld	s0,80(sp)
     fde:	64a6                	ld	s1,72(sp)
     fe0:	6906                	ld	s2,64(sp)
     fe2:	79e2                	ld	s3,56(sp)
     fe4:	7a42                	ld	s4,48(sp)
     fe6:	7aa2                	ld	s5,40(sp)
     fe8:	7b02                	ld	s6,32(sp)
     fea:	6be2                	ld	s7,24(sp)
     fec:	6125                	addi	sp,sp,96
     fee:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     ff0:	85de                	mv	a1,s7
     ff2:	00005517          	auipc	a0,0x5
     ff6:	a6e50513          	addi	a0,a0,-1426 # 5a60 <malloc+0x878>
     ffa:	136040ef          	jal	5130 <printf>
    exit(1);
     ffe:	4505                	li	a0,1
    1000:	4f9030ef          	jal	4cf8 <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
    1004:	fa040693          	addi	a3,s0,-96
    1008:	864a                	mv	a2,s2
    100a:	85de                	mv	a1,s7
    100c:	00005517          	auipc	a0,0x5
    1010:	a7450513          	addi	a0,a0,-1420 # 5a80 <malloc+0x898>
    1014:	11c040ef          	jal	5130 <printf>
      exit(1);
    1018:	4505                	li	a0,1
    101a:	4df030ef          	jal	4cf8 <exit>
      printf("%s: bigdir unlink failed", s);
    101e:	85de                	mv	a1,s7
    1020:	00005517          	auipc	a0,0x5
    1024:	a8850513          	addi	a0,a0,-1400 # 5aa8 <malloc+0x8c0>
    1028:	108040ef          	jal	5130 <printf>
      exit(1);
    102c:	4505                	li	a0,1
    102e:	4cb030ef          	jal	4cf8 <exit>

0000000000001032 <pgbug>:
{
    1032:	7179                	addi	sp,sp,-48
    1034:	f406                	sd	ra,40(sp)
    1036:	f022                	sd	s0,32(sp)
    1038:	ec26                	sd	s1,24(sp)
    103a:	1800                	addi	s0,sp,48
  argv[0] = 0;
    103c:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1040:	00008497          	auipc	s1,0x8
    1044:	fc048493          	addi	s1,s1,-64 # 9000 <big>
    1048:	fd840593          	addi	a1,s0,-40
    104c:	6088                	ld	a0,0(s1)
    104e:	4e3030ef          	jal	4d30 <exec>
  pipe(big);
    1052:	6088                	ld	a0,0(s1)
    1054:	4b5030ef          	jal	4d08 <pipe>
  exit(0);
    1058:	4501                	li	a0,0
    105a:	49f030ef          	jal	4cf8 <exit>

000000000000105e <badarg>:
{
    105e:	7139                	addi	sp,sp,-64
    1060:	fc06                	sd	ra,56(sp)
    1062:	f822                	sd	s0,48(sp)
    1064:	f426                	sd	s1,40(sp)
    1066:	f04a                	sd	s2,32(sp)
    1068:	ec4e                	sd	s3,24(sp)
    106a:	e852                	sd	s4,16(sp)
    106c:	0080                	addi	s0,sp,64
    106e:	64b1                	lui	s1,0xc
    1070:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1074:	597d                	li	s2,-1
    1076:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    107a:	fc040a13          	addi	s4,s0,-64
    107e:	00004997          	auipc	s3,0x4
    1082:	29a98993          	addi	s3,s3,666 # 5318 <malloc+0x130>
    argv[0] = (char*)0xffffffff;
    1086:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    108a:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    108e:	85d2                	mv	a1,s4
    1090:	854e                	mv	a0,s3
    1092:	49f030ef          	jal	4d30 <exec>
  for(int i = 0; i < 50000; i++){
    1096:	34fd                	addiw	s1,s1,-1
    1098:	f4fd                	bnez	s1,1086 <badarg+0x28>
  exit(0);
    109a:	4501                	li	a0,0
    109c:	45d030ef          	jal	4cf8 <exit>

00000000000010a0 <copyinstr2>:
{
    10a0:	7155                	addi	sp,sp,-208
    10a2:	e586                	sd	ra,200(sp)
    10a4:	e1a2                	sd	s0,192(sp)
    10a6:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    10a8:	f6840793          	addi	a5,s0,-152
    10ac:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    10b0:	07800713          	li	a4,120
    10b4:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    10b8:	0785                	addi	a5,a5,1
    10ba:	fed79de3          	bne	a5,a3,10b4 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    10be:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    10c2:	f6840513          	addi	a0,s0,-152
    10c6:	483030ef          	jal	4d48 <unlink>
  if(ret != -1){
    10ca:	57fd                	li	a5,-1
    10cc:	0cf51263          	bne	a0,a5,1190 <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    10d0:	20100593          	li	a1,513
    10d4:	f6840513          	addi	a0,s0,-152
    10d8:	461030ef          	jal	4d38 <open>
  if(fd != -1){
    10dc:	57fd                	li	a5,-1
    10de:	0cf51563          	bne	a0,a5,11a8 <copyinstr2+0x108>
  ret = link(b, b);
    10e2:	f6840513          	addi	a0,s0,-152
    10e6:	85aa                	mv	a1,a0
    10e8:	471030ef          	jal	4d58 <link>
  if(ret != -1){
    10ec:	57fd                	li	a5,-1
    10ee:	0cf51963          	bne	a0,a5,11c0 <copyinstr2+0x120>
  char *args[] = { "xx", 0 };
    10f2:	00006797          	auipc	a5,0x6
    10f6:	b0678793          	addi	a5,a5,-1274 # 6bf8 <malloc+0x1a10>
    10fa:	f4f43c23          	sd	a5,-168(s0)
    10fe:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1102:	f5840593          	addi	a1,s0,-168
    1106:	f6840513          	addi	a0,s0,-152
    110a:	427030ef          	jal	4d30 <exec>
  if(ret != -1){
    110e:	57fd                	li	a5,-1
    1110:	0cf51563          	bne	a0,a5,11da <copyinstr2+0x13a>
  int pid = fork();
    1114:	3dd030ef          	jal	4cf0 <fork>
  if(pid < 0){
    1118:	0c054d63          	bltz	a0,11f2 <copyinstr2+0x152>
  if(pid == 0){
    111c:	0e051863          	bnez	a0,120c <copyinstr2+0x16c>
    1120:	00008797          	auipc	a5,0x8
    1124:	44078793          	addi	a5,a5,1088 # 9560 <big.0>
    1128:	00009697          	auipc	a3,0x9
    112c:	43868693          	addi	a3,a3,1080 # a560 <big.0+0x1000>
      big[i] = 'x';
    1130:	07800713          	li	a4,120
    1134:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1138:	0785                	addi	a5,a5,1
    113a:	fed79de3          	bne	a5,a3,1134 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    113e:	00009797          	auipc	a5,0x9
    1142:	42078123          	sb	zero,1058(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    1146:	00006797          	auipc	a5,0x6
    114a:	53278793          	addi	a5,a5,1330 # 7678 <malloc+0x2490>
    114e:	6fb0                	ld	a2,88(a5)
    1150:	73b4                	ld	a3,96(a5)
    1152:	77b8                	ld	a4,104(a5)
    1154:	f2c43823          	sd	a2,-208(s0)
    1158:	f2d43c23          	sd	a3,-200(s0)
    115c:	f4e43023          	sd	a4,-192(s0)
    1160:	7bbc                	ld	a5,112(a5)
    1162:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1166:	f3040593          	addi	a1,s0,-208
    116a:	00004517          	auipc	a0,0x4
    116e:	1ae50513          	addi	a0,a0,430 # 5318 <malloc+0x130>
    1172:	3bf030ef          	jal	4d30 <exec>
    if(ret != -1){
    1176:	57fd                	li	a5,-1
    1178:	08f50663          	beq	a0,a5,1204 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    117c:	85be                	mv	a1,a5
    117e:	00005517          	auipc	a0,0x5
    1182:	9d250513          	addi	a0,a0,-1582 # 5b50 <malloc+0x968>
    1186:	7ab030ef          	jal	5130 <printf>
      exit(1);
    118a:	4505                	li	a0,1
    118c:	36d030ef          	jal	4cf8 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1190:	862a                	mv	a2,a0
    1192:	f6840593          	addi	a1,s0,-152
    1196:	00005517          	auipc	a0,0x5
    119a:	93250513          	addi	a0,a0,-1742 # 5ac8 <malloc+0x8e0>
    119e:	793030ef          	jal	5130 <printf>
    exit(1);
    11a2:	4505                	li	a0,1
    11a4:	355030ef          	jal	4cf8 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    11a8:	862a                	mv	a2,a0
    11aa:	f6840593          	addi	a1,s0,-152
    11ae:	00005517          	auipc	a0,0x5
    11b2:	93a50513          	addi	a0,a0,-1734 # 5ae8 <malloc+0x900>
    11b6:	77b030ef          	jal	5130 <printf>
    exit(1);
    11ba:	4505                	li	a0,1
    11bc:	33d030ef          	jal	4cf8 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    11c0:	f6840593          	addi	a1,s0,-152
    11c4:	86aa                	mv	a3,a0
    11c6:	862e                	mv	a2,a1
    11c8:	00005517          	auipc	a0,0x5
    11cc:	94050513          	addi	a0,a0,-1728 # 5b08 <malloc+0x920>
    11d0:	761030ef          	jal	5130 <printf>
    exit(1);
    11d4:	4505                	li	a0,1
    11d6:	323030ef          	jal	4cf8 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    11da:	863e                	mv	a2,a5
    11dc:	f6840593          	addi	a1,s0,-152
    11e0:	00005517          	auipc	a0,0x5
    11e4:	95050513          	addi	a0,a0,-1712 # 5b30 <malloc+0x948>
    11e8:	749030ef          	jal	5130 <printf>
    exit(1);
    11ec:	4505                	li	a0,1
    11ee:	30b030ef          	jal	4cf8 <exit>
    printf("fork failed\n");
    11f2:	00006517          	auipc	a0,0x6
    11f6:	f2650513          	addi	a0,a0,-218 # 7118 <malloc+0x1f30>
    11fa:	737030ef          	jal	5130 <printf>
    exit(1);
    11fe:	4505                	li	a0,1
    1200:	2f9030ef          	jal	4cf8 <exit>
    exit(747); // OK
    1204:	2eb00513          	li	a0,747
    1208:	2f1030ef          	jal	4cf8 <exit>
  int st = 0;
    120c:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1210:	f5440513          	addi	a0,s0,-172
    1214:	2ed030ef          	jal	4d00 <wait>
  if(st != 747){
    1218:	f5442703          	lw	a4,-172(s0)
    121c:	2eb00793          	li	a5,747
    1220:	00f71663          	bne	a4,a5,122c <copyinstr2+0x18c>
}
    1224:	60ae                	ld	ra,200(sp)
    1226:	640e                	ld	s0,192(sp)
    1228:	6169                	addi	sp,sp,208
    122a:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    122c:	00005517          	auipc	a0,0x5
    1230:	94c50513          	addi	a0,a0,-1716 # 5b78 <malloc+0x990>
    1234:	6fd030ef          	jal	5130 <printf>
    exit(1);
    1238:	4505                	li	a0,1
    123a:	2bf030ef          	jal	4cf8 <exit>

000000000000123e <truncate3>:
{
    123e:	7175                	addi	sp,sp,-144
    1240:	e506                	sd	ra,136(sp)
    1242:	e122                	sd	s0,128(sp)
    1244:	fc66                	sd	s9,56(sp)
    1246:	0900                	addi	s0,sp,144
    1248:	8caa                	mv	s9,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    124a:	60100593          	li	a1,1537
    124e:	00004517          	auipc	a0,0x4
    1252:	12250513          	addi	a0,a0,290 # 5370 <malloc+0x188>
    1256:	2e3030ef          	jal	4d38 <open>
    125a:	2c7030ef          	jal	4d20 <close>
  pid = fork();
    125e:	293030ef          	jal	4cf0 <fork>
  if(pid < 0){
    1262:	06054d63          	bltz	a0,12dc <truncate3+0x9e>
  if(pid == 0){
    1266:	e171                	bnez	a0,132a <truncate3+0xec>
    1268:	fca6                	sd	s1,120(sp)
    126a:	f8ca                	sd	s2,112(sp)
    126c:	f4ce                	sd	s3,104(sp)
    126e:	f0d2                	sd	s4,96(sp)
    1270:	ecd6                	sd	s5,88(sp)
    1272:	e8da                	sd	s6,80(sp)
    1274:	e4de                	sd	s7,72(sp)
    1276:	e0e2                	sd	s8,64(sp)
    1278:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    127c:	4a85                	li	s5,1
    127e:	00004997          	auipc	s3,0x4
    1282:	0f298993          	addi	s3,s3,242 # 5370 <malloc+0x188>
      int n = write(fd, "1234567890", 10);
    1286:	4a29                	li	s4,10
    1288:	00005b17          	auipc	s6,0x5
    128c:	950b0b13          	addi	s6,s6,-1712 # 5bd8 <malloc+0x9f0>
      read(fd, buf, sizeof(buf));
    1290:	f7840c13          	addi	s8,s0,-136
    1294:	02000b93          	li	s7,32
      int fd = open("truncfile", O_WRONLY);
    1298:	85d6                	mv	a1,s5
    129a:	854e                	mv	a0,s3
    129c:	29d030ef          	jal	4d38 <open>
    12a0:	84aa                	mv	s1,a0
      if(fd < 0){
    12a2:	04054f63          	bltz	a0,1300 <truncate3+0xc2>
      int n = write(fd, "1234567890", 10);
    12a6:	8652                	mv	a2,s4
    12a8:	85da                	mv	a1,s6
    12aa:	26f030ef          	jal	4d18 <write>
      if(n != 10){
    12ae:	07451363          	bne	a0,s4,1314 <truncate3+0xd6>
      close(fd);
    12b2:	8526                	mv	a0,s1
    12b4:	26d030ef          	jal	4d20 <close>
      fd = open("truncfile", O_RDONLY);
    12b8:	4581                	li	a1,0
    12ba:	854e                	mv	a0,s3
    12bc:	27d030ef          	jal	4d38 <open>
    12c0:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    12c2:	865e                	mv	a2,s7
    12c4:	85e2                	mv	a1,s8
    12c6:	24b030ef          	jal	4d10 <read>
      close(fd);
    12ca:	8526                	mv	a0,s1
    12cc:	255030ef          	jal	4d20 <close>
    for(int i = 0; i < 100; i++){
    12d0:	397d                	addiw	s2,s2,-1
    12d2:	fc0913e3          	bnez	s2,1298 <truncate3+0x5a>
    exit(0);
    12d6:	4501                	li	a0,0
    12d8:	221030ef          	jal	4cf8 <exit>
    12dc:	fca6                	sd	s1,120(sp)
    12de:	f8ca                	sd	s2,112(sp)
    12e0:	f4ce                	sd	s3,104(sp)
    12e2:	f0d2                	sd	s4,96(sp)
    12e4:	ecd6                	sd	s5,88(sp)
    12e6:	e8da                	sd	s6,80(sp)
    12e8:	e4de                	sd	s7,72(sp)
    12ea:	e0e2                	sd	s8,64(sp)
    printf("%s: fork failed\n", s);
    12ec:	85e6                	mv	a1,s9
    12ee:	00005517          	auipc	a0,0x5
    12f2:	8ba50513          	addi	a0,a0,-1862 # 5ba8 <malloc+0x9c0>
    12f6:	63b030ef          	jal	5130 <printf>
    exit(1);
    12fa:	4505                	li	a0,1
    12fc:	1fd030ef          	jal	4cf8 <exit>
        printf("%s: open failed\n", s);
    1300:	85e6                	mv	a1,s9
    1302:	00005517          	auipc	a0,0x5
    1306:	8be50513          	addi	a0,a0,-1858 # 5bc0 <malloc+0x9d8>
    130a:	627030ef          	jal	5130 <printf>
        exit(1);
    130e:	4505                	li	a0,1
    1310:	1e9030ef          	jal	4cf8 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1314:	862a                	mv	a2,a0
    1316:	85e6                	mv	a1,s9
    1318:	00005517          	auipc	a0,0x5
    131c:	8d050513          	addi	a0,a0,-1840 # 5be8 <malloc+0xa00>
    1320:	611030ef          	jal	5130 <printf>
        exit(1);
    1324:	4505                	li	a0,1
    1326:	1d3030ef          	jal	4cf8 <exit>
    132a:	fca6                	sd	s1,120(sp)
    132c:	f8ca                	sd	s2,112(sp)
    132e:	f4ce                	sd	s3,104(sp)
    1330:	f0d2                	sd	s4,96(sp)
    1332:	ecd6                	sd	s5,88(sp)
    1334:	e8da                	sd	s6,80(sp)
    1336:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    133a:	60100a93          	li	s5,1537
    133e:	00004a17          	auipc	s4,0x4
    1342:	032a0a13          	addi	s4,s4,50 # 5370 <malloc+0x188>
    int n = write(fd, "xxx", 3);
    1346:	498d                	li	s3,3
    1348:	00005b17          	auipc	s6,0x5
    134c:	8c0b0b13          	addi	s6,s6,-1856 # 5c08 <malloc+0xa20>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1350:	85d6                	mv	a1,s5
    1352:	8552                	mv	a0,s4
    1354:	1e5030ef          	jal	4d38 <open>
    1358:	84aa                	mv	s1,a0
    if(fd < 0){
    135a:	02054e63          	bltz	a0,1396 <truncate3+0x158>
    int n = write(fd, "xxx", 3);
    135e:	864e                	mv	a2,s3
    1360:	85da                	mv	a1,s6
    1362:	1b7030ef          	jal	4d18 <write>
    if(n != 3){
    1366:	05351463          	bne	a0,s3,13ae <truncate3+0x170>
    close(fd);
    136a:	8526                	mv	a0,s1
    136c:	1b5030ef          	jal	4d20 <close>
  for(int i = 0; i < 150; i++){
    1370:	397d                	addiw	s2,s2,-1
    1372:	fc091fe3          	bnez	s2,1350 <truncate3+0x112>
    1376:	e4de                	sd	s7,72(sp)
    1378:	e0e2                	sd	s8,64(sp)
  wait(&xstatus);
    137a:	f9c40513          	addi	a0,s0,-100
    137e:	183030ef          	jal	4d00 <wait>
  unlink("truncfile");
    1382:	00004517          	auipc	a0,0x4
    1386:	fee50513          	addi	a0,a0,-18 # 5370 <malloc+0x188>
    138a:	1bf030ef          	jal	4d48 <unlink>
  exit(xstatus);
    138e:	f9c42503          	lw	a0,-100(s0)
    1392:	167030ef          	jal	4cf8 <exit>
    1396:	e4de                	sd	s7,72(sp)
    1398:	e0e2                	sd	s8,64(sp)
      printf("%s: open failed\n", s);
    139a:	85e6                	mv	a1,s9
    139c:	00005517          	auipc	a0,0x5
    13a0:	82450513          	addi	a0,a0,-2012 # 5bc0 <malloc+0x9d8>
    13a4:	58d030ef          	jal	5130 <printf>
      exit(1);
    13a8:	4505                	li	a0,1
    13aa:	14f030ef          	jal	4cf8 <exit>
    13ae:	e4de                	sd	s7,72(sp)
    13b0:	e0e2                	sd	s8,64(sp)
      printf("%s: write got %d, expected 3\n", s, n);
    13b2:	862a                	mv	a2,a0
    13b4:	85e6                	mv	a1,s9
    13b6:	00005517          	auipc	a0,0x5
    13ba:	85a50513          	addi	a0,a0,-1958 # 5c10 <malloc+0xa28>
    13be:	573030ef          	jal	5130 <printf>
      exit(1);
    13c2:	4505                	li	a0,1
    13c4:	135030ef          	jal	4cf8 <exit>

00000000000013c8 <exectest>:
{
    13c8:	715d                	addi	sp,sp,-80
    13ca:	e486                	sd	ra,72(sp)
    13cc:	e0a2                	sd	s0,64(sp)
    13ce:	f84a                	sd	s2,48(sp)
    13d0:	0880                	addi	s0,sp,80
    13d2:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    13d4:	00004797          	auipc	a5,0x4
    13d8:	f4478793          	addi	a5,a5,-188 # 5318 <malloc+0x130>
    13dc:	fcf43023          	sd	a5,-64(s0)
    13e0:	00005797          	auipc	a5,0x5
    13e4:	85078793          	addi	a5,a5,-1968 # 5c30 <malloc+0xa48>
    13e8:	fcf43423          	sd	a5,-56(s0)
    13ec:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    13f0:	00005517          	auipc	a0,0x5
    13f4:	84850513          	addi	a0,a0,-1976 # 5c38 <malloc+0xa50>
    13f8:	151030ef          	jal	4d48 <unlink>
  pid = fork();
    13fc:	0f5030ef          	jal	4cf0 <fork>
  if(pid < 0) {
    1400:	02054f63          	bltz	a0,143e <exectest+0x76>
    1404:	fc26                	sd	s1,56(sp)
    1406:	84aa                	mv	s1,a0
  if(pid == 0) {
    1408:	e935                	bnez	a0,147c <exectest+0xb4>
    close(1);
    140a:	4505                	li	a0,1
    140c:	115030ef          	jal	4d20 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1410:	20100593          	li	a1,513
    1414:	00005517          	auipc	a0,0x5
    1418:	82450513          	addi	a0,a0,-2012 # 5c38 <malloc+0xa50>
    141c:	11d030ef          	jal	4d38 <open>
    if(fd < 0) {
    1420:	02054a63          	bltz	a0,1454 <exectest+0x8c>
    if(fd != 1) {
    1424:	4785                	li	a5,1
    1426:	04f50163          	beq	a0,a5,1468 <exectest+0xa0>
      printf("%s: wrong fd\n", s);
    142a:	85ca                	mv	a1,s2
    142c:	00005517          	auipc	a0,0x5
    1430:	82c50513          	addi	a0,a0,-2004 # 5c58 <malloc+0xa70>
    1434:	4fd030ef          	jal	5130 <printf>
      exit(1);
    1438:	4505                	li	a0,1
    143a:	0bf030ef          	jal	4cf8 <exit>
    143e:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    1440:	85ca                	mv	a1,s2
    1442:	00004517          	auipc	a0,0x4
    1446:	76650513          	addi	a0,a0,1894 # 5ba8 <malloc+0x9c0>
    144a:	4e7030ef          	jal	5130 <printf>
     exit(1);
    144e:	4505                	li	a0,1
    1450:	0a9030ef          	jal	4cf8 <exit>
      printf("%s: create failed\n", s);
    1454:	85ca                	mv	a1,s2
    1456:	00004517          	auipc	a0,0x4
    145a:	7ea50513          	addi	a0,a0,2026 # 5c40 <malloc+0xa58>
    145e:	4d3030ef          	jal	5130 <printf>
      exit(1);
    1462:	4505                	li	a0,1
    1464:	095030ef          	jal	4cf8 <exit>
    if(exec("echo", echoargv) < 0){
    1468:	fc040593          	addi	a1,s0,-64
    146c:	00004517          	auipc	a0,0x4
    1470:	eac50513          	addi	a0,a0,-340 # 5318 <malloc+0x130>
    1474:	0bd030ef          	jal	4d30 <exec>
    1478:	00054d63          	bltz	a0,1492 <exectest+0xca>
  if (wait(&xstatus) != pid) {
    147c:	fdc40513          	addi	a0,s0,-36
    1480:	081030ef          	jal	4d00 <wait>
    1484:	02951163          	bne	a0,s1,14a6 <exectest+0xde>
  if(xstatus != 0)
    1488:	fdc42503          	lw	a0,-36(s0)
    148c:	c50d                	beqz	a0,14b6 <exectest+0xee>
    exit(xstatus);
    148e:	06b030ef          	jal	4cf8 <exit>
      printf("%s: exec echo failed\n", s);
    1492:	85ca                	mv	a1,s2
    1494:	00004517          	auipc	a0,0x4
    1498:	7d450513          	addi	a0,a0,2004 # 5c68 <malloc+0xa80>
    149c:	495030ef          	jal	5130 <printf>
      exit(1);
    14a0:	4505                	li	a0,1
    14a2:	057030ef          	jal	4cf8 <exit>
    printf("%s: wait failed!\n", s);
    14a6:	85ca                	mv	a1,s2
    14a8:	00004517          	auipc	a0,0x4
    14ac:	7d850513          	addi	a0,a0,2008 # 5c80 <malloc+0xa98>
    14b0:	481030ef          	jal	5130 <printf>
    14b4:	bfd1                	j	1488 <exectest+0xc0>
  fd = open("echo-ok", O_RDONLY);
    14b6:	4581                	li	a1,0
    14b8:	00004517          	auipc	a0,0x4
    14bc:	78050513          	addi	a0,a0,1920 # 5c38 <malloc+0xa50>
    14c0:	079030ef          	jal	4d38 <open>
  if(fd < 0) {
    14c4:	02054463          	bltz	a0,14ec <exectest+0x124>
  if (read(fd, buf, 2) != 2) {
    14c8:	4609                	li	a2,2
    14ca:	fb840593          	addi	a1,s0,-72
    14ce:	043030ef          	jal	4d10 <read>
    14d2:	4789                	li	a5,2
    14d4:	02f50663          	beq	a0,a5,1500 <exectest+0x138>
    printf("%s: read failed\n", s);
    14d8:	85ca                	mv	a1,s2
    14da:	00004517          	auipc	a0,0x4
    14de:	20e50513          	addi	a0,a0,526 # 56e8 <malloc+0x500>
    14e2:	44f030ef          	jal	5130 <printf>
    exit(1);
    14e6:	4505                	li	a0,1
    14e8:	011030ef          	jal	4cf8 <exit>
    printf("%s: open failed\n", s);
    14ec:	85ca                	mv	a1,s2
    14ee:	00004517          	auipc	a0,0x4
    14f2:	6d250513          	addi	a0,a0,1746 # 5bc0 <malloc+0x9d8>
    14f6:	43b030ef          	jal	5130 <printf>
    exit(1);
    14fa:	4505                	li	a0,1
    14fc:	7fc030ef          	jal	4cf8 <exit>
  unlink("echo-ok");
    1500:	00004517          	auipc	a0,0x4
    1504:	73850513          	addi	a0,a0,1848 # 5c38 <malloc+0xa50>
    1508:	041030ef          	jal	4d48 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    150c:	fb844703          	lbu	a4,-72(s0)
    1510:	04f00793          	li	a5,79
    1514:	00f71863          	bne	a4,a5,1524 <exectest+0x15c>
    1518:	fb944703          	lbu	a4,-71(s0)
    151c:	04b00793          	li	a5,75
    1520:	00f70c63          	beq	a4,a5,1538 <exectest+0x170>
    printf("%s: wrong output\n", s);
    1524:	85ca                	mv	a1,s2
    1526:	00004517          	auipc	a0,0x4
    152a:	77250513          	addi	a0,a0,1906 # 5c98 <malloc+0xab0>
    152e:	403030ef          	jal	5130 <printf>
    exit(1);
    1532:	4505                	li	a0,1
    1534:	7c4030ef          	jal	4cf8 <exit>
    exit(0);
    1538:	4501                	li	a0,0
    153a:	7be030ef          	jal	4cf8 <exit>

000000000000153e <pipe1>:
{
    153e:	711d                	addi	sp,sp,-96
    1540:	ec86                	sd	ra,88(sp)
    1542:	e8a2                	sd	s0,80(sp)
    1544:	e862                	sd	s8,16(sp)
    1546:	1080                	addi	s0,sp,96
    1548:	8c2a                	mv	s8,a0
  if(pipe(fds) != 0){
    154a:	fa840513          	addi	a0,s0,-88
    154e:	7ba030ef          	jal	4d08 <pipe>
    1552:	e925                	bnez	a0,15c2 <pipe1+0x84>
    1554:	e4a6                	sd	s1,72(sp)
    1556:	fc4e                	sd	s3,56(sp)
    1558:	84aa                	mv	s1,a0
  pid = fork();
    155a:	796030ef          	jal	4cf0 <fork>
    155e:	89aa                	mv	s3,a0
  if(pid == 0){
    1560:	c151                	beqz	a0,15e4 <pipe1+0xa6>
  } else if(pid > 0){
    1562:	16a05063          	blez	a0,16c2 <pipe1+0x184>
    1566:	e0ca                	sd	s2,64(sp)
    1568:	f852                	sd	s4,48(sp)
    close(fds[1]);
    156a:	fac42503          	lw	a0,-84(s0)
    156e:	7b2030ef          	jal	4d20 <close>
    total = 0;
    1572:	89a6                	mv	s3,s1
    cc = 1;
    1574:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    1576:	0000ba17          	auipc	s4,0xb
    157a:	702a0a13          	addi	s4,s4,1794 # cc78 <buf>
    157e:	864a                	mv	a2,s2
    1580:	85d2                	mv	a1,s4
    1582:	fa842503          	lw	a0,-88(s0)
    1586:	78a030ef          	jal	4d10 <read>
    158a:	85aa                	mv	a1,a0
    158c:	0ea05963          	blez	a0,167e <pipe1+0x140>
    1590:	0000b797          	auipc	a5,0xb
    1594:	6e878793          	addi	a5,a5,1768 # cc78 <buf>
    1598:	00b4863b          	addw	a2,s1,a1
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    159c:	0007c683          	lbu	a3,0(a5)
    15a0:	0ff4f713          	zext.b	a4,s1
    15a4:	0ae69d63          	bne	a3,a4,165e <pipe1+0x120>
    15a8:	2485                	addiw	s1,s1,1
      for(i = 0; i < n; i++){
    15aa:	0785                	addi	a5,a5,1
    15ac:	fec498e3          	bne	s1,a2,159c <pipe1+0x5e>
      total += n;
    15b0:	00b989bb          	addw	s3,s3,a1
      cc = cc * 2;
    15b4:	0019191b          	slliw	s2,s2,0x1
      if(cc > sizeof(buf))
    15b8:	678d                	lui	a5,0x3
    15ba:	fd27f2e3          	bgeu	a5,s2,157e <pipe1+0x40>
        cc = sizeof(buf);
    15be:	893e                	mv	s2,a5
    15c0:	bf7d                	j	157e <pipe1+0x40>
    15c2:	e4a6                	sd	s1,72(sp)
    15c4:	e0ca                	sd	s2,64(sp)
    15c6:	fc4e                	sd	s3,56(sp)
    15c8:	f852                	sd	s4,48(sp)
    15ca:	f456                	sd	s5,40(sp)
    15cc:	f05a                	sd	s6,32(sp)
    15ce:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    15d0:	85e2                	mv	a1,s8
    15d2:	00004517          	auipc	a0,0x4
    15d6:	6de50513          	addi	a0,a0,1758 # 5cb0 <malloc+0xac8>
    15da:	357030ef          	jal	5130 <printf>
    exit(1);
    15de:	4505                	li	a0,1
    15e0:	718030ef          	jal	4cf8 <exit>
    15e4:	e0ca                	sd	s2,64(sp)
    15e6:	f852                	sd	s4,48(sp)
    15e8:	f456                	sd	s5,40(sp)
    15ea:	f05a                	sd	s6,32(sp)
    15ec:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    15ee:	fa842503          	lw	a0,-88(s0)
    15f2:	72e030ef          	jal	4d20 <close>
    for(n = 0; n < N; n++){
    15f6:	0000bb17          	auipc	s6,0xb
    15fa:	682b0b13          	addi	s6,s6,1666 # cc78 <buf>
    15fe:	416004bb          	negw	s1,s6
    1602:	0ff4f493          	zext.b	s1,s1
    1606:	409b0913          	addi	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    160a:	40900a13          	li	s4,1033
    160e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1610:	6a85                	lui	s5,0x1
    1612:	42da8a93          	addi	s5,s5,1069 # 142d <exectest+0x65>
{
    1616:	87da                	mv	a5,s6
        buf[i] = seq++;
    1618:	0097873b          	addw	a4,a5,s1
    161c:	00e78023          	sb	a4,0(a5) # 3000 <subdir+0x2e6>
      for(i = 0; i < SZ; i++)
    1620:	0785                	addi	a5,a5,1
    1622:	ff279be3          	bne	a5,s2,1618 <pipe1+0xda>
      if(write(fds[1], buf, SZ) != SZ){
    1626:	8652                	mv	a2,s4
    1628:	85de                	mv	a1,s7
    162a:	fac42503          	lw	a0,-84(s0)
    162e:	6ea030ef          	jal	4d18 <write>
    1632:	01451c63          	bne	a0,s4,164a <pipe1+0x10c>
    1636:	4099899b          	addiw	s3,s3,1033
    for(n = 0; n < N; n++){
    163a:	24a5                	addiw	s1,s1,9
    163c:	0ff4f493          	zext.b	s1,s1
    1640:	fd599be3          	bne	s3,s5,1616 <pipe1+0xd8>
    exit(0);
    1644:	4501                	li	a0,0
    1646:	6b2030ef          	jal	4cf8 <exit>
        printf("%s: pipe1 oops 1\n", s);
    164a:	85e2                	mv	a1,s8
    164c:	00004517          	auipc	a0,0x4
    1650:	67c50513          	addi	a0,a0,1660 # 5cc8 <malloc+0xae0>
    1654:	2dd030ef          	jal	5130 <printf>
        exit(1);
    1658:	4505                	li	a0,1
    165a:	69e030ef          	jal	4cf8 <exit>
          printf("%s: pipe1 oops 2\n", s);
    165e:	85e2                	mv	a1,s8
    1660:	00004517          	auipc	a0,0x4
    1664:	68050513          	addi	a0,a0,1664 # 5ce0 <malloc+0xaf8>
    1668:	2c9030ef          	jal	5130 <printf>
          return;
    166c:	64a6                	ld	s1,72(sp)
    166e:	6906                	ld	s2,64(sp)
    1670:	79e2                	ld	s3,56(sp)
    1672:	7a42                	ld	s4,48(sp)
}
    1674:	60e6                	ld	ra,88(sp)
    1676:	6446                	ld	s0,80(sp)
    1678:	6c42                	ld	s8,16(sp)
    167a:	6125                	addi	sp,sp,96
    167c:	8082                	ret
    if(total != N * SZ){
    167e:	6785                	lui	a5,0x1
    1680:	42d78793          	addi	a5,a5,1069 # 142d <exectest+0x65>
    1684:	02f98063          	beq	s3,a5,16a4 <pipe1+0x166>
    1688:	f456                	sd	s5,40(sp)
    168a:	f05a                	sd	s6,32(sp)
    168c:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    168e:	864e                	mv	a2,s3
    1690:	85e2                	mv	a1,s8
    1692:	00004517          	auipc	a0,0x4
    1696:	66650513          	addi	a0,a0,1638 # 5cf8 <malloc+0xb10>
    169a:	297030ef          	jal	5130 <printf>
      exit(1);
    169e:	4505                	li	a0,1
    16a0:	658030ef          	jal	4cf8 <exit>
    16a4:	f456                	sd	s5,40(sp)
    16a6:	f05a                	sd	s6,32(sp)
    16a8:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    16aa:	fa842503          	lw	a0,-88(s0)
    16ae:	672030ef          	jal	4d20 <close>
    wait(&xstatus);
    16b2:	fa440513          	addi	a0,s0,-92
    16b6:	64a030ef          	jal	4d00 <wait>
    exit(xstatus);
    16ba:	fa442503          	lw	a0,-92(s0)
    16be:	63a030ef          	jal	4cf8 <exit>
    16c2:	e0ca                	sd	s2,64(sp)
    16c4:	f852                	sd	s4,48(sp)
    16c6:	f456                	sd	s5,40(sp)
    16c8:	f05a                	sd	s6,32(sp)
    16ca:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    16cc:	85e2                	mv	a1,s8
    16ce:	00004517          	auipc	a0,0x4
    16d2:	64a50513          	addi	a0,a0,1610 # 5d18 <malloc+0xb30>
    16d6:	25b030ef          	jal	5130 <printf>
    exit(1);
    16da:	4505                	li	a0,1
    16dc:	61c030ef          	jal	4cf8 <exit>

00000000000016e0 <exitwait>:
{
    16e0:	715d                	addi	sp,sp,-80
    16e2:	e486                	sd	ra,72(sp)
    16e4:	e0a2                	sd	s0,64(sp)
    16e6:	fc26                	sd	s1,56(sp)
    16e8:	f84a                	sd	s2,48(sp)
    16ea:	f44e                	sd	s3,40(sp)
    16ec:	f052                	sd	s4,32(sp)
    16ee:	ec56                	sd	s5,24(sp)
    16f0:	0880                	addi	s0,sp,80
    16f2:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    16f4:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    16f6:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    16fa:	06400a13          	li	s4,100
    pid = fork();
    16fe:	5f2030ef          	jal	4cf0 <fork>
    1702:	84aa                	mv	s1,a0
    if(pid < 0){
    1704:	02054863          	bltz	a0,1734 <exitwait+0x54>
    if(pid){
    1708:	c525                	beqz	a0,1770 <exitwait+0x90>
      if(wait(&xstate) != pid){
    170a:	854e                	mv	a0,s3
    170c:	5f4030ef          	jal	4d00 <wait>
    1710:	02951c63          	bne	a0,s1,1748 <exitwait+0x68>
      if(i != xstate) {
    1714:	fbc42783          	lw	a5,-68(s0)
    1718:	05279263          	bne	a5,s2,175c <exitwait+0x7c>
  for(i = 0; i < 100; i++){
    171c:	2905                	addiw	s2,s2,1
    171e:	ff4910e3          	bne	s2,s4,16fe <exitwait+0x1e>
}
    1722:	60a6                	ld	ra,72(sp)
    1724:	6406                	ld	s0,64(sp)
    1726:	74e2                	ld	s1,56(sp)
    1728:	7942                	ld	s2,48(sp)
    172a:	79a2                	ld	s3,40(sp)
    172c:	7a02                	ld	s4,32(sp)
    172e:	6ae2                	ld	s5,24(sp)
    1730:	6161                	addi	sp,sp,80
    1732:	8082                	ret
      printf("%s: fork failed\n", s);
    1734:	85d6                	mv	a1,s5
    1736:	00004517          	auipc	a0,0x4
    173a:	47250513          	addi	a0,a0,1138 # 5ba8 <malloc+0x9c0>
    173e:	1f3030ef          	jal	5130 <printf>
      exit(1);
    1742:	4505                	li	a0,1
    1744:	5b4030ef          	jal	4cf8 <exit>
        printf("%s: wait wrong pid\n", s);
    1748:	85d6                	mv	a1,s5
    174a:	00004517          	auipc	a0,0x4
    174e:	5e650513          	addi	a0,a0,1510 # 5d30 <malloc+0xb48>
    1752:	1df030ef          	jal	5130 <printf>
        exit(1);
    1756:	4505                	li	a0,1
    1758:	5a0030ef          	jal	4cf8 <exit>
        printf("%s: wait wrong exit status\n", s);
    175c:	85d6                	mv	a1,s5
    175e:	00004517          	auipc	a0,0x4
    1762:	5ea50513          	addi	a0,a0,1514 # 5d48 <malloc+0xb60>
    1766:	1cb030ef          	jal	5130 <printf>
        exit(1);
    176a:	4505                	li	a0,1
    176c:	58c030ef          	jal	4cf8 <exit>
      exit(i);
    1770:	854a                	mv	a0,s2
    1772:	586030ef          	jal	4cf8 <exit>

0000000000001776 <twochildren>:
{
    1776:	1101                	addi	sp,sp,-32
    1778:	ec06                	sd	ra,24(sp)
    177a:	e822                	sd	s0,16(sp)
    177c:	e426                	sd	s1,8(sp)
    177e:	e04a                	sd	s2,0(sp)
    1780:	1000                	addi	s0,sp,32
    1782:	892a                	mv	s2,a0
    1784:	3e800493          	li	s1,1000
    int pid1 = fork();
    1788:	568030ef          	jal	4cf0 <fork>
    if(pid1 < 0){
    178c:	02054663          	bltz	a0,17b8 <twochildren+0x42>
    if(pid1 == 0){
    1790:	cd15                	beqz	a0,17cc <twochildren+0x56>
      int pid2 = fork();
    1792:	55e030ef          	jal	4cf0 <fork>
      if(pid2 < 0){
    1796:	02054d63          	bltz	a0,17d0 <twochildren+0x5a>
      if(pid2 == 0){
    179a:	c529                	beqz	a0,17e4 <twochildren+0x6e>
        wait(0);
    179c:	4501                	li	a0,0
    179e:	562030ef          	jal	4d00 <wait>
        wait(0);
    17a2:	4501                	li	a0,0
    17a4:	55c030ef          	jal	4d00 <wait>
  for(int i = 0; i < 1000; i++){
    17a8:	34fd                	addiw	s1,s1,-1
    17aa:	fcf9                	bnez	s1,1788 <twochildren+0x12>
}
    17ac:	60e2                	ld	ra,24(sp)
    17ae:	6442                	ld	s0,16(sp)
    17b0:	64a2                	ld	s1,8(sp)
    17b2:	6902                	ld	s2,0(sp)
    17b4:	6105                	addi	sp,sp,32
    17b6:	8082                	ret
      printf("%s: fork failed\n", s);
    17b8:	85ca                	mv	a1,s2
    17ba:	00004517          	auipc	a0,0x4
    17be:	3ee50513          	addi	a0,a0,1006 # 5ba8 <malloc+0x9c0>
    17c2:	16f030ef          	jal	5130 <printf>
      exit(1);
    17c6:	4505                	li	a0,1
    17c8:	530030ef          	jal	4cf8 <exit>
      exit(0);
    17cc:	52c030ef          	jal	4cf8 <exit>
        printf("%s: fork failed\n", s);
    17d0:	85ca                	mv	a1,s2
    17d2:	00004517          	auipc	a0,0x4
    17d6:	3d650513          	addi	a0,a0,982 # 5ba8 <malloc+0x9c0>
    17da:	157030ef          	jal	5130 <printf>
        exit(1);
    17de:	4505                	li	a0,1
    17e0:	518030ef          	jal	4cf8 <exit>
        exit(0);
    17e4:	514030ef          	jal	4cf8 <exit>

00000000000017e8 <forkfork>:
{
    17e8:	7179                	addi	sp,sp,-48
    17ea:	f406                	sd	ra,40(sp)
    17ec:	f022                	sd	s0,32(sp)
    17ee:	ec26                	sd	s1,24(sp)
    17f0:	1800                	addi	s0,sp,48
    17f2:	84aa                	mv	s1,a0
    int pid = fork();
    17f4:	4fc030ef          	jal	4cf0 <fork>
    if(pid < 0){
    17f8:	02054b63          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    17fc:	c139                	beqz	a0,1842 <forkfork+0x5a>
    int pid = fork();
    17fe:	4f2030ef          	jal	4cf0 <fork>
    if(pid < 0){
    1802:	02054663          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    1806:	cd15                	beqz	a0,1842 <forkfork+0x5a>
    wait(&xstatus);
    1808:	fdc40513          	addi	a0,s0,-36
    180c:	4f4030ef          	jal	4d00 <wait>
    if(xstatus != 0) {
    1810:	fdc42783          	lw	a5,-36(s0)
    1814:	ebb9                	bnez	a5,186a <forkfork+0x82>
    wait(&xstatus);
    1816:	fdc40513          	addi	a0,s0,-36
    181a:	4e6030ef          	jal	4d00 <wait>
    if(xstatus != 0) {
    181e:	fdc42783          	lw	a5,-36(s0)
    1822:	e7a1                	bnez	a5,186a <forkfork+0x82>
}
    1824:	70a2                	ld	ra,40(sp)
    1826:	7402                	ld	s0,32(sp)
    1828:	64e2                	ld	s1,24(sp)
    182a:	6145                	addi	sp,sp,48
    182c:	8082                	ret
      printf("%s: fork failed", s);
    182e:	85a6                	mv	a1,s1
    1830:	00004517          	auipc	a0,0x4
    1834:	53850513          	addi	a0,a0,1336 # 5d68 <malloc+0xb80>
    1838:	0f9030ef          	jal	5130 <printf>
      exit(1);
    183c:	4505                	li	a0,1
    183e:	4ba030ef          	jal	4cf8 <exit>
{
    1842:	0c800493          	li	s1,200
        int pid1 = fork();
    1846:	4aa030ef          	jal	4cf0 <fork>
        if(pid1 < 0){
    184a:	00054b63          	bltz	a0,1860 <forkfork+0x78>
        if(pid1 == 0){
    184e:	cd01                	beqz	a0,1866 <forkfork+0x7e>
        wait(0);
    1850:	4501                	li	a0,0
    1852:	4ae030ef          	jal	4d00 <wait>
      for(int j = 0; j < 200; j++){
    1856:	34fd                	addiw	s1,s1,-1
    1858:	f4fd                	bnez	s1,1846 <forkfork+0x5e>
      exit(0);
    185a:	4501                	li	a0,0
    185c:	49c030ef          	jal	4cf8 <exit>
          exit(1);
    1860:	4505                	li	a0,1
    1862:	496030ef          	jal	4cf8 <exit>
          exit(0);
    1866:	492030ef          	jal	4cf8 <exit>
      printf("%s: fork in child failed", s);
    186a:	85a6                	mv	a1,s1
    186c:	00004517          	auipc	a0,0x4
    1870:	50c50513          	addi	a0,a0,1292 # 5d78 <malloc+0xb90>
    1874:	0bd030ef          	jal	5130 <printf>
      exit(1);
    1878:	4505                	li	a0,1
    187a:	47e030ef          	jal	4cf8 <exit>

000000000000187e <reparent2>:
{
    187e:	1101                	addi	sp,sp,-32
    1880:	ec06                	sd	ra,24(sp)
    1882:	e822                	sd	s0,16(sp)
    1884:	e426                	sd	s1,8(sp)
    1886:	1000                	addi	s0,sp,32
    1888:	32000493          	li	s1,800
    int pid1 = fork();
    188c:	464030ef          	jal	4cf0 <fork>
    if(pid1 < 0){
    1890:	00054b63          	bltz	a0,18a6 <reparent2+0x28>
    if(pid1 == 0){
    1894:	c115                	beqz	a0,18b8 <reparent2+0x3a>
    wait(0);
    1896:	4501                	li	a0,0
    1898:	468030ef          	jal	4d00 <wait>
  for(int i = 0; i < 800; i++){
    189c:	34fd                	addiw	s1,s1,-1
    189e:	f4fd                	bnez	s1,188c <reparent2+0xe>
  exit(0);
    18a0:	4501                	li	a0,0
    18a2:	456030ef          	jal	4cf8 <exit>
      printf("fork failed\n");
    18a6:	00006517          	auipc	a0,0x6
    18aa:	87250513          	addi	a0,a0,-1934 # 7118 <malloc+0x1f30>
    18ae:	083030ef          	jal	5130 <printf>
      exit(1);
    18b2:	4505                	li	a0,1
    18b4:	444030ef          	jal	4cf8 <exit>
      fork();
    18b8:	438030ef          	jal	4cf0 <fork>
      fork();
    18bc:	434030ef          	jal	4cf0 <fork>
      exit(0);
    18c0:	4501                	li	a0,0
    18c2:	436030ef          	jal	4cf8 <exit>

00000000000018c6 <createdelete>:
{
    18c6:	7135                	addi	sp,sp,-160
    18c8:	ed06                	sd	ra,152(sp)
    18ca:	e922                	sd	s0,144(sp)
    18cc:	e526                	sd	s1,136(sp)
    18ce:	e14a                	sd	s2,128(sp)
    18d0:	fcce                	sd	s3,120(sp)
    18d2:	f8d2                	sd	s4,112(sp)
    18d4:	f4d6                	sd	s5,104(sp)
    18d6:	f0da                	sd	s6,96(sp)
    18d8:	ecde                	sd	s7,88(sp)
    18da:	e8e2                	sd	s8,80(sp)
    18dc:	e4e6                	sd	s9,72(sp)
    18de:	e0ea                	sd	s10,64(sp)
    18e0:	fc6e                	sd	s11,56(sp)
    18e2:	1100                	addi	s0,sp,160
    18e4:	8daa                	mv	s11,a0
  for(pi = 0; pi < NCHILD; pi++){
    18e6:	4901                	li	s2,0
    18e8:	4991                	li	s3,4
    pid = fork();
    18ea:	406030ef          	jal	4cf0 <fork>
    18ee:	84aa                	mv	s1,a0
    if(pid < 0){
    18f0:	04054063          	bltz	a0,1930 <createdelete+0x6a>
    if(pid == 0){
    18f4:	c921                	beqz	a0,1944 <createdelete+0x7e>
  for(pi = 0; pi < NCHILD; pi++){
    18f6:	2905                	addiw	s2,s2,1
    18f8:	ff3919e3          	bne	s2,s3,18ea <createdelete+0x24>
    18fc:	4491                	li	s1,4
    wait(&xstatus);
    18fe:	f6c40913          	addi	s2,s0,-148
    1902:	854a                	mv	a0,s2
    1904:	3fc030ef          	jal	4d00 <wait>
    if(xstatus != 0)
    1908:	f6c42a83          	lw	s5,-148(s0)
    190c:	0c0a9263          	bnez	s5,19d0 <createdelete+0x10a>
  for(pi = 0; pi < NCHILD; pi++){
    1910:	34fd                	addiw	s1,s1,-1
    1912:	f8e5                	bnez	s1,1902 <createdelete+0x3c>
  name[0] = name[1] = name[2] = 0;
    1914:	f6040923          	sb	zero,-142(s0)
    1918:	03000913          	li	s2,48
    191c:	5a7d                	li	s4,-1
      if((i == 0 || i >= N/2) && fd < 0){
    191e:	4d25                	li	s10,9
    1920:	07000c93          	li	s9,112
      fd = open(name, 0);
    1924:	f7040c13          	addi	s8,s0,-144
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1928:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
    192a:	07400b13          	li	s6,116
    192e:	aa39                	j	1a4c <createdelete+0x186>
      printf("%s: fork failed\n", s);
    1930:	85ee                	mv	a1,s11
    1932:	00004517          	auipc	a0,0x4
    1936:	27650513          	addi	a0,a0,630 # 5ba8 <malloc+0x9c0>
    193a:	7f6030ef          	jal	5130 <printf>
      exit(1);
    193e:	4505                	li	a0,1
    1940:	3b8030ef          	jal	4cf8 <exit>
      name[0] = 'p' + pi;
    1944:	0709091b          	addiw	s2,s2,112
    1948:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
    194c:	f6040923          	sb	zero,-142(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1950:	f7040913          	addi	s2,s0,-144
    1954:	20200993          	li	s3,514
      for(i = 0; i < N; i++){
    1958:	4a51                	li	s4,20
    195a:	a815                	j	198e <createdelete+0xc8>
          printf("%s: create failed\n", s);
    195c:	85ee                	mv	a1,s11
    195e:	00004517          	auipc	a0,0x4
    1962:	2e250513          	addi	a0,a0,738 # 5c40 <malloc+0xa58>
    1966:	7ca030ef          	jal	5130 <printf>
          exit(1);
    196a:	4505                	li	a0,1
    196c:	38c030ef          	jal	4cf8 <exit>
          name[1] = '0' + (i / 2);
    1970:	01f4d79b          	srliw	a5,s1,0x1f
    1974:	9fa5                	addw	a5,a5,s1
    1976:	4017d79b          	sraiw	a5,a5,0x1
    197a:	0307879b          	addiw	a5,a5,48
    197e:	f6f408a3          	sb	a5,-143(s0)
          if(unlink(name) < 0){
    1982:	854a                	mv	a0,s2
    1984:	3c4030ef          	jal	4d48 <unlink>
    1988:	02054a63          	bltz	a0,19bc <createdelete+0xf6>
      for(i = 0; i < N; i++){
    198c:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
    198e:	0304879b          	addiw	a5,s1,48
    1992:	f6f408a3          	sb	a5,-143(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1996:	85ce                	mv	a1,s3
    1998:	854a                	mv	a0,s2
    199a:	39e030ef          	jal	4d38 <open>
        if(fd < 0){
    199e:	fa054fe3          	bltz	a0,195c <createdelete+0x96>
        close(fd);
    19a2:	37e030ef          	jal	4d20 <close>
        if(i > 0 && (i % 2 ) == 0){
    19a6:	fe9053e3          	blez	s1,198c <createdelete+0xc6>
    19aa:	0014f793          	andi	a5,s1,1
    19ae:	d3e9                	beqz	a5,1970 <createdelete+0xaa>
      for(i = 0; i < N; i++){
    19b0:	2485                	addiw	s1,s1,1
    19b2:	fd449ee3          	bne	s1,s4,198e <createdelete+0xc8>
      exit(0);
    19b6:	4501                	li	a0,0
    19b8:	340030ef          	jal	4cf8 <exit>
            printf("%s: unlink failed\n", s);
    19bc:	85ee                	mv	a1,s11
    19be:	00004517          	auipc	a0,0x4
    19c2:	3da50513          	addi	a0,a0,986 # 5d98 <malloc+0xbb0>
    19c6:	76a030ef          	jal	5130 <printf>
            exit(1);
    19ca:	4505                	li	a0,1
    19cc:	32c030ef          	jal	4cf8 <exit>
      exit(1);
    19d0:	4505                	li	a0,1
    19d2:	326030ef          	jal	4cf8 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    19d6:	054bf263          	bgeu	s7,s4,1a1a <createdelete+0x154>
      if(fd >= 0)
    19da:	04055e63          	bgez	a0,1a36 <createdelete+0x170>
    for(pi = 0; pi < NCHILD; pi++){
    19de:	2485                	addiw	s1,s1,1
    19e0:	0ff4f493          	zext.b	s1,s1
    19e4:	05648c63          	beq	s1,s6,1a3c <createdelete+0x176>
      name[0] = 'p' + pi;
    19e8:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    19ec:	f72408a3          	sb	s2,-143(s0)
      fd = open(name, 0);
    19f0:	4581                	li	a1,0
    19f2:	8562                	mv	a0,s8
    19f4:	344030ef          	jal	4d38 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    19f8:	01f5579b          	srliw	a5,a0,0x1f
    19fc:	dfe9                	beqz	a5,19d6 <createdelete+0x110>
    19fe:	fc098ce3          	beqz	s3,19d6 <createdelete+0x110>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1a02:	f7040613          	addi	a2,s0,-144
    1a06:	85ee                	mv	a1,s11
    1a08:	00004517          	auipc	a0,0x4
    1a0c:	3a850513          	addi	a0,a0,936 # 5db0 <malloc+0xbc8>
    1a10:	720030ef          	jal	5130 <printf>
        exit(1);
    1a14:	4505                	li	a0,1
    1a16:	2e2030ef          	jal	4cf8 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1a1a:	fc0542e3          	bltz	a0,19de <createdelete+0x118>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1a1e:	f7040613          	addi	a2,s0,-144
    1a22:	85ee                	mv	a1,s11
    1a24:	00004517          	auipc	a0,0x4
    1a28:	3b450513          	addi	a0,a0,948 # 5dd8 <malloc+0xbf0>
    1a2c:	704030ef          	jal	5130 <printf>
        exit(1);
    1a30:	4505                	li	a0,1
    1a32:	2c6030ef          	jal	4cf8 <exit>
        close(fd);
    1a36:	2ea030ef          	jal	4d20 <close>
    1a3a:	b755                	j	19de <createdelete+0x118>
  for(i = 0; i < N; i++){
    1a3c:	2a85                	addiw	s5,s5,1
    1a3e:	2a05                	addiw	s4,s4,1
    1a40:	2905                	addiw	s2,s2,1
    1a42:	0ff97913          	zext.b	s2,s2
    1a46:	47d1                	li	a5,20
    1a48:	00fa8a63          	beq	s5,a5,1a5c <createdelete+0x196>
      if((i == 0 || i >= N/2) && fd < 0){
    1a4c:	001ab993          	seqz	s3,s5
    1a50:	015d27b3          	slt	a5,s10,s5
    1a54:	00f9e9b3          	or	s3,s3,a5
    1a58:	84e6                	mv	s1,s9
    1a5a:	b779                	j	19e8 <createdelete+0x122>
    1a5c:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    1a60:	07000b13          	li	s6,112
      unlink(name);
    1a64:	f7040a13          	addi	s4,s0,-144
    for(pi = 0; pi < NCHILD; pi++){
    1a68:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    1a6c:	04400a93          	li	s5,68
  name[0] = name[1] = name[2] = 0;
    1a70:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    1a72:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    1a76:	f72408a3          	sb	s2,-143(s0)
      unlink(name);
    1a7a:	8552                	mv	a0,s4
    1a7c:	2cc030ef          	jal	4d48 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1a80:	2485                	addiw	s1,s1,1
    1a82:	0ff4f493          	zext.b	s1,s1
    1a86:	ff3496e3          	bne	s1,s3,1a72 <createdelete+0x1ac>
  for(i = 0; i < N; i++){
    1a8a:	2905                	addiw	s2,s2,1
    1a8c:	0ff97913          	zext.b	s2,s2
    1a90:	ff5910e3          	bne	s2,s5,1a70 <createdelete+0x1aa>
}
    1a94:	60ea                	ld	ra,152(sp)
    1a96:	644a                	ld	s0,144(sp)
    1a98:	64aa                	ld	s1,136(sp)
    1a9a:	690a                	ld	s2,128(sp)
    1a9c:	79e6                	ld	s3,120(sp)
    1a9e:	7a46                	ld	s4,112(sp)
    1aa0:	7aa6                	ld	s5,104(sp)
    1aa2:	7b06                	ld	s6,96(sp)
    1aa4:	6be6                	ld	s7,88(sp)
    1aa6:	6c46                	ld	s8,80(sp)
    1aa8:	6ca6                	ld	s9,72(sp)
    1aaa:	6d06                	ld	s10,64(sp)
    1aac:	7de2                	ld	s11,56(sp)
    1aae:	610d                	addi	sp,sp,160
    1ab0:	8082                	ret

0000000000001ab2 <linkunlink>:
{
    1ab2:	711d                	addi	sp,sp,-96
    1ab4:	ec86                	sd	ra,88(sp)
    1ab6:	e8a2                	sd	s0,80(sp)
    1ab8:	e4a6                	sd	s1,72(sp)
    1aba:	e0ca                	sd	s2,64(sp)
    1abc:	fc4e                	sd	s3,56(sp)
    1abe:	f852                	sd	s4,48(sp)
    1ac0:	f456                	sd	s5,40(sp)
    1ac2:	f05a                	sd	s6,32(sp)
    1ac4:	ec5e                	sd	s7,24(sp)
    1ac6:	e862                	sd	s8,16(sp)
    1ac8:	e466                	sd	s9,8(sp)
    1aca:	e06a                	sd	s10,0(sp)
    1acc:	1080                	addi	s0,sp,96
    1ace:	84aa                	mv	s1,a0
  unlink("x");
    1ad0:	00004517          	auipc	a0,0x4
    1ad4:	8b850513          	addi	a0,a0,-1864 # 5388 <malloc+0x1a0>
    1ad8:	270030ef          	jal	4d48 <unlink>
  pid = fork();
    1adc:	214030ef          	jal	4cf0 <fork>
  if(pid < 0){
    1ae0:	04054363          	bltz	a0,1b26 <linkunlink+0x74>
    1ae4:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    1ae6:	06100913          	li	s2,97
    1aea:	c111                	beqz	a0,1aee <linkunlink+0x3c>
    1aec:	4905                	li	s2,1
    1aee:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1af2:	41c65ab7          	lui	s5,0x41c65
    1af6:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <base+0x41c551f5>
    1afa:	6a0d                	lui	s4,0x3
    1afc:	039a0a1b          	addiw	s4,s4,57 # 3039 <subdir+0x31f>
    if((x % 3) == 0){
    1b00:	000ab9b7          	lui	s3,0xab
    1b04:	aab98993          	addi	s3,s3,-1365 # aaaab <base+0x9ae33>
    1b08:	09b2                	slli	s3,s3,0xc
    1b0a:	aab98993          	addi	s3,s3,-1365
    } else if((x % 3) == 1){
    1b0e:	4b85                	li	s7,1
      unlink("x");
    1b10:	00004b17          	auipc	s6,0x4
    1b14:	878b0b13          	addi	s6,s6,-1928 # 5388 <malloc+0x1a0>
      link("cat", "x");
    1b18:	00004c97          	auipc	s9,0x4
    1b1c:	2e8c8c93          	addi	s9,s9,744 # 5e00 <malloc+0xc18>
      close(open("x", O_RDWR | O_CREATE));
    1b20:	20200c13          	li	s8,514
    1b24:	a03d                	j	1b52 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1b26:	85a6                	mv	a1,s1
    1b28:	00004517          	auipc	a0,0x4
    1b2c:	08050513          	addi	a0,a0,128 # 5ba8 <malloc+0x9c0>
    1b30:	600030ef          	jal	5130 <printf>
    exit(1);
    1b34:	4505                	li	a0,1
    1b36:	1c2030ef          	jal	4cf8 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1b3a:	85e2                	mv	a1,s8
    1b3c:	855a                	mv	a0,s6
    1b3e:	1fa030ef          	jal	4d38 <open>
    1b42:	1de030ef          	jal	4d20 <close>
    1b46:	a021                	j	1b4e <linkunlink+0x9c>
      unlink("x");
    1b48:	855a                	mv	a0,s6
    1b4a:	1fe030ef          	jal	4d48 <unlink>
  for(i = 0; i < 100; i++){
    1b4e:	34fd                	addiw	s1,s1,-1
    1b50:	c885                	beqz	s1,1b80 <linkunlink+0xce>
    x = x * 1103515245 + 12345;
    1b52:	035907bb          	mulw	a5,s2,s5
    1b56:	00fa07bb          	addw	a5,s4,a5
    1b5a:	893e                	mv	s2,a5
    if((x % 3) == 0){
    1b5c:	02079713          	slli	a4,a5,0x20
    1b60:	9301                	srli	a4,a4,0x20
    1b62:	03370733          	mul	a4,a4,s3
    1b66:	9305                	srli	a4,a4,0x21
    1b68:	0017169b          	slliw	a3,a4,0x1
    1b6c:	9f35                	addw	a4,a4,a3
    1b6e:	9f99                	subw	a5,a5,a4
    1b70:	d7e9                	beqz	a5,1b3a <linkunlink+0x88>
    } else if((x % 3) == 1){
    1b72:	fd779be3          	bne	a5,s7,1b48 <linkunlink+0x96>
      link("cat", "x");
    1b76:	85da                	mv	a1,s6
    1b78:	8566                	mv	a0,s9
    1b7a:	1de030ef          	jal	4d58 <link>
    1b7e:	bfc1                	j	1b4e <linkunlink+0x9c>
  if(pid)
    1b80:	020d0363          	beqz	s10,1ba6 <linkunlink+0xf4>
    wait(0);
    1b84:	4501                	li	a0,0
    1b86:	17a030ef          	jal	4d00 <wait>
}
    1b8a:	60e6                	ld	ra,88(sp)
    1b8c:	6446                	ld	s0,80(sp)
    1b8e:	64a6                	ld	s1,72(sp)
    1b90:	6906                	ld	s2,64(sp)
    1b92:	79e2                	ld	s3,56(sp)
    1b94:	7a42                	ld	s4,48(sp)
    1b96:	7aa2                	ld	s5,40(sp)
    1b98:	7b02                	ld	s6,32(sp)
    1b9a:	6be2                	ld	s7,24(sp)
    1b9c:	6c42                	ld	s8,16(sp)
    1b9e:	6ca2                	ld	s9,8(sp)
    1ba0:	6d02                	ld	s10,0(sp)
    1ba2:	6125                	addi	sp,sp,96
    1ba4:	8082                	ret
    exit(0);
    1ba6:	4501                	li	a0,0
    1ba8:	150030ef          	jal	4cf8 <exit>

0000000000001bac <forktest>:
{
    1bac:	7179                	addi	sp,sp,-48
    1bae:	f406                	sd	ra,40(sp)
    1bb0:	f022                	sd	s0,32(sp)
    1bb2:	ec26                	sd	s1,24(sp)
    1bb4:	e84a                	sd	s2,16(sp)
    1bb6:	e44e                	sd	s3,8(sp)
    1bb8:	1800                	addi	s0,sp,48
    1bba:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1bbc:	4481                	li	s1,0
    1bbe:	3e800913          	li	s2,1000
    pid = fork();
    1bc2:	12e030ef          	jal	4cf0 <fork>
    if(pid < 0)
    1bc6:	06054063          	bltz	a0,1c26 <forktest+0x7a>
    if(pid == 0)
    1bca:	cd11                	beqz	a0,1be6 <forktest+0x3a>
  for(n=0; n<N; n++){
    1bcc:	2485                	addiw	s1,s1,1
    1bce:	ff249ae3          	bne	s1,s2,1bc2 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1bd2:	85ce                	mv	a1,s3
    1bd4:	00004517          	auipc	a0,0x4
    1bd8:	27c50513          	addi	a0,a0,636 # 5e50 <malloc+0xc68>
    1bdc:	554030ef          	jal	5130 <printf>
    exit(1);
    1be0:	4505                	li	a0,1
    1be2:	116030ef          	jal	4cf8 <exit>
      exit(0);
    1be6:	112030ef          	jal	4cf8 <exit>
    printf("%s: no fork at all!\n", s);
    1bea:	85ce                	mv	a1,s3
    1bec:	00004517          	auipc	a0,0x4
    1bf0:	21c50513          	addi	a0,a0,540 # 5e08 <malloc+0xc20>
    1bf4:	53c030ef          	jal	5130 <printf>
    exit(1);
    1bf8:	4505                	li	a0,1
    1bfa:	0fe030ef          	jal	4cf8 <exit>
      printf("%s: wait stopped early\n", s);
    1bfe:	85ce                	mv	a1,s3
    1c00:	00004517          	auipc	a0,0x4
    1c04:	22050513          	addi	a0,a0,544 # 5e20 <malloc+0xc38>
    1c08:	528030ef          	jal	5130 <printf>
      exit(1);
    1c0c:	4505                	li	a0,1
    1c0e:	0ea030ef          	jal	4cf8 <exit>
    printf("%s: wait got too many\n", s);
    1c12:	85ce                	mv	a1,s3
    1c14:	00004517          	auipc	a0,0x4
    1c18:	22450513          	addi	a0,a0,548 # 5e38 <malloc+0xc50>
    1c1c:	514030ef          	jal	5130 <printf>
    exit(1);
    1c20:	4505                	li	a0,1
    1c22:	0d6030ef          	jal	4cf8 <exit>
  if (n == 0) {
    1c26:	d0f1                	beqz	s1,1bea <forktest+0x3e>
  for(; n > 0; n--){
    1c28:	00905963          	blez	s1,1c3a <forktest+0x8e>
    if(wait(0) < 0){
    1c2c:	4501                	li	a0,0
    1c2e:	0d2030ef          	jal	4d00 <wait>
    1c32:	fc0546e3          	bltz	a0,1bfe <forktest+0x52>
  for(; n > 0; n--){
    1c36:	34fd                	addiw	s1,s1,-1
    1c38:	f8f5                	bnez	s1,1c2c <forktest+0x80>
  if(wait(0) != -1){
    1c3a:	4501                	li	a0,0
    1c3c:	0c4030ef          	jal	4d00 <wait>
    1c40:	57fd                	li	a5,-1
    1c42:	fcf518e3          	bne	a0,a5,1c12 <forktest+0x66>
}
    1c46:	70a2                	ld	ra,40(sp)
    1c48:	7402                	ld	s0,32(sp)
    1c4a:	64e2                	ld	s1,24(sp)
    1c4c:	6942                	ld	s2,16(sp)
    1c4e:	69a2                	ld	s3,8(sp)
    1c50:	6145                	addi	sp,sp,48
    1c52:	8082                	ret

0000000000001c54 <kernmem>:
{
    1c54:	715d                	addi	sp,sp,-80
    1c56:	e486                	sd	ra,72(sp)
    1c58:	e0a2                	sd	s0,64(sp)
    1c5a:	fc26                	sd	s1,56(sp)
    1c5c:	f84a                	sd	s2,48(sp)
    1c5e:	f44e                	sd	s3,40(sp)
    1c60:	f052                	sd	s4,32(sp)
    1c62:	ec56                	sd	s5,24(sp)
    1c64:	e85a                	sd	s6,16(sp)
    1c66:	0880                	addi	s0,sp,80
    1c68:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c6a:	4485                	li	s1,1
    1c6c:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
    1c6e:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    1c72:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c74:	69b1                	lui	s3,0xc
    1c76:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    1c7a:	1003d937          	lui	s2,0x1003d
    1c7e:	090e                	slli	s2,s2,0x3
    1c80:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    1c84:	06c030ef          	jal	4cf0 <fork>
    if(pid < 0){
    1c88:	02054763          	bltz	a0,1cb6 <kernmem+0x62>
    if(pid == 0){
    1c8c:	cd1d                	beqz	a0,1cca <kernmem+0x76>
    wait(&xstatus);
    1c8e:	8556                	mv	a0,s5
    1c90:	070030ef          	jal	4d00 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1c94:	fbc42783          	lw	a5,-68(s0)
    1c98:	05479663          	bne	a5,s4,1ce4 <kernmem+0x90>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c9c:	94ce                	add	s1,s1,s3
    1c9e:	ff2493e3          	bne	s1,s2,1c84 <kernmem+0x30>
}
    1ca2:	60a6                	ld	ra,72(sp)
    1ca4:	6406                	ld	s0,64(sp)
    1ca6:	74e2                	ld	s1,56(sp)
    1ca8:	7942                	ld	s2,48(sp)
    1caa:	79a2                	ld	s3,40(sp)
    1cac:	7a02                	ld	s4,32(sp)
    1cae:	6ae2                	ld	s5,24(sp)
    1cb0:	6b42                	ld	s6,16(sp)
    1cb2:	6161                	addi	sp,sp,80
    1cb4:	8082                	ret
      printf("%s: fork failed\n", s);
    1cb6:	85da                	mv	a1,s6
    1cb8:	00004517          	auipc	a0,0x4
    1cbc:	ef050513          	addi	a0,a0,-272 # 5ba8 <malloc+0x9c0>
    1cc0:	470030ef          	jal	5130 <printf>
      exit(1);
    1cc4:	4505                	li	a0,1
    1cc6:	032030ef          	jal	4cf8 <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1cca:	0004c683          	lbu	a3,0(s1)
    1cce:	8626                	mv	a2,s1
    1cd0:	85da                	mv	a1,s6
    1cd2:	00004517          	auipc	a0,0x4
    1cd6:	1a650513          	addi	a0,a0,422 # 5e78 <malloc+0xc90>
    1cda:	456030ef          	jal	5130 <printf>
      exit(1);
    1cde:	4505                	li	a0,1
    1ce0:	018030ef          	jal	4cf8 <exit>
      exit(1);
    1ce4:	4505                	li	a0,1
    1ce6:	012030ef          	jal	4cf8 <exit>

0000000000001cea <MAXVAplus>:
{
    1cea:	7139                	addi	sp,sp,-64
    1cec:	fc06                	sd	ra,56(sp)
    1cee:	f822                	sd	s0,48(sp)
    1cf0:	0080                	addi	s0,sp,64
  volatile uint64 a = MAXVA;
    1cf2:	4785                	li	a5,1
    1cf4:	179a                	slli	a5,a5,0x26
    1cf6:	fcf43423          	sd	a5,-56(s0)
  for( ; a != 0; a <<= 1){
    1cfa:	fc843783          	ld	a5,-56(s0)
    1cfe:	cf9d                	beqz	a5,1d3c <MAXVAplus+0x52>
    1d00:	f426                	sd	s1,40(sp)
    1d02:	f04a                	sd	s2,32(sp)
    1d04:	ec4e                	sd	s3,24(sp)
    1d06:	89aa                	mv	s3,a0
    wait(&xstatus);
    1d08:	fc440913          	addi	s2,s0,-60
    if(xstatus != -1)  // did kernel kill child?
    1d0c:	54fd                	li	s1,-1
    pid = fork();
    1d0e:	7e3020ef          	jal	4cf0 <fork>
    if(pid < 0){
    1d12:	02054963          	bltz	a0,1d44 <MAXVAplus+0x5a>
    if(pid == 0){
    1d16:	c129                	beqz	a0,1d58 <MAXVAplus+0x6e>
    wait(&xstatus);
    1d18:	854a                	mv	a0,s2
    1d1a:	7e7020ef          	jal	4d00 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1d1e:	fc442783          	lw	a5,-60(s0)
    1d22:	04979d63          	bne	a5,s1,1d7c <MAXVAplus+0x92>
  for( ; a != 0; a <<= 1){
    1d26:	fc843783          	ld	a5,-56(s0)
    1d2a:	0786                	slli	a5,a5,0x1
    1d2c:	fcf43423          	sd	a5,-56(s0)
    1d30:	fc843783          	ld	a5,-56(s0)
    1d34:	ffe9                	bnez	a5,1d0e <MAXVAplus+0x24>
    1d36:	74a2                	ld	s1,40(sp)
    1d38:	7902                	ld	s2,32(sp)
    1d3a:	69e2                	ld	s3,24(sp)
}
    1d3c:	70e2                	ld	ra,56(sp)
    1d3e:	7442                	ld	s0,48(sp)
    1d40:	6121                	addi	sp,sp,64
    1d42:	8082                	ret
      printf("%s: fork failed\n", s);
    1d44:	85ce                	mv	a1,s3
    1d46:	00004517          	auipc	a0,0x4
    1d4a:	e6250513          	addi	a0,a0,-414 # 5ba8 <malloc+0x9c0>
    1d4e:	3e2030ef          	jal	5130 <printf>
      exit(1);
    1d52:	4505                	li	a0,1
    1d54:	7a5020ef          	jal	4cf8 <exit>
      *(char*)a = 99;
    1d58:	fc843783          	ld	a5,-56(s0)
    1d5c:	06300713          	li	a4,99
    1d60:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void*)a);
    1d64:	fc843603          	ld	a2,-56(s0)
    1d68:	85ce                	mv	a1,s3
    1d6a:	00004517          	auipc	a0,0x4
    1d6e:	12e50513          	addi	a0,a0,302 # 5e98 <malloc+0xcb0>
    1d72:	3be030ef          	jal	5130 <printf>
      exit(1);
    1d76:	4505                	li	a0,1
    1d78:	781020ef          	jal	4cf8 <exit>
      exit(1);
    1d7c:	4505                	li	a0,1
    1d7e:	77b020ef          	jal	4cf8 <exit>

0000000000001d82 <stacktest>:
{
    1d82:	7179                	addi	sp,sp,-48
    1d84:	f406                	sd	ra,40(sp)
    1d86:	f022                	sd	s0,32(sp)
    1d88:	ec26                	sd	s1,24(sp)
    1d8a:	1800                	addi	s0,sp,48
    1d8c:	84aa                	mv	s1,a0
  pid = fork();
    1d8e:	763020ef          	jal	4cf0 <fork>
  if(pid == 0) {
    1d92:	cd11                	beqz	a0,1dae <stacktest+0x2c>
  } else if(pid < 0){
    1d94:	02054c63          	bltz	a0,1dcc <stacktest+0x4a>
  wait(&xstatus);
    1d98:	fdc40513          	addi	a0,s0,-36
    1d9c:	765020ef          	jal	4d00 <wait>
  if(xstatus == -1)  // kernel killed child?
    1da0:	fdc42503          	lw	a0,-36(s0)
    1da4:	57fd                	li	a5,-1
    1da6:	02f50d63          	beq	a0,a5,1de0 <stacktest+0x5e>
    exit(xstatus);
    1daa:	74f020ef          	jal	4cf8 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1dae:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1db0:	77f9                	lui	a5,0xffffe
    1db2:	97ba                	add	a5,a5,a4
    1db4:	0007c603          	lbu	a2,0(a5) # ffffffffffffe000 <base+0xfffffffffffee388>
    1db8:	85a6                	mv	a1,s1
    1dba:	00004517          	auipc	a0,0x4
    1dbe:	0f650513          	addi	a0,a0,246 # 5eb0 <malloc+0xcc8>
    1dc2:	36e030ef          	jal	5130 <printf>
    exit(1);
    1dc6:	4505                	li	a0,1
    1dc8:	731020ef          	jal	4cf8 <exit>
    printf("%s: fork failed\n", s);
    1dcc:	85a6                	mv	a1,s1
    1dce:	00004517          	auipc	a0,0x4
    1dd2:	dda50513          	addi	a0,a0,-550 # 5ba8 <malloc+0x9c0>
    1dd6:	35a030ef          	jal	5130 <printf>
    exit(1);
    1dda:	4505                	li	a0,1
    1ddc:	71d020ef          	jal	4cf8 <exit>
    exit(0);
    1de0:	4501                	li	a0,0
    1de2:	717020ef          	jal	4cf8 <exit>

0000000000001de6 <nowrite>:
{
    1de6:	7159                	addi	sp,sp,-112
    1de8:	f486                	sd	ra,104(sp)
    1dea:	f0a2                	sd	s0,96(sp)
    1dec:	eca6                	sd	s1,88(sp)
    1dee:	e8ca                	sd	s2,80(sp)
    1df0:	e4ce                	sd	s3,72(sp)
    1df2:	e0d2                	sd	s4,64(sp)
    1df4:	1880                	addi	s0,sp,112
    1df6:	8a2a                	mv	s4,a0
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    1df8:	00006797          	auipc	a5,0x6
    1dfc:	88078793          	addi	a5,a5,-1920 # 7678 <malloc+0x2490>
    1e00:	7788                	ld	a0,40(a5)
    1e02:	7b8c                	ld	a1,48(a5)
    1e04:	7f90                	ld	a2,56(a5)
    1e06:	63b4                	ld	a3,64(a5)
    1e08:	67b8                	ld	a4,72(a5)
    1e0a:	f8a43c23          	sd	a0,-104(s0)
    1e0e:	fab43023          	sd	a1,-96(s0)
    1e12:	fac43423          	sd	a2,-88(s0)
    1e16:	fad43823          	sd	a3,-80(s0)
    1e1a:	fae43c23          	sd	a4,-72(s0)
    1e1e:	6bbc                	ld	a5,80(a5)
    1e20:	fcf43023          	sd	a5,-64(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e24:	4481                	li	s1,0
    wait(&xstatus);
    1e26:	fcc40913          	addi	s2,s0,-52
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e2a:	4999                	li	s3,6
    pid = fork();
    1e2c:	6c5020ef          	jal	4cf0 <fork>
    if(pid == 0) {
    1e30:	cd19                	beqz	a0,1e4e <nowrite+0x68>
    } else if(pid < 0){
    1e32:	04054163          	bltz	a0,1e74 <nowrite+0x8e>
    wait(&xstatus);
    1e36:	854a                	mv	a0,s2
    1e38:	6c9020ef          	jal	4d00 <wait>
    if(xstatus == 0){
    1e3c:	fcc42783          	lw	a5,-52(s0)
    1e40:	c7a1                	beqz	a5,1e88 <nowrite+0xa2>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e42:	2485                	addiw	s1,s1,1
    1e44:	ff3494e3          	bne	s1,s3,1e2c <nowrite+0x46>
  exit(0);
    1e48:	4501                	li	a0,0
    1e4a:	6af020ef          	jal	4cf8 <exit>
      volatile int *addr = (int *) addrs[ai];
    1e4e:	048e                	slli	s1,s1,0x3
    1e50:	fd048793          	addi	a5,s1,-48
    1e54:	008784b3          	add	s1,a5,s0
    1e58:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1e5c:	47a9                	li	a5,10
    1e5e:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1e60:	85d2                	mv	a1,s4
    1e62:	00004517          	auipc	a0,0x4
    1e66:	07650513          	addi	a0,a0,118 # 5ed8 <malloc+0xcf0>
    1e6a:	2c6030ef          	jal	5130 <printf>
      exit(0);
    1e6e:	4501                	li	a0,0
    1e70:	689020ef          	jal	4cf8 <exit>
      printf("%s: fork failed\n", s);
    1e74:	85d2                	mv	a1,s4
    1e76:	00004517          	auipc	a0,0x4
    1e7a:	d3250513          	addi	a0,a0,-718 # 5ba8 <malloc+0x9c0>
    1e7e:	2b2030ef          	jal	5130 <printf>
      exit(1);
    1e82:	4505                	li	a0,1
    1e84:	675020ef          	jal	4cf8 <exit>
      exit(1);
    1e88:	4505                	li	a0,1
    1e8a:	66f020ef          	jal	4cf8 <exit>

0000000000001e8e <manywrites>:
{
    1e8e:	7159                	addi	sp,sp,-112
    1e90:	f486                	sd	ra,104(sp)
    1e92:	f0a2                	sd	s0,96(sp)
    1e94:	eca6                	sd	s1,88(sp)
    1e96:	e8ca                	sd	s2,80(sp)
    1e98:	e4ce                	sd	s3,72(sp)
    1e9a:	ec66                	sd	s9,24(sp)
    1e9c:	1880                	addi	s0,sp,112
    1e9e:	8caa                	mv	s9,a0
  for(int ci = 0; ci < nchildren; ci++){
    1ea0:	4901                	li	s2,0
    1ea2:	4991                	li	s3,4
    int pid = fork();
    1ea4:	64d020ef          	jal	4cf0 <fork>
    1ea8:	84aa                	mv	s1,a0
    if(pid < 0){
    1eaa:	02054c63          	bltz	a0,1ee2 <manywrites+0x54>
    if(pid == 0){
    1eae:	c929                	beqz	a0,1f00 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    1eb0:	2905                	addiw	s2,s2,1
    1eb2:	ff3919e3          	bne	s2,s3,1ea4 <manywrites+0x16>
    1eb6:	4491                	li	s1,4
    wait(&st);
    1eb8:	f9840913          	addi	s2,s0,-104
    int st = 0;
    1ebc:	f8042c23          	sw	zero,-104(s0)
    wait(&st);
    1ec0:	854a                	mv	a0,s2
    1ec2:	63f020ef          	jal	4d00 <wait>
    if(st != 0)
    1ec6:	f9842503          	lw	a0,-104(s0)
    1eca:	0e051763          	bnez	a0,1fb8 <manywrites+0x12a>
  for(int ci = 0; ci < nchildren; ci++){
    1ece:	34fd                	addiw	s1,s1,-1
    1ed0:	f4f5                	bnez	s1,1ebc <manywrites+0x2e>
    1ed2:	e0d2                	sd	s4,64(sp)
    1ed4:	fc56                	sd	s5,56(sp)
    1ed6:	f85a                	sd	s6,48(sp)
    1ed8:	f45e                	sd	s7,40(sp)
    1eda:	f062                	sd	s8,32(sp)
    1edc:	e86a                	sd	s10,16(sp)
  exit(0);
    1ede:	61b020ef          	jal	4cf8 <exit>
    1ee2:	e0d2                	sd	s4,64(sp)
    1ee4:	fc56                	sd	s5,56(sp)
    1ee6:	f85a                	sd	s6,48(sp)
    1ee8:	f45e                	sd	s7,40(sp)
    1eea:	f062                	sd	s8,32(sp)
    1eec:	e86a                	sd	s10,16(sp)
      printf("fork failed\n");
    1eee:	00005517          	auipc	a0,0x5
    1ef2:	22a50513          	addi	a0,a0,554 # 7118 <malloc+0x1f30>
    1ef6:	23a030ef          	jal	5130 <printf>
      exit(1);
    1efa:	4505                	li	a0,1
    1efc:	5fd020ef          	jal	4cf8 <exit>
    1f00:	e0d2                	sd	s4,64(sp)
    1f02:	fc56                	sd	s5,56(sp)
    1f04:	f85a                	sd	s6,48(sp)
    1f06:	f45e                	sd	s7,40(sp)
    1f08:	f062                	sd	s8,32(sp)
    1f0a:	e86a                	sd	s10,16(sp)
      name[0] = 'b';
    1f0c:	06200793          	li	a5,98
    1f10:	f8f40c23          	sb	a5,-104(s0)
      name[1] = 'a' + ci;
    1f14:	0619079b          	addiw	a5,s2,97
    1f18:	f8f40ca3          	sb	a5,-103(s0)
      name[2] = '\0';
    1f1c:	f8040d23          	sb	zero,-102(s0)
      unlink(name);
    1f20:	f9840513          	addi	a0,s0,-104
    1f24:	625020ef          	jal	4d48 <unlink>
    1f28:	47f9                	li	a5,30
    1f2a:	8d3e                	mv	s10,a5
          int fd = open(name, O_CREATE | O_RDWR);
    1f2c:	f9840b93          	addi	s7,s0,-104
    1f30:	20200b13          	li	s6,514
          int cc = write(fd, buf, sz);
    1f34:	6a8d                	lui	s5,0x3
    1f36:	0000bc17          	auipc	s8,0xb
    1f3a:	d42c0c13          	addi	s8,s8,-702 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    1f3e:	8a26                	mv	s4,s1
    1f40:	02094563          	bltz	s2,1f6a <manywrites+0xdc>
          int fd = open(name, O_CREATE | O_RDWR);
    1f44:	85da                	mv	a1,s6
    1f46:	855e                	mv	a0,s7
    1f48:	5f1020ef          	jal	4d38 <open>
    1f4c:	89aa                	mv	s3,a0
          if(fd < 0){
    1f4e:	02054d63          	bltz	a0,1f88 <manywrites+0xfa>
          int cc = write(fd, buf, sz);
    1f52:	8656                	mv	a2,s5
    1f54:	85e2                	mv	a1,s8
    1f56:	5c3020ef          	jal	4d18 <write>
          if(cc != sz){
    1f5a:	05551363          	bne	a0,s5,1fa0 <manywrites+0x112>
          close(fd);
    1f5e:	854e                	mv	a0,s3
    1f60:	5c1020ef          	jal	4d20 <close>
        for(int i = 0; i < ci+1; i++){
    1f64:	2a05                	addiw	s4,s4,1
    1f66:	fd495fe3          	bge	s2,s4,1f44 <manywrites+0xb6>
        unlink(name);
    1f6a:	f9840513          	addi	a0,s0,-104
    1f6e:	5db020ef          	jal	4d48 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f72:	fffd079b          	addiw	a5,s10,-1
    1f76:	8d3e                	mv	s10,a5
    1f78:	f3f9                	bnez	a5,1f3e <manywrites+0xb0>
      unlink(name);
    1f7a:	f9840513          	addi	a0,s0,-104
    1f7e:	5cb020ef          	jal	4d48 <unlink>
      exit(0);
    1f82:	4501                	li	a0,0
    1f84:	575020ef          	jal	4cf8 <exit>
            printf("%s: cannot create %s\n", s, name);
    1f88:	f9840613          	addi	a2,s0,-104
    1f8c:	85e6                	mv	a1,s9
    1f8e:	00004517          	auipc	a0,0x4
    1f92:	f6a50513          	addi	a0,a0,-150 # 5ef8 <malloc+0xd10>
    1f96:	19a030ef          	jal	5130 <printf>
            exit(1);
    1f9a:	4505                	li	a0,1
    1f9c:	55d020ef          	jal	4cf8 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1fa0:	86aa                	mv	a3,a0
    1fa2:	660d                	lui	a2,0x3
    1fa4:	85e6                	mv	a1,s9
    1fa6:	00003517          	auipc	a0,0x3
    1faa:	44250513          	addi	a0,a0,1090 # 53e8 <malloc+0x200>
    1fae:	182030ef          	jal	5130 <printf>
            exit(1);
    1fb2:	4505                	li	a0,1
    1fb4:	545020ef          	jal	4cf8 <exit>
    1fb8:	e0d2                	sd	s4,64(sp)
    1fba:	fc56                	sd	s5,56(sp)
    1fbc:	f85a                	sd	s6,48(sp)
    1fbe:	f45e                	sd	s7,40(sp)
    1fc0:	f062                	sd	s8,32(sp)
    1fc2:	e86a                	sd	s10,16(sp)
      exit(st);
    1fc4:	535020ef          	jal	4cf8 <exit>

0000000000001fc8 <copyinstr3>:
{
    1fc8:	7179                	addi	sp,sp,-48
    1fca:	f406                	sd	ra,40(sp)
    1fcc:	f022                	sd	s0,32(sp)
    1fce:	ec26                	sd	s1,24(sp)
    1fd0:	1800                	addi	s0,sp,48
  sbrk(8192);
    1fd2:	6509                	lui	a0,0x2
    1fd4:	5ad020ef          	jal	4d80 <sbrk>
  uint64 top = (uint64) sbrk(0);
    1fd8:	4501                	li	a0,0
    1fda:	5a7020ef          	jal	4d80 <sbrk>
  if((top % PGSIZE) != 0){
    1fde:	03451793          	slli	a5,a0,0x34
    1fe2:	e7bd                	bnez	a5,2050 <copyinstr3+0x88>
  top = (uint64) sbrk(0);
    1fe4:	4501                	li	a0,0
    1fe6:	59b020ef          	jal	4d80 <sbrk>
  if(top % PGSIZE){
    1fea:	03451793          	slli	a5,a0,0x34
    1fee:	ebad                	bnez	a5,2060 <copyinstr3+0x98>
  char *b = (char *) (top - 1);
    1ff0:	fff50493          	addi	s1,a0,-1 # 1fff <copyinstr3+0x37>
  *b = 'x';
    1ff4:	07800793          	li	a5,120
    1ff8:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1ffc:	8526                	mv	a0,s1
    1ffe:	54b020ef          	jal	4d48 <unlink>
  if(ret != -1){
    2002:	57fd                	li	a5,-1
    2004:	06f51763          	bne	a0,a5,2072 <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    2008:	20100593          	li	a1,513
    200c:	8526                	mv	a0,s1
    200e:	52b020ef          	jal	4d38 <open>
  if(fd != -1){
    2012:	57fd                	li	a5,-1
    2014:	06f51a63          	bne	a0,a5,2088 <copyinstr3+0xc0>
  ret = link(b, b);
    2018:	85a6                	mv	a1,s1
    201a:	8526                	mv	a0,s1
    201c:	53d020ef          	jal	4d58 <link>
  if(ret != -1){
    2020:	57fd                	li	a5,-1
    2022:	06f51e63          	bne	a0,a5,209e <copyinstr3+0xd6>
  char *args[] = { "xx", 0 };
    2026:	00005797          	auipc	a5,0x5
    202a:	bd278793          	addi	a5,a5,-1070 # 6bf8 <malloc+0x1a10>
    202e:	fcf43823          	sd	a5,-48(s0)
    2032:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2036:	fd040593          	addi	a1,s0,-48
    203a:	8526                	mv	a0,s1
    203c:	4f5020ef          	jal	4d30 <exec>
  if(ret != -1){
    2040:	57fd                	li	a5,-1
    2042:	06f51a63          	bne	a0,a5,20b6 <copyinstr3+0xee>
}
    2046:	70a2                	ld	ra,40(sp)
    2048:	7402                	ld	s0,32(sp)
    204a:	64e2                	ld	s1,24(sp)
    204c:	6145                	addi	sp,sp,48
    204e:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2050:	0347d513          	srli	a0,a5,0x34
    2054:	6785                	lui	a5,0x1
    2056:	40a7853b          	subw	a0,a5,a0
    205a:	527020ef          	jal	4d80 <sbrk>
    205e:	b759                	j	1fe4 <copyinstr3+0x1c>
    printf("oops\n");
    2060:	00004517          	auipc	a0,0x4
    2064:	eb050513          	addi	a0,a0,-336 # 5f10 <malloc+0xd28>
    2068:	0c8030ef          	jal	5130 <printf>
    exit(1);
    206c:	4505                	li	a0,1
    206e:	48b020ef          	jal	4cf8 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    2072:	862a                	mv	a2,a0
    2074:	85a6                	mv	a1,s1
    2076:	00004517          	auipc	a0,0x4
    207a:	a5250513          	addi	a0,a0,-1454 # 5ac8 <malloc+0x8e0>
    207e:	0b2030ef          	jal	5130 <printf>
    exit(1);
    2082:	4505                	li	a0,1
    2084:	475020ef          	jal	4cf8 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2088:	862a                	mv	a2,a0
    208a:	85a6                	mv	a1,s1
    208c:	00004517          	auipc	a0,0x4
    2090:	a5c50513          	addi	a0,a0,-1444 # 5ae8 <malloc+0x900>
    2094:	09c030ef          	jal	5130 <printf>
    exit(1);
    2098:	4505                	li	a0,1
    209a:	45f020ef          	jal	4cf8 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    209e:	86aa                	mv	a3,a0
    20a0:	8626                	mv	a2,s1
    20a2:	85a6                	mv	a1,s1
    20a4:	00004517          	auipc	a0,0x4
    20a8:	a6450513          	addi	a0,a0,-1436 # 5b08 <malloc+0x920>
    20ac:	084030ef          	jal	5130 <printf>
    exit(1);
    20b0:	4505                	li	a0,1
    20b2:	447020ef          	jal	4cf8 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    20b6:	863e                	mv	a2,a5
    20b8:	85a6                	mv	a1,s1
    20ba:	00004517          	auipc	a0,0x4
    20be:	a7650513          	addi	a0,a0,-1418 # 5b30 <malloc+0x948>
    20c2:	06e030ef          	jal	5130 <printf>
    exit(1);
    20c6:	4505                	li	a0,1
    20c8:	431020ef          	jal	4cf8 <exit>

00000000000020cc <rwsbrk>:
{
    20cc:	1101                	addi	sp,sp,-32
    20ce:	ec06                	sd	ra,24(sp)
    20d0:	e822                	sd	s0,16(sp)
    20d2:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    20d4:	6509                	lui	a0,0x2
    20d6:	4ab020ef          	jal	4d80 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    20da:	57fd                	li	a5,-1
    20dc:	04f50a63          	beq	a0,a5,2130 <rwsbrk+0x64>
    20e0:	e426                	sd	s1,8(sp)
    20e2:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    20e4:	7579                	lui	a0,0xffffe
    20e6:	49b020ef          	jal	4d80 <sbrk>
    20ea:	57fd                	li	a5,-1
    20ec:	04f50d63          	beq	a0,a5,2146 <rwsbrk+0x7a>
    20f0:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    20f2:	20100593          	li	a1,513
    20f6:	00004517          	auipc	a0,0x4
    20fa:	e5a50513          	addi	a0,a0,-422 # 5f50 <malloc+0xd68>
    20fe:	43b020ef          	jal	4d38 <open>
    2102:	892a                	mv	s2,a0
  if(fd < 0){
    2104:	04054b63          	bltz	a0,215a <rwsbrk+0x8e>
  n = write(fd, (void*)(a+4096), 1024);
    2108:	6785                	lui	a5,0x1
    210a:	94be                	add	s1,s1,a5
    210c:	40000613          	li	a2,1024
    2110:	85a6                	mv	a1,s1
    2112:	407020ef          	jal	4d18 <write>
    2116:	862a                	mv	a2,a0
  if(n >= 0){
    2118:	04054a63          	bltz	a0,216c <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+4096, n);
    211c:	85a6                	mv	a1,s1
    211e:	00004517          	auipc	a0,0x4
    2122:	e5250513          	addi	a0,a0,-430 # 5f70 <malloc+0xd88>
    2126:	00a030ef          	jal	5130 <printf>
    exit(1);
    212a:	4505                	li	a0,1
    212c:	3cd020ef          	jal	4cf8 <exit>
    2130:	e426                	sd	s1,8(sp)
    2132:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    2134:	00004517          	auipc	a0,0x4
    2138:	de450513          	addi	a0,a0,-540 # 5f18 <malloc+0xd30>
    213c:	7f5020ef          	jal	5130 <printf>
    exit(1);
    2140:	4505                	li	a0,1
    2142:	3b7020ef          	jal	4cf8 <exit>
    2146:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    2148:	00004517          	auipc	a0,0x4
    214c:	de850513          	addi	a0,a0,-536 # 5f30 <malloc+0xd48>
    2150:	7e1020ef          	jal	5130 <printf>
    exit(1);
    2154:	4505                	li	a0,1
    2156:	3a3020ef          	jal	4cf8 <exit>
    printf("open(rwsbrk) failed\n");
    215a:	00004517          	auipc	a0,0x4
    215e:	dfe50513          	addi	a0,a0,-514 # 5f58 <malloc+0xd70>
    2162:	7cf020ef          	jal	5130 <printf>
    exit(1);
    2166:	4505                	li	a0,1
    2168:	391020ef          	jal	4cf8 <exit>
  close(fd);
    216c:	854a                	mv	a0,s2
    216e:	3b3020ef          	jal	4d20 <close>
  unlink("rwsbrk");
    2172:	00004517          	auipc	a0,0x4
    2176:	dde50513          	addi	a0,a0,-546 # 5f50 <malloc+0xd68>
    217a:	3cf020ef          	jal	4d48 <unlink>
  fd = open("README", O_RDONLY);
    217e:	4581                	li	a1,0
    2180:	00003517          	auipc	a0,0x3
    2184:	37050513          	addi	a0,a0,880 # 54f0 <malloc+0x308>
    2188:	3b1020ef          	jal	4d38 <open>
    218c:	892a                	mv	s2,a0
  if(fd < 0){
    218e:	02054363          	bltz	a0,21b4 <rwsbrk+0xe8>
  n = read(fd, (void*)(a+4096), 10);
    2192:	4629                	li	a2,10
    2194:	85a6                	mv	a1,s1
    2196:	37b020ef          	jal	4d10 <read>
    219a:	862a                	mv	a2,a0
  if(n >= 0){
    219c:	02054563          	bltz	a0,21c6 <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+4096, n);
    21a0:	85a6                	mv	a1,s1
    21a2:	00004517          	auipc	a0,0x4
    21a6:	dfe50513          	addi	a0,a0,-514 # 5fa0 <malloc+0xdb8>
    21aa:	787020ef          	jal	5130 <printf>
    exit(1);
    21ae:	4505                	li	a0,1
    21b0:	349020ef          	jal	4cf8 <exit>
    printf("open(rwsbrk) failed\n");
    21b4:	00004517          	auipc	a0,0x4
    21b8:	da450513          	addi	a0,a0,-604 # 5f58 <malloc+0xd70>
    21bc:	775020ef          	jal	5130 <printf>
    exit(1);
    21c0:	4505                	li	a0,1
    21c2:	337020ef          	jal	4cf8 <exit>
  close(fd);
    21c6:	854a                	mv	a0,s2
    21c8:	359020ef          	jal	4d20 <close>
  exit(0);
    21cc:	4501                	li	a0,0
    21ce:	32b020ef          	jal	4cf8 <exit>

00000000000021d2 <sbrkbasic>:
{
    21d2:	715d                	addi	sp,sp,-80
    21d4:	e486                	sd	ra,72(sp)
    21d6:	e0a2                	sd	s0,64(sp)
    21d8:	ec56                	sd	s5,24(sp)
    21da:	0880                	addi	s0,sp,80
    21dc:	8aaa                	mv	s5,a0
  pid = fork();
    21de:	313020ef          	jal	4cf0 <fork>
  if(pid < 0){
    21e2:	02054c63          	bltz	a0,221a <sbrkbasic+0x48>
  if(pid == 0){
    21e6:	ed31                	bnez	a0,2242 <sbrkbasic+0x70>
    a = sbrk(TOOMUCH);
    21e8:	40000537          	lui	a0,0x40000
    21ec:	395020ef          	jal	4d80 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    21f0:	57fd                	li	a5,-1
    21f2:	04f50163          	beq	a0,a5,2234 <sbrkbasic+0x62>
    21f6:	fc26                	sd	s1,56(sp)
    21f8:	f84a                	sd	s2,48(sp)
    21fa:	f44e                	sd	s3,40(sp)
    21fc:	f052                	sd	s4,32(sp)
    for(b = a; b < a+TOOMUCH; b += 4096){
    21fe:	400007b7          	lui	a5,0x40000
    2202:	97aa                	add	a5,a5,a0
      *b = 99;
    2204:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    2208:	6705                	lui	a4,0x1
      *b = 99;
    220a:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    220e:	953a                	add	a0,a0,a4
    2210:	fef51de3          	bne	a0,a5,220a <sbrkbasic+0x38>
    exit(1);
    2214:	4505                	li	a0,1
    2216:	2e3020ef          	jal	4cf8 <exit>
    221a:	fc26                	sd	s1,56(sp)
    221c:	f84a                	sd	s2,48(sp)
    221e:	f44e                	sd	s3,40(sp)
    2220:	f052                	sd	s4,32(sp)
    printf("fork failed in sbrkbasic\n");
    2222:	00004517          	auipc	a0,0x4
    2226:	da650513          	addi	a0,a0,-602 # 5fc8 <malloc+0xde0>
    222a:	707020ef          	jal	5130 <printf>
    exit(1);
    222e:	4505                	li	a0,1
    2230:	2c9020ef          	jal	4cf8 <exit>
    2234:	fc26                	sd	s1,56(sp)
    2236:	f84a                	sd	s2,48(sp)
    2238:	f44e                	sd	s3,40(sp)
    223a:	f052                	sd	s4,32(sp)
      exit(0);
    223c:	4501                	li	a0,0
    223e:	2bb020ef          	jal	4cf8 <exit>
  wait(&xstatus);
    2242:	fbc40513          	addi	a0,s0,-68
    2246:	2bb020ef          	jal	4d00 <wait>
  if(xstatus == 1){
    224a:	fbc42703          	lw	a4,-68(s0)
    224e:	4785                	li	a5,1
    2250:	02f70063          	beq	a4,a5,2270 <sbrkbasic+0x9e>
    2254:	fc26                	sd	s1,56(sp)
    2256:	f84a                	sd	s2,48(sp)
    2258:	f44e                	sd	s3,40(sp)
    225a:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    225c:	4501                	li	a0,0
    225e:	323020ef          	jal	4d80 <sbrk>
    2262:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2264:	4901                	li	s2,0
    b = sbrk(1);
    2266:	4985                	li	s3,1
  for(i = 0; i < 5000; i++){
    2268:	6a05                	lui	s4,0x1
    226a:	388a0a13          	addi	s4,s4,904 # 1388 <truncate3+0x14a>
    226e:	a005                	j	228e <sbrkbasic+0xbc>
    2270:	fc26                	sd	s1,56(sp)
    2272:	f84a                	sd	s2,48(sp)
    2274:	f44e                	sd	s3,40(sp)
    2276:	f052                	sd	s4,32(sp)
    printf("%s: too much memory allocated!\n", s);
    2278:	85d6                	mv	a1,s5
    227a:	00004517          	auipc	a0,0x4
    227e:	d6e50513          	addi	a0,a0,-658 # 5fe8 <malloc+0xe00>
    2282:	6af020ef          	jal	5130 <printf>
    exit(1);
    2286:	4505                	li	a0,1
    2288:	271020ef          	jal	4cf8 <exit>
    228c:	84be                	mv	s1,a5
    b = sbrk(1);
    228e:	854e                	mv	a0,s3
    2290:	2f1020ef          	jal	4d80 <sbrk>
    if(b != a){
    2294:	04951163          	bne	a0,s1,22d6 <sbrkbasic+0x104>
    *b = 1;
    2298:	01348023          	sb	s3,0(s1)
    a = b + 1;
    229c:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    22a0:	2905                	addiw	s2,s2,1
    22a2:	ff4915e3          	bne	s2,s4,228c <sbrkbasic+0xba>
  pid = fork();
    22a6:	24b020ef          	jal	4cf0 <fork>
    22aa:	892a                	mv	s2,a0
  if(pid < 0){
    22ac:	04054263          	bltz	a0,22f0 <sbrkbasic+0x11e>
  c = sbrk(1);
    22b0:	4505                	li	a0,1
    22b2:	2cf020ef          	jal	4d80 <sbrk>
  c = sbrk(1);
    22b6:	4505                	li	a0,1
    22b8:	2c9020ef          	jal	4d80 <sbrk>
  if(c != a + 1){
    22bc:	0489                	addi	s1,s1,2
    22be:	04950363          	beq	a0,s1,2304 <sbrkbasic+0x132>
    printf("%s: sbrk test failed post-fork\n", s);
    22c2:	85d6                	mv	a1,s5
    22c4:	00004517          	auipc	a0,0x4
    22c8:	d8450513          	addi	a0,a0,-636 # 6048 <malloc+0xe60>
    22cc:	665020ef          	jal	5130 <printf>
    exit(1);
    22d0:	4505                	li	a0,1
    22d2:	227020ef          	jal	4cf8 <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    22d6:	872a                	mv	a4,a0
    22d8:	86a6                	mv	a3,s1
    22da:	864a                	mv	a2,s2
    22dc:	85d6                	mv	a1,s5
    22de:	00004517          	auipc	a0,0x4
    22e2:	d2a50513          	addi	a0,a0,-726 # 6008 <malloc+0xe20>
    22e6:	64b020ef          	jal	5130 <printf>
      exit(1);
    22ea:	4505                	li	a0,1
    22ec:	20d020ef          	jal	4cf8 <exit>
    printf("%s: sbrk test fork failed\n", s);
    22f0:	85d6                	mv	a1,s5
    22f2:	00004517          	auipc	a0,0x4
    22f6:	d3650513          	addi	a0,a0,-714 # 6028 <malloc+0xe40>
    22fa:	637020ef          	jal	5130 <printf>
    exit(1);
    22fe:	4505                	li	a0,1
    2300:	1f9020ef          	jal	4cf8 <exit>
  if(pid == 0)
    2304:	00091563          	bnez	s2,230e <sbrkbasic+0x13c>
    exit(0);
    2308:	4501                	li	a0,0
    230a:	1ef020ef          	jal	4cf8 <exit>
  wait(&xstatus);
    230e:	fbc40513          	addi	a0,s0,-68
    2312:	1ef020ef          	jal	4d00 <wait>
  exit(xstatus);
    2316:	fbc42503          	lw	a0,-68(s0)
    231a:	1df020ef          	jal	4cf8 <exit>

000000000000231e <sbrkmuch>:
{
    231e:	7179                	addi	sp,sp,-48
    2320:	f406                	sd	ra,40(sp)
    2322:	f022                	sd	s0,32(sp)
    2324:	ec26                	sd	s1,24(sp)
    2326:	e84a                	sd	s2,16(sp)
    2328:	e44e                	sd	s3,8(sp)
    232a:	e052                	sd	s4,0(sp)
    232c:	1800                	addi	s0,sp,48
    232e:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2330:	4501                	li	a0,0
    2332:	24f020ef          	jal	4d80 <sbrk>
    2336:	892a                	mv	s2,a0
  a = sbrk(0);
    2338:	4501                	li	a0,0
    233a:	247020ef          	jal	4d80 <sbrk>
    233e:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2340:	06400537          	lui	a0,0x6400
    2344:	9d05                	subw	a0,a0,s1
    2346:	23b020ef          	jal	4d80 <sbrk>
  if (p != a) {
    234a:	0aa49663          	bne	s1,a0,23f6 <sbrkmuch+0xd8>
  char *eee = sbrk(0);
    234e:	4501                	li	a0,0
    2350:	231020ef          	jal	4d80 <sbrk>
    2354:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2356:	00a4f963          	bgeu	s1,a0,2368 <sbrkmuch+0x4a>
    *pp = 1;
    235a:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    235c:	6705                	lui	a4,0x1
    *pp = 1;
    235e:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2362:	94ba                	add	s1,s1,a4
    2364:	fef4ede3          	bltu	s1,a5,235e <sbrkmuch+0x40>
  *lastaddr = 99;
    2368:	064007b7          	lui	a5,0x6400
    236c:	06300713          	li	a4,99
    2370:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2374:	4501                	li	a0,0
    2376:	20b020ef          	jal	4d80 <sbrk>
    237a:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    237c:	757d                	lui	a0,0xfffff
    237e:	203020ef          	jal	4d80 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2382:	57fd                	li	a5,-1
    2384:	08f50363          	beq	a0,a5,240a <sbrkmuch+0xec>
  c = sbrk(0);
    2388:	4501                	li	a0,0
    238a:	1f7020ef          	jal	4d80 <sbrk>
  if(c != a - PGSIZE){
    238e:	80048793          	addi	a5,s1,-2048
    2392:	80078793          	addi	a5,a5,-2048
    2396:	08f51463          	bne	a0,a5,241e <sbrkmuch+0x100>
  a = sbrk(0);
    239a:	4501                	li	a0,0
    239c:	1e5020ef          	jal	4d80 <sbrk>
    23a0:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    23a2:	6505                	lui	a0,0x1
    23a4:	1dd020ef          	jal	4d80 <sbrk>
    23a8:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    23aa:	08a49663          	bne	s1,a0,2436 <sbrkmuch+0x118>
    23ae:	4501                	li	a0,0
    23b0:	1d1020ef          	jal	4d80 <sbrk>
    23b4:	6785                	lui	a5,0x1
    23b6:	97a6                	add	a5,a5,s1
    23b8:	06f51f63          	bne	a0,a5,2436 <sbrkmuch+0x118>
  if(*lastaddr == 99){
    23bc:	064007b7          	lui	a5,0x6400
    23c0:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    23c4:	06300793          	li	a5,99
    23c8:	08f70363          	beq	a4,a5,244e <sbrkmuch+0x130>
  a = sbrk(0);
    23cc:	4501                	li	a0,0
    23ce:	1b3020ef          	jal	4d80 <sbrk>
    23d2:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    23d4:	4501                	li	a0,0
    23d6:	1ab020ef          	jal	4d80 <sbrk>
    23da:	40a9053b          	subw	a0,s2,a0
    23de:	1a3020ef          	jal	4d80 <sbrk>
  if(c != a){
    23e2:	08a49063          	bne	s1,a0,2462 <sbrkmuch+0x144>
}
    23e6:	70a2                	ld	ra,40(sp)
    23e8:	7402                	ld	s0,32(sp)
    23ea:	64e2                	ld	s1,24(sp)
    23ec:	6942                	ld	s2,16(sp)
    23ee:	69a2                	ld	s3,8(sp)
    23f0:	6a02                	ld	s4,0(sp)
    23f2:	6145                	addi	sp,sp,48
    23f4:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    23f6:	85ce                	mv	a1,s3
    23f8:	00004517          	auipc	a0,0x4
    23fc:	c7050513          	addi	a0,a0,-912 # 6068 <malloc+0xe80>
    2400:	531020ef          	jal	5130 <printf>
    exit(1);
    2404:	4505                	li	a0,1
    2406:	0f3020ef          	jal	4cf8 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    240a:	85ce                	mv	a1,s3
    240c:	00004517          	auipc	a0,0x4
    2410:	ca450513          	addi	a0,a0,-860 # 60b0 <malloc+0xec8>
    2414:	51d020ef          	jal	5130 <printf>
    exit(1);
    2418:	4505                	li	a0,1
    241a:	0df020ef          	jal	4cf8 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    241e:	86aa                	mv	a3,a0
    2420:	8626                	mv	a2,s1
    2422:	85ce                	mv	a1,s3
    2424:	00004517          	auipc	a0,0x4
    2428:	cac50513          	addi	a0,a0,-852 # 60d0 <malloc+0xee8>
    242c:	505020ef          	jal	5130 <printf>
    exit(1);
    2430:	4505                	li	a0,1
    2432:	0c7020ef          	jal	4cf8 <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    2436:	86d2                	mv	a3,s4
    2438:	8626                	mv	a2,s1
    243a:	85ce                	mv	a1,s3
    243c:	00004517          	auipc	a0,0x4
    2440:	cd450513          	addi	a0,a0,-812 # 6110 <malloc+0xf28>
    2444:	4ed020ef          	jal	5130 <printf>
    exit(1);
    2448:	4505                	li	a0,1
    244a:	0af020ef          	jal	4cf8 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    244e:	85ce                	mv	a1,s3
    2450:	00004517          	auipc	a0,0x4
    2454:	cf050513          	addi	a0,a0,-784 # 6140 <malloc+0xf58>
    2458:	4d9020ef          	jal	5130 <printf>
    exit(1);
    245c:	4505                	li	a0,1
    245e:	09b020ef          	jal	4cf8 <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    2462:	86aa                	mv	a3,a0
    2464:	8626                	mv	a2,s1
    2466:	85ce                	mv	a1,s3
    2468:	00004517          	auipc	a0,0x4
    246c:	d1050513          	addi	a0,a0,-752 # 6178 <malloc+0xf90>
    2470:	4c1020ef          	jal	5130 <printf>
    exit(1);
    2474:	4505                	li	a0,1
    2476:	083020ef          	jal	4cf8 <exit>

000000000000247a <sbrkarg>:
{
    247a:	7179                	addi	sp,sp,-48
    247c:	f406                	sd	ra,40(sp)
    247e:	f022                	sd	s0,32(sp)
    2480:	ec26                	sd	s1,24(sp)
    2482:	e84a                	sd	s2,16(sp)
    2484:	e44e                	sd	s3,8(sp)
    2486:	1800                	addi	s0,sp,48
    2488:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    248a:	6505                	lui	a0,0x1
    248c:	0f5020ef          	jal	4d80 <sbrk>
    2490:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2492:	20100593          	li	a1,513
    2496:	00004517          	auipc	a0,0x4
    249a:	d0a50513          	addi	a0,a0,-758 # 61a0 <malloc+0xfb8>
    249e:	09b020ef          	jal	4d38 <open>
    24a2:	84aa                	mv	s1,a0
  unlink("sbrk");
    24a4:	00004517          	auipc	a0,0x4
    24a8:	cfc50513          	addi	a0,a0,-772 # 61a0 <malloc+0xfb8>
    24ac:	09d020ef          	jal	4d48 <unlink>
  if(fd < 0)  {
    24b0:	0204c963          	bltz	s1,24e2 <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    24b4:	6605                	lui	a2,0x1
    24b6:	85ca                	mv	a1,s2
    24b8:	8526                	mv	a0,s1
    24ba:	05f020ef          	jal	4d18 <write>
    24be:	02054c63          	bltz	a0,24f6 <sbrkarg+0x7c>
  close(fd);
    24c2:	8526                	mv	a0,s1
    24c4:	05d020ef          	jal	4d20 <close>
  a = sbrk(PGSIZE);
    24c8:	6505                	lui	a0,0x1
    24ca:	0b7020ef          	jal	4d80 <sbrk>
  if(pipe((int *) a) != 0){
    24ce:	03b020ef          	jal	4d08 <pipe>
    24d2:	ed05                	bnez	a0,250a <sbrkarg+0x90>
}
    24d4:	70a2                	ld	ra,40(sp)
    24d6:	7402                	ld	s0,32(sp)
    24d8:	64e2                	ld	s1,24(sp)
    24da:	6942                	ld	s2,16(sp)
    24dc:	69a2                	ld	s3,8(sp)
    24de:	6145                	addi	sp,sp,48
    24e0:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    24e2:	85ce                	mv	a1,s3
    24e4:	00004517          	auipc	a0,0x4
    24e8:	cc450513          	addi	a0,a0,-828 # 61a8 <malloc+0xfc0>
    24ec:	445020ef          	jal	5130 <printf>
    exit(1);
    24f0:	4505                	li	a0,1
    24f2:	007020ef          	jal	4cf8 <exit>
    printf("%s: write sbrk failed\n", s);
    24f6:	85ce                	mv	a1,s3
    24f8:	00004517          	auipc	a0,0x4
    24fc:	cc850513          	addi	a0,a0,-824 # 61c0 <malloc+0xfd8>
    2500:	431020ef          	jal	5130 <printf>
    exit(1);
    2504:	4505                	li	a0,1
    2506:	7f2020ef          	jal	4cf8 <exit>
    printf("%s: pipe() failed\n", s);
    250a:	85ce                	mv	a1,s3
    250c:	00003517          	auipc	a0,0x3
    2510:	7a450513          	addi	a0,a0,1956 # 5cb0 <malloc+0xac8>
    2514:	41d020ef          	jal	5130 <printf>
    exit(1);
    2518:	4505                	li	a0,1
    251a:	7de020ef          	jal	4cf8 <exit>

000000000000251e <argptest>:
{
    251e:	1101                	addi	sp,sp,-32
    2520:	ec06                	sd	ra,24(sp)
    2522:	e822                	sd	s0,16(sp)
    2524:	e426                	sd	s1,8(sp)
    2526:	e04a                	sd	s2,0(sp)
    2528:	1000                	addi	s0,sp,32
    252a:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    252c:	4581                	li	a1,0
    252e:	00004517          	auipc	a0,0x4
    2532:	caa50513          	addi	a0,a0,-854 # 61d8 <malloc+0xff0>
    2536:	003020ef          	jal	4d38 <open>
  if (fd < 0) {
    253a:	02054563          	bltz	a0,2564 <argptest+0x46>
    253e:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2540:	4501                	li	a0,0
    2542:	03f020ef          	jal	4d80 <sbrk>
    2546:	567d                	li	a2,-1
    2548:	00c505b3          	add	a1,a0,a2
    254c:	8526                	mv	a0,s1
    254e:	7c2020ef          	jal	4d10 <read>
  close(fd);
    2552:	8526                	mv	a0,s1
    2554:	7cc020ef          	jal	4d20 <close>
}
    2558:	60e2                	ld	ra,24(sp)
    255a:	6442                	ld	s0,16(sp)
    255c:	64a2                	ld	s1,8(sp)
    255e:	6902                	ld	s2,0(sp)
    2560:	6105                	addi	sp,sp,32
    2562:	8082                	ret
    printf("%s: open failed\n", s);
    2564:	85ca                	mv	a1,s2
    2566:	00003517          	auipc	a0,0x3
    256a:	65a50513          	addi	a0,a0,1626 # 5bc0 <malloc+0x9d8>
    256e:	3c3020ef          	jal	5130 <printf>
    exit(1);
    2572:	4505                	li	a0,1
    2574:	784020ef          	jal	4cf8 <exit>

0000000000002578 <sbrkbugs>:
{
    2578:	1141                	addi	sp,sp,-16
    257a:	e406                	sd	ra,8(sp)
    257c:	e022                	sd	s0,0(sp)
    257e:	0800                	addi	s0,sp,16
  int pid = fork();
    2580:	770020ef          	jal	4cf0 <fork>
  if(pid < 0){
    2584:	00054c63          	bltz	a0,259c <sbrkbugs+0x24>
  if(pid == 0){
    2588:	e11d                	bnez	a0,25ae <sbrkbugs+0x36>
    int sz = (uint64) sbrk(0);
    258a:	7f6020ef          	jal	4d80 <sbrk>
    sbrk(-sz);
    258e:	40a0053b          	negw	a0,a0
    2592:	7ee020ef          	jal	4d80 <sbrk>
    exit(0);
    2596:	4501                	li	a0,0
    2598:	760020ef          	jal	4cf8 <exit>
    printf("fork failed\n");
    259c:	00005517          	auipc	a0,0x5
    25a0:	b7c50513          	addi	a0,a0,-1156 # 7118 <malloc+0x1f30>
    25a4:	38d020ef          	jal	5130 <printf>
    exit(1);
    25a8:	4505                	li	a0,1
    25aa:	74e020ef          	jal	4cf8 <exit>
  wait(0);
    25ae:	4501                	li	a0,0
    25b0:	750020ef          	jal	4d00 <wait>
  pid = fork();
    25b4:	73c020ef          	jal	4cf0 <fork>
  if(pid < 0){
    25b8:	00054f63          	bltz	a0,25d6 <sbrkbugs+0x5e>
  if(pid == 0){
    25bc:	e515                	bnez	a0,25e8 <sbrkbugs+0x70>
    int sz = (uint64) sbrk(0);
    25be:	7c2020ef          	jal	4d80 <sbrk>
    sbrk(-(sz - 3500));
    25c2:	6785                	lui	a5,0x1
    25c4:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0xe2>
    25c8:	40a7853b          	subw	a0,a5,a0
    25cc:	7b4020ef          	jal	4d80 <sbrk>
    exit(0);
    25d0:	4501                	li	a0,0
    25d2:	726020ef          	jal	4cf8 <exit>
    printf("fork failed\n");
    25d6:	00005517          	auipc	a0,0x5
    25da:	b4250513          	addi	a0,a0,-1214 # 7118 <malloc+0x1f30>
    25de:	353020ef          	jal	5130 <printf>
    exit(1);
    25e2:	4505                	li	a0,1
    25e4:	714020ef          	jal	4cf8 <exit>
  wait(0);
    25e8:	4501                	li	a0,0
    25ea:	716020ef          	jal	4d00 <wait>
  pid = fork();
    25ee:	702020ef          	jal	4cf0 <fork>
  if(pid < 0){
    25f2:	02054263          	bltz	a0,2616 <sbrkbugs+0x9e>
  if(pid == 0){
    25f6:	e90d                	bnez	a0,2628 <sbrkbugs+0xb0>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    25f8:	788020ef          	jal	4d80 <sbrk>
    25fc:	67ad                	lui	a5,0xb
    25fe:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x298>
    2602:	40a7853b          	subw	a0,a5,a0
    2606:	77a020ef          	jal	4d80 <sbrk>
    sbrk(-10);
    260a:	5559                	li	a0,-10
    260c:	774020ef          	jal	4d80 <sbrk>
    exit(0);
    2610:	4501                	li	a0,0
    2612:	6e6020ef          	jal	4cf8 <exit>
    printf("fork failed\n");
    2616:	00005517          	auipc	a0,0x5
    261a:	b0250513          	addi	a0,a0,-1278 # 7118 <malloc+0x1f30>
    261e:	313020ef          	jal	5130 <printf>
    exit(1);
    2622:	4505                	li	a0,1
    2624:	6d4020ef          	jal	4cf8 <exit>
  wait(0);
    2628:	4501                	li	a0,0
    262a:	6d6020ef          	jal	4d00 <wait>
  exit(0);
    262e:	4501                	li	a0,0
    2630:	6c8020ef          	jal	4cf8 <exit>

0000000000002634 <sbrklast>:
{
    2634:	7179                	addi	sp,sp,-48
    2636:	f406                	sd	ra,40(sp)
    2638:	f022                	sd	s0,32(sp)
    263a:	ec26                	sd	s1,24(sp)
    263c:	e84a                	sd	s2,16(sp)
    263e:	e44e                	sd	s3,8(sp)
    2640:	e052                	sd	s4,0(sp)
    2642:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2644:	4501                	li	a0,0
    2646:	73a020ef          	jal	4d80 <sbrk>
  if((top % 4096) != 0)
    264a:	03451793          	slli	a5,a0,0x34
    264e:	ebad                	bnez	a5,26c0 <sbrklast+0x8c>
  sbrk(4096);
    2650:	6505                	lui	a0,0x1
    2652:	72e020ef          	jal	4d80 <sbrk>
  sbrk(10);
    2656:	4529                	li	a0,10
    2658:	728020ef          	jal	4d80 <sbrk>
  sbrk(-20);
    265c:	5531                	li	a0,-20
    265e:	722020ef          	jal	4d80 <sbrk>
  top = (uint64) sbrk(0);
    2662:	4501                	li	a0,0
    2664:	71c020ef          	jal	4d80 <sbrk>
    2668:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    266a:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0xcc>
  p[0] = 'x';
    266e:	07800993          	li	s3,120
    2672:	fd350023          	sb	s3,-64(a0)
  p[1] = '\0';
    2676:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    267a:	20200593          	li	a1,514
    267e:	854a                	mv	a0,s2
    2680:	6b8020ef          	jal	4d38 <open>
    2684:	8a2a                	mv	s4,a0
  write(fd, p, 1);
    2686:	4605                	li	a2,1
    2688:	85ca                	mv	a1,s2
    268a:	68e020ef          	jal	4d18 <write>
  close(fd);
    268e:	8552                	mv	a0,s4
    2690:	690020ef          	jal	4d20 <close>
  fd = open(p, O_RDWR);
    2694:	4589                	li	a1,2
    2696:	854a                	mv	a0,s2
    2698:	6a0020ef          	jal	4d38 <open>
  p[0] = '\0';
    269c:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    26a0:	4605                	li	a2,1
    26a2:	85ca                	mv	a1,s2
    26a4:	66c020ef          	jal	4d10 <read>
  if(p[0] != 'x')
    26a8:	fc04c783          	lbu	a5,-64(s1)
    26ac:	03379263          	bne	a5,s3,26d0 <sbrklast+0x9c>
}
    26b0:	70a2                	ld	ra,40(sp)
    26b2:	7402                	ld	s0,32(sp)
    26b4:	64e2                	ld	s1,24(sp)
    26b6:	6942                	ld	s2,16(sp)
    26b8:	69a2                	ld	s3,8(sp)
    26ba:	6a02                	ld	s4,0(sp)
    26bc:	6145                	addi	sp,sp,48
    26be:	8082                	ret
    sbrk(4096 - (top % 4096));
    26c0:	0347d513          	srli	a0,a5,0x34
    26c4:	6785                	lui	a5,0x1
    26c6:	40a7853b          	subw	a0,a5,a0
    26ca:	6b6020ef          	jal	4d80 <sbrk>
    26ce:	b749                	j	2650 <sbrklast+0x1c>
    exit(1);
    26d0:	4505                	li	a0,1
    26d2:	626020ef          	jal	4cf8 <exit>

00000000000026d6 <sbrk8000>:
{
    26d6:	1141                	addi	sp,sp,-16
    26d8:	e406                	sd	ra,8(sp)
    26da:	e022                	sd	s0,0(sp)
    26dc:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    26de:	80000537          	lui	a0,0x80000
    26e2:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    26e4:	69c020ef          	jal	4d80 <sbrk>
  volatile char *top = sbrk(0);
    26e8:	4501                	li	a0,0
    26ea:	696020ef          	jal	4d80 <sbrk>
  *(top-1) = *(top-1) + 1;
    26ee:	fff54783          	lbu	a5,-1(a0)
    26f2:	0785                	addi	a5,a5,1 # 1001 <bigdir+0x10d>
    26f4:	0ff7f793          	zext.b	a5,a5
    26f8:	fef50fa3          	sb	a5,-1(a0)
}
    26fc:	60a2                	ld	ra,8(sp)
    26fe:	6402                	ld	s0,0(sp)
    2700:	0141                	addi	sp,sp,16
    2702:	8082                	ret

0000000000002704 <execout>:
{
    2704:	711d                	addi	sp,sp,-96
    2706:	ec86                	sd	ra,88(sp)
    2708:	e8a2                	sd	s0,80(sp)
    270a:	e4a6                	sd	s1,72(sp)
    270c:	e0ca                	sd	s2,64(sp)
    270e:	fc4e                	sd	s3,56(sp)
    2710:	1080                	addi	s0,sp,96
  for(int avail = 0; avail < 15; avail++){
    2712:	4901                	li	s2,0
    2714:	49bd                	li	s3,15
    int pid = fork();
    2716:	5da020ef          	jal	4cf0 <fork>
    271a:	84aa                	mv	s1,a0
    if(pid < 0){
    271c:	00054e63          	bltz	a0,2738 <execout+0x34>
    } else if(pid == 0){
    2720:	c51d                	beqz	a0,274e <execout+0x4a>
      wait((int*)0);
    2722:	4501                	li	a0,0
    2724:	5dc020ef          	jal	4d00 <wait>
  for(int avail = 0; avail < 15; avail++){
    2728:	2905                	addiw	s2,s2,1
    272a:	ff3916e3          	bne	s2,s3,2716 <execout+0x12>
    272e:	f852                	sd	s4,48(sp)
    2730:	f456                	sd	s5,40(sp)
  exit(0);
    2732:	4501                	li	a0,0
    2734:	5c4020ef          	jal	4cf8 <exit>
    2738:	f852                	sd	s4,48(sp)
    273a:	f456                	sd	s5,40(sp)
      printf("fork failed\n");
    273c:	00005517          	auipc	a0,0x5
    2740:	9dc50513          	addi	a0,a0,-1572 # 7118 <malloc+0x1f30>
    2744:	1ed020ef          	jal	5130 <printf>
      exit(1);
    2748:	4505                	li	a0,1
    274a:	5ae020ef          	jal	4cf8 <exit>
    274e:	f852                	sd	s4,48(sp)
    2750:	f456                	sd	s5,40(sp)
        uint64 a = (uint64) sbrk(4096);
    2752:	6985                	lui	s3,0x1
        if(a == 0xffffffffffffffffLL)
    2754:	5a7d                	li	s4,-1
        *(char*)(a + 4096 - 1) = 1;
    2756:	4a85                	li	s5,1
        uint64 a = (uint64) sbrk(4096);
    2758:	854e                	mv	a0,s3
    275a:	626020ef          	jal	4d80 <sbrk>
        if(a == 0xffffffffffffffffLL)
    275e:	01450663          	beq	a0,s4,276a <execout+0x66>
        *(char*)(a + 4096 - 1) = 1;
    2762:	954e                	add	a0,a0,s3
    2764:	ff550fa3          	sb	s5,-1(a0)
      while(1){
    2768:	bfc5                	j	2758 <execout+0x54>
        sbrk(-4096);
    276a:	79fd                	lui	s3,0xfffff
      for(int i = 0; i < avail; i++)
    276c:	01205863          	blez	s2,277c <execout+0x78>
        sbrk(-4096);
    2770:	854e                	mv	a0,s3
    2772:	60e020ef          	jal	4d80 <sbrk>
      for(int i = 0; i < avail; i++)
    2776:	2485                	addiw	s1,s1,1
    2778:	ff249ce3          	bne	s1,s2,2770 <execout+0x6c>
      close(1);
    277c:	4505                	li	a0,1
    277e:	5a2020ef          	jal	4d20 <close>
      char *args[] = { "echo", "x", 0 };
    2782:	00003797          	auipc	a5,0x3
    2786:	b9678793          	addi	a5,a5,-1130 # 5318 <malloc+0x130>
    278a:	faf43423          	sd	a5,-88(s0)
    278e:	00003797          	auipc	a5,0x3
    2792:	bfa78793          	addi	a5,a5,-1030 # 5388 <malloc+0x1a0>
    2796:	faf43823          	sd	a5,-80(s0)
    279a:	fa043c23          	sd	zero,-72(s0)
      exec("echo", args);
    279e:	fa840593          	addi	a1,s0,-88
    27a2:	00003517          	auipc	a0,0x3
    27a6:	b7650513          	addi	a0,a0,-1162 # 5318 <malloc+0x130>
    27aa:	586020ef          	jal	4d30 <exec>
      exit(0);
    27ae:	4501                	li	a0,0
    27b0:	548020ef          	jal	4cf8 <exit>

00000000000027b4 <fourteen>:
{
    27b4:	1101                	addi	sp,sp,-32
    27b6:	ec06                	sd	ra,24(sp)
    27b8:	e822                	sd	s0,16(sp)
    27ba:	e426                	sd	s1,8(sp)
    27bc:	1000                	addi	s0,sp,32
    27be:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    27c0:	00004517          	auipc	a0,0x4
    27c4:	bf050513          	addi	a0,a0,-1040 # 63b0 <malloc+0x11c8>
    27c8:	598020ef          	jal	4d60 <mkdir>
    27cc:	e555                	bnez	a0,2878 <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    27ce:	00004517          	auipc	a0,0x4
    27d2:	a3a50513          	addi	a0,a0,-1478 # 6208 <malloc+0x1020>
    27d6:	58a020ef          	jal	4d60 <mkdir>
    27da:	e94d                	bnez	a0,288c <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    27dc:	20000593          	li	a1,512
    27e0:	00004517          	auipc	a0,0x4
    27e4:	a8050513          	addi	a0,a0,-1408 # 6260 <malloc+0x1078>
    27e8:	550020ef          	jal	4d38 <open>
  if(fd < 0){
    27ec:	0a054a63          	bltz	a0,28a0 <fourteen+0xec>
  close(fd);
    27f0:	530020ef          	jal	4d20 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27f4:	4581                	li	a1,0
    27f6:	00004517          	auipc	a0,0x4
    27fa:	ae250513          	addi	a0,a0,-1310 # 62d8 <malloc+0x10f0>
    27fe:	53a020ef          	jal	4d38 <open>
  if(fd < 0){
    2802:	0a054963          	bltz	a0,28b4 <fourteen+0x100>
  close(fd);
    2806:	51a020ef          	jal	4d20 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    280a:	00004517          	auipc	a0,0x4
    280e:	b3e50513          	addi	a0,a0,-1218 # 6348 <malloc+0x1160>
    2812:	54e020ef          	jal	4d60 <mkdir>
    2816:	c94d                	beqz	a0,28c8 <fourteen+0x114>
  if(mkdir("123456789012345/12345678901234") == 0){
    2818:	00004517          	auipc	a0,0x4
    281c:	b8850513          	addi	a0,a0,-1144 # 63a0 <malloc+0x11b8>
    2820:	540020ef          	jal	4d60 <mkdir>
    2824:	cd45                	beqz	a0,28dc <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    2826:	00004517          	auipc	a0,0x4
    282a:	b7a50513          	addi	a0,a0,-1158 # 63a0 <malloc+0x11b8>
    282e:	51a020ef          	jal	4d48 <unlink>
  unlink("12345678901234/12345678901234");
    2832:	00004517          	auipc	a0,0x4
    2836:	b1650513          	addi	a0,a0,-1258 # 6348 <malloc+0x1160>
    283a:	50e020ef          	jal	4d48 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    283e:	00004517          	auipc	a0,0x4
    2842:	a9a50513          	addi	a0,a0,-1382 # 62d8 <malloc+0x10f0>
    2846:	502020ef          	jal	4d48 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    284a:	00004517          	auipc	a0,0x4
    284e:	a1650513          	addi	a0,a0,-1514 # 6260 <malloc+0x1078>
    2852:	4f6020ef          	jal	4d48 <unlink>
  unlink("12345678901234/123456789012345");
    2856:	00004517          	auipc	a0,0x4
    285a:	9b250513          	addi	a0,a0,-1614 # 6208 <malloc+0x1020>
    285e:	4ea020ef          	jal	4d48 <unlink>
  unlink("12345678901234");
    2862:	00004517          	auipc	a0,0x4
    2866:	b4e50513          	addi	a0,a0,-1202 # 63b0 <malloc+0x11c8>
    286a:	4de020ef          	jal	4d48 <unlink>
}
    286e:	60e2                	ld	ra,24(sp)
    2870:	6442                	ld	s0,16(sp)
    2872:	64a2                	ld	s1,8(sp)
    2874:	6105                	addi	sp,sp,32
    2876:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2878:	85a6                	mv	a1,s1
    287a:	00004517          	auipc	a0,0x4
    287e:	96650513          	addi	a0,a0,-1690 # 61e0 <malloc+0xff8>
    2882:	0af020ef          	jal	5130 <printf>
    exit(1);
    2886:	4505                	li	a0,1
    2888:	470020ef          	jal	4cf8 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    288c:	85a6                	mv	a1,s1
    288e:	00004517          	auipc	a0,0x4
    2892:	99a50513          	addi	a0,a0,-1638 # 6228 <malloc+0x1040>
    2896:	09b020ef          	jal	5130 <printf>
    exit(1);
    289a:	4505                	li	a0,1
    289c:	45c020ef          	jal	4cf8 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    28a0:	85a6                	mv	a1,s1
    28a2:	00004517          	auipc	a0,0x4
    28a6:	9ee50513          	addi	a0,a0,-1554 # 6290 <malloc+0x10a8>
    28aa:	087020ef          	jal	5130 <printf>
    exit(1);
    28ae:	4505                	li	a0,1
    28b0:	448020ef          	jal	4cf8 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    28b4:	85a6                	mv	a1,s1
    28b6:	00004517          	auipc	a0,0x4
    28ba:	a5250513          	addi	a0,a0,-1454 # 6308 <malloc+0x1120>
    28be:	073020ef          	jal	5130 <printf>
    exit(1);
    28c2:	4505                	li	a0,1
    28c4:	434020ef          	jal	4cf8 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    28c8:	85a6                	mv	a1,s1
    28ca:	00004517          	auipc	a0,0x4
    28ce:	a9e50513          	addi	a0,a0,-1378 # 6368 <malloc+0x1180>
    28d2:	05f020ef          	jal	5130 <printf>
    exit(1);
    28d6:	4505                	li	a0,1
    28d8:	420020ef          	jal	4cf8 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    28dc:	85a6                	mv	a1,s1
    28de:	00004517          	auipc	a0,0x4
    28e2:	ae250513          	addi	a0,a0,-1310 # 63c0 <malloc+0x11d8>
    28e6:	04b020ef          	jal	5130 <printf>
    exit(1);
    28ea:	4505                	li	a0,1
    28ec:	40c020ef          	jal	4cf8 <exit>

00000000000028f0 <diskfull>:
{
    28f0:	b6010113          	addi	sp,sp,-1184
    28f4:	48113c23          	sd	ra,1176(sp)
    28f8:	48813823          	sd	s0,1168(sp)
    28fc:	48913423          	sd	s1,1160(sp)
    2900:	49213023          	sd	s2,1152(sp)
    2904:	47313c23          	sd	s3,1144(sp)
    2908:	47413823          	sd	s4,1136(sp)
    290c:	47513423          	sd	s5,1128(sp)
    2910:	47613023          	sd	s6,1120(sp)
    2914:	45713c23          	sd	s7,1112(sp)
    2918:	45813823          	sd	s8,1104(sp)
    291c:	45913423          	sd	s9,1096(sp)
    2920:	45a13023          	sd	s10,1088(sp)
    2924:	43b13c23          	sd	s11,1080(sp)
    2928:	4a010413          	addi	s0,sp,1184
    292c:	b6a43423          	sd	a0,-1176(s0)
  unlink("diskfulldir");
    2930:	00004517          	auipc	a0,0x4
    2934:	ac850513          	addi	a0,a0,-1336 # 63f8 <malloc+0x1210>
    2938:	410020ef          	jal	4d48 <unlink>
    293c:	03000a93          	li	s5,48
    name[0] = 'b';
    2940:	06200d13          	li	s10,98
    name[1] = 'i';
    2944:	06900c93          	li	s9,105
    name[2] = 'g';
    2948:	06700c13          	li	s8,103
    unlink(name);
    294c:	b7040b13          	addi	s6,s0,-1168
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2950:	60200b93          	li	s7,1538
    2954:	10c00d93          	li	s11,268
      if(write(fd, buf, BSIZE) != BSIZE){
    2958:	b9040a13          	addi	s4,s0,-1136
    295c:	aa8d                	j	2ace <diskfull+0x1de>
      printf("%s: could not create file %s\n", s, name);
    295e:	b7040613          	addi	a2,s0,-1168
    2962:	b6843583          	ld	a1,-1176(s0)
    2966:	00004517          	auipc	a0,0x4
    296a:	aa250513          	addi	a0,a0,-1374 # 6408 <malloc+0x1220>
    296e:	7c2020ef          	jal	5130 <printf>
      break;
    2972:	a039                	j	2980 <diskfull+0x90>
        close(fd);
    2974:	854e                	mv	a0,s3
    2976:	3aa020ef          	jal	4d20 <close>
    close(fd);
    297a:	854e                	mv	a0,s3
    297c:	3a4020ef          	jal	4d20 <close>
  for(int i = 0; i < nzz; i++){
    2980:	4481                	li	s1,0
    name[0] = 'z';
    2982:	07a00993          	li	s3,122
    unlink(name);
    2986:	b9040913          	addi	s2,s0,-1136
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    298a:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
    298e:	08000a93          	li	s5,128
    name[0] = 'z';
    2992:	b9340823          	sb	s3,-1136(s0)
    name[1] = 'z';
    2996:	b93408a3          	sb	s3,-1135(s0)
    name[2] = '0' + (i / 32);
    299a:	41f4d71b          	sraiw	a4,s1,0x1f
    299e:	01b7571b          	srliw	a4,a4,0x1b
    29a2:	009707bb          	addw	a5,a4,s1
    29a6:	4057d69b          	sraiw	a3,a5,0x5
    29aa:	0306869b          	addiw	a3,a3,48
    29ae:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    29b2:	8bfd                	andi	a5,a5,31
    29b4:	9f99                	subw	a5,a5,a4
    29b6:	0307879b          	addiw	a5,a5,48
    29ba:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    29be:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    29c2:	854a                	mv	a0,s2
    29c4:	384020ef          	jal	4d48 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    29c8:	85d2                	mv	a1,s4
    29ca:	854a                	mv	a0,s2
    29cc:	36c020ef          	jal	4d38 <open>
    if(fd < 0)
    29d0:	00054763          	bltz	a0,29de <diskfull+0xee>
    close(fd);
    29d4:	34c020ef          	jal	4d20 <close>
  for(int i = 0; i < nzz; i++){
    29d8:	2485                	addiw	s1,s1,1
    29da:	fb549ce3          	bne	s1,s5,2992 <diskfull+0xa2>
  if(mkdir("diskfulldir") == 0)
    29de:	00004517          	auipc	a0,0x4
    29e2:	a1a50513          	addi	a0,a0,-1510 # 63f8 <malloc+0x1210>
    29e6:	37a020ef          	jal	4d60 <mkdir>
    29ea:	12050363          	beqz	a0,2b10 <diskfull+0x220>
  unlink("diskfulldir");
    29ee:	00004517          	auipc	a0,0x4
    29f2:	a0a50513          	addi	a0,a0,-1526 # 63f8 <malloc+0x1210>
    29f6:	352020ef          	jal	4d48 <unlink>
  for(int i = 0; i < nzz; i++){
    29fa:	4481                	li	s1,0
    name[0] = 'z';
    29fc:	07a00913          	li	s2,122
    unlink(name);
    2a00:	b9040a13          	addi	s4,s0,-1136
  for(int i = 0; i < nzz; i++){
    2a04:	08000993          	li	s3,128
    name[0] = 'z';
    2a08:	b9240823          	sb	s2,-1136(s0)
    name[1] = 'z';
    2a0c:	b92408a3          	sb	s2,-1135(s0)
    name[2] = '0' + (i / 32);
    2a10:	41f4d71b          	sraiw	a4,s1,0x1f
    2a14:	01b7571b          	srliw	a4,a4,0x1b
    2a18:	009707bb          	addw	a5,a4,s1
    2a1c:	4057d69b          	sraiw	a3,a5,0x5
    2a20:	0306869b          	addiw	a3,a3,48
    2a24:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    2a28:	8bfd                	andi	a5,a5,31
    2a2a:	9f99                	subw	a5,a5,a4
    2a2c:	0307879b          	addiw	a5,a5,48
    2a30:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    2a34:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a38:	8552                	mv	a0,s4
    2a3a:	30e020ef          	jal	4d48 <unlink>
  for(int i = 0; i < nzz; i++){
    2a3e:	2485                	addiw	s1,s1,1
    2a40:	fd3494e3          	bne	s1,s3,2a08 <diskfull+0x118>
    2a44:	03000493          	li	s1,48
    name[0] = 'b';
    2a48:	06200b13          	li	s6,98
    name[1] = 'i';
    2a4c:	06900a93          	li	s5,105
    name[2] = 'g';
    2a50:	06700a13          	li	s4,103
    unlink(name);
    2a54:	b9040993          	addi	s3,s0,-1136
  for(int i = 0; '0' + i < 0177; i++){
    2a58:	07f00913          	li	s2,127
    name[0] = 'b';
    2a5c:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    2a60:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    2a64:	b9440923          	sb	s4,-1134(s0)
    name[3] = '0' + i;
    2a68:	b89409a3          	sb	s1,-1133(s0)
    name[4] = '\0';
    2a6c:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a70:	854e                	mv	a0,s3
    2a72:	2d6020ef          	jal	4d48 <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    2a76:	2485                	addiw	s1,s1,1
    2a78:	0ff4f493          	zext.b	s1,s1
    2a7c:	ff2490e3          	bne	s1,s2,2a5c <diskfull+0x16c>
}
    2a80:	49813083          	ld	ra,1176(sp)
    2a84:	49013403          	ld	s0,1168(sp)
    2a88:	48813483          	ld	s1,1160(sp)
    2a8c:	48013903          	ld	s2,1152(sp)
    2a90:	47813983          	ld	s3,1144(sp)
    2a94:	47013a03          	ld	s4,1136(sp)
    2a98:	46813a83          	ld	s5,1128(sp)
    2a9c:	46013b03          	ld	s6,1120(sp)
    2aa0:	45813b83          	ld	s7,1112(sp)
    2aa4:	45013c03          	ld	s8,1104(sp)
    2aa8:	44813c83          	ld	s9,1096(sp)
    2aac:	44013d03          	ld	s10,1088(sp)
    2ab0:	43813d83          	ld	s11,1080(sp)
    2ab4:	4a010113          	addi	sp,sp,1184
    2ab8:	8082                	ret
    close(fd);
    2aba:	854e                	mv	a0,s3
    2abc:	264020ef          	jal	4d20 <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    2ac0:	2a85                	addiw	s5,s5,1 # 3001 <subdir+0x2e7>
    2ac2:	0ffafa93          	zext.b	s5,s5
    2ac6:	07f00793          	li	a5,127
    2aca:	eafa8be3          	beq	s5,a5,2980 <diskfull+0x90>
    name[0] = 'b';
    2ace:	b7a40823          	sb	s10,-1168(s0)
    name[1] = 'i';
    2ad2:	b79408a3          	sb	s9,-1167(s0)
    name[2] = 'g';
    2ad6:	b7840923          	sb	s8,-1166(s0)
    name[3] = '0' + fi;
    2ada:	b75409a3          	sb	s5,-1165(s0)
    name[4] = '\0';
    2ade:	b6040a23          	sb	zero,-1164(s0)
    unlink(name);
    2ae2:	855a                	mv	a0,s6
    2ae4:	264020ef          	jal	4d48 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2ae8:	85de                	mv	a1,s7
    2aea:	855a                	mv	a0,s6
    2aec:	24c020ef          	jal	4d38 <open>
    2af0:	89aa                	mv	s3,a0
    if(fd < 0){
    2af2:	e60546e3          	bltz	a0,295e <diskfull+0x6e>
    2af6:	84ee                	mv	s1,s11
      if(write(fd, buf, BSIZE) != BSIZE){
    2af8:	40000913          	li	s2,1024
    2afc:	864a                	mv	a2,s2
    2afe:	85d2                	mv	a1,s4
    2b00:	854e                	mv	a0,s3
    2b02:	216020ef          	jal	4d18 <write>
    2b06:	e72517e3          	bne	a0,s2,2974 <diskfull+0x84>
    for(int i = 0; i < MAXFILE; i++){
    2b0a:	34fd                	addiw	s1,s1,-1
    2b0c:	f8e5                	bnez	s1,2afc <diskfull+0x20c>
    2b0e:	b775                	j	2aba <diskfull+0x1ca>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    2b10:	b6843583          	ld	a1,-1176(s0)
    2b14:	00004517          	auipc	a0,0x4
    2b18:	91450513          	addi	a0,a0,-1772 # 6428 <malloc+0x1240>
    2b1c:	614020ef          	jal	5130 <printf>
    2b20:	b5f9                	j	29ee <diskfull+0xfe>

0000000000002b22 <iputtest>:
{
    2b22:	1101                	addi	sp,sp,-32
    2b24:	ec06                	sd	ra,24(sp)
    2b26:	e822                	sd	s0,16(sp)
    2b28:	e426                	sd	s1,8(sp)
    2b2a:	1000                	addi	s0,sp,32
    2b2c:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2b2e:	00004517          	auipc	a0,0x4
    2b32:	92a50513          	addi	a0,a0,-1750 # 6458 <malloc+0x1270>
    2b36:	22a020ef          	jal	4d60 <mkdir>
    2b3a:	02054f63          	bltz	a0,2b78 <iputtest+0x56>
  if(chdir("iputdir") < 0){
    2b3e:	00004517          	auipc	a0,0x4
    2b42:	91a50513          	addi	a0,a0,-1766 # 6458 <malloc+0x1270>
    2b46:	222020ef          	jal	4d68 <chdir>
    2b4a:	04054163          	bltz	a0,2b8c <iputtest+0x6a>
  if(unlink("../iputdir") < 0){
    2b4e:	00004517          	auipc	a0,0x4
    2b52:	94a50513          	addi	a0,a0,-1718 # 6498 <malloc+0x12b0>
    2b56:	1f2020ef          	jal	4d48 <unlink>
    2b5a:	04054363          	bltz	a0,2ba0 <iputtest+0x7e>
  if(chdir("/") < 0){
    2b5e:	00004517          	auipc	a0,0x4
    2b62:	96a50513          	addi	a0,a0,-1686 # 64c8 <malloc+0x12e0>
    2b66:	202020ef          	jal	4d68 <chdir>
    2b6a:	04054563          	bltz	a0,2bb4 <iputtest+0x92>
}
    2b6e:	60e2                	ld	ra,24(sp)
    2b70:	6442                	ld	s0,16(sp)
    2b72:	64a2                	ld	s1,8(sp)
    2b74:	6105                	addi	sp,sp,32
    2b76:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b78:	85a6                	mv	a1,s1
    2b7a:	00004517          	auipc	a0,0x4
    2b7e:	8e650513          	addi	a0,a0,-1818 # 6460 <malloc+0x1278>
    2b82:	5ae020ef          	jal	5130 <printf>
    exit(1);
    2b86:	4505                	li	a0,1
    2b88:	170020ef          	jal	4cf8 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2b8c:	85a6                	mv	a1,s1
    2b8e:	00004517          	auipc	a0,0x4
    2b92:	8ea50513          	addi	a0,a0,-1814 # 6478 <malloc+0x1290>
    2b96:	59a020ef          	jal	5130 <printf>
    exit(1);
    2b9a:	4505                	li	a0,1
    2b9c:	15c020ef          	jal	4cf8 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2ba0:	85a6                	mv	a1,s1
    2ba2:	00004517          	auipc	a0,0x4
    2ba6:	90650513          	addi	a0,a0,-1786 # 64a8 <malloc+0x12c0>
    2baa:	586020ef          	jal	5130 <printf>
    exit(1);
    2bae:	4505                	li	a0,1
    2bb0:	148020ef          	jal	4cf8 <exit>
    printf("%s: chdir / failed\n", s);
    2bb4:	85a6                	mv	a1,s1
    2bb6:	00004517          	auipc	a0,0x4
    2bba:	91a50513          	addi	a0,a0,-1766 # 64d0 <malloc+0x12e8>
    2bbe:	572020ef          	jal	5130 <printf>
    exit(1);
    2bc2:	4505                	li	a0,1
    2bc4:	134020ef          	jal	4cf8 <exit>

0000000000002bc8 <exitiputtest>:
{
    2bc8:	7179                	addi	sp,sp,-48
    2bca:	f406                	sd	ra,40(sp)
    2bcc:	f022                	sd	s0,32(sp)
    2bce:	ec26                	sd	s1,24(sp)
    2bd0:	1800                	addi	s0,sp,48
    2bd2:	84aa                	mv	s1,a0
  pid = fork();
    2bd4:	11c020ef          	jal	4cf0 <fork>
  if(pid < 0){
    2bd8:	02054e63          	bltz	a0,2c14 <exitiputtest+0x4c>
  if(pid == 0){
    2bdc:	e541                	bnez	a0,2c64 <exitiputtest+0x9c>
    if(mkdir("iputdir") < 0){
    2bde:	00004517          	auipc	a0,0x4
    2be2:	87a50513          	addi	a0,a0,-1926 # 6458 <malloc+0x1270>
    2be6:	17a020ef          	jal	4d60 <mkdir>
    2bea:	02054f63          	bltz	a0,2c28 <exitiputtest+0x60>
    if(chdir("iputdir") < 0){
    2bee:	00004517          	auipc	a0,0x4
    2bf2:	86a50513          	addi	a0,a0,-1942 # 6458 <malloc+0x1270>
    2bf6:	172020ef          	jal	4d68 <chdir>
    2bfa:	04054163          	bltz	a0,2c3c <exitiputtest+0x74>
    if(unlink("../iputdir") < 0){
    2bfe:	00004517          	auipc	a0,0x4
    2c02:	89a50513          	addi	a0,a0,-1894 # 6498 <malloc+0x12b0>
    2c06:	142020ef          	jal	4d48 <unlink>
    2c0a:	04054363          	bltz	a0,2c50 <exitiputtest+0x88>
    exit(0);
    2c0e:	4501                	li	a0,0
    2c10:	0e8020ef          	jal	4cf8 <exit>
    printf("%s: fork failed\n", s);
    2c14:	85a6                	mv	a1,s1
    2c16:	00003517          	auipc	a0,0x3
    2c1a:	f9250513          	addi	a0,a0,-110 # 5ba8 <malloc+0x9c0>
    2c1e:	512020ef          	jal	5130 <printf>
    exit(1);
    2c22:	4505                	li	a0,1
    2c24:	0d4020ef          	jal	4cf8 <exit>
      printf("%s: mkdir failed\n", s);
    2c28:	85a6                	mv	a1,s1
    2c2a:	00004517          	auipc	a0,0x4
    2c2e:	83650513          	addi	a0,a0,-1994 # 6460 <malloc+0x1278>
    2c32:	4fe020ef          	jal	5130 <printf>
      exit(1);
    2c36:	4505                	li	a0,1
    2c38:	0c0020ef          	jal	4cf8 <exit>
      printf("%s: child chdir failed\n", s);
    2c3c:	85a6                	mv	a1,s1
    2c3e:	00004517          	auipc	a0,0x4
    2c42:	8aa50513          	addi	a0,a0,-1878 # 64e8 <malloc+0x1300>
    2c46:	4ea020ef          	jal	5130 <printf>
      exit(1);
    2c4a:	4505                	li	a0,1
    2c4c:	0ac020ef          	jal	4cf8 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2c50:	85a6                	mv	a1,s1
    2c52:	00004517          	auipc	a0,0x4
    2c56:	85650513          	addi	a0,a0,-1962 # 64a8 <malloc+0x12c0>
    2c5a:	4d6020ef          	jal	5130 <printf>
      exit(1);
    2c5e:	4505                	li	a0,1
    2c60:	098020ef          	jal	4cf8 <exit>
  wait(&xstatus);
    2c64:	fdc40513          	addi	a0,s0,-36
    2c68:	098020ef          	jal	4d00 <wait>
  exit(xstatus);
    2c6c:	fdc42503          	lw	a0,-36(s0)
    2c70:	088020ef          	jal	4cf8 <exit>

0000000000002c74 <dirtest>:
{
    2c74:	1101                	addi	sp,sp,-32
    2c76:	ec06                	sd	ra,24(sp)
    2c78:	e822                	sd	s0,16(sp)
    2c7a:	e426                	sd	s1,8(sp)
    2c7c:	1000                	addi	s0,sp,32
    2c7e:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2c80:	00004517          	auipc	a0,0x4
    2c84:	88050513          	addi	a0,a0,-1920 # 6500 <malloc+0x1318>
    2c88:	0d8020ef          	jal	4d60 <mkdir>
    2c8c:	02054f63          	bltz	a0,2cca <dirtest+0x56>
  if(chdir("dir0") < 0){
    2c90:	00004517          	auipc	a0,0x4
    2c94:	87050513          	addi	a0,a0,-1936 # 6500 <malloc+0x1318>
    2c98:	0d0020ef          	jal	4d68 <chdir>
    2c9c:	04054163          	bltz	a0,2cde <dirtest+0x6a>
  if(chdir("..") < 0){
    2ca0:	00004517          	auipc	a0,0x4
    2ca4:	88050513          	addi	a0,a0,-1920 # 6520 <malloc+0x1338>
    2ca8:	0c0020ef          	jal	4d68 <chdir>
    2cac:	04054363          	bltz	a0,2cf2 <dirtest+0x7e>
  if(unlink("dir0") < 0){
    2cb0:	00004517          	auipc	a0,0x4
    2cb4:	85050513          	addi	a0,a0,-1968 # 6500 <malloc+0x1318>
    2cb8:	090020ef          	jal	4d48 <unlink>
    2cbc:	04054563          	bltz	a0,2d06 <dirtest+0x92>
}
    2cc0:	60e2                	ld	ra,24(sp)
    2cc2:	6442                	ld	s0,16(sp)
    2cc4:	64a2                	ld	s1,8(sp)
    2cc6:	6105                	addi	sp,sp,32
    2cc8:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2cca:	85a6                	mv	a1,s1
    2ccc:	00003517          	auipc	a0,0x3
    2cd0:	79450513          	addi	a0,a0,1940 # 6460 <malloc+0x1278>
    2cd4:	45c020ef          	jal	5130 <printf>
    exit(1);
    2cd8:	4505                	li	a0,1
    2cda:	01e020ef          	jal	4cf8 <exit>
    printf("%s: chdir dir0 failed\n", s);
    2cde:	85a6                	mv	a1,s1
    2ce0:	00004517          	auipc	a0,0x4
    2ce4:	82850513          	addi	a0,a0,-2008 # 6508 <malloc+0x1320>
    2ce8:	448020ef          	jal	5130 <printf>
    exit(1);
    2cec:	4505                	li	a0,1
    2cee:	00a020ef          	jal	4cf8 <exit>
    printf("%s: chdir .. failed\n", s);
    2cf2:	85a6                	mv	a1,s1
    2cf4:	00004517          	auipc	a0,0x4
    2cf8:	83450513          	addi	a0,a0,-1996 # 6528 <malloc+0x1340>
    2cfc:	434020ef          	jal	5130 <printf>
    exit(1);
    2d00:	4505                	li	a0,1
    2d02:	7f7010ef          	jal	4cf8 <exit>
    printf("%s: unlink dir0 failed\n", s);
    2d06:	85a6                	mv	a1,s1
    2d08:	00004517          	auipc	a0,0x4
    2d0c:	83850513          	addi	a0,a0,-1992 # 6540 <malloc+0x1358>
    2d10:	420020ef          	jal	5130 <printf>
    exit(1);
    2d14:	4505                	li	a0,1
    2d16:	7e3010ef          	jal	4cf8 <exit>

0000000000002d1a <subdir>:
{
    2d1a:	1101                	addi	sp,sp,-32
    2d1c:	ec06                	sd	ra,24(sp)
    2d1e:	e822                	sd	s0,16(sp)
    2d20:	e426                	sd	s1,8(sp)
    2d22:	e04a                	sd	s2,0(sp)
    2d24:	1000                	addi	s0,sp,32
    2d26:	892a                	mv	s2,a0
  unlink("ff");
    2d28:	00004517          	auipc	a0,0x4
    2d2c:	96050513          	addi	a0,a0,-1696 # 6688 <malloc+0x14a0>
    2d30:	018020ef          	jal	4d48 <unlink>
  if(mkdir("dd") != 0){
    2d34:	00004517          	auipc	a0,0x4
    2d38:	82450513          	addi	a0,a0,-2012 # 6558 <malloc+0x1370>
    2d3c:	024020ef          	jal	4d60 <mkdir>
    2d40:	2e051263          	bnez	a0,3024 <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2d44:	20200593          	li	a1,514
    2d48:	00004517          	auipc	a0,0x4
    2d4c:	83050513          	addi	a0,a0,-2000 # 6578 <malloc+0x1390>
    2d50:	7e9010ef          	jal	4d38 <open>
    2d54:	84aa                	mv	s1,a0
  if(fd < 0){
    2d56:	2e054163          	bltz	a0,3038 <subdir+0x31e>
  write(fd, "ff", 2);
    2d5a:	4609                	li	a2,2
    2d5c:	00004597          	auipc	a1,0x4
    2d60:	92c58593          	addi	a1,a1,-1748 # 6688 <malloc+0x14a0>
    2d64:	7b5010ef          	jal	4d18 <write>
  close(fd);
    2d68:	8526                	mv	a0,s1
    2d6a:	7b7010ef          	jal	4d20 <close>
  if(unlink("dd") >= 0){
    2d6e:	00003517          	auipc	a0,0x3
    2d72:	7ea50513          	addi	a0,a0,2026 # 6558 <malloc+0x1370>
    2d76:	7d3010ef          	jal	4d48 <unlink>
    2d7a:	2c055963          	bgez	a0,304c <subdir+0x332>
  if(mkdir("/dd/dd") != 0){
    2d7e:	00004517          	auipc	a0,0x4
    2d82:	85250513          	addi	a0,a0,-1966 # 65d0 <malloc+0x13e8>
    2d86:	7db010ef          	jal	4d60 <mkdir>
    2d8a:	2c051b63          	bnez	a0,3060 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2d8e:	20200593          	li	a1,514
    2d92:	00004517          	auipc	a0,0x4
    2d96:	86650513          	addi	a0,a0,-1946 # 65f8 <malloc+0x1410>
    2d9a:	79f010ef          	jal	4d38 <open>
    2d9e:	84aa                	mv	s1,a0
  if(fd < 0){
    2da0:	2c054a63          	bltz	a0,3074 <subdir+0x35a>
  write(fd, "FF", 2);
    2da4:	4609                	li	a2,2
    2da6:	00004597          	auipc	a1,0x4
    2daa:	88258593          	addi	a1,a1,-1918 # 6628 <malloc+0x1440>
    2dae:	76b010ef          	jal	4d18 <write>
  close(fd);
    2db2:	8526                	mv	a0,s1
    2db4:	76d010ef          	jal	4d20 <close>
  fd = open("dd/dd/../ff", 0);
    2db8:	4581                	li	a1,0
    2dba:	00004517          	auipc	a0,0x4
    2dbe:	87650513          	addi	a0,a0,-1930 # 6630 <malloc+0x1448>
    2dc2:	777010ef          	jal	4d38 <open>
    2dc6:	84aa                	mv	s1,a0
  if(fd < 0){
    2dc8:	2c054063          	bltz	a0,3088 <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2dcc:	660d                	lui	a2,0x3
    2dce:	0000a597          	auipc	a1,0xa
    2dd2:	eaa58593          	addi	a1,a1,-342 # cc78 <buf>
    2dd6:	73b010ef          	jal	4d10 <read>
  if(cc != 2 || buf[0] != 'f'){
    2dda:	4789                	li	a5,2
    2ddc:	2cf51063          	bne	a0,a5,309c <subdir+0x382>
    2de0:	0000a717          	auipc	a4,0xa
    2de4:	e9874703          	lbu	a4,-360(a4) # cc78 <buf>
    2de8:	06600793          	li	a5,102
    2dec:	2af71863          	bne	a4,a5,309c <subdir+0x382>
  close(fd);
    2df0:	8526                	mv	a0,s1
    2df2:	72f010ef          	jal	4d20 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2df6:	00004597          	auipc	a1,0x4
    2dfa:	88a58593          	addi	a1,a1,-1910 # 6680 <malloc+0x1498>
    2dfe:	00003517          	auipc	a0,0x3
    2e02:	7fa50513          	addi	a0,a0,2042 # 65f8 <malloc+0x1410>
    2e06:	753010ef          	jal	4d58 <link>
    2e0a:	2a051363          	bnez	a0,30b0 <subdir+0x396>
  if(unlink("dd/dd/ff") != 0){
    2e0e:	00003517          	auipc	a0,0x3
    2e12:	7ea50513          	addi	a0,a0,2026 # 65f8 <malloc+0x1410>
    2e16:	733010ef          	jal	4d48 <unlink>
    2e1a:	2a051563          	bnez	a0,30c4 <subdir+0x3aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e1e:	4581                	li	a1,0
    2e20:	00003517          	auipc	a0,0x3
    2e24:	7d850513          	addi	a0,a0,2008 # 65f8 <malloc+0x1410>
    2e28:	711010ef          	jal	4d38 <open>
    2e2c:	2a055663          	bgez	a0,30d8 <subdir+0x3be>
  if(chdir("dd") != 0){
    2e30:	00003517          	auipc	a0,0x3
    2e34:	72850513          	addi	a0,a0,1832 # 6558 <malloc+0x1370>
    2e38:	731010ef          	jal	4d68 <chdir>
    2e3c:	2a051863          	bnez	a0,30ec <subdir+0x3d2>
  if(chdir("dd/../../dd") != 0){
    2e40:	00004517          	auipc	a0,0x4
    2e44:	8d850513          	addi	a0,a0,-1832 # 6718 <malloc+0x1530>
    2e48:	721010ef          	jal	4d68 <chdir>
    2e4c:	2a051a63          	bnez	a0,3100 <subdir+0x3e6>
  if(chdir("dd/../../../dd") != 0){
    2e50:	00004517          	auipc	a0,0x4
    2e54:	8f850513          	addi	a0,a0,-1800 # 6748 <malloc+0x1560>
    2e58:	711010ef          	jal	4d68 <chdir>
    2e5c:	2a051c63          	bnez	a0,3114 <subdir+0x3fa>
  if(chdir("./..") != 0){
    2e60:	00004517          	auipc	a0,0x4
    2e64:	92050513          	addi	a0,a0,-1760 # 6780 <malloc+0x1598>
    2e68:	701010ef          	jal	4d68 <chdir>
    2e6c:	2a051e63          	bnez	a0,3128 <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2e70:	4581                	li	a1,0
    2e72:	00004517          	auipc	a0,0x4
    2e76:	80e50513          	addi	a0,a0,-2034 # 6680 <malloc+0x1498>
    2e7a:	6bf010ef          	jal	4d38 <open>
    2e7e:	84aa                	mv	s1,a0
  if(fd < 0){
    2e80:	2a054e63          	bltz	a0,313c <subdir+0x422>
  if(read(fd, buf, sizeof(buf)) != 2){
    2e84:	660d                	lui	a2,0x3
    2e86:	0000a597          	auipc	a1,0xa
    2e8a:	df258593          	addi	a1,a1,-526 # cc78 <buf>
    2e8e:	683010ef          	jal	4d10 <read>
    2e92:	4789                	li	a5,2
    2e94:	2af51e63          	bne	a0,a5,3150 <subdir+0x436>
  close(fd);
    2e98:	8526                	mv	a0,s1
    2e9a:	687010ef          	jal	4d20 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e9e:	4581                	li	a1,0
    2ea0:	00003517          	auipc	a0,0x3
    2ea4:	75850513          	addi	a0,a0,1880 # 65f8 <malloc+0x1410>
    2ea8:	691010ef          	jal	4d38 <open>
    2eac:	2a055c63          	bgez	a0,3164 <subdir+0x44a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2eb0:	20200593          	li	a1,514
    2eb4:	00004517          	auipc	a0,0x4
    2eb8:	95c50513          	addi	a0,a0,-1700 # 6810 <malloc+0x1628>
    2ebc:	67d010ef          	jal	4d38 <open>
    2ec0:	2a055c63          	bgez	a0,3178 <subdir+0x45e>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2ec4:	20200593          	li	a1,514
    2ec8:	00004517          	auipc	a0,0x4
    2ecc:	97850513          	addi	a0,a0,-1672 # 6840 <malloc+0x1658>
    2ed0:	669010ef          	jal	4d38 <open>
    2ed4:	2a055c63          	bgez	a0,318c <subdir+0x472>
  if(open("dd", O_CREATE) >= 0){
    2ed8:	20000593          	li	a1,512
    2edc:	00003517          	auipc	a0,0x3
    2ee0:	67c50513          	addi	a0,a0,1660 # 6558 <malloc+0x1370>
    2ee4:	655010ef          	jal	4d38 <open>
    2ee8:	2a055c63          	bgez	a0,31a0 <subdir+0x486>
  if(open("dd", O_RDWR) >= 0){
    2eec:	4589                	li	a1,2
    2eee:	00003517          	auipc	a0,0x3
    2ef2:	66a50513          	addi	a0,a0,1642 # 6558 <malloc+0x1370>
    2ef6:	643010ef          	jal	4d38 <open>
    2efa:	2a055d63          	bgez	a0,31b4 <subdir+0x49a>
  if(open("dd", O_WRONLY) >= 0){
    2efe:	4585                	li	a1,1
    2f00:	00003517          	auipc	a0,0x3
    2f04:	65850513          	addi	a0,a0,1624 # 6558 <malloc+0x1370>
    2f08:	631010ef          	jal	4d38 <open>
    2f0c:	2a055e63          	bgez	a0,31c8 <subdir+0x4ae>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2f10:	00004597          	auipc	a1,0x4
    2f14:	9c058593          	addi	a1,a1,-1600 # 68d0 <malloc+0x16e8>
    2f18:	00004517          	auipc	a0,0x4
    2f1c:	8f850513          	addi	a0,a0,-1800 # 6810 <malloc+0x1628>
    2f20:	639010ef          	jal	4d58 <link>
    2f24:	2a050c63          	beqz	a0,31dc <subdir+0x4c2>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2f28:	00004597          	auipc	a1,0x4
    2f2c:	9a858593          	addi	a1,a1,-1624 # 68d0 <malloc+0x16e8>
    2f30:	00004517          	auipc	a0,0x4
    2f34:	91050513          	addi	a0,a0,-1776 # 6840 <malloc+0x1658>
    2f38:	621010ef          	jal	4d58 <link>
    2f3c:	2a050a63          	beqz	a0,31f0 <subdir+0x4d6>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2f40:	00003597          	auipc	a1,0x3
    2f44:	74058593          	addi	a1,a1,1856 # 6680 <malloc+0x1498>
    2f48:	00003517          	auipc	a0,0x3
    2f4c:	63050513          	addi	a0,a0,1584 # 6578 <malloc+0x1390>
    2f50:	609010ef          	jal	4d58 <link>
    2f54:	2a050863          	beqz	a0,3204 <subdir+0x4ea>
  if(mkdir("dd/ff/ff") == 0){
    2f58:	00004517          	auipc	a0,0x4
    2f5c:	8b850513          	addi	a0,a0,-1864 # 6810 <malloc+0x1628>
    2f60:	601010ef          	jal	4d60 <mkdir>
    2f64:	2a050a63          	beqz	a0,3218 <subdir+0x4fe>
  if(mkdir("dd/xx/ff") == 0){
    2f68:	00004517          	auipc	a0,0x4
    2f6c:	8d850513          	addi	a0,a0,-1832 # 6840 <malloc+0x1658>
    2f70:	5f1010ef          	jal	4d60 <mkdir>
    2f74:	2a050c63          	beqz	a0,322c <subdir+0x512>
  if(mkdir("dd/dd/ffff") == 0){
    2f78:	00003517          	auipc	a0,0x3
    2f7c:	70850513          	addi	a0,a0,1800 # 6680 <malloc+0x1498>
    2f80:	5e1010ef          	jal	4d60 <mkdir>
    2f84:	2a050e63          	beqz	a0,3240 <subdir+0x526>
  if(unlink("dd/xx/ff") == 0){
    2f88:	00004517          	auipc	a0,0x4
    2f8c:	8b850513          	addi	a0,a0,-1864 # 6840 <malloc+0x1658>
    2f90:	5b9010ef          	jal	4d48 <unlink>
    2f94:	2c050063          	beqz	a0,3254 <subdir+0x53a>
  if(unlink("dd/ff/ff") == 0){
    2f98:	00004517          	auipc	a0,0x4
    2f9c:	87850513          	addi	a0,a0,-1928 # 6810 <malloc+0x1628>
    2fa0:	5a9010ef          	jal	4d48 <unlink>
    2fa4:	2c050263          	beqz	a0,3268 <subdir+0x54e>
  if(chdir("dd/ff") == 0){
    2fa8:	00003517          	auipc	a0,0x3
    2fac:	5d050513          	addi	a0,a0,1488 # 6578 <malloc+0x1390>
    2fb0:	5b9010ef          	jal	4d68 <chdir>
    2fb4:	2c050463          	beqz	a0,327c <subdir+0x562>
  if(chdir("dd/xx") == 0){
    2fb8:	00004517          	auipc	a0,0x4
    2fbc:	a6850513          	addi	a0,a0,-1432 # 6a20 <malloc+0x1838>
    2fc0:	5a9010ef          	jal	4d68 <chdir>
    2fc4:	2c050663          	beqz	a0,3290 <subdir+0x576>
  if(unlink("dd/dd/ffff") != 0){
    2fc8:	00003517          	auipc	a0,0x3
    2fcc:	6b850513          	addi	a0,a0,1720 # 6680 <malloc+0x1498>
    2fd0:	579010ef          	jal	4d48 <unlink>
    2fd4:	2c051863          	bnez	a0,32a4 <subdir+0x58a>
  if(unlink("dd/ff") != 0){
    2fd8:	00003517          	auipc	a0,0x3
    2fdc:	5a050513          	addi	a0,a0,1440 # 6578 <malloc+0x1390>
    2fe0:	569010ef          	jal	4d48 <unlink>
    2fe4:	2c051a63          	bnez	a0,32b8 <subdir+0x59e>
  if(unlink("dd") == 0){
    2fe8:	00003517          	auipc	a0,0x3
    2fec:	57050513          	addi	a0,a0,1392 # 6558 <malloc+0x1370>
    2ff0:	559010ef          	jal	4d48 <unlink>
    2ff4:	2c050c63          	beqz	a0,32cc <subdir+0x5b2>
  if(unlink("dd/dd") < 0){
    2ff8:	00004517          	auipc	a0,0x4
    2ffc:	a9850513          	addi	a0,a0,-1384 # 6a90 <malloc+0x18a8>
    3000:	549010ef          	jal	4d48 <unlink>
    3004:	2c054e63          	bltz	a0,32e0 <subdir+0x5c6>
  if(unlink("dd") < 0){
    3008:	00003517          	auipc	a0,0x3
    300c:	55050513          	addi	a0,a0,1360 # 6558 <malloc+0x1370>
    3010:	539010ef          	jal	4d48 <unlink>
    3014:	2e054063          	bltz	a0,32f4 <subdir+0x5da>
}
    3018:	60e2                	ld	ra,24(sp)
    301a:	6442                	ld	s0,16(sp)
    301c:	64a2                	ld	s1,8(sp)
    301e:	6902                	ld	s2,0(sp)
    3020:	6105                	addi	sp,sp,32
    3022:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3024:	85ca                	mv	a1,s2
    3026:	00003517          	auipc	a0,0x3
    302a:	53a50513          	addi	a0,a0,1338 # 6560 <malloc+0x1378>
    302e:	102020ef          	jal	5130 <printf>
    exit(1);
    3032:	4505                	li	a0,1
    3034:	4c5010ef          	jal	4cf8 <exit>
    printf("%s: create dd/ff failed\n", s);
    3038:	85ca                	mv	a1,s2
    303a:	00003517          	auipc	a0,0x3
    303e:	54650513          	addi	a0,a0,1350 # 6580 <malloc+0x1398>
    3042:	0ee020ef          	jal	5130 <printf>
    exit(1);
    3046:	4505                	li	a0,1
    3048:	4b1010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    304c:	85ca                	mv	a1,s2
    304e:	00003517          	auipc	a0,0x3
    3052:	55250513          	addi	a0,a0,1362 # 65a0 <malloc+0x13b8>
    3056:	0da020ef          	jal	5130 <printf>
    exit(1);
    305a:	4505                	li	a0,1
    305c:	49d010ef          	jal	4cf8 <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    3060:	85ca                	mv	a1,s2
    3062:	00003517          	auipc	a0,0x3
    3066:	57650513          	addi	a0,a0,1398 # 65d8 <malloc+0x13f0>
    306a:	0c6020ef          	jal	5130 <printf>
    exit(1);
    306e:	4505                	li	a0,1
    3070:	489010ef          	jal	4cf8 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3074:	85ca                	mv	a1,s2
    3076:	00003517          	auipc	a0,0x3
    307a:	59250513          	addi	a0,a0,1426 # 6608 <malloc+0x1420>
    307e:	0b2020ef          	jal	5130 <printf>
    exit(1);
    3082:	4505                	li	a0,1
    3084:	475010ef          	jal	4cf8 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3088:	85ca                	mv	a1,s2
    308a:	00003517          	auipc	a0,0x3
    308e:	5b650513          	addi	a0,a0,1462 # 6640 <malloc+0x1458>
    3092:	09e020ef          	jal	5130 <printf>
    exit(1);
    3096:	4505                	li	a0,1
    3098:	461010ef          	jal	4cf8 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    309c:	85ca                	mv	a1,s2
    309e:	00003517          	auipc	a0,0x3
    30a2:	5c250513          	addi	a0,a0,1474 # 6660 <malloc+0x1478>
    30a6:	08a020ef          	jal	5130 <printf>
    exit(1);
    30aa:	4505                	li	a0,1
    30ac:	44d010ef          	jal	4cf8 <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    30b0:	85ca                	mv	a1,s2
    30b2:	00003517          	auipc	a0,0x3
    30b6:	5de50513          	addi	a0,a0,1502 # 6690 <malloc+0x14a8>
    30ba:	076020ef          	jal	5130 <printf>
    exit(1);
    30be:	4505                	li	a0,1
    30c0:	439010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    30c4:	85ca                	mv	a1,s2
    30c6:	00003517          	auipc	a0,0x3
    30ca:	5f250513          	addi	a0,a0,1522 # 66b8 <malloc+0x14d0>
    30ce:	062020ef          	jal	5130 <printf>
    exit(1);
    30d2:	4505                	li	a0,1
    30d4:	425010ef          	jal	4cf8 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    30d8:	85ca                	mv	a1,s2
    30da:	00003517          	auipc	a0,0x3
    30de:	5fe50513          	addi	a0,a0,1534 # 66d8 <malloc+0x14f0>
    30e2:	04e020ef          	jal	5130 <printf>
    exit(1);
    30e6:	4505                	li	a0,1
    30e8:	411010ef          	jal	4cf8 <exit>
    printf("%s: chdir dd failed\n", s);
    30ec:	85ca                	mv	a1,s2
    30ee:	00003517          	auipc	a0,0x3
    30f2:	61250513          	addi	a0,a0,1554 # 6700 <malloc+0x1518>
    30f6:	03a020ef          	jal	5130 <printf>
    exit(1);
    30fa:	4505                	li	a0,1
    30fc:	3fd010ef          	jal	4cf8 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3100:	85ca                	mv	a1,s2
    3102:	00003517          	auipc	a0,0x3
    3106:	62650513          	addi	a0,a0,1574 # 6728 <malloc+0x1540>
    310a:	026020ef          	jal	5130 <printf>
    exit(1);
    310e:	4505                	li	a0,1
    3110:	3e9010ef          	jal	4cf8 <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    3114:	85ca                	mv	a1,s2
    3116:	00003517          	auipc	a0,0x3
    311a:	64250513          	addi	a0,a0,1602 # 6758 <malloc+0x1570>
    311e:	012020ef          	jal	5130 <printf>
    exit(1);
    3122:	4505                	li	a0,1
    3124:	3d5010ef          	jal	4cf8 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3128:	85ca                	mv	a1,s2
    312a:	00003517          	auipc	a0,0x3
    312e:	65e50513          	addi	a0,a0,1630 # 6788 <malloc+0x15a0>
    3132:	7ff010ef          	jal	5130 <printf>
    exit(1);
    3136:	4505                	li	a0,1
    3138:	3c1010ef          	jal	4cf8 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    313c:	85ca                	mv	a1,s2
    313e:	00003517          	auipc	a0,0x3
    3142:	66250513          	addi	a0,a0,1634 # 67a0 <malloc+0x15b8>
    3146:	7eb010ef          	jal	5130 <printf>
    exit(1);
    314a:	4505                	li	a0,1
    314c:	3ad010ef          	jal	4cf8 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3150:	85ca                	mv	a1,s2
    3152:	00003517          	auipc	a0,0x3
    3156:	66e50513          	addi	a0,a0,1646 # 67c0 <malloc+0x15d8>
    315a:	7d7010ef          	jal	5130 <printf>
    exit(1);
    315e:	4505                	li	a0,1
    3160:	399010ef          	jal	4cf8 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3164:	85ca                	mv	a1,s2
    3166:	00003517          	auipc	a0,0x3
    316a:	67a50513          	addi	a0,a0,1658 # 67e0 <malloc+0x15f8>
    316e:	7c3010ef          	jal	5130 <printf>
    exit(1);
    3172:	4505                	li	a0,1
    3174:	385010ef          	jal	4cf8 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3178:	85ca                	mv	a1,s2
    317a:	00003517          	auipc	a0,0x3
    317e:	6a650513          	addi	a0,a0,1702 # 6820 <malloc+0x1638>
    3182:	7af010ef          	jal	5130 <printf>
    exit(1);
    3186:	4505                	li	a0,1
    3188:	371010ef          	jal	4cf8 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    318c:	85ca                	mv	a1,s2
    318e:	00003517          	auipc	a0,0x3
    3192:	6c250513          	addi	a0,a0,1730 # 6850 <malloc+0x1668>
    3196:	79b010ef          	jal	5130 <printf>
    exit(1);
    319a:	4505                	li	a0,1
    319c:	35d010ef          	jal	4cf8 <exit>
    printf("%s: create dd succeeded!\n", s);
    31a0:	85ca                	mv	a1,s2
    31a2:	00003517          	auipc	a0,0x3
    31a6:	6ce50513          	addi	a0,a0,1742 # 6870 <malloc+0x1688>
    31aa:	787010ef          	jal	5130 <printf>
    exit(1);
    31ae:	4505                	li	a0,1
    31b0:	349010ef          	jal	4cf8 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    31b4:	85ca                	mv	a1,s2
    31b6:	00003517          	auipc	a0,0x3
    31ba:	6da50513          	addi	a0,a0,1754 # 6890 <malloc+0x16a8>
    31be:	773010ef          	jal	5130 <printf>
    exit(1);
    31c2:	4505                	li	a0,1
    31c4:	335010ef          	jal	4cf8 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    31c8:	85ca                	mv	a1,s2
    31ca:	00003517          	auipc	a0,0x3
    31ce:	6e650513          	addi	a0,a0,1766 # 68b0 <malloc+0x16c8>
    31d2:	75f010ef          	jal	5130 <printf>
    exit(1);
    31d6:	4505                	li	a0,1
    31d8:	321010ef          	jal	4cf8 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    31dc:	85ca                	mv	a1,s2
    31de:	00003517          	auipc	a0,0x3
    31e2:	70250513          	addi	a0,a0,1794 # 68e0 <malloc+0x16f8>
    31e6:	74b010ef          	jal	5130 <printf>
    exit(1);
    31ea:	4505                	li	a0,1
    31ec:	30d010ef          	jal	4cf8 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    31f0:	85ca                	mv	a1,s2
    31f2:	00003517          	auipc	a0,0x3
    31f6:	71650513          	addi	a0,a0,1814 # 6908 <malloc+0x1720>
    31fa:	737010ef          	jal	5130 <printf>
    exit(1);
    31fe:	4505                	li	a0,1
    3200:	2f9010ef          	jal	4cf8 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3204:	85ca                	mv	a1,s2
    3206:	00003517          	auipc	a0,0x3
    320a:	72a50513          	addi	a0,a0,1834 # 6930 <malloc+0x1748>
    320e:	723010ef          	jal	5130 <printf>
    exit(1);
    3212:	4505                	li	a0,1
    3214:	2e5010ef          	jal	4cf8 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3218:	85ca                	mv	a1,s2
    321a:	00003517          	auipc	a0,0x3
    321e:	73e50513          	addi	a0,a0,1854 # 6958 <malloc+0x1770>
    3222:	70f010ef          	jal	5130 <printf>
    exit(1);
    3226:	4505                	li	a0,1
    3228:	2d1010ef          	jal	4cf8 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    322c:	85ca                	mv	a1,s2
    322e:	00003517          	auipc	a0,0x3
    3232:	74a50513          	addi	a0,a0,1866 # 6978 <malloc+0x1790>
    3236:	6fb010ef          	jal	5130 <printf>
    exit(1);
    323a:	4505                	li	a0,1
    323c:	2bd010ef          	jal	4cf8 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3240:	85ca                	mv	a1,s2
    3242:	00003517          	auipc	a0,0x3
    3246:	75650513          	addi	a0,a0,1878 # 6998 <malloc+0x17b0>
    324a:	6e7010ef          	jal	5130 <printf>
    exit(1);
    324e:	4505                	li	a0,1
    3250:	2a9010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3254:	85ca                	mv	a1,s2
    3256:	00003517          	auipc	a0,0x3
    325a:	76a50513          	addi	a0,a0,1898 # 69c0 <malloc+0x17d8>
    325e:	6d3010ef          	jal	5130 <printf>
    exit(1);
    3262:	4505                	li	a0,1
    3264:	295010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3268:	85ca                	mv	a1,s2
    326a:	00003517          	auipc	a0,0x3
    326e:	77650513          	addi	a0,a0,1910 # 69e0 <malloc+0x17f8>
    3272:	6bf010ef          	jal	5130 <printf>
    exit(1);
    3276:	4505                	li	a0,1
    3278:	281010ef          	jal	4cf8 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    327c:	85ca                	mv	a1,s2
    327e:	00003517          	auipc	a0,0x3
    3282:	78250513          	addi	a0,a0,1922 # 6a00 <malloc+0x1818>
    3286:	6ab010ef          	jal	5130 <printf>
    exit(1);
    328a:	4505                	li	a0,1
    328c:	26d010ef          	jal	4cf8 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3290:	85ca                	mv	a1,s2
    3292:	00003517          	auipc	a0,0x3
    3296:	79650513          	addi	a0,a0,1942 # 6a28 <malloc+0x1840>
    329a:	697010ef          	jal	5130 <printf>
    exit(1);
    329e:	4505                	li	a0,1
    32a0:	259010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    32a4:	85ca                	mv	a1,s2
    32a6:	00003517          	auipc	a0,0x3
    32aa:	41250513          	addi	a0,a0,1042 # 66b8 <malloc+0x14d0>
    32ae:	683010ef          	jal	5130 <printf>
    exit(1);
    32b2:	4505                	li	a0,1
    32b4:	245010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    32b8:	85ca                	mv	a1,s2
    32ba:	00003517          	auipc	a0,0x3
    32be:	78e50513          	addi	a0,a0,1934 # 6a48 <malloc+0x1860>
    32c2:	66f010ef          	jal	5130 <printf>
    exit(1);
    32c6:	4505                	li	a0,1
    32c8:	231010ef          	jal	4cf8 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    32cc:	85ca                	mv	a1,s2
    32ce:	00003517          	auipc	a0,0x3
    32d2:	79a50513          	addi	a0,a0,1946 # 6a68 <malloc+0x1880>
    32d6:	65b010ef          	jal	5130 <printf>
    exit(1);
    32da:	4505                	li	a0,1
    32dc:	21d010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    32e0:	85ca                	mv	a1,s2
    32e2:	00003517          	auipc	a0,0x3
    32e6:	7b650513          	addi	a0,a0,1974 # 6a98 <malloc+0x18b0>
    32ea:	647010ef          	jal	5130 <printf>
    exit(1);
    32ee:	4505                	li	a0,1
    32f0:	209010ef          	jal	4cf8 <exit>
    printf("%s: unlink dd failed\n", s);
    32f4:	85ca                	mv	a1,s2
    32f6:	00003517          	auipc	a0,0x3
    32fa:	7c250513          	addi	a0,a0,1986 # 6ab8 <malloc+0x18d0>
    32fe:	633010ef          	jal	5130 <printf>
    exit(1);
    3302:	4505                	li	a0,1
    3304:	1f5010ef          	jal	4cf8 <exit>

0000000000003308 <rmdot>:
{
    3308:	1101                	addi	sp,sp,-32
    330a:	ec06                	sd	ra,24(sp)
    330c:	e822                	sd	s0,16(sp)
    330e:	e426                	sd	s1,8(sp)
    3310:	1000                	addi	s0,sp,32
    3312:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3314:	00003517          	auipc	a0,0x3
    3318:	7bc50513          	addi	a0,a0,1980 # 6ad0 <malloc+0x18e8>
    331c:	245010ef          	jal	4d60 <mkdir>
    3320:	e53d                	bnez	a0,338e <rmdot+0x86>
  if(chdir("dots") != 0){
    3322:	00003517          	auipc	a0,0x3
    3326:	7ae50513          	addi	a0,a0,1966 # 6ad0 <malloc+0x18e8>
    332a:	23f010ef          	jal	4d68 <chdir>
    332e:	e935                	bnez	a0,33a2 <rmdot+0x9a>
  if(unlink(".") == 0){
    3330:	00002517          	auipc	a0,0x2
    3334:	6d050513          	addi	a0,a0,1744 # 5a00 <malloc+0x818>
    3338:	211010ef          	jal	4d48 <unlink>
    333c:	cd2d                	beqz	a0,33b6 <rmdot+0xae>
  if(unlink("..") == 0){
    333e:	00003517          	auipc	a0,0x3
    3342:	1e250513          	addi	a0,a0,482 # 6520 <malloc+0x1338>
    3346:	203010ef          	jal	4d48 <unlink>
    334a:	c141                	beqz	a0,33ca <rmdot+0xc2>
  if(chdir("/") != 0){
    334c:	00003517          	auipc	a0,0x3
    3350:	17c50513          	addi	a0,a0,380 # 64c8 <malloc+0x12e0>
    3354:	215010ef          	jal	4d68 <chdir>
    3358:	e159                	bnez	a0,33de <rmdot+0xd6>
  if(unlink("dots/.") == 0){
    335a:	00003517          	auipc	a0,0x3
    335e:	7de50513          	addi	a0,a0,2014 # 6b38 <malloc+0x1950>
    3362:	1e7010ef          	jal	4d48 <unlink>
    3366:	c551                	beqz	a0,33f2 <rmdot+0xea>
  if(unlink("dots/..") == 0){
    3368:	00003517          	auipc	a0,0x3
    336c:	7f850513          	addi	a0,a0,2040 # 6b60 <malloc+0x1978>
    3370:	1d9010ef          	jal	4d48 <unlink>
    3374:	c949                	beqz	a0,3406 <rmdot+0xfe>
  if(unlink("dots") != 0){
    3376:	00003517          	auipc	a0,0x3
    337a:	75a50513          	addi	a0,a0,1882 # 6ad0 <malloc+0x18e8>
    337e:	1cb010ef          	jal	4d48 <unlink>
    3382:	ed41                	bnez	a0,341a <rmdot+0x112>
}
    3384:	60e2                	ld	ra,24(sp)
    3386:	6442                	ld	s0,16(sp)
    3388:	64a2                	ld	s1,8(sp)
    338a:	6105                	addi	sp,sp,32
    338c:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    338e:	85a6                	mv	a1,s1
    3390:	00003517          	auipc	a0,0x3
    3394:	74850513          	addi	a0,a0,1864 # 6ad8 <malloc+0x18f0>
    3398:	599010ef          	jal	5130 <printf>
    exit(1);
    339c:	4505                	li	a0,1
    339e:	15b010ef          	jal	4cf8 <exit>
    printf("%s: chdir dots failed\n", s);
    33a2:	85a6                	mv	a1,s1
    33a4:	00003517          	auipc	a0,0x3
    33a8:	74c50513          	addi	a0,a0,1868 # 6af0 <malloc+0x1908>
    33ac:	585010ef          	jal	5130 <printf>
    exit(1);
    33b0:	4505                	li	a0,1
    33b2:	147010ef          	jal	4cf8 <exit>
    printf("%s: rm . worked!\n", s);
    33b6:	85a6                	mv	a1,s1
    33b8:	00003517          	auipc	a0,0x3
    33bc:	75050513          	addi	a0,a0,1872 # 6b08 <malloc+0x1920>
    33c0:	571010ef          	jal	5130 <printf>
    exit(1);
    33c4:	4505                	li	a0,1
    33c6:	133010ef          	jal	4cf8 <exit>
    printf("%s: rm .. worked!\n", s);
    33ca:	85a6                	mv	a1,s1
    33cc:	00003517          	auipc	a0,0x3
    33d0:	75450513          	addi	a0,a0,1876 # 6b20 <malloc+0x1938>
    33d4:	55d010ef          	jal	5130 <printf>
    exit(1);
    33d8:	4505                	li	a0,1
    33da:	11f010ef          	jal	4cf8 <exit>
    printf("%s: chdir / failed\n", s);
    33de:	85a6                	mv	a1,s1
    33e0:	00003517          	auipc	a0,0x3
    33e4:	0f050513          	addi	a0,a0,240 # 64d0 <malloc+0x12e8>
    33e8:	549010ef          	jal	5130 <printf>
    exit(1);
    33ec:	4505                	li	a0,1
    33ee:	10b010ef          	jal	4cf8 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    33f2:	85a6                	mv	a1,s1
    33f4:	00003517          	auipc	a0,0x3
    33f8:	74c50513          	addi	a0,a0,1868 # 6b40 <malloc+0x1958>
    33fc:	535010ef          	jal	5130 <printf>
    exit(1);
    3400:	4505                	li	a0,1
    3402:	0f7010ef          	jal	4cf8 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3406:	85a6                	mv	a1,s1
    3408:	00003517          	auipc	a0,0x3
    340c:	76050513          	addi	a0,a0,1888 # 6b68 <malloc+0x1980>
    3410:	521010ef          	jal	5130 <printf>
    exit(1);
    3414:	4505                	li	a0,1
    3416:	0e3010ef          	jal	4cf8 <exit>
    printf("%s: unlink dots failed!\n", s);
    341a:	85a6                	mv	a1,s1
    341c:	00003517          	auipc	a0,0x3
    3420:	76c50513          	addi	a0,a0,1900 # 6b88 <malloc+0x19a0>
    3424:	50d010ef          	jal	5130 <printf>
    exit(1);
    3428:	4505                	li	a0,1
    342a:	0cf010ef          	jal	4cf8 <exit>

000000000000342e <dirfile>:
{
    342e:	1101                	addi	sp,sp,-32
    3430:	ec06                	sd	ra,24(sp)
    3432:	e822                	sd	s0,16(sp)
    3434:	e426                	sd	s1,8(sp)
    3436:	e04a                	sd	s2,0(sp)
    3438:	1000                	addi	s0,sp,32
    343a:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    343c:	20000593          	li	a1,512
    3440:	00003517          	auipc	a0,0x3
    3444:	76850513          	addi	a0,a0,1896 # 6ba8 <malloc+0x19c0>
    3448:	0f1010ef          	jal	4d38 <open>
  if(fd < 0){
    344c:	0c054563          	bltz	a0,3516 <dirfile+0xe8>
  close(fd);
    3450:	0d1010ef          	jal	4d20 <close>
  if(chdir("dirfile") == 0){
    3454:	00003517          	auipc	a0,0x3
    3458:	75450513          	addi	a0,a0,1876 # 6ba8 <malloc+0x19c0>
    345c:	10d010ef          	jal	4d68 <chdir>
    3460:	c569                	beqz	a0,352a <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    3462:	4581                	li	a1,0
    3464:	00003517          	auipc	a0,0x3
    3468:	78c50513          	addi	a0,a0,1932 # 6bf0 <malloc+0x1a08>
    346c:	0cd010ef          	jal	4d38 <open>
  if(fd >= 0){
    3470:	0c055763          	bgez	a0,353e <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    3474:	20000593          	li	a1,512
    3478:	00003517          	auipc	a0,0x3
    347c:	77850513          	addi	a0,a0,1912 # 6bf0 <malloc+0x1a08>
    3480:	0b9010ef          	jal	4d38 <open>
  if(fd >= 0){
    3484:	0c055763          	bgez	a0,3552 <dirfile+0x124>
  if(mkdir("dirfile/xx") == 0){
    3488:	00003517          	auipc	a0,0x3
    348c:	76850513          	addi	a0,a0,1896 # 6bf0 <malloc+0x1a08>
    3490:	0d1010ef          	jal	4d60 <mkdir>
    3494:	0c050963          	beqz	a0,3566 <dirfile+0x138>
  if(unlink("dirfile/xx") == 0){
    3498:	00003517          	auipc	a0,0x3
    349c:	75850513          	addi	a0,a0,1880 # 6bf0 <malloc+0x1a08>
    34a0:	0a9010ef          	jal	4d48 <unlink>
    34a4:	0c050b63          	beqz	a0,357a <dirfile+0x14c>
  if(link("README", "dirfile/xx") == 0){
    34a8:	00003597          	auipc	a1,0x3
    34ac:	74858593          	addi	a1,a1,1864 # 6bf0 <malloc+0x1a08>
    34b0:	00002517          	auipc	a0,0x2
    34b4:	04050513          	addi	a0,a0,64 # 54f0 <malloc+0x308>
    34b8:	0a1010ef          	jal	4d58 <link>
    34bc:	0c050963          	beqz	a0,358e <dirfile+0x160>
  if(unlink("dirfile") != 0){
    34c0:	00003517          	auipc	a0,0x3
    34c4:	6e850513          	addi	a0,a0,1768 # 6ba8 <malloc+0x19c0>
    34c8:	081010ef          	jal	4d48 <unlink>
    34cc:	0c051b63          	bnez	a0,35a2 <dirfile+0x174>
  fd = open(".", O_RDWR);
    34d0:	4589                	li	a1,2
    34d2:	00002517          	auipc	a0,0x2
    34d6:	52e50513          	addi	a0,a0,1326 # 5a00 <malloc+0x818>
    34da:	05f010ef          	jal	4d38 <open>
  if(fd >= 0){
    34de:	0c055c63          	bgez	a0,35b6 <dirfile+0x188>
  fd = open(".", 0);
    34e2:	4581                	li	a1,0
    34e4:	00002517          	auipc	a0,0x2
    34e8:	51c50513          	addi	a0,a0,1308 # 5a00 <malloc+0x818>
    34ec:	04d010ef          	jal	4d38 <open>
    34f0:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    34f2:	4605                	li	a2,1
    34f4:	00002597          	auipc	a1,0x2
    34f8:	e9458593          	addi	a1,a1,-364 # 5388 <malloc+0x1a0>
    34fc:	01d010ef          	jal	4d18 <write>
    3500:	0ca04563          	bgtz	a0,35ca <dirfile+0x19c>
  close(fd);
    3504:	8526                	mv	a0,s1
    3506:	01b010ef          	jal	4d20 <close>
}
    350a:	60e2                	ld	ra,24(sp)
    350c:	6442                	ld	s0,16(sp)
    350e:	64a2                	ld	s1,8(sp)
    3510:	6902                	ld	s2,0(sp)
    3512:	6105                	addi	sp,sp,32
    3514:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3516:	85ca                	mv	a1,s2
    3518:	00003517          	auipc	a0,0x3
    351c:	69850513          	addi	a0,a0,1688 # 6bb0 <malloc+0x19c8>
    3520:	411010ef          	jal	5130 <printf>
    exit(1);
    3524:	4505                	li	a0,1
    3526:	7d2010ef          	jal	4cf8 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    352a:	85ca                	mv	a1,s2
    352c:	00003517          	auipc	a0,0x3
    3530:	6a450513          	addi	a0,a0,1700 # 6bd0 <malloc+0x19e8>
    3534:	3fd010ef          	jal	5130 <printf>
    exit(1);
    3538:	4505                	li	a0,1
    353a:	7be010ef          	jal	4cf8 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    353e:	85ca                	mv	a1,s2
    3540:	00003517          	auipc	a0,0x3
    3544:	6c050513          	addi	a0,a0,1728 # 6c00 <malloc+0x1a18>
    3548:	3e9010ef          	jal	5130 <printf>
    exit(1);
    354c:	4505                	li	a0,1
    354e:	7aa010ef          	jal	4cf8 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3552:	85ca                	mv	a1,s2
    3554:	00003517          	auipc	a0,0x3
    3558:	6ac50513          	addi	a0,a0,1708 # 6c00 <malloc+0x1a18>
    355c:	3d5010ef          	jal	5130 <printf>
    exit(1);
    3560:	4505                	li	a0,1
    3562:	796010ef          	jal	4cf8 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3566:	85ca                	mv	a1,s2
    3568:	00003517          	auipc	a0,0x3
    356c:	6c050513          	addi	a0,a0,1728 # 6c28 <malloc+0x1a40>
    3570:	3c1010ef          	jal	5130 <printf>
    exit(1);
    3574:	4505                	li	a0,1
    3576:	782010ef          	jal	4cf8 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    357a:	85ca                	mv	a1,s2
    357c:	00003517          	auipc	a0,0x3
    3580:	6d450513          	addi	a0,a0,1748 # 6c50 <malloc+0x1a68>
    3584:	3ad010ef          	jal	5130 <printf>
    exit(1);
    3588:	4505                	li	a0,1
    358a:	76e010ef          	jal	4cf8 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    358e:	85ca                	mv	a1,s2
    3590:	00003517          	auipc	a0,0x3
    3594:	6e850513          	addi	a0,a0,1768 # 6c78 <malloc+0x1a90>
    3598:	399010ef          	jal	5130 <printf>
    exit(1);
    359c:	4505                	li	a0,1
    359e:	75a010ef          	jal	4cf8 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    35a2:	85ca                	mv	a1,s2
    35a4:	00003517          	auipc	a0,0x3
    35a8:	6fc50513          	addi	a0,a0,1788 # 6ca0 <malloc+0x1ab8>
    35ac:	385010ef          	jal	5130 <printf>
    exit(1);
    35b0:	4505                	li	a0,1
    35b2:	746010ef          	jal	4cf8 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    35b6:	85ca                	mv	a1,s2
    35b8:	00003517          	auipc	a0,0x3
    35bc:	70850513          	addi	a0,a0,1800 # 6cc0 <malloc+0x1ad8>
    35c0:	371010ef          	jal	5130 <printf>
    exit(1);
    35c4:	4505                	li	a0,1
    35c6:	732010ef          	jal	4cf8 <exit>
    printf("%s: write . succeeded!\n", s);
    35ca:	85ca                	mv	a1,s2
    35cc:	00003517          	auipc	a0,0x3
    35d0:	71c50513          	addi	a0,a0,1820 # 6ce8 <malloc+0x1b00>
    35d4:	35d010ef          	jal	5130 <printf>
    exit(1);
    35d8:	4505                	li	a0,1
    35da:	71e010ef          	jal	4cf8 <exit>

00000000000035de <iref>:
{
    35de:	715d                	addi	sp,sp,-80
    35e0:	e486                	sd	ra,72(sp)
    35e2:	e0a2                	sd	s0,64(sp)
    35e4:	fc26                	sd	s1,56(sp)
    35e6:	f84a                	sd	s2,48(sp)
    35e8:	f44e                	sd	s3,40(sp)
    35ea:	f052                	sd	s4,32(sp)
    35ec:	ec56                	sd	s5,24(sp)
    35ee:	e85a                	sd	s6,16(sp)
    35f0:	e45e                	sd	s7,8(sp)
    35f2:	0880                	addi	s0,sp,80
    35f4:	8baa                	mv	s7,a0
    35f6:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    35fa:	00003a97          	auipc	s5,0x3
    35fe:	706a8a93          	addi	s5,s5,1798 # 6d00 <malloc+0x1b18>
    mkdir("");
    3602:	00003497          	auipc	s1,0x3
    3606:	20648493          	addi	s1,s1,518 # 6808 <malloc+0x1620>
    link("README", "");
    360a:	00002b17          	auipc	s6,0x2
    360e:	ee6b0b13          	addi	s6,s6,-282 # 54f0 <malloc+0x308>
    fd = open("", O_CREATE);
    3612:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    3616:	00003997          	auipc	s3,0x3
    361a:	5e298993          	addi	s3,s3,1506 # 6bf8 <malloc+0x1a10>
    361e:	a835                	j	365a <iref+0x7c>
      printf("%s: mkdir irefd failed\n", s);
    3620:	85de                	mv	a1,s7
    3622:	00003517          	auipc	a0,0x3
    3626:	6e650513          	addi	a0,a0,1766 # 6d08 <malloc+0x1b20>
    362a:	307010ef          	jal	5130 <printf>
      exit(1);
    362e:	4505                	li	a0,1
    3630:	6c8010ef          	jal	4cf8 <exit>
      printf("%s: chdir irefd failed\n", s);
    3634:	85de                	mv	a1,s7
    3636:	00003517          	auipc	a0,0x3
    363a:	6ea50513          	addi	a0,a0,1770 # 6d20 <malloc+0x1b38>
    363e:	2f3010ef          	jal	5130 <printf>
      exit(1);
    3642:	4505                	li	a0,1
    3644:	6b4010ef          	jal	4cf8 <exit>
      close(fd);
    3648:	6d8010ef          	jal	4d20 <close>
    364c:	a825                	j	3684 <iref+0xa6>
    unlink("xx");
    364e:	854e                	mv	a0,s3
    3650:	6f8010ef          	jal	4d48 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3654:	397d                	addiw	s2,s2,-1
    3656:	04090063          	beqz	s2,3696 <iref+0xb8>
    if(mkdir("irefd") != 0){
    365a:	8556                	mv	a0,s5
    365c:	704010ef          	jal	4d60 <mkdir>
    3660:	f161                	bnez	a0,3620 <iref+0x42>
    if(chdir("irefd") != 0){
    3662:	8556                	mv	a0,s5
    3664:	704010ef          	jal	4d68 <chdir>
    3668:	f571                	bnez	a0,3634 <iref+0x56>
    mkdir("");
    366a:	8526                	mv	a0,s1
    366c:	6f4010ef          	jal	4d60 <mkdir>
    link("README", "");
    3670:	85a6                	mv	a1,s1
    3672:	855a                	mv	a0,s6
    3674:	6e4010ef          	jal	4d58 <link>
    fd = open("", O_CREATE);
    3678:	85d2                	mv	a1,s4
    367a:	8526                	mv	a0,s1
    367c:	6bc010ef          	jal	4d38 <open>
    if(fd >= 0)
    3680:	fc0554e3          	bgez	a0,3648 <iref+0x6a>
    fd = open("xx", O_CREATE);
    3684:	85d2                	mv	a1,s4
    3686:	854e                	mv	a0,s3
    3688:	6b0010ef          	jal	4d38 <open>
    if(fd >= 0)
    368c:	fc0541e3          	bltz	a0,364e <iref+0x70>
      close(fd);
    3690:	690010ef          	jal	4d20 <close>
    3694:	bf6d                	j	364e <iref+0x70>
    3696:	03300493          	li	s1,51
    chdir("..");
    369a:	00003997          	auipc	s3,0x3
    369e:	e8698993          	addi	s3,s3,-378 # 6520 <malloc+0x1338>
    unlink("irefd");
    36a2:	00003917          	auipc	s2,0x3
    36a6:	65e90913          	addi	s2,s2,1630 # 6d00 <malloc+0x1b18>
    chdir("..");
    36aa:	854e                	mv	a0,s3
    36ac:	6bc010ef          	jal	4d68 <chdir>
    unlink("irefd");
    36b0:	854a                	mv	a0,s2
    36b2:	696010ef          	jal	4d48 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    36b6:	34fd                	addiw	s1,s1,-1
    36b8:	f8ed                	bnez	s1,36aa <iref+0xcc>
  chdir("/");
    36ba:	00003517          	auipc	a0,0x3
    36be:	e0e50513          	addi	a0,a0,-498 # 64c8 <malloc+0x12e0>
    36c2:	6a6010ef          	jal	4d68 <chdir>
}
    36c6:	60a6                	ld	ra,72(sp)
    36c8:	6406                	ld	s0,64(sp)
    36ca:	74e2                	ld	s1,56(sp)
    36cc:	7942                	ld	s2,48(sp)
    36ce:	79a2                	ld	s3,40(sp)
    36d0:	7a02                	ld	s4,32(sp)
    36d2:	6ae2                	ld	s5,24(sp)
    36d4:	6b42                	ld	s6,16(sp)
    36d6:	6ba2                	ld	s7,8(sp)
    36d8:	6161                	addi	sp,sp,80
    36da:	8082                	ret

00000000000036dc <openiputtest>:
{
    36dc:	7179                	addi	sp,sp,-48
    36de:	f406                	sd	ra,40(sp)
    36e0:	f022                	sd	s0,32(sp)
    36e2:	ec26                	sd	s1,24(sp)
    36e4:	1800                	addi	s0,sp,48
    36e6:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    36e8:	00003517          	auipc	a0,0x3
    36ec:	65050513          	addi	a0,a0,1616 # 6d38 <malloc+0x1b50>
    36f0:	670010ef          	jal	4d60 <mkdir>
    36f4:	02054a63          	bltz	a0,3728 <openiputtest+0x4c>
  pid = fork();
    36f8:	5f8010ef          	jal	4cf0 <fork>
  if(pid < 0){
    36fc:	04054063          	bltz	a0,373c <openiputtest+0x60>
  if(pid == 0){
    3700:	e939                	bnez	a0,3756 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    3702:	4589                	li	a1,2
    3704:	00003517          	auipc	a0,0x3
    3708:	63450513          	addi	a0,a0,1588 # 6d38 <malloc+0x1b50>
    370c:	62c010ef          	jal	4d38 <open>
    if(fd >= 0){
    3710:	04054063          	bltz	a0,3750 <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    3714:	85a6                	mv	a1,s1
    3716:	00003517          	auipc	a0,0x3
    371a:	64250513          	addi	a0,a0,1602 # 6d58 <malloc+0x1b70>
    371e:	213010ef          	jal	5130 <printf>
      exit(1);
    3722:	4505                	li	a0,1
    3724:	5d4010ef          	jal	4cf8 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3728:	85a6                	mv	a1,s1
    372a:	00003517          	auipc	a0,0x3
    372e:	61650513          	addi	a0,a0,1558 # 6d40 <malloc+0x1b58>
    3732:	1ff010ef          	jal	5130 <printf>
    exit(1);
    3736:	4505                	li	a0,1
    3738:	5c0010ef          	jal	4cf8 <exit>
    printf("%s: fork failed\n", s);
    373c:	85a6                	mv	a1,s1
    373e:	00002517          	auipc	a0,0x2
    3742:	46a50513          	addi	a0,a0,1130 # 5ba8 <malloc+0x9c0>
    3746:	1eb010ef          	jal	5130 <printf>
    exit(1);
    374a:	4505                	li	a0,1
    374c:	5ac010ef          	jal	4cf8 <exit>
    exit(0);
    3750:	4501                	li	a0,0
    3752:	5a6010ef          	jal	4cf8 <exit>
  sleep(1);
    3756:	4505                	li	a0,1
    3758:	630010ef          	jal	4d88 <sleep>
  if(unlink("oidir") != 0){
    375c:	00003517          	auipc	a0,0x3
    3760:	5dc50513          	addi	a0,a0,1500 # 6d38 <malloc+0x1b50>
    3764:	5e4010ef          	jal	4d48 <unlink>
    3768:	c919                	beqz	a0,377e <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    376a:	85a6                	mv	a1,s1
    376c:	00002517          	auipc	a0,0x2
    3770:	62c50513          	addi	a0,a0,1580 # 5d98 <malloc+0xbb0>
    3774:	1bd010ef          	jal	5130 <printf>
    exit(1);
    3778:	4505                	li	a0,1
    377a:	57e010ef          	jal	4cf8 <exit>
  wait(&xstatus);
    377e:	fdc40513          	addi	a0,s0,-36
    3782:	57e010ef          	jal	4d00 <wait>
  exit(xstatus);
    3786:	fdc42503          	lw	a0,-36(s0)
    378a:	56e010ef          	jal	4cf8 <exit>

000000000000378e <forkforkfork>:
{
    378e:	1101                	addi	sp,sp,-32
    3790:	ec06                	sd	ra,24(sp)
    3792:	e822                	sd	s0,16(sp)
    3794:	e426                	sd	s1,8(sp)
    3796:	1000                	addi	s0,sp,32
    3798:	84aa                	mv	s1,a0
  unlink("stopforking");
    379a:	00003517          	auipc	a0,0x3
    379e:	5e650513          	addi	a0,a0,1510 # 6d80 <malloc+0x1b98>
    37a2:	5a6010ef          	jal	4d48 <unlink>
  int pid = fork();
    37a6:	54a010ef          	jal	4cf0 <fork>
  if(pid < 0){
    37aa:	02054b63          	bltz	a0,37e0 <forkforkfork+0x52>
  if(pid == 0){
    37ae:	c139                	beqz	a0,37f4 <forkforkfork+0x66>
  sleep(20); // two seconds
    37b0:	4551                	li	a0,20
    37b2:	5d6010ef          	jal	4d88 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    37b6:	20200593          	li	a1,514
    37ba:	00003517          	auipc	a0,0x3
    37be:	5c650513          	addi	a0,a0,1478 # 6d80 <malloc+0x1b98>
    37c2:	576010ef          	jal	4d38 <open>
    37c6:	55a010ef          	jal	4d20 <close>
  wait(0);
    37ca:	4501                	li	a0,0
    37cc:	534010ef          	jal	4d00 <wait>
  sleep(10); // one second
    37d0:	4529                	li	a0,10
    37d2:	5b6010ef          	jal	4d88 <sleep>
}
    37d6:	60e2                	ld	ra,24(sp)
    37d8:	6442                	ld	s0,16(sp)
    37da:	64a2                	ld	s1,8(sp)
    37dc:	6105                	addi	sp,sp,32
    37de:	8082                	ret
    printf("%s: fork failed", s);
    37e0:	85a6                	mv	a1,s1
    37e2:	00002517          	auipc	a0,0x2
    37e6:	58650513          	addi	a0,a0,1414 # 5d68 <malloc+0xb80>
    37ea:	147010ef          	jal	5130 <printf>
    exit(1);
    37ee:	4505                	li	a0,1
    37f0:	508010ef          	jal	4cf8 <exit>
      int fd = open("stopforking", 0);
    37f4:	4581                	li	a1,0
    37f6:	00003517          	auipc	a0,0x3
    37fa:	58a50513          	addi	a0,a0,1418 # 6d80 <malloc+0x1b98>
    37fe:	53a010ef          	jal	4d38 <open>
      if(fd >= 0){
    3802:	02055163          	bgez	a0,3824 <forkforkfork+0x96>
      if(fork() < 0){
    3806:	4ea010ef          	jal	4cf0 <fork>
    380a:	fe0555e3          	bgez	a0,37f4 <forkforkfork+0x66>
        close(open("stopforking", O_CREATE|O_RDWR));
    380e:	20200593          	li	a1,514
    3812:	00003517          	auipc	a0,0x3
    3816:	56e50513          	addi	a0,a0,1390 # 6d80 <malloc+0x1b98>
    381a:	51e010ef          	jal	4d38 <open>
    381e:	502010ef          	jal	4d20 <close>
    3822:	bfc9                	j	37f4 <forkforkfork+0x66>
        exit(0);
    3824:	4501                	li	a0,0
    3826:	4d2010ef          	jal	4cf8 <exit>

000000000000382a <killstatus>:
{
    382a:	715d                	addi	sp,sp,-80
    382c:	e486                	sd	ra,72(sp)
    382e:	e0a2                	sd	s0,64(sp)
    3830:	fc26                	sd	s1,56(sp)
    3832:	f84a                	sd	s2,48(sp)
    3834:	f44e                	sd	s3,40(sp)
    3836:	f052                	sd	s4,32(sp)
    3838:	ec56                	sd	s5,24(sp)
    383a:	e85a                	sd	s6,16(sp)
    383c:	0880                	addi	s0,sp,80
    383e:	8b2a                	mv	s6,a0
    3840:	06400913          	li	s2,100
    sleep(1);
    3844:	4a85                	li	s5,1
    wait(&xst);
    3846:	fbc40a13          	addi	s4,s0,-68
    if(xst != -1) {
    384a:	59fd                	li	s3,-1
    int pid1 = fork();
    384c:	4a4010ef          	jal	4cf0 <fork>
    3850:	84aa                	mv	s1,a0
    if(pid1 < 0){
    3852:	02054663          	bltz	a0,387e <killstatus+0x54>
    if(pid1 == 0){
    3856:	cd15                	beqz	a0,3892 <killstatus+0x68>
    sleep(1);
    3858:	8556                	mv	a0,s5
    385a:	52e010ef          	jal	4d88 <sleep>
    kill(pid1);
    385e:	8526                	mv	a0,s1
    3860:	4c8010ef          	jal	4d28 <kill>
    wait(&xst);
    3864:	8552                	mv	a0,s4
    3866:	49a010ef          	jal	4d00 <wait>
    if(xst != -1) {
    386a:	fbc42783          	lw	a5,-68(s0)
    386e:	03379563          	bne	a5,s3,3898 <killstatus+0x6e>
  for(int i = 0; i < 100; i++){
    3872:	397d                	addiw	s2,s2,-1
    3874:	fc091ce3          	bnez	s2,384c <killstatus+0x22>
  exit(0);
    3878:	4501                	li	a0,0
    387a:	47e010ef          	jal	4cf8 <exit>
      printf("%s: fork failed\n", s);
    387e:	85da                	mv	a1,s6
    3880:	00002517          	auipc	a0,0x2
    3884:	32850513          	addi	a0,a0,808 # 5ba8 <malloc+0x9c0>
    3888:	0a9010ef          	jal	5130 <printf>
      exit(1);
    388c:	4505                	li	a0,1
    388e:	46a010ef          	jal	4cf8 <exit>
        getpid();
    3892:	4e6010ef          	jal	4d78 <getpid>
      while(1) {
    3896:	bff5                	j	3892 <killstatus+0x68>
       printf("%s: status should be -1\n", s);
    3898:	85da                	mv	a1,s6
    389a:	00003517          	auipc	a0,0x3
    389e:	4f650513          	addi	a0,a0,1270 # 6d90 <malloc+0x1ba8>
    38a2:	08f010ef          	jal	5130 <printf>
       exit(1);
    38a6:	4505                	li	a0,1
    38a8:	450010ef          	jal	4cf8 <exit>

00000000000038ac <preempt>:
{
    38ac:	7139                	addi	sp,sp,-64
    38ae:	fc06                	sd	ra,56(sp)
    38b0:	f822                	sd	s0,48(sp)
    38b2:	f426                	sd	s1,40(sp)
    38b4:	f04a                	sd	s2,32(sp)
    38b6:	ec4e                	sd	s3,24(sp)
    38b8:	e852                	sd	s4,16(sp)
    38ba:	0080                	addi	s0,sp,64
    38bc:	892a                	mv	s2,a0
  pid1 = fork();
    38be:	432010ef          	jal	4cf0 <fork>
  if(pid1 < 0) {
    38c2:	00054563          	bltz	a0,38cc <preempt+0x20>
    38c6:	84aa                	mv	s1,a0
  if(pid1 == 0)
    38c8:	ed01                	bnez	a0,38e0 <preempt+0x34>
    for(;;)
    38ca:	a001                	j	38ca <preempt+0x1e>
    printf("%s: fork failed", s);
    38cc:	85ca                	mv	a1,s2
    38ce:	00002517          	auipc	a0,0x2
    38d2:	49a50513          	addi	a0,a0,1178 # 5d68 <malloc+0xb80>
    38d6:	05b010ef          	jal	5130 <printf>
    exit(1);
    38da:	4505                	li	a0,1
    38dc:	41c010ef          	jal	4cf8 <exit>
  pid2 = fork();
    38e0:	410010ef          	jal	4cf0 <fork>
    38e4:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    38e6:	00054463          	bltz	a0,38ee <preempt+0x42>
  if(pid2 == 0)
    38ea:	ed01                	bnez	a0,3902 <preempt+0x56>
    for(;;)
    38ec:	a001                	j	38ec <preempt+0x40>
    printf("%s: fork failed\n", s);
    38ee:	85ca                	mv	a1,s2
    38f0:	00002517          	auipc	a0,0x2
    38f4:	2b850513          	addi	a0,a0,696 # 5ba8 <malloc+0x9c0>
    38f8:	039010ef          	jal	5130 <printf>
    exit(1);
    38fc:	4505                	li	a0,1
    38fe:	3fa010ef          	jal	4cf8 <exit>
  pipe(pfds);
    3902:	fc840513          	addi	a0,s0,-56
    3906:	402010ef          	jal	4d08 <pipe>
  pid3 = fork();
    390a:	3e6010ef          	jal	4cf0 <fork>
    390e:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    3910:	02054863          	bltz	a0,3940 <preempt+0x94>
  if(pid3 == 0){
    3914:	e921                	bnez	a0,3964 <preempt+0xb8>
    close(pfds[0]);
    3916:	fc842503          	lw	a0,-56(s0)
    391a:	406010ef          	jal	4d20 <close>
    if(write(pfds[1], "x", 1) != 1)
    391e:	4605                	li	a2,1
    3920:	00002597          	auipc	a1,0x2
    3924:	a6858593          	addi	a1,a1,-1432 # 5388 <malloc+0x1a0>
    3928:	fcc42503          	lw	a0,-52(s0)
    392c:	3ec010ef          	jal	4d18 <write>
    3930:	4785                	li	a5,1
    3932:	02f51163          	bne	a0,a5,3954 <preempt+0xa8>
    close(pfds[1]);
    3936:	fcc42503          	lw	a0,-52(s0)
    393a:	3e6010ef          	jal	4d20 <close>
    for(;;)
    393e:	a001                	j	393e <preempt+0x92>
     printf("%s: fork failed\n", s);
    3940:	85ca                	mv	a1,s2
    3942:	00002517          	auipc	a0,0x2
    3946:	26650513          	addi	a0,a0,614 # 5ba8 <malloc+0x9c0>
    394a:	7e6010ef          	jal	5130 <printf>
     exit(1);
    394e:	4505                	li	a0,1
    3950:	3a8010ef          	jal	4cf8 <exit>
      printf("%s: preempt write error", s);
    3954:	85ca                	mv	a1,s2
    3956:	00003517          	auipc	a0,0x3
    395a:	45a50513          	addi	a0,a0,1114 # 6db0 <malloc+0x1bc8>
    395e:	7d2010ef          	jal	5130 <printf>
    3962:	bfd1                	j	3936 <preempt+0x8a>
  close(pfds[1]);
    3964:	fcc42503          	lw	a0,-52(s0)
    3968:	3b8010ef          	jal	4d20 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    396c:	660d                	lui	a2,0x3
    396e:	00009597          	auipc	a1,0x9
    3972:	30a58593          	addi	a1,a1,778 # cc78 <buf>
    3976:	fc842503          	lw	a0,-56(s0)
    397a:	396010ef          	jal	4d10 <read>
    397e:	4785                	li	a5,1
    3980:	02f50163          	beq	a0,a5,39a2 <preempt+0xf6>
    printf("%s: preempt read error", s);
    3984:	85ca                	mv	a1,s2
    3986:	00003517          	auipc	a0,0x3
    398a:	44250513          	addi	a0,a0,1090 # 6dc8 <malloc+0x1be0>
    398e:	7a2010ef          	jal	5130 <printf>
}
    3992:	70e2                	ld	ra,56(sp)
    3994:	7442                	ld	s0,48(sp)
    3996:	74a2                	ld	s1,40(sp)
    3998:	7902                	ld	s2,32(sp)
    399a:	69e2                	ld	s3,24(sp)
    399c:	6a42                	ld	s4,16(sp)
    399e:	6121                	addi	sp,sp,64
    39a0:	8082                	ret
  close(pfds[0]);
    39a2:	fc842503          	lw	a0,-56(s0)
    39a6:	37a010ef          	jal	4d20 <close>
  printf("kill... ");
    39aa:	00003517          	auipc	a0,0x3
    39ae:	43650513          	addi	a0,a0,1078 # 6de0 <malloc+0x1bf8>
    39b2:	77e010ef          	jal	5130 <printf>
  kill(pid1);
    39b6:	8526                	mv	a0,s1
    39b8:	370010ef          	jal	4d28 <kill>
  kill(pid2);
    39bc:	854e                	mv	a0,s3
    39be:	36a010ef          	jal	4d28 <kill>
  kill(pid3);
    39c2:	8552                	mv	a0,s4
    39c4:	364010ef          	jal	4d28 <kill>
  printf("wait... ");
    39c8:	00003517          	auipc	a0,0x3
    39cc:	42850513          	addi	a0,a0,1064 # 6df0 <malloc+0x1c08>
    39d0:	760010ef          	jal	5130 <printf>
  wait(0);
    39d4:	4501                	li	a0,0
    39d6:	32a010ef          	jal	4d00 <wait>
  wait(0);
    39da:	4501                	li	a0,0
    39dc:	324010ef          	jal	4d00 <wait>
  wait(0);
    39e0:	4501                	li	a0,0
    39e2:	31e010ef          	jal	4d00 <wait>
    39e6:	b775                	j	3992 <preempt+0xe6>

00000000000039e8 <reparent>:
{
    39e8:	7179                	addi	sp,sp,-48
    39ea:	f406                	sd	ra,40(sp)
    39ec:	f022                	sd	s0,32(sp)
    39ee:	ec26                	sd	s1,24(sp)
    39f0:	e84a                	sd	s2,16(sp)
    39f2:	e44e                	sd	s3,8(sp)
    39f4:	e052                	sd	s4,0(sp)
    39f6:	1800                	addi	s0,sp,48
    39f8:	89aa                	mv	s3,a0
  int master_pid = getpid();
    39fa:	37e010ef          	jal	4d78 <getpid>
    39fe:	8a2a                	mv	s4,a0
    3a00:	0c800913          	li	s2,200
    int pid = fork();
    3a04:	2ec010ef          	jal	4cf0 <fork>
    3a08:	84aa                	mv	s1,a0
    if(pid < 0){
    3a0a:	00054e63          	bltz	a0,3a26 <reparent+0x3e>
    if(pid){
    3a0e:	c121                	beqz	a0,3a4e <reparent+0x66>
      if(wait(0) != pid){
    3a10:	4501                	li	a0,0
    3a12:	2ee010ef          	jal	4d00 <wait>
    3a16:	02951263          	bne	a0,s1,3a3a <reparent+0x52>
  for(int i = 0; i < 200; i++){
    3a1a:	397d                	addiw	s2,s2,-1
    3a1c:	fe0914e3          	bnez	s2,3a04 <reparent+0x1c>
  exit(0);
    3a20:	4501                	li	a0,0
    3a22:	2d6010ef          	jal	4cf8 <exit>
      printf("%s: fork failed\n", s);
    3a26:	85ce                	mv	a1,s3
    3a28:	00002517          	auipc	a0,0x2
    3a2c:	18050513          	addi	a0,a0,384 # 5ba8 <malloc+0x9c0>
    3a30:	700010ef          	jal	5130 <printf>
      exit(1);
    3a34:	4505                	li	a0,1
    3a36:	2c2010ef          	jal	4cf8 <exit>
        printf("%s: wait wrong pid\n", s);
    3a3a:	85ce                	mv	a1,s3
    3a3c:	00002517          	auipc	a0,0x2
    3a40:	2f450513          	addi	a0,a0,756 # 5d30 <malloc+0xb48>
    3a44:	6ec010ef          	jal	5130 <printf>
        exit(1);
    3a48:	4505                	li	a0,1
    3a4a:	2ae010ef          	jal	4cf8 <exit>
      int pid2 = fork();
    3a4e:	2a2010ef          	jal	4cf0 <fork>
      if(pid2 < 0){
    3a52:	00054563          	bltz	a0,3a5c <reparent+0x74>
      exit(0);
    3a56:	4501                	li	a0,0
    3a58:	2a0010ef          	jal	4cf8 <exit>
        kill(master_pid);
    3a5c:	8552                	mv	a0,s4
    3a5e:	2ca010ef          	jal	4d28 <kill>
        exit(1);
    3a62:	4505                	li	a0,1
    3a64:	294010ef          	jal	4cf8 <exit>

0000000000003a68 <sbrkfail>:
{
    3a68:	7175                	addi	sp,sp,-144
    3a6a:	e506                	sd	ra,136(sp)
    3a6c:	e122                	sd	s0,128(sp)
    3a6e:	fca6                	sd	s1,120(sp)
    3a70:	f8ca                	sd	s2,112(sp)
    3a72:	f4ce                	sd	s3,104(sp)
    3a74:	f0d2                	sd	s4,96(sp)
    3a76:	ecd6                	sd	s5,88(sp)
    3a78:	e8da                	sd	s6,80(sp)
    3a7a:	e4de                	sd	s7,72(sp)
    3a7c:	0900                	addi	s0,sp,144
    3a7e:	8baa                	mv	s7,a0
  if(pipe(fds) != 0){
    3a80:	fa040513          	addi	a0,s0,-96
    3a84:	284010ef          	jal	4d08 <pipe>
    3a88:	e919                	bnez	a0,3a9e <sbrkfail+0x36>
    3a8a:	f7040493          	addi	s1,s0,-144
    3a8e:	f9840993          	addi	s3,s0,-104
    3a92:	8926                	mv	s2,s1
    if(pids[i] != -1)
    3a94:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    3a96:	f9f40b13          	addi	s6,s0,-97
    3a9a:	4a85                	li	s5,1
    3a9c:	a0a9                	j	3ae6 <sbrkfail+0x7e>
    printf("%s: pipe() failed\n", s);
    3a9e:	85de                	mv	a1,s7
    3aa0:	00002517          	auipc	a0,0x2
    3aa4:	21050513          	addi	a0,a0,528 # 5cb0 <malloc+0xac8>
    3aa8:	688010ef          	jal	5130 <printf>
    exit(1);
    3aac:	4505                	li	a0,1
    3aae:	24a010ef          	jal	4cf8 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    3ab2:	2ce010ef          	jal	4d80 <sbrk>
    3ab6:	064007b7          	lui	a5,0x6400
    3aba:	40a7853b          	subw	a0,a5,a0
    3abe:	2c2010ef          	jal	4d80 <sbrk>
      write(fds[1], "x", 1);
    3ac2:	4605                	li	a2,1
    3ac4:	00002597          	auipc	a1,0x2
    3ac8:	8c458593          	addi	a1,a1,-1852 # 5388 <malloc+0x1a0>
    3acc:	fa442503          	lw	a0,-92(s0)
    3ad0:	248010ef          	jal	4d18 <write>
      for(;;) sleep(1000);
    3ad4:	3e800493          	li	s1,1000
    3ad8:	8526                	mv	a0,s1
    3ada:	2ae010ef          	jal	4d88 <sleep>
    3ade:	bfed                	j	3ad8 <sbrkfail+0x70>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3ae0:	0911                	addi	s2,s2,4
    3ae2:	03390063          	beq	s2,s3,3b02 <sbrkfail+0x9a>
    if((pids[i] = fork()) == 0){
    3ae6:	20a010ef          	jal	4cf0 <fork>
    3aea:	00a92023          	sw	a0,0(s2)
    3aee:	d171                	beqz	a0,3ab2 <sbrkfail+0x4a>
    if(pids[i] != -1)
    3af0:	ff4508e3          	beq	a0,s4,3ae0 <sbrkfail+0x78>
      read(fds[0], &scratch, 1);
    3af4:	8656                	mv	a2,s5
    3af6:	85da                	mv	a1,s6
    3af8:	fa042503          	lw	a0,-96(s0)
    3afc:	214010ef          	jal	4d10 <read>
    3b00:	b7c5                	j	3ae0 <sbrkfail+0x78>
  c = sbrk(PGSIZE);
    3b02:	6505                	lui	a0,0x1
    3b04:	27c010ef          	jal	4d80 <sbrk>
    3b08:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    3b0a:	597d                	li	s2,-1
    3b0c:	a021                	j	3b14 <sbrkfail+0xac>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3b0e:	0491                	addi	s1,s1,4
    3b10:	01348b63          	beq	s1,s3,3b26 <sbrkfail+0xbe>
    if(pids[i] == -1)
    3b14:	4088                	lw	a0,0(s1)
    3b16:	ff250ce3          	beq	a0,s2,3b0e <sbrkfail+0xa6>
    kill(pids[i]);
    3b1a:	20e010ef          	jal	4d28 <kill>
    wait(0);
    3b1e:	4501                	li	a0,0
    3b20:	1e0010ef          	jal	4d00 <wait>
    3b24:	b7ed                	j	3b0e <sbrkfail+0xa6>
  if(c == (char*)0xffffffffffffffffL){
    3b26:	57fd                	li	a5,-1
    3b28:	02fa0e63          	beq	s4,a5,3b64 <sbrkfail+0xfc>
  pid = fork();
    3b2c:	1c4010ef          	jal	4cf0 <fork>
    3b30:	84aa                	mv	s1,a0
  if(pid < 0){
    3b32:	04054363          	bltz	a0,3b78 <sbrkfail+0x110>
  if(pid == 0){
    3b36:	c939                	beqz	a0,3b8c <sbrkfail+0x124>
  wait(&xstatus);
    3b38:	fac40513          	addi	a0,s0,-84
    3b3c:	1c4010ef          	jal	4d00 <wait>
  if(xstatus != -1 && xstatus != 2)
    3b40:	fac42783          	lw	a5,-84(s0)
    3b44:	00178713          	addi	a4,a5,1 # 6400001 <base+0x63f0389>
    3b48:	c319                	beqz	a4,3b4e <sbrkfail+0xe6>
    3b4a:	17f9                	addi	a5,a5,-2
    3b4c:	efb5                	bnez	a5,3bc8 <sbrkfail+0x160>
}
    3b4e:	60aa                	ld	ra,136(sp)
    3b50:	640a                	ld	s0,128(sp)
    3b52:	74e6                	ld	s1,120(sp)
    3b54:	7946                	ld	s2,112(sp)
    3b56:	79a6                	ld	s3,104(sp)
    3b58:	7a06                	ld	s4,96(sp)
    3b5a:	6ae6                	ld	s5,88(sp)
    3b5c:	6b46                	ld	s6,80(sp)
    3b5e:	6ba6                	ld	s7,72(sp)
    3b60:	6149                	addi	sp,sp,144
    3b62:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    3b64:	85de                	mv	a1,s7
    3b66:	00003517          	auipc	a0,0x3
    3b6a:	29a50513          	addi	a0,a0,666 # 6e00 <malloc+0x1c18>
    3b6e:	5c2010ef          	jal	5130 <printf>
    exit(1);
    3b72:	4505                	li	a0,1
    3b74:	184010ef          	jal	4cf8 <exit>
    printf("%s: fork failed\n", s);
    3b78:	85de                	mv	a1,s7
    3b7a:	00002517          	auipc	a0,0x2
    3b7e:	02e50513          	addi	a0,a0,46 # 5ba8 <malloc+0x9c0>
    3b82:	5ae010ef          	jal	5130 <printf>
    exit(1);
    3b86:	4505                	li	a0,1
    3b88:	170010ef          	jal	4cf8 <exit>
    a = sbrk(0);
    3b8c:	4501                	li	a0,0
    3b8e:	1f2010ef          	jal	4d80 <sbrk>
    3b92:	892a                	mv	s2,a0
    sbrk(10*BIG);
    3b94:	3e800537          	lui	a0,0x3e800
    3b98:	1e8010ef          	jal	4d80 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3b9c:	87ca                	mv	a5,s2
    3b9e:	3e800737          	lui	a4,0x3e800
    3ba2:	993a                	add	s2,s2,a4
    3ba4:	6705                	lui	a4,0x1
      n += *(a+i);
    3ba6:	0007c603          	lbu	a2,0(a5)
    3baa:	9e25                	addw	a2,a2,s1
    3bac:	84b2                	mv	s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3bae:	97ba                	add	a5,a5,a4
    3bb0:	fef91be3          	bne	s2,a5,3ba6 <sbrkfail+0x13e>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    3bb4:	85de                	mv	a1,s7
    3bb6:	00003517          	auipc	a0,0x3
    3bba:	26a50513          	addi	a0,a0,618 # 6e20 <malloc+0x1c38>
    3bbe:	572010ef          	jal	5130 <printf>
    exit(1);
    3bc2:	4505                	li	a0,1
    3bc4:	134010ef          	jal	4cf8 <exit>
    exit(1);
    3bc8:	4505                	li	a0,1
    3bca:	12e010ef          	jal	4cf8 <exit>

0000000000003bce <mem>:
{
    3bce:	7139                	addi	sp,sp,-64
    3bd0:	fc06                	sd	ra,56(sp)
    3bd2:	f822                	sd	s0,48(sp)
    3bd4:	f426                	sd	s1,40(sp)
    3bd6:	f04a                	sd	s2,32(sp)
    3bd8:	ec4e                	sd	s3,24(sp)
    3bda:	0080                	addi	s0,sp,64
    3bdc:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    3bde:	112010ef          	jal	4cf0 <fork>
    m1 = 0;
    3be2:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    3be4:	6909                	lui	s2,0x2
    3be6:	71190913          	addi	s2,s2,1809 # 2711 <execout+0xd>
  if((pid = fork()) == 0){
    3bea:	cd11                	beqz	a0,3c06 <mem+0x38>
    wait(&xstatus);
    3bec:	fcc40513          	addi	a0,s0,-52
    3bf0:	110010ef          	jal	4d00 <wait>
    if(xstatus == -1){
    3bf4:	fcc42503          	lw	a0,-52(s0)
    3bf8:	57fd                	li	a5,-1
    3bfa:	04f50363          	beq	a0,a5,3c40 <mem+0x72>
    exit(xstatus);
    3bfe:	0fa010ef          	jal	4cf8 <exit>
      *(char**)m2 = m1;
    3c02:	e104                	sd	s1,0(a0)
      m1 = m2;
    3c04:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3c06:	854a                	mv	a0,s2
    3c08:	5e0010ef          	jal	51e8 <malloc>
    3c0c:	f97d                	bnez	a0,3c02 <mem+0x34>
    while(m1){
    3c0e:	c491                	beqz	s1,3c1a <mem+0x4c>
      m2 = *(char**)m1;
    3c10:	8526                	mv	a0,s1
    3c12:	6084                	ld	s1,0(s1)
      free(m1);
    3c14:	54e010ef          	jal	5162 <free>
    while(m1){
    3c18:	fce5                	bnez	s1,3c10 <mem+0x42>
    m1 = malloc(1024*20);
    3c1a:	6515                	lui	a0,0x5
    3c1c:	5cc010ef          	jal	51e8 <malloc>
    if(m1 == 0){
    3c20:	c511                	beqz	a0,3c2c <mem+0x5e>
    free(m1);
    3c22:	540010ef          	jal	5162 <free>
    exit(0);
    3c26:	4501                	li	a0,0
    3c28:	0d0010ef          	jal	4cf8 <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3c2c:	85ce                	mv	a1,s3
    3c2e:	00003517          	auipc	a0,0x3
    3c32:	22250513          	addi	a0,a0,546 # 6e50 <malloc+0x1c68>
    3c36:	4fa010ef          	jal	5130 <printf>
      exit(1);
    3c3a:	4505                	li	a0,1
    3c3c:	0bc010ef          	jal	4cf8 <exit>
      exit(0);
    3c40:	4501                	li	a0,0
    3c42:	0b6010ef          	jal	4cf8 <exit>

0000000000003c46 <sharedfd>:
{
    3c46:	7159                	addi	sp,sp,-112
    3c48:	f486                	sd	ra,104(sp)
    3c4a:	f0a2                	sd	s0,96(sp)
    3c4c:	eca6                	sd	s1,88(sp)
    3c4e:	f85a                	sd	s6,48(sp)
    3c50:	1880                	addi	s0,sp,112
    3c52:	84aa                	mv	s1,a0
    3c54:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    3c56:	00003517          	auipc	a0,0x3
    3c5a:	21a50513          	addi	a0,a0,538 # 6e70 <malloc+0x1c88>
    3c5e:	0ea010ef          	jal	4d48 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3c62:	20200593          	li	a1,514
    3c66:	00003517          	auipc	a0,0x3
    3c6a:	20a50513          	addi	a0,a0,522 # 6e70 <malloc+0x1c88>
    3c6e:	0ca010ef          	jal	4d38 <open>
  if(fd < 0){
    3c72:	04054863          	bltz	a0,3cc2 <sharedfd+0x7c>
    3c76:	e8ca                	sd	s2,80(sp)
    3c78:	e4ce                	sd	s3,72(sp)
    3c7a:	e0d2                	sd	s4,64(sp)
    3c7c:	fc56                	sd	s5,56(sp)
    3c7e:	89aa                	mv	s3,a0
  pid = fork();
    3c80:	070010ef          	jal	4cf0 <fork>
    3c84:	8aaa                	mv	s5,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    3c86:	07000593          	li	a1,112
    3c8a:	e119                	bnez	a0,3c90 <sharedfd+0x4a>
    3c8c:	06300593          	li	a1,99
    3c90:	4629                	li	a2,10
    3c92:	fa040513          	addi	a0,s0,-96
    3c96:	665000ef          	jal	4afa <memset>
    3c9a:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3c9e:	fa040a13          	addi	s4,s0,-96
    3ca2:	4929                	li	s2,10
    3ca4:	864a                	mv	a2,s2
    3ca6:	85d2                	mv	a1,s4
    3ca8:	854e                	mv	a0,s3
    3caa:	06e010ef          	jal	4d18 <write>
    3cae:	03251963          	bne	a0,s2,3ce0 <sharedfd+0x9a>
  for(i = 0; i < N; i++){
    3cb2:	34fd                	addiw	s1,s1,-1
    3cb4:	f8e5                	bnez	s1,3ca4 <sharedfd+0x5e>
  if(pid == 0) {
    3cb6:	040a9063          	bnez	s5,3cf6 <sharedfd+0xb0>
    3cba:	f45e                	sd	s7,40(sp)
    exit(0);
    3cbc:	4501                	li	a0,0
    3cbe:	03a010ef          	jal	4cf8 <exit>
    3cc2:	e8ca                	sd	s2,80(sp)
    3cc4:	e4ce                	sd	s3,72(sp)
    3cc6:	e0d2                	sd	s4,64(sp)
    3cc8:	fc56                	sd	s5,56(sp)
    3cca:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3ccc:	85a6                	mv	a1,s1
    3cce:	00003517          	auipc	a0,0x3
    3cd2:	1b250513          	addi	a0,a0,434 # 6e80 <malloc+0x1c98>
    3cd6:	45a010ef          	jal	5130 <printf>
    exit(1);
    3cda:	4505                	li	a0,1
    3cdc:	01c010ef          	jal	4cf8 <exit>
    3ce0:	f45e                	sd	s7,40(sp)
      printf("%s: write sharedfd failed\n", s);
    3ce2:	85da                	mv	a1,s6
    3ce4:	00003517          	auipc	a0,0x3
    3ce8:	1c450513          	addi	a0,a0,452 # 6ea8 <malloc+0x1cc0>
    3cec:	444010ef          	jal	5130 <printf>
      exit(1);
    3cf0:	4505                	li	a0,1
    3cf2:	006010ef          	jal	4cf8 <exit>
    wait(&xstatus);
    3cf6:	f9c40513          	addi	a0,s0,-100
    3cfa:	006010ef          	jal	4d00 <wait>
    if(xstatus != 0)
    3cfe:	f9c42a03          	lw	s4,-100(s0)
    3d02:	000a0663          	beqz	s4,3d0e <sharedfd+0xc8>
    3d06:	f45e                	sd	s7,40(sp)
      exit(xstatus);
    3d08:	8552                	mv	a0,s4
    3d0a:	7ef000ef          	jal	4cf8 <exit>
    3d0e:	f45e                	sd	s7,40(sp)
  close(fd);
    3d10:	854e                	mv	a0,s3
    3d12:	00e010ef          	jal	4d20 <close>
  fd = open("sharedfd", 0);
    3d16:	4581                	li	a1,0
    3d18:	00003517          	auipc	a0,0x3
    3d1c:	15850513          	addi	a0,a0,344 # 6e70 <malloc+0x1c88>
    3d20:	018010ef          	jal	4d38 <open>
    3d24:	8baa                	mv	s7,a0
  nc = np = 0;
    3d26:	89d2                	mv	s3,s4
  if(fd < 0){
    3d28:	02054363          	bltz	a0,3d4e <sharedfd+0x108>
    3d2c:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    3d30:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3d34:	07000a93          	li	s5,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3d38:	4629                	li	a2,10
    3d3a:	fa040593          	addi	a1,s0,-96
    3d3e:	855e                	mv	a0,s7
    3d40:	7d1000ef          	jal	4d10 <read>
    3d44:	02a05b63          	blez	a0,3d7a <sharedfd+0x134>
    3d48:	fa040793          	addi	a5,s0,-96
    3d4c:	a839                	j	3d6a <sharedfd+0x124>
    printf("%s: cannot open sharedfd for reading\n", s);
    3d4e:	85da                	mv	a1,s6
    3d50:	00003517          	auipc	a0,0x3
    3d54:	17850513          	addi	a0,a0,376 # 6ec8 <malloc+0x1ce0>
    3d58:	3d8010ef          	jal	5130 <printf>
    exit(1);
    3d5c:	4505                	li	a0,1
    3d5e:	79b000ef          	jal	4cf8 <exit>
        nc++;
    3d62:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    3d64:	0785                	addi	a5,a5,1
    3d66:	fd2789e3          	beq	a5,s2,3d38 <sharedfd+0xf2>
      if(buf[i] == 'c')
    3d6a:	0007c703          	lbu	a4,0(a5)
    3d6e:	fe970ae3          	beq	a4,s1,3d62 <sharedfd+0x11c>
      if(buf[i] == 'p')
    3d72:	ff5719e3          	bne	a4,s5,3d64 <sharedfd+0x11e>
        np++;
    3d76:	2985                	addiw	s3,s3,1
    3d78:	b7f5                	j	3d64 <sharedfd+0x11e>
  close(fd);
    3d7a:	855e                	mv	a0,s7
    3d7c:	7a5000ef          	jal	4d20 <close>
  unlink("sharedfd");
    3d80:	00003517          	auipc	a0,0x3
    3d84:	0f050513          	addi	a0,a0,240 # 6e70 <malloc+0x1c88>
    3d88:	7c1000ef          	jal	4d48 <unlink>
  if(nc == N*SZ && np == N*SZ){
    3d8c:	6789                	lui	a5,0x2
    3d8e:	71078793          	addi	a5,a5,1808 # 2710 <execout+0xc>
    3d92:	00fa1763          	bne	s4,a5,3da0 <sharedfd+0x15a>
    3d96:	01499563          	bne	s3,s4,3da0 <sharedfd+0x15a>
    exit(0);
    3d9a:	4501                	li	a0,0
    3d9c:	75d000ef          	jal	4cf8 <exit>
    printf("%s: nc/np test fails\n", s);
    3da0:	85da                	mv	a1,s6
    3da2:	00003517          	auipc	a0,0x3
    3da6:	14e50513          	addi	a0,a0,334 # 6ef0 <malloc+0x1d08>
    3daa:	386010ef          	jal	5130 <printf>
    exit(1);
    3dae:	4505                	li	a0,1
    3db0:	749000ef          	jal	4cf8 <exit>

0000000000003db4 <fourfiles>:
{
    3db4:	7135                	addi	sp,sp,-160
    3db6:	ed06                	sd	ra,152(sp)
    3db8:	e922                	sd	s0,144(sp)
    3dba:	e526                	sd	s1,136(sp)
    3dbc:	e14a                	sd	s2,128(sp)
    3dbe:	fcce                	sd	s3,120(sp)
    3dc0:	f8d2                	sd	s4,112(sp)
    3dc2:	f4d6                	sd	s5,104(sp)
    3dc4:	f0da                	sd	s6,96(sp)
    3dc6:	ecde                	sd	s7,88(sp)
    3dc8:	e8e2                	sd	s8,80(sp)
    3dca:	e4e6                	sd	s9,72(sp)
    3dcc:	e0ea                	sd	s10,64(sp)
    3dce:	fc6e                	sd	s11,56(sp)
    3dd0:	1100                	addi	s0,sp,160
    3dd2:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    3dd4:	00003797          	auipc	a5,0x3
    3dd8:	13478793          	addi	a5,a5,308 # 6f08 <malloc+0x1d20>
    3ddc:	f6f43823          	sd	a5,-144(s0)
    3de0:	00003797          	auipc	a5,0x3
    3de4:	13078793          	addi	a5,a5,304 # 6f10 <malloc+0x1d28>
    3de8:	f6f43c23          	sd	a5,-136(s0)
    3dec:	00003797          	auipc	a5,0x3
    3df0:	12c78793          	addi	a5,a5,300 # 6f18 <malloc+0x1d30>
    3df4:	f8f43023          	sd	a5,-128(s0)
    3df8:	00003797          	auipc	a5,0x3
    3dfc:	12878793          	addi	a5,a5,296 # 6f20 <malloc+0x1d38>
    3e00:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3e04:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3e08:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    3e0a:	4481                	li	s1,0
    3e0c:	4a11                	li	s4,4
    fname = names[pi];
    3e0e:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3e12:	854e                	mv	a0,s3
    3e14:	735000ef          	jal	4d48 <unlink>
    pid = fork();
    3e18:	6d9000ef          	jal	4cf0 <fork>
    if(pid < 0){
    3e1c:	04054063          	bltz	a0,3e5c <fourfiles+0xa8>
    if(pid == 0){
    3e20:	c921                	beqz	a0,3e70 <fourfiles+0xbc>
  for(pi = 0; pi < NCHILD; pi++){
    3e22:	2485                	addiw	s1,s1,1
    3e24:	0921                	addi	s2,s2,8
    3e26:	ff4494e3          	bne	s1,s4,3e0e <fourfiles+0x5a>
    3e2a:	4491                	li	s1,4
    wait(&xstatus);
    3e2c:	f6c40913          	addi	s2,s0,-148
    3e30:	854a                	mv	a0,s2
    3e32:	6cf000ef          	jal	4d00 <wait>
    if(xstatus != 0)
    3e36:	f6c42b03          	lw	s6,-148(s0)
    3e3a:	0a0b1463          	bnez	s6,3ee2 <fourfiles+0x12e>
  for(pi = 0; pi < NCHILD; pi++){
    3e3e:	34fd                	addiw	s1,s1,-1
    3e40:	f8e5                	bnez	s1,3e30 <fourfiles+0x7c>
    3e42:	03000493          	li	s1,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3e46:	6a8d                	lui	s5,0x3
    3e48:	00009a17          	auipc	s4,0x9
    3e4c:	e30a0a13          	addi	s4,s4,-464 # cc78 <buf>
    if(total != N*SZ){
    3e50:	6d05                	lui	s10,0x1
    3e52:	770d0d13          	addi	s10,s10,1904 # 1770 <exitwait+0x90>
  for(i = 0; i < NCHILD; i++){
    3e56:	03400d93          	li	s11,52
    3e5a:	a86d                	j	3f14 <fourfiles+0x160>
      printf("%s: fork failed\n", s);
    3e5c:	85e6                	mv	a1,s9
    3e5e:	00002517          	auipc	a0,0x2
    3e62:	d4a50513          	addi	a0,a0,-694 # 5ba8 <malloc+0x9c0>
    3e66:	2ca010ef          	jal	5130 <printf>
      exit(1);
    3e6a:	4505                	li	a0,1
    3e6c:	68d000ef          	jal	4cf8 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3e70:	20200593          	li	a1,514
    3e74:	854e                	mv	a0,s3
    3e76:	6c3000ef          	jal	4d38 <open>
    3e7a:	892a                	mv	s2,a0
      if(fd < 0){
    3e7c:	04054063          	bltz	a0,3ebc <fourfiles+0x108>
      memset(buf, '0'+pi, SZ);
    3e80:	1f400613          	li	a2,500
    3e84:	0304859b          	addiw	a1,s1,48
    3e88:	00009517          	auipc	a0,0x9
    3e8c:	df050513          	addi	a0,a0,-528 # cc78 <buf>
    3e90:	46b000ef          	jal	4afa <memset>
    3e94:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3e96:	1f400993          	li	s3,500
    3e9a:	00009a17          	auipc	s4,0x9
    3e9e:	ddea0a13          	addi	s4,s4,-546 # cc78 <buf>
    3ea2:	864e                	mv	a2,s3
    3ea4:	85d2                	mv	a1,s4
    3ea6:	854a                	mv	a0,s2
    3ea8:	671000ef          	jal	4d18 <write>
    3eac:	85aa                	mv	a1,a0
    3eae:	03351163          	bne	a0,s3,3ed0 <fourfiles+0x11c>
      for(i = 0; i < N; i++){
    3eb2:	34fd                	addiw	s1,s1,-1
    3eb4:	f4fd                	bnez	s1,3ea2 <fourfiles+0xee>
      exit(0);
    3eb6:	4501                	li	a0,0
    3eb8:	641000ef          	jal	4cf8 <exit>
        printf("%s: create failed\n", s);
    3ebc:	85e6                	mv	a1,s9
    3ebe:	00002517          	auipc	a0,0x2
    3ec2:	d8250513          	addi	a0,a0,-638 # 5c40 <malloc+0xa58>
    3ec6:	26a010ef          	jal	5130 <printf>
        exit(1);
    3eca:	4505                	li	a0,1
    3ecc:	62d000ef          	jal	4cf8 <exit>
          printf("write failed %d\n", n);
    3ed0:	00003517          	auipc	a0,0x3
    3ed4:	05850513          	addi	a0,a0,88 # 6f28 <malloc+0x1d40>
    3ed8:	258010ef          	jal	5130 <printf>
          exit(1);
    3edc:	4505                	li	a0,1
    3ede:	61b000ef          	jal	4cf8 <exit>
      exit(xstatus);
    3ee2:	855a                	mv	a0,s6
    3ee4:	615000ef          	jal	4cf8 <exit>
          printf("%s: wrong char\n", s);
    3ee8:	85e6                	mv	a1,s9
    3eea:	00003517          	auipc	a0,0x3
    3eee:	05650513          	addi	a0,a0,86 # 6f40 <malloc+0x1d58>
    3ef2:	23e010ef          	jal	5130 <printf>
          exit(1);
    3ef6:	4505                	li	a0,1
    3ef8:	601000ef          	jal	4cf8 <exit>
    close(fd);
    3efc:	854e                	mv	a0,s3
    3efe:	623000ef          	jal	4d20 <close>
    if(total != N*SZ){
    3f02:	05a91863          	bne	s2,s10,3f52 <fourfiles+0x19e>
    unlink(fname);
    3f06:	8562                	mv	a0,s8
    3f08:	641000ef          	jal	4d48 <unlink>
  for(i = 0; i < NCHILD; i++){
    3f0c:	0ba1                	addi	s7,s7,8
    3f0e:	2485                	addiw	s1,s1,1
    3f10:	05b48b63          	beq	s1,s11,3f66 <fourfiles+0x1b2>
    fname = names[i];
    3f14:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3f18:	4581                	li	a1,0
    3f1a:	8562                	mv	a0,s8
    3f1c:	61d000ef          	jal	4d38 <open>
    3f20:	89aa                	mv	s3,a0
    total = 0;
    3f22:	895a                	mv	s2,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3f24:	8656                	mv	a2,s5
    3f26:	85d2                	mv	a1,s4
    3f28:	854e                	mv	a0,s3
    3f2a:	5e7000ef          	jal	4d10 <read>
    3f2e:	fca057e3          	blez	a0,3efc <fourfiles+0x148>
    3f32:	00009797          	auipc	a5,0x9
    3f36:	d4678793          	addi	a5,a5,-698 # cc78 <buf>
    3f3a:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    3f3e:	0007c703          	lbu	a4,0(a5)
    3f42:	fa9713e3          	bne	a4,s1,3ee8 <fourfiles+0x134>
      for(j = 0; j < n; j++){
    3f46:	0785                	addi	a5,a5,1
    3f48:	fed79be3          	bne	a5,a3,3f3e <fourfiles+0x18a>
      total += n;
    3f4c:	00a9093b          	addw	s2,s2,a0
    3f50:	bfd1                	j	3f24 <fourfiles+0x170>
      printf("wrong length %d\n", total);
    3f52:	85ca                	mv	a1,s2
    3f54:	00003517          	auipc	a0,0x3
    3f58:	ffc50513          	addi	a0,a0,-4 # 6f50 <malloc+0x1d68>
    3f5c:	1d4010ef          	jal	5130 <printf>
      exit(1);
    3f60:	4505                	li	a0,1
    3f62:	597000ef          	jal	4cf8 <exit>
}
    3f66:	60ea                	ld	ra,152(sp)
    3f68:	644a                	ld	s0,144(sp)
    3f6a:	64aa                	ld	s1,136(sp)
    3f6c:	690a                	ld	s2,128(sp)
    3f6e:	79e6                	ld	s3,120(sp)
    3f70:	7a46                	ld	s4,112(sp)
    3f72:	7aa6                	ld	s5,104(sp)
    3f74:	7b06                	ld	s6,96(sp)
    3f76:	6be6                	ld	s7,88(sp)
    3f78:	6c46                	ld	s8,80(sp)
    3f7a:	6ca6                	ld	s9,72(sp)
    3f7c:	6d06                	ld	s10,64(sp)
    3f7e:	7de2                	ld	s11,56(sp)
    3f80:	610d                	addi	sp,sp,160
    3f82:	8082                	ret

0000000000003f84 <concreate>:
{
    3f84:	7171                	addi	sp,sp,-176
    3f86:	f506                	sd	ra,168(sp)
    3f88:	f122                	sd	s0,160(sp)
    3f8a:	ed26                	sd	s1,152(sp)
    3f8c:	e94a                	sd	s2,144(sp)
    3f8e:	e54e                	sd	s3,136(sp)
    3f90:	e152                	sd	s4,128(sp)
    3f92:	fcd6                	sd	s5,120(sp)
    3f94:	f8da                	sd	s6,112(sp)
    3f96:	f4de                	sd	s7,104(sp)
    3f98:	f0e2                	sd	s8,96(sp)
    3f9a:	ece6                	sd	s9,88(sp)
    3f9c:	e8ea                	sd	s10,80(sp)
    3f9e:	1900                	addi	s0,sp,176
    3fa0:	8d2a                	mv	s10,a0
  file[0] = 'C';
    3fa2:	04300793          	li	a5,67
    3fa6:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    3faa:	f8040d23          	sb	zero,-102(s0)
  for(i = 0; i < N; i++){
    3fae:	4901                	li	s2,0
    unlink(file);
    3fb0:	f9840993          	addi	s3,s0,-104
    if(pid && (i % 3) == 1){
    3fb4:	55555b37          	lui	s6,0x55555
    3fb8:	556b0b13          	addi	s6,s6,1366 # 55555556 <base+0x555458de>
    3fbc:	4b85                	li	s7,1
      fd = open(file, O_CREATE | O_RDWR);
    3fbe:	20200c13          	li	s8,514
      link("C0", file);
    3fc2:	00003c97          	auipc	s9,0x3
    3fc6:	fa6c8c93          	addi	s9,s9,-90 # 6f68 <malloc+0x1d80>
      wait(&xstatus);
    3fca:	f5c40a93          	addi	s5,s0,-164
  for(i = 0; i < N; i++){
    3fce:	02800a13          	li	s4,40
    3fd2:	ac25                	j	420a <concreate+0x286>
      link("C0", file);
    3fd4:	85ce                	mv	a1,s3
    3fd6:	8566                	mv	a0,s9
    3fd8:	581000ef          	jal	4d58 <link>
    if(pid == 0) {
    3fdc:	ac29                	j	41f6 <concreate+0x272>
    } else if(pid == 0 && (i % 5) == 1){
    3fde:	666667b7          	lui	a5,0x66666
    3fe2:	66778793          	addi	a5,a5,1639 # 66666667 <base+0x666569ef>
    3fe6:	02f907b3          	mul	a5,s2,a5
    3fea:	9785                	srai	a5,a5,0x21
    3fec:	41f9571b          	sraiw	a4,s2,0x1f
    3ff0:	9f99                	subw	a5,a5,a4
    3ff2:	0027971b          	slliw	a4,a5,0x2
    3ff6:	9fb9                	addw	a5,a5,a4
    3ff8:	40f9093b          	subw	s2,s2,a5
    3ffc:	4785                	li	a5,1
    3ffe:	02f90563          	beq	s2,a5,4028 <concreate+0xa4>
      fd = open(file, O_CREATE | O_RDWR);
    4002:	20200593          	li	a1,514
    4006:	f9840513          	addi	a0,s0,-104
    400a:	52f000ef          	jal	4d38 <open>
      if(fd < 0){
    400e:	1c055f63          	bgez	a0,41ec <concreate+0x268>
        printf("concreate create %s failed\n", file);
    4012:	f9840593          	addi	a1,s0,-104
    4016:	00003517          	auipc	a0,0x3
    401a:	f5a50513          	addi	a0,a0,-166 # 6f70 <malloc+0x1d88>
    401e:	112010ef          	jal	5130 <printf>
        exit(1);
    4022:	4505                	li	a0,1
    4024:	4d5000ef          	jal	4cf8 <exit>
      link("C0", file);
    4028:	f9840593          	addi	a1,s0,-104
    402c:	00003517          	auipc	a0,0x3
    4030:	f3c50513          	addi	a0,a0,-196 # 6f68 <malloc+0x1d80>
    4034:	525000ef          	jal	4d58 <link>
      exit(0);
    4038:	4501                	li	a0,0
    403a:	4bf000ef          	jal	4cf8 <exit>
        exit(1);
    403e:	4505                	li	a0,1
    4040:	4b9000ef          	jal	4cf8 <exit>
  memset(fa, 0, sizeof(fa));
    4044:	02800613          	li	a2,40
    4048:	4581                	li	a1,0
    404a:	f7040513          	addi	a0,s0,-144
    404e:	2ad000ef          	jal	4afa <memset>
  fd = open(".", 0);
    4052:	4581                	li	a1,0
    4054:	00002517          	auipc	a0,0x2
    4058:	9ac50513          	addi	a0,a0,-1620 # 5a00 <malloc+0x818>
    405c:	4dd000ef          	jal	4d38 <open>
    4060:	892a                	mv	s2,a0
  n = 0;
    4062:	8b26                	mv	s6,s1
  while(read(fd, &de, sizeof(de)) > 0){
    4064:	f6040a13          	addi	s4,s0,-160
    4068:	49c1                	li	s3,16
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    406a:	04300a93          	li	s5,67
      if(i < 0 || i >= sizeof(fa)){
    406e:	02700b93          	li	s7,39
      fa[i] = 1;
    4072:	4c05                	li	s8,1
  while(read(fd, &de, sizeof(de)) > 0){
    4074:	864e                	mv	a2,s3
    4076:	85d2                	mv	a1,s4
    4078:	854a                	mv	a0,s2
    407a:	497000ef          	jal	4d10 <read>
    407e:	06a05763          	blez	a0,40ec <concreate+0x168>
    if(de.inum == 0)
    4082:	f6045783          	lhu	a5,-160(s0)
    4086:	d7fd                	beqz	a5,4074 <concreate+0xf0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4088:	f6244783          	lbu	a5,-158(s0)
    408c:	ff5794e3          	bne	a5,s5,4074 <concreate+0xf0>
    4090:	f6444783          	lbu	a5,-156(s0)
    4094:	f3e5                	bnez	a5,4074 <concreate+0xf0>
      i = de.name[1] - '0';
    4096:	f6344783          	lbu	a5,-157(s0)
    409a:	fd07879b          	addiw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    409e:	00fbef63          	bltu	s7,a5,40bc <concreate+0x138>
      if(fa[i]){
    40a2:	fa078713          	addi	a4,a5,-96
    40a6:	9722                	add	a4,a4,s0
    40a8:	fd074703          	lbu	a4,-48(a4) # fd0 <bigdir+0xdc>
    40ac:	e705                	bnez	a4,40d4 <concreate+0x150>
      fa[i] = 1;
    40ae:	fa078793          	addi	a5,a5,-96
    40b2:	97a2                	add	a5,a5,s0
    40b4:	fd878823          	sb	s8,-48(a5)
      n++;
    40b8:	2b05                	addiw	s6,s6,1
    40ba:	bf6d                	j	4074 <concreate+0xf0>
        printf("%s: concreate weird file %s\n", s, de.name);
    40bc:	f6240613          	addi	a2,s0,-158
    40c0:	85ea                	mv	a1,s10
    40c2:	00003517          	auipc	a0,0x3
    40c6:	ece50513          	addi	a0,a0,-306 # 6f90 <malloc+0x1da8>
    40ca:	066010ef          	jal	5130 <printf>
        exit(1);
    40ce:	4505                	li	a0,1
    40d0:	429000ef          	jal	4cf8 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    40d4:	f6240613          	addi	a2,s0,-158
    40d8:	85ea                	mv	a1,s10
    40da:	00003517          	auipc	a0,0x3
    40de:	ed650513          	addi	a0,a0,-298 # 6fb0 <malloc+0x1dc8>
    40e2:	04e010ef          	jal	5130 <printf>
        exit(1);
    40e6:	4505                	li	a0,1
    40e8:	411000ef          	jal	4cf8 <exit>
  close(fd);
    40ec:	854a                	mv	a0,s2
    40ee:	433000ef          	jal	4d20 <close>
  if(n != N){
    40f2:	02800793          	li	a5,40
    40f6:	00fb1a63          	bne	s6,a5,410a <concreate+0x186>
    if(((i % 3) == 0 && pid == 0) ||
    40fa:	55555a37          	lui	s4,0x55555
    40fe:	556a0a13          	addi	s4,s4,1366 # 55555556 <base+0x555458de>
      close(open(file, 0));
    4102:	f9840993          	addi	s3,s0,-104
  for(i = 0; i < N; i++){
    4106:	8ada                	mv	s5,s6
    4108:	a049                	j	418a <concreate+0x206>
    printf("%s: concreate not enough files in directory listing\n", s);
    410a:	85ea                	mv	a1,s10
    410c:	00003517          	auipc	a0,0x3
    4110:	ecc50513          	addi	a0,a0,-308 # 6fd8 <malloc+0x1df0>
    4114:	01c010ef          	jal	5130 <printf>
    exit(1);
    4118:	4505                	li	a0,1
    411a:	3df000ef          	jal	4cf8 <exit>
      printf("%s: fork failed\n", s);
    411e:	85ea                	mv	a1,s10
    4120:	00002517          	auipc	a0,0x2
    4124:	a8850513          	addi	a0,a0,-1400 # 5ba8 <malloc+0x9c0>
    4128:	008010ef          	jal	5130 <printf>
      exit(1);
    412c:	4505                	li	a0,1
    412e:	3cb000ef          	jal	4cf8 <exit>
      close(open(file, 0));
    4132:	4581                	li	a1,0
    4134:	854e                	mv	a0,s3
    4136:	403000ef          	jal	4d38 <open>
    413a:	3e7000ef          	jal	4d20 <close>
      close(open(file, 0));
    413e:	4581                	li	a1,0
    4140:	854e                	mv	a0,s3
    4142:	3f7000ef          	jal	4d38 <open>
    4146:	3db000ef          	jal	4d20 <close>
      close(open(file, 0));
    414a:	4581                	li	a1,0
    414c:	854e                	mv	a0,s3
    414e:	3eb000ef          	jal	4d38 <open>
    4152:	3cf000ef          	jal	4d20 <close>
      close(open(file, 0));
    4156:	4581                	li	a1,0
    4158:	854e                	mv	a0,s3
    415a:	3df000ef          	jal	4d38 <open>
    415e:	3c3000ef          	jal	4d20 <close>
      close(open(file, 0));
    4162:	4581                	li	a1,0
    4164:	854e                	mv	a0,s3
    4166:	3d3000ef          	jal	4d38 <open>
    416a:	3b7000ef          	jal	4d20 <close>
      close(open(file, 0));
    416e:	4581                	li	a1,0
    4170:	854e                	mv	a0,s3
    4172:	3c7000ef          	jal	4d38 <open>
    4176:	3ab000ef          	jal	4d20 <close>
    if(pid == 0)
    417a:	06090663          	beqz	s2,41e6 <concreate+0x262>
      wait(0);
    417e:	4501                	li	a0,0
    4180:	381000ef          	jal	4d00 <wait>
  for(i = 0; i < N; i++){
    4184:	2485                	addiw	s1,s1,1
    4186:	0d548163          	beq	s1,s5,4248 <concreate+0x2c4>
    file[1] = '0' + i;
    418a:	0304879b          	addiw	a5,s1,48
    418e:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    4192:	35f000ef          	jal	4cf0 <fork>
    4196:	892a                	mv	s2,a0
    if(pid < 0){
    4198:	f80543e3          	bltz	a0,411e <concreate+0x19a>
    if(((i % 3) == 0 && pid == 0) ||
    419c:	03448733          	mul	a4,s1,s4
    41a0:	9301                	srli	a4,a4,0x20
    41a2:	41f4d79b          	sraiw	a5,s1,0x1f
    41a6:	9f1d                	subw	a4,a4,a5
    41a8:	0017179b          	slliw	a5,a4,0x1
    41ac:	9fb9                	addw	a5,a5,a4
    41ae:	40f487bb          	subw	a5,s1,a5
    41b2:	00a7e733          	or	a4,a5,a0
    41b6:	2701                	sext.w	a4,a4
    41b8:	df2d                	beqz	a4,4132 <concreate+0x1ae>
       ((i % 3) == 1 && pid != 0)){
    41ba:	c119                	beqz	a0,41c0 <concreate+0x23c>
    if(((i % 3) == 0 && pid == 0) ||
    41bc:	17fd                	addi	a5,a5,-1
       ((i % 3) == 1 && pid != 0)){
    41be:	dbb5                	beqz	a5,4132 <concreate+0x1ae>
      unlink(file);
    41c0:	854e                	mv	a0,s3
    41c2:	387000ef          	jal	4d48 <unlink>
      unlink(file);
    41c6:	854e                	mv	a0,s3
    41c8:	381000ef          	jal	4d48 <unlink>
      unlink(file);
    41cc:	854e                	mv	a0,s3
    41ce:	37b000ef          	jal	4d48 <unlink>
      unlink(file);
    41d2:	854e                	mv	a0,s3
    41d4:	375000ef          	jal	4d48 <unlink>
      unlink(file);
    41d8:	854e                	mv	a0,s3
    41da:	36f000ef          	jal	4d48 <unlink>
      unlink(file);
    41de:	854e                	mv	a0,s3
    41e0:	369000ef          	jal	4d48 <unlink>
    41e4:	bf59                	j	417a <concreate+0x1f6>
      exit(0);
    41e6:	4501                	li	a0,0
    41e8:	311000ef          	jal	4cf8 <exit>
      close(fd);
    41ec:	335000ef          	jal	4d20 <close>
    if(pid == 0) {
    41f0:	b5a1                	j	4038 <concreate+0xb4>
      close(fd);
    41f2:	32f000ef          	jal	4d20 <close>
      wait(&xstatus);
    41f6:	8556                	mv	a0,s5
    41f8:	309000ef          	jal	4d00 <wait>
      if(xstatus != 0)
    41fc:	f5c42483          	lw	s1,-164(s0)
    4200:	e2049fe3          	bnez	s1,403e <concreate+0xba>
  for(i = 0; i < N; i++){
    4204:	2905                	addiw	s2,s2,1
    4206:	e3490fe3          	beq	s2,s4,4044 <concreate+0xc0>
    file[1] = '0' + i;
    420a:	0309079b          	addiw	a5,s2,48
    420e:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    4212:	854e                	mv	a0,s3
    4214:	335000ef          	jal	4d48 <unlink>
    pid = fork();
    4218:	2d9000ef          	jal	4cf0 <fork>
    if(pid && (i % 3) == 1){
    421c:	dc0501e3          	beqz	a0,3fde <concreate+0x5a>
    4220:	036907b3          	mul	a5,s2,s6
    4224:	9381                	srli	a5,a5,0x20
    4226:	41f9571b          	sraiw	a4,s2,0x1f
    422a:	9f99                	subw	a5,a5,a4
    422c:	0017971b          	slliw	a4,a5,0x1
    4230:	9fb9                	addw	a5,a5,a4
    4232:	40f907bb          	subw	a5,s2,a5
    4236:	d9778fe3          	beq	a5,s7,3fd4 <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    423a:	85e2                	mv	a1,s8
    423c:	854e                	mv	a0,s3
    423e:	2fb000ef          	jal	4d38 <open>
      if(fd < 0){
    4242:	fa0558e3          	bgez	a0,41f2 <concreate+0x26e>
    4246:	b3f1                	j	4012 <concreate+0x8e>
}
    4248:	70aa                	ld	ra,168(sp)
    424a:	740a                	ld	s0,160(sp)
    424c:	64ea                	ld	s1,152(sp)
    424e:	694a                	ld	s2,144(sp)
    4250:	69aa                	ld	s3,136(sp)
    4252:	6a0a                	ld	s4,128(sp)
    4254:	7ae6                	ld	s5,120(sp)
    4256:	7b46                	ld	s6,112(sp)
    4258:	7ba6                	ld	s7,104(sp)
    425a:	7c06                	ld	s8,96(sp)
    425c:	6ce6                	ld	s9,88(sp)
    425e:	6d46                	ld	s10,80(sp)
    4260:	614d                	addi	sp,sp,176
    4262:	8082                	ret

0000000000004264 <bigfile>:
{
    4264:	7139                	addi	sp,sp,-64
    4266:	fc06                	sd	ra,56(sp)
    4268:	f822                	sd	s0,48(sp)
    426a:	f426                	sd	s1,40(sp)
    426c:	f04a                	sd	s2,32(sp)
    426e:	ec4e                	sd	s3,24(sp)
    4270:	e852                	sd	s4,16(sp)
    4272:	e456                	sd	s5,8(sp)
    4274:	e05a                	sd	s6,0(sp)
    4276:	0080                	addi	s0,sp,64
    4278:	8b2a                	mv	s6,a0
  unlink("bigfile.dat");
    427a:	00003517          	auipc	a0,0x3
    427e:	d9650513          	addi	a0,a0,-618 # 7010 <malloc+0x1e28>
    4282:	2c7000ef          	jal	4d48 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4286:	20200593          	li	a1,514
    428a:	00003517          	auipc	a0,0x3
    428e:	d8650513          	addi	a0,a0,-634 # 7010 <malloc+0x1e28>
    4292:	2a7000ef          	jal	4d38 <open>
  if(fd < 0){
    4296:	08054a63          	bltz	a0,432a <bigfile+0xc6>
    429a:	8a2a                	mv	s4,a0
    429c:	4481                	li	s1,0
    memset(buf, i, SZ);
    429e:	25800913          	li	s2,600
    42a2:	00009997          	auipc	s3,0x9
    42a6:	9d698993          	addi	s3,s3,-1578 # cc78 <buf>
  for(i = 0; i < N; i++){
    42aa:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    42ac:	864a                	mv	a2,s2
    42ae:	85a6                	mv	a1,s1
    42b0:	854e                	mv	a0,s3
    42b2:	049000ef          	jal	4afa <memset>
    if(write(fd, buf, SZ) != SZ){
    42b6:	864a                	mv	a2,s2
    42b8:	85ce                	mv	a1,s3
    42ba:	8552                	mv	a0,s4
    42bc:	25d000ef          	jal	4d18 <write>
    42c0:	07251f63          	bne	a0,s2,433e <bigfile+0xda>
  for(i = 0; i < N; i++){
    42c4:	2485                	addiw	s1,s1,1
    42c6:	ff5493e3          	bne	s1,s5,42ac <bigfile+0x48>
  close(fd);
    42ca:	8552                	mv	a0,s4
    42cc:	255000ef          	jal	4d20 <close>
  fd = open("bigfile.dat", 0);
    42d0:	4581                	li	a1,0
    42d2:	00003517          	auipc	a0,0x3
    42d6:	d3e50513          	addi	a0,a0,-706 # 7010 <malloc+0x1e28>
    42da:	25f000ef          	jal	4d38 <open>
    42de:	8aaa                	mv	s5,a0
  total = 0;
    42e0:	4a01                	li	s4,0
  for(i = 0; ; i++){
    42e2:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    42e4:	12c00993          	li	s3,300
    42e8:	00009917          	auipc	s2,0x9
    42ec:	99090913          	addi	s2,s2,-1648 # cc78 <buf>
  if(fd < 0){
    42f0:	06054163          	bltz	a0,4352 <bigfile+0xee>
    cc = read(fd, buf, SZ/2);
    42f4:	864e                	mv	a2,s3
    42f6:	85ca                	mv	a1,s2
    42f8:	8556                	mv	a0,s5
    42fa:	217000ef          	jal	4d10 <read>
    if(cc < 0){
    42fe:	06054463          	bltz	a0,4366 <bigfile+0x102>
    if(cc == 0)
    4302:	c145                	beqz	a0,43a2 <bigfile+0x13e>
    if(cc != SZ/2){
    4304:	07351b63          	bne	a0,s3,437a <bigfile+0x116>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4308:	01f4d79b          	srliw	a5,s1,0x1f
    430c:	9fa5                	addw	a5,a5,s1
    430e:	4017d79b          	sraiw	a5,a5,0x1
    4312:	00094703          	lbu	a4,0(s2)
    4316:	06f71c63          	bne	a4,a5,438e <bigfile+0x12a>
    431a:	12b94703          	lbu	a4,299(s2)
    431e:	06f71863          	bne	a4,a5,438e <bigfile+0x12a>
    total += cc;
    4322:	12ca0a1b          	addiw	s4,s4,300
  for(i = 0; ; i++){
    4326:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4328:	b7f1                	j	42f4 <bigfile+0x90>
    printf("%s: cannot create bigfile", s);
    432a:	85da                	mv	a1,s6
    432c:	00003517          	auipc	a0,0x3
    4330:	cf450513          	addi	a0,a0,-780 # 7020 <malloc+0x1e38>
    4334:	5fd000ef          	jal	5130 <printf>
    exit(1);
    4338:	4505                	li	a0,1
    433a:	1bf000ef          	jal	4cf8 <exit>
      printf("%s: write bigfile failed\n", s);
    433e:	85da                	mv	a1,s6
    4340:	00003517          	auipc	a0,0x3
    4344:	d0050513          	addi	a0,a0,-768 # 7040 <malloc+0x1e58>
    4348:	5e9000ef          	jal	5130 <printf>
      exit(1);
    434c:	4505                	li	a0,1
    434e:	1ab000ef          	jal	4cf8 <exit>
    printf("%s: cannot open bigfile\n", s);
    4352:	85da                	mv	a1,s6
    4354:	00003517          	auipc	a0,0x3
    4358:	d0c50513          	addi	a0,a0,-756 # 7060 <malloc+0x1e78>
    435c:	5d5000ef          	jal	5130 <printf>
    exit(1);
    4360:	4505                	li	a0,1
    4362:	197000ef          	jal	4cf8 <exit>
      printf("%s: read bigfile failed\n", s);
    4366:	85da                	mv	a1,s6
    4368:	00003517          	auipc	a0,0x3
    436c:	d1850513          	addi	a0,a0,-744 # 7080 <malloc+0x1e98>
    4370:	5c1000ef          	jal	5130 <printf>
      exit(1);
    4374:	4505                	li	a0,1
    4376:	183000ef          	jal	4cf8 <exit>
      printf("%s: short read bigfile\n", s);
    437a:	85da                	mv	a1,s6
    437c:	00003517          	auipc	a0,0x3
    4380:	d2450513          	addi	a0,a0,-732 # 70a0 <malloc+0x1eb8>
    4384:	5ad000ef          	jal	5130 <printf>
      exit(1);
    4388:	4505                	li	a0,1
    438a:	16f000ef          	jal	4cf8 <exit>
      printf("%s: read bigfile wrong data\n", s);
    438e:	85da                	mv	a1,s6
    4390:	00003517          	auipc	a0,0x3
    4394:	d2850513          	addi	a0,a0,-728 # 70b8 <malloc+0x1ed0>
    4398:	599000ef          	jal	5130 <printf>
      exit(1);
    439c:	4505                	li	a0,1
    439e:	15b000ef          	jal	4cf8 <exit>
  close(fd);
    43a2:	8556                	mv	a0,s5
    43a4:	17d000ef          	jal	4d20 <close>
  if(total != N*SZ){
    43a8:	678d                	lui	a5,0x3
    43aa:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x1c6>
    43ae:	02fa1263          	bne	s4,a5,43d2 <bigfile+0x16e>
  unlink("bigfile.dat");
    43b2:	00003517          	auipc	a0,0x3
    43b6:	c5e50513          	addi	a0,a0,-930 # 7010 <malloc+0x1e28>
    43ba:	18f000ef          	jal	4d48 <unlink>
}
    43be:	70e2                	ld	ra,56(sp)
    43c0:	7442                	ld	s0,48(sp)
    43c2:	74a2                	ld	s1,40(sp)
    43c4:	7902                	ld	s2,32(sp)
    43c6:	69e2                	ld	s3,24(sp)
    43c8:	6a42                	ld	s4,16(sp)
    43ca:	6aa2                	ld	s5,8(sp)
    43cc:	6b02                	ld	s6,0(sp)
    43ce:	6121                	addi	sp,sp,64
    43d0:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    43d2:	85da                	mv	a1,s6
    43d4:	00003517          	auipc	a0,0x3
    43d8:	d0450513          	addi	a0,a0,-764 # 70d8 <malloc+0x1ef0>
    43dc:	555000ef          	jal	5130 <printf>
    exit(1);
    43e0:	4505                	li	a0,1
    43e2:	117000ef          	jal	4cf8 <exit>

00000000000043e6 <bigargtest>:
{
    43e6:	7121                	addi	sp,sp,-448
    43e8:	ff06                	sd	ra,440(sp)
    43ea:	fb22                	sd	s0,432(sp)
    43ec:	f726                	sd	s1,424(sp)
    43ee:	0380                	addi	s0,sp,448
    43f0:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    43f2:	00003517          	auipc	a0,0x3
    43f6:	d0650513          	addi	a0,a0,-762 # 70f8 <malloc+0x1f10>
    43fa:	14f000ef          	jal	4d48 <unlink>
  pid = fork();
    43fe:	0f3000ef          	jal	4cf0 <fork>
  if(pid == 0){
    4402:	c915                	beqz	a0,4436 <bigargtest+0x50>
  } else if(pid < 0){
    4404:	08054c63          	bltz	a0,449c <bigargtest+0xb6>
  wait(&xstatus);
    4408:	fdc40513          	addi	a0,s0,-36
    440c:	0f5000ef          	jal	4d00 <wait>
  if(xstatus != 0)
    4410:	fdc42503          	lw	a0,-36(s0)
    4414:	ed51                	bnez	a0,44b0 <bigargtest+0xca>
  fd = open("bigarg-ok", 0);
    4416:	4581                	li	a1,0
    4418:	00003517          	auipc	a0,0x3
    441c:	ce050513          	addi	a0,a0,-800 # 70f8 <malloc+0x1f10>
    4420:	119000ef          	jal	4d38 <open>
  if(fd < 0){
    4424:	08054863          	bltz	a0,44b4 <bigargtest+0xce>
  close(fd);
    4428:	0f9000ef          	jal	4d20 <close>
}
    442c:	70fa                	ld	ra,440(sp)
    442e:	745a                	ld	s0,432(sp)
    4430:	74ba                	ld	s1,424(sp)
    4432:	6139                	addi	sp,sp,448
    4434:	8082                	ret
    memset(big, ' ', sizeof(big));
    4436:	19000613          	li	a2,400
    443a:	02000593          	li	a1,32
    443e:	e4840513          	addi	a0,s0,-440
    4442:	6b8000ef          	jal	4afa <memset>
    big[sizeof(big)-1] = '\0';
    4446:	fc040ba3          	sb	zero,-41(s0)
    for(i = 0; i < MAXARG-1; i++)
    444a:	00005797          	auipc	a5,0x5
    444e:	01678793          	addi	a5,a5,22 # 9460 <args.1>
    4452:	00005697          	auipc	a3,0x5
    4456:	10668693          	addi	a3,a3,262 # 9558 <args.1+0xf8>
      args[i] = big;
    445a:	e4840713          	addi	a4,s0,-440
    445e:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    4460:	07a1                	addi	a5,a5,8
    4462:	fed79ee3          	bne	a5,a3,445e <bigargtest+0x78>
    args[MAXARG-1] = 0;
    4466:	00005797          	auipc	a5,0x5
    446a:	0e07b923          	sd	zero,242(a5) # 9558 <args.1+0xf8>
    exec("echo", args);
    446e:	00005597          	auipc	a1,0x5
    4472:	ff258593          	addi	a1,a1,-14 # 9460 <args.1>
    4476:	00001517          	auipc	a0,0x1
    447a:	ea250513          	addi	a0,a0,-350 # 5318 <malloc+0x130>
    447e:	0b3000ef          	jal	4d30 <exec>
    fd = open("bigarg-ok", O_CREATE);
    4482:	20000593          	li	a1,512
    4486:	00003517          	auipc	a0,0x3
    448a:	c7250513          	addi	a0,a0,-910 # 70f8 <malloc+0x1f10>
    448e:	0ab000ef          	jal	4d38 <open>
    close(fd);
    4492:	08f000ef          	jal	4d20 <close>
    exit(0);
    4496:	4501                	li	a0,0
    4498:	061000ef          	jal	4cf8 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    449c:	85a6                	mv	a1,s1
    449e:	00003517          	auipc	a0,0x3
    44a2:	c6a50513          	addi	a0,a0,-918 # 7108 <malloc+0x1f20>
    44a6:	48b000ef          	jal	5130 <printf>
    exit(1);
    44aa:	4505                	li	a0,1
    44ac:	04d000ef          	jal	4cf8 <exit>
    exit(xstatus);
    44b0:	049000ef          	jal	4cf8 <exit>
    printf("%s: bigarg test failed!\n", s);
    44b4:	85a6                	mv	a1,s1
    44b6:	00003517          	auipc	a0,0x3
    44ba:	c7250513          	addi	a0,a0,-910 # 7128 <malloc+0x1f40>
    44be:	473000ef          	jal	5130 <printf>
    exit(1);
    44c2:	4505                	li	a0,1
    44c4:	035000ef          	jal	4cf8 <exit>

00000000000044c8 <fsfull>:
{
    44c8:	7171                	addi	sp,sp,-176
    44ca:	f506                	sd	ra,168(sp)
    44cc:	f122                	sd	s0,160(sp)
    44ce:	ed26                	sd	s1,152(sp)
    44d0:	e94a                	sd	s2,144(sp)
    44d2:	e54e                	sd	s3,136(sp)
    44d4:	e152                	sd	s4,128(sp)
    44d6:	fcd6                	sd	s5,120(sp)
    44d8:	f8da                	sd	s6,112(sp)
    44da:	f4de                	sd	s7,104(sp)
    44dc:	f0e2                	sd	s8,96(sp)
    44de:	ece6                	sd	s9,88(sp)
    44e0:	e8ea                	sd	s10,80(sp)
    44e2:	e4ee                	sd	s11,72(sp)
    44e4:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    44e6:	00003517          	auipc	a0,0x3
    44ea:	c6250513          	addi	a0,a0,-926 # 7148 <malloc+0x1f60>
    44ee:	443000ef          	jal	5130 <printf>
  for(nfiles = 0; ; nfiles++){
    44f2:	4481                	li	s1,0
    name[0] = 'f';
    44f4:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    44f8:	10625cb7          	lui	s9,0x10625
    44fc:	dd3c8c93          	addi	s9,s9,-557 # 10624dd3 <base+0x1061515b>
    name[2] = '0' + (nfiles % 1000) / 100;
    4500:	51eb8ab7          	lui	s5,0x51eb8
    4504:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <base+0x51ea88a7>
    name[3] = '0' + (nfiles % 100) / 10;
    4508:	66666a37          	lui	s4,0x66666
    450c:	667a0a13          	addi	s4,s4,1639 # 66666667 <base+0x666569ef>
    printf("writing %s\n", name);
    4510:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    4514:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4518:	039487b3          	mul	a5,s1,s9
    451c:	9799                	srai	a5,a5,0x26
    451e:	41f4d69b          	sraiw	a3,s1,0x1f
    4522:	9f95                	subw	a5,a5,a3
    4524:	0307871b          	addiw	a4,a5,48
    4528:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    452c:	3e800713          	li	a4,1000
    4530:	02f707bb          	mulw	a5,a4,a5
    4534:	40f487bb          	subw	a5,s1,a5
    4538:	03578733          	mul	a4,a5,s5
    453c:	9715                	srai	a4,a4,0x25
    453e:	41f7d79b          	sraiw	a5,a5,0x1f
    4542:	40f707bb          	subw	a5,a4,a5
    4546:	0307879b          	addiw	a5,a5,48
    454a:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    454e:	035487b3          	mul	a5,s1,s5
    4552:	9795                	srai	a5,a5,0x25
    4554:	9f95                	subw	a5,a5,a3
    4556:	06400713          	li	a4,100
    455a:	02f707bb          	mulw	a5,a4,a5
    455e:	40f487bb          	subw	a5,s1,a5
    4562:	03478733          	mul	a4,a5,s4
    4566:	9709                	srai	a4,a4,0x22
    4568:	41f7d79b          	sraiw	a5,a5,0x1f
    456c:	40f707bb          	subw	a5,a4,a5
    4570:	0307879b          	addiw	a5,a5,48
    4574:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4578:	03448733          	mul	a4,s1,s4
    457c:	9709                	srai	a4,a4,0x22
    457e:	9f15                	subw	a4,a4,a3
    4580:	0027179b          	slliw	a5,a4,0x2
    4584:	9fb9                	addw	a5,a5,a4
    4586:	0017979b          	slliw	a5,a5,0x1
    458a:	40f487bb          	subw	a5,s1,a5
    458e:	0307879b          	addiw	a5,a5,48
    4592:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4596:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    459a:	85ea                	mv	a1,s10
    459c:	00003517          	auipc	a0,0x3
    45a0:	bbc50513          	addi	a0,a0,-1092 # 7158 <malloc+0x1f70>
    45a4:	38d000ef          	jal	5130 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    45a8:	20200593          	li	a1,514
    45ac:	856a                	mv	a0,s10
    45ae:	78a000ef          	jal	4d38 <open>
    45b2:	892a                	mv	s2,a0
    if(fd < 0){
    45b4:	0e055b63          	bgez	a0,46aa <fsfull+0x1e2>
      printf("open %s failed\n", name);
    45b8:	f5040593          	addi	a1,s0,-176
    45bc:	00003517          	auipc	a0,0x3
    45c0:	bac50513          	addi	a0,a0,-1108 # 7168 <malloc+0x1f80>
    45c4:	36d000ef          	jal	5130 <printf>
  while(nfiles >= 0){
    45c8:	0a04cc63          	bltz	s1,4680 <fsfull+0x1b8>
    name[0] = 'f';
    45cc:	06600c13          	li	s8,102
    name[1] = '0' + nfiles / 1000;
    45d0:	10625a37          	lui	s4,0x10625
    45d4:	dd3a0a13          	addi	s4,s4,-557 # 10624dd3 <base+0x1061515b>
    name[2] = '0' + (nfiles % 1000) / 100;
    45d8:	3e800b93          	li	s7,1000
    45dc:	51eb89b7          	lui	s3,0x51eb8
    45e0:	51f98993          	addi	s3,s3,1311 # 51eb851f <base+0x51ea88a7>
    name[3] = '0' + (nfiles % 100) / 10;
    45e4:	06400b13          	li	s6,100
    45e8:	66666937          	lui	s2,0x66666
    45ec:	66790913          	addi	s2,s2,1639 # 66666667 <base+0x666569ef>
    unlink(name);
    45f0:	f5040a93          	addi	s5,s0,-176
    name[0] = 'f';
    45f4:	f5840823          	sb	s8,-176(s0)
    name[1] = '0' + nfiles / 1000;
    45f8:	034487b3          	mul	a5,s1,s4
    45fc:	9799                	srai	a5,a5,0x26
    45fe:	41f4d69b          	sraiw	a3,s1,0x1f
    4602:	9f95                	subw	a5,a5,a3
    4604:	0307871b          	addiw	a4,a5,48
    4608:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    460c:	02fb87bb          	mulw	a5,s7,a5
    4610:	40f487bb          	subw	a5,s1,a5
    4614:	03378733          	mul	a4,a5,s3
    4618:	9715                	srai	a4,a4,0x25
    461a:	41f7d79b          	sraiw	a5,a5,0x1f
    461e:	40f707bb          	subw	a5,a4,a5
    4622:	0307879b          	addiw	a5,a5,48
    4626:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    462a:	033487b3          	mul	a5,s1,s3
    462e:	9795                	srai	a5,a5,0x25
    4630:	9f95                	subw	a5,a5,a3
    4632:	02fb07bb          	mulw	a5,s6,a5
    4636:	40f487bb          	subw	a5,s1,a5
    463a:	03278733          	mul	a4,a5,s2
    463e:	9709                	srai	a4,a4,0x22
    4640:	41f7d79b          	sraiw	a5,a5,0x1f
    4644:	40f707bb          	subw	a5,a4,a5
    4648:	0307879b          	addiw	a5,a5,48
    464c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4650:	03248733          	mul	a4,s1,s2
    4654:	9709                	srai	a4,a4,0x22
    4656:	9f15                	subw	a4,a4,a3
    4658:	0027179b          	slliw	a5,a4,0x2
    465c:	9fb9                	addw	a5,a5,a4
    465e:	0017979b          	slliw	a5,a5,0x1
    4662:	40f487bb          	subw	a5,s1,a5
    4666:	0307879b          	addiw	a5,a5,48
    466a:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    466e:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    4672:	8556                	mv	a0,s5
    4674:	6d4000ef          	jal	4d48 <unlink>
    nfiles--;
    4678:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    467a:	57fd                	li	a5,-1
    467c:	f6f49ce3          	bne	s1,a5,45f4 <fsfull+0x12c>
  printf("fsfull test finished\n");
    4680:	00003517          	auipc	a0,0x3
    4684:	b0850513          	addi	a0,a0,-1272 # 7188 <malloc+0x1fa0>
    4688:	2a9000ef          	jal	5130 <printf>
}
    468c:	70aa                	ld	ra,168(sp)
    468e:	740a                	ld	s0,160(sp)
    4690:	64ea                	ld	s1,152(sp)
    4692:	694a                	ld	s2,144(sp)
    4694:	69aa                	ld	s3,136(sp)
    4696:	6a0a                	ld	s4,128(sp)
    4698:	7ae6                	ld	s5,120(sp)
    469a:	7b46                	ld	s6,112(sp)
    469c:	7ba6                	ld	s7,104(sp)
    469e:	7c06                	ld	s8,96(sp)
    46a0:	6ce6                	ld	s9,88(sp)
    46a2:	6d46                	ld	s10,80(sp)
    46a4:	6da6                	ld	s11,72(sp)
    46a6:	614d                	addi	sp,sp,176
    46a8:	8082                	ret
    int total = 0;
    46aa:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    46ac:	40000c13          	li	s8,1024
    46b0:	00008b97          	auipc	s7,0x8
    46b4:	5c8b8b93          	addi	s7,s7,1480 # cc78 <buf>
      if(cc < BSIZE)
    46b8:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    46bc:	8662                	mv	a2,s8
    46be:	85de                	mv	a1,s7
    46c0:	854a                	mv	a0,s2
    46c2:	656000ef          	jal	4d18 <write>
      if(cc < BSIZE)
    46c6:	00ab5563          	bge	s6,a0,46d0 <fsfull+0x208>
      total += cc;
    46ca:	00a989bb          	addw	s3,s3,a0
    while(1){
    46ce:	b7fd                	j	46bc <fsfull+0x1f4>
    printf("wrote %d bytes\n", total);
    46d0:	85ce                	mv	a1,s3
    46d2:	00003517          	auipc	a0,0x3
    46d6:	aa650513          	addi	a0,a0,-1370 # 7178 <malloc+0x1f90>
    46da:	257000ef          	jal	5130 <printf>
    close(fd);
    46de:	854a                	mv	a0,s2
    46e0:	640000ef          	jal	4d20 <close>
    if(total == 0)
    46e4:	ee0982e3          	beqz	s3,45c8 <fsfull+0x100>
  for(nfiles = 0; ; nfiles++){
    46e8:	2485                	addiw	s1,s1,1
    46ea:	b52d                	j	4514 <fsfull+0x4c>

00000000000046ec <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    46ec:	7179                	addi	sp,sp,-48
    46ee:	f406                	sd	ra,40(sp)
    46f0:	f022                	sd	s0,32(sp)
    46f2:	ec26                	sd	s1,24(sp)
    46f4:	e84a                	sd	s2,16(sp)
    46f6:	1800                	addi	s0,sp,48
    46f8:	84aa                	mv	s1,a0
    46fa:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    46fc:	00003517          	auipc	a0,0x3
    4700:	aa450513          	addi	a0,a0,-1372 # 71a0 <malloc+0x1fb8>
    4704:	22d000ef          	jal	5130 <printf>
  if((pid = fork()) < 0) {
    4708:	5e8000ef          	jal	4cf0 <fork>
    470c:	02054a63          	bltz	a0,4740 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    4710:	c129                	beqz	a0,4752 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4712:	fdc40513          	addi	a0,s0,-36
    4716:	5ea000ef          	jal	4d00 <wait>
    if(xstatus != 0) 
    471a:	fdc42783          	lw	a5,-36(s0)
    471e:	cf9d                	beqz	a5,475c <run+0x70>
      printf("FAILED\n");
    4720:	00003517          	auipc	a0,0x3
    4724:	aa850513          	addi	a0,a0,-1368 # 71c8 <malloc+0x1fe0>
    4728:	209000ef          	jal	5130 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    472c:	fdc42503          	lw	a0,-36(s0)
  }
}
    4730:	00153513          	seqz	a0,a0
    4734:	70a2                	ld	ra,40(sp)
    4736:	7402                	ld	s0,32(sp)
    4738:	64e2                	ld	s1,24(sp)
    473a:	6942                	ld	s2,16(sp)
    473c:	6145                	addi	sp,sp,48
    473e:	8082                	ret
    printf("runtest: fork error\n");
    4740:	00003517          	auipc	a0,0x3
    4744:	a7050513          	addi	a0,a0,-1424 # 71b0 <malloc+0x1fc8>
    4748:	1e9000ef          	jal	5130 <printf>
    exit(1);
    474c:	4505                	li	a0,1
    474e:	5aa000ef          	jal	4cf8 <exit>
    f(s);
    4752:	854a                	mv	a0,s2
    4754:	9482                	jalr	s1
    exit(0);
    4756:	4501                	li	a0,0
    4758:	5a0000ef          	jal	4cf8 <exit>
      printf("OK\n");
    475c:	00003517          	auipc	a0,0x3
    4760:	a7450513          	addi	a0,a0,-1420 # 71d0 <malloc+0x1fe8>
    4764:	1cd000ef          	jal	5130 <printf>
    4768:	b7d1                	j	472c <run+0x40>

000000000000476a <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    476a:	7179                	addi	sp,sp,-48
    476c:	f406                	sd	ra,40(sp)
    476e:	f022                	sd	s0,32(sp)
    4770:	e84a                	sd	s2,16(sp)
    4772:	1800                	addi	s0,sp,48
  for (struct test *t = tests; t->s != 0; t++) {
    4774:	00853903          	ld	s2,8(a0)
    4778:	06090263          	beqz	s2,47dc <runtests+0x72>
    477c:	ec26                	sd	s1,24(sp)
    477e:	e44e                	sd	s3,8(sp)
    4780:	e052                	sd	s4,0(sp)
    4782:	84aa                	mv	s1,a0
    4784:	89ae                	mv	s3,a1
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s)){
        if(continuous != 2){
    4786:	1679                	addi	a2,a2,-2 # 2ffe <subdir+0x2e4>
    4788:	00c03a33          	snez	s4,a2
    478c:	a031                	j	4798 <runtests+0x2e>
  for (struct test *t = tests; t->s != 0; t++) {
    478e:	04c1                	addi	s1,s1,16
    4790:	0084b903          	ld	s2,8(s1)
    4794:	02090b63          	beqz	s2,47ca <runtests+0x60>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    4798:	00098763          	beqz	s3,47a6 <runtests+0x3c>
    479c:	85ce                	mv	a1,s3
    479e:	854a                	mv	a0,s2
    47a0:	2fe000ef          	jal	4a9e <strcmp>
    47a4:	f56d                	bnez	a0,478e <runtests+0x24>
      if(!run(t->f, t->s)){
    47a6:	85ca                	mv	a1,s2
    47a8:	6088                	ld	a0,0(s1)
    47aa:	f43ff0ef          	jal	46ec <run>
        if(continuous != 2){
    47ae:	f165                	bnez	a0,478e <runtests+0x24>
    47b0:	fc0a0fe3          	beqz	s4,478e <runtests+0x24>
          printf("SOME TESTS FAILED\n");
    47b4:	00003517          	auipc	a0,0x3
    47b8:	a2450513          	addi	a0,a0,-1500 # 71d8 <malloc+0x1ff0>
    47bc:	175000ef          	jal	5130 <printf>
          return 1;
    47c0:	4505                	li	a0,1
    47c2:	64e2                	ld	s1,24(sp)
    47c4:	69a2                	ld	s3,8(sp)
    47c6:	6a02                	ld	s4,0(sp)
    47c8:	a029                	j	47d2 <runtests+0x68>
        }
      }
    }
  }
  return 0;
    47ca:	4501                	li	a0,0
    47cc:	64e2                	ld	s1,24(sp)
    47ce:	69a2                	ld	s3,8(sp)
    47d0:	6a02                	ld	s4,0(sp)
}
    47d2:	70a2                	ld	ra,40(sp)
    47d4:	7402                	ld	s0,32(sp)
    47d6:	6942                	ld	s2,16(sp)
    47d8:	6145                	addi	sp,sp,48
    47da:	8082                	ret
  return 0;
    47dc:	4501                	li	a0,0
    47de:	bfd5                	j	47d2 <runtests+0x68>

00000000000047e0 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    47e0:	7139                	addi	sp,sp,-64
    47e2:	fc06                	sd	ra,56(sp)
    47e4:	f822                	sd	s0,48(sp)
    47e6:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    47e8:	fc840513          	addi	a0,s0,-56
    47ec:	51c000ef          	jal	4d08 <pipe>
    47f0:	04054f63          	bltz	a0,484e <countfree+0x6e>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    47f4:	4fc000ef          	jal	4cf0 <fork>

  if(pid < 0){
    47f8:	06054863          	bltz	a0,4868 <countfree+0x88>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    47fc:	e551                	bnez	a0,4888 <countfree+0xa8>
    47fe:	f426                	sd	s1,40(sp)
    4800:	f04a                	sd	s2,32(sp)
    4802:	ec4e                	sd	s3,24(sp)
    4804:	e852                	sd	s4,16(sp)
    close(fds[0]);
    4806:	fc842503          	lw	a0,-56(s0)
    480a:	516000ef          	jal	4d20 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
    480e:	6905                	lui	s2,0x1
      if(a == 0xffffffffffffffff){
    4810:	59fd                	li	s3,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    4812:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    4814:	00001a17          	auipc	s4,0x1
    4818:	b74a0a13          	addi	s4,s4,-1164 # 5388 <malloc+0x1a0>
      uint64 a = (uint64) sbrk(4096);
    481c:	854a                	mv	a0,s2
    481e:	562000ef          	jal	4d80 <sbrk>
      if(a == 0xffffffffffffffff){
    4822:	07350063          	beq	a0,s3,4882 <countfree+0xa2>
      *(char *)(a + 4096 - 1) = 1;
    4826:	954a                	add	a0,a0,s2
    4828:	fe950fa3          	sb	s1,-1(a0)
      if(write(fds[1], "x", 1) != 1){
    482c:	8626                	mv	a2,s1
    482e:	85d2                	mv	a1,s4
    4830:	fcc42503          	lw	a0,-52(s0)
    4834:	4e4000ef          	jal	4d18 <write>
    4838:	fe9502e3          	beq	a0,s1,481c <countfree+0x3c>
        printf("write() failed in countfree()\n");
    483c:	00003517          	auipc	a0,0x3
    4840:	9f450513          	addi	a0,a0,-1548 # 7230 <malloc+0x2048>
    4844:	0ed000ef          	jal	5130 <printf>
        exit(1);
    4848:	4505                	li	a0,1
    484a:	4ae000ef          	jal	4cf8 <exit>
    484e:	f426                	sd	s1,40(sp)
    4850:	f04a                	sd	s2,32(sp)
    4852:	ec4e                	sd	s3,24(sp)
    4854:	e852                	sd	s4,16(sp)
    printf("pipe() failed in countfree()\n");
    4856:	00003517          	auipc	a0,0x3
    485a:	99a50513          	addi	a0,a0,-1638 # 71f0 <malloc+0x2008>
    485e:	0d3000ef          	jal	5130 <printf>
    exit(1);
    4862:	4505                	li	a0,1
    4864:	494000ef          	jal	4cf8 <exit>
    4868:	f426                	sd	s1,40(sp)
    486a:	f04a                	sd	s2,32(sp)
    486c:	ec4e                	sd	s3,24(sp)
    486e:	e852                	sd	s4,16(sp)
    printf("fork failed in countfree()\n");
    4870:	00003517          	auipc	a0,0x3
    4874:	9a050513          	addi	a0,a0,-1632 # 7210 <malloc+0x2028>
    4878:	0b9000ef          	jal	5130 <printf>
    exit(1);
    487c:	4505                	li	a0,1
    487e:	47a000ef          	jal	4cf8 <exit>
      }
    }

    exit(0);
    4882:	4501                	li	a0,0
    4884:	474000ef          	jal	4cf8 <exit>
    4888:	f426                	sd	s1,40(sp)
    488a:	f04a                	sd	s2,32(sp)
    488c:	ec4e                	sd	s3,24(sp)
  }

  close(fds[1]);
    488e:	fcc42503          	lw	a0,-52(s0)
    4892:	48e000ef          	jal	4d20 <close>

  int n = 0;
    4896:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    4898:	fc740993          	addi	s3,s0,-57
    489c:	4905                	li	s2,1
    489e:	864a                	mv	a2,s2
    48a0:	85ce                	mv	a1,s3
    48a2:	fc842503          	lw	a0,-56(s0)
    48a6:	46a000ef          	jal	4d10 <read>
    if(cc < 0){
    48aa:	00054563          	bltz	a0,48b4 <countfree+0xd4>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    48ae:	cd09                	beqz	a0,48c8 <countfree+0xe8>
      break;
    n += 1;
    48b0:	2485                	addiw	s1,s1,1
  while(1){
    48b2:	b7f5                	j	489e <countfree+0xbe>
    48b4:	e852                	sd	s4,16(sp)
      printf("read() failed in countfree()\n");
    48b6:	00003517          	auipc	a0,0x3
    48ba:	99a50513          	addi	a0,a0,-1638 # 7250 <malloc+0x2068>
    48be:	073000ef          	jal	5130 <printf>
      exit(1);
    48c2:	4505                	li	a0,1
    48c4:	434000ef          	jal	4cf8 <exit>
  }

  close(fds[0]);
    48c8:	fc842503          	lw	a0,-56(s0)
    48cc:	454000ef          	jal	4d20 <close>
  wait((int*)0);
    48d0:	4501                	li	a0,0
    48d2:	42e000ef          	jal	4d00 <wait>
  
  return n;
}
    48d6:	8526                	mv	a0,s1
    48d8:	74a2                	ld	s1,40(sp)
    48da:	7902                	ld	s2,32(sp)
    48dc:	69e2                	ld	s3,24(sp)
    48de:	70e2                	ld	ra,56(sp)
    48e0:	7442                	ld	s0,48(sp)
    48e2:	6121                	addi	sp,sp,64
    48e4:	8082                	ret

00000000000048e6 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    48e6:	7159                	addi	sp,sp,-112
    48e8:	f486                	sd	ra,104(sp)
    48ea:	f0a2                	sd	s0,96(sp)
    48ec:	eca6                	sd	s1,88(sp)
    48ee:	e8ca                	sd	s2,80(sp)
    48f0:	e4ce                	sd	s3,72(sp)
    48f2:	e0d2                	sd	s4,64(sp)
    48f4:	fc56                	sd	s5,56(sp)
    48f6:	f85a                	sd	s6,48(sp)
    48f8:	f45e                	sd	s7,40(sp)
    48fa:	f062                	sd	s8,32(sp)
    48fc:	ec66                	sd	s9,24(sp)
    48fe:	e86a                	sd	s10,16(sp)
    4900:	e46e                	sd	s11,8(sp)
    4902:	1880                	addi	s0,sp,112
    4904:	8a2a                	mv	s4,a0
    4906:	892e                	mv	s2,a1
    4908:	89b2                	mv	s3,a2
  do {
    printf("usertests starting\n");
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone, continuous)) {
      if(continuous != 2) {
    490a:	ffe58b93          	addi	s7,a1,-2
    490e:	01703bb3          	snez	s7,s7
    printf("usertests starting\n");
    4912:	00003b17          	auipc	s6,0x3
    4916:	95eb0b13          	addi	s6,s6,-1698 # 7270 <malloc+0x2088>
    if (runtests(quicktests, justone, continuous)) {
    491a:	00004a97          	auipc	s5,0x4
    491e:	6f6a8a93          	addi	s5,s5,1782 # 9010 <quicktests>
      }
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      if (runtests(slowtests, justone, continuous)) {
    4922:	00005c17          	auipc	s8,0x5
    4926:	abec0c13          	addi	s8,s8,-1346 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    492a:	00003d97          	auipc	s11,0x3
    492e:	95ed8d93          	addi	s11,s11,-1698 # 7288 <malloc+0x20a0>
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4932:	00003d17          	auipc	s10,0x3
    4936:	976d0d13          	addi	s10,s10,-1674 # 72a8 <malloc+0x20c0>
      if(continuous != 2) {
    493a:	4c89                	li	s9,2
    493c:	a819                	j	4952 <drivetests+0x6c>
        printf("usertests slow tests starting\n");
    493e:	856e                	mv	a0,s11
    4940:	7f0000ef          	jal	5130 <printf>
    4944:	a80d                	j	4976 <drivetests+0x90>
    if((free1 = countfree()) < free0) {
    4946:	e9bff0ef          	jal	47e0 <countfree>
    494a:	04954063          	blt	a0,s1,498a <drivetests+0xa4>
        return 1;
      }
    }
  } while(continuous);
    494e:	04090963          	beqz	s2,49a0 <drivetests+0xba>
    printf("usertests starting\n");
    4952:	855a                	mv	a0,s6
    4954:	7dc000ef          	jal	5130 <printf>
    int free0 = countfree();
    4958:	e89ff0ef          	jal	47e0 <countfree>
    495c:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone, continuous)) {
    495e:	864a                	mv	a2,s2
    4960:	85ce                	mv	a1,s3
    4962:	8556                	mv	a0,s5
    4964:	e07ff0ef          	jal	476a <runtests>
      if(continuous != 2) {
    4968:	c119                	beqz	a0,496e <drivetests+0x88>
    496a:	020b9963          	bnez	s7,499c <drivetests+0xb6>
    if(!quick) {
    496e:	fc0a1ce3          	bnez	s4,4946 <drivetests+0x60>
      if (justone == 0)
    4972:	fc0986e3          	beqz	s3,493e <drivetests+0x58>
      if (runtests(slowtests, justone, continuous)) {
    4976:	864a                	mv	a2,s2
    4978:	85ce                	mv	a1,s3
    497a:	8562                	mv	a0,s8
    497c:	defff0ef          	jal	476a <runtests>
        if(continuous != 2) {
    4980:	d179                	beqz	a0,4946 <drivetests+0x60>
    4982:	fc0b82e3          	beqz	s7,4946 <drivetests+0x60>
          return 1;
    4986:	4505                	li	a0,1
    4988:	a829                	j	49a2 <drivetests+0xbc>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    498a:	8626                	mv	a2,s1
    498c:	85aa                	mv	a1,a0
    498e:	856a                	mv	a0,s10
    4990:	7a0000ef          	jal	5130 <printf>
      if(continuous != 2) {
    4994:	fb990fe3          	beq	s2,s9,4952 <drivetests+0x6c>
        return 1;
    4998:	4505                	li	a0,1
    499a:	a021                	j	49a2 <drivetests+0xbc>
        return 1;
    499c:	4505                	li	a0,1
    499e:	a011                	j	49a2 <drivetests+0xbc>
  return 0;
    49a0:	854a                	mv	a0,s2
}
    49a2:	70a6                	ld	ra,104(sp)
    49a4:	7406                	ld	s0,96(sp)
    49a6:	64e6                	ld	s1,88(sp)
    49a8:	6946                	ld	s2,80(sp)
    49aa:	69a6                	ld	s3,72(sp)
    49ac:	6a06                	ld	s4,64(sp)
    49ae:	7ae2                	ld	s5,56(sp)
    49b0:	7b42                	ld	s6,48(sp)
    49b2:	7ba2                	ld	s7,40(sp)
    49b4:	7c02                	ld	s8,32(sp)
    49b6:	6ce2                	ld	s9,24(sp)
    49b8:	6d42                	ld	s10,16(sp)
    49ba:	6da2                	ld	s11,8(sp)
    49bc:	6165                	addi	sp,sp,112
    49be:	8082                	ret

00000000000049c0 <main>:

int
main(int argc, char *argv[])
{
    49c0:	1101                	addi	sp,sp,-32
    49c2:	ec06                	sd	ra,24(sp)
    49c4:	e822                	sd	s0,16(sp)
    49c6:	e426                	sd	s1,8(sp)
    49c8:	e04a                	sd	s2,0(sp)
    49ca:	1000                	addi	s0,sp,32
    49cc:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    49ce:	4789                	li	a5,2
    49d0:	00f50f63          	beq	a0,a5,49ee <main+0x2e>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    49d4:	4785                	li	a5,1
    49d6:	06a7c063          	blt	a5,a0,4a36 <main+0x76>
  char *justone = 0;
    49da:	4901                	li	s2,0
  int quick = 0;
    49dc:	4501                	li	a0,0
  int continuous = 0;
    49de:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    49e0:	864a                	mv	a2,s2
    49e2:	f05ff0ef          	jal	48e6 <drivetests>
    49e6:	c935                	beqz	a0,4a5a <main+0x9a>
    exit(1);
    49e8:	4505                	li	a0,1
    49ea:	30e000ef          	jal	4cf8 <exit>
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    49ee:	0085b903          	ld	s2,8(a1)
    49f2:	00003597          	auipc	a1,0x3
    49f6:	8e658593          	addi	a1,a1,-1818 # 72d8 <malloc+0x20f0>
    49fa:	854a                	mv	a0,s2
    49fc:	0a2000ef          	jal	4a9e <strcmp>
    4a00:	85aa                	mv	a1,a0
    4a02:	c139                	beqz	a0,4a48 <main+0x88>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    4a04:	00003597          	auipc	a1,0x3
    4a08:	8dc58593          	addi	a1,a1,-1828 # 72e0 <malloc+0x20f8>
    4a0c:	854a                	mv	a0,s2
    4a0e:	090000ef          	jal	4a9e <strcmp>
    4a12:	cd15                	beqz	a0,4a4e <main+0x8e>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    4a14:	00003597          	auipc	a1,0x3
    4a18:	8d458593          	addi	a1,a1,-1836 # 72e8 <malloc+0x2100>
    4a1c:	854a                	mv	a0,s2
    4a1e:	080000ef          	jal	4a9e <strcmp>
    4a22:	c90d                	beqz	a0,4a54 <main+0x94>
  } else if(argc == 2 && argv[1][0] != '-'){
    4a24:	00094703          	lbu	a4,0(s2) # 1000 <bigdir+0x10c>
    4a28:	02d00793          	li	a5,45
    4a2c:	00f70563          	beq	a4,a5,4a36 <main+0x76>
  int quick = 0;
    4a30:	4501                	li	a0,0
  int continuous = 0;
    4a32:	4581                	li	a1,0
    4a34:	b775                	j	49e0 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    4a36:	00003517          	auipc	a0,0x3
    4a3a:	8ba50513          	addi	a0,a0,-1862 # 72f0 <malloc+0x2108>
    4a3e:	6f2000ef          	jal	5130 <printf>
    exit(1);
    4a42:	4505                	li	a0,1
    4a44:	2b4000ef          	jal	4cf8 <exit>
  char *justone = 0;
    4a48:	4901                	li	s2,0
    quick = 1;
    4a4a:	4505                	li	a0,1
    4a4c:	bf51                	j	49e0 <main+0x20>
  char *justone = 0;
    4a4e:	4901                	li	s2,0
    continuous = 1;
    4a50:	4585                	li	a1,1
    4a52:	b779                	j	49e0 <main+0x20>
    continuous = 2;
    4a54:	85a6                	mv	a1,s1
  char *justone = 0;
    4a56:	4901                	li	s2,0
    4a58:	b761                	j	49e0 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4a5a:	00003517          	auipc	a0,0x3
    4a5e:	8c650513          	addi	a0,a0,-1850 # 7320 <malloc+0x2138>
    4a62:	6ce000ef          	jal	5130 <printf>
  exit(0);
    4a66:	4501                	li	a0,0
    4a68:	290000ef          	jal	4cf8 <exit>

0000000000004a6c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
    4a6c:	1141                	addi	sp,sp,-16
    4a6e:	e406                	sd	ra,8(sp)
    4a70:	e022                	sd	s0,0(sp)
    4a72:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
    4a74:	f4dff0ef          	jal	49c0 <main>
  exit (0);
    4a78:	4501                	li	a0,0
    4a7a:	27e000ef          	jal	4cf8 <exit>

0000000000004a7e <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
    4a7e:	1141                	addi	sp,sp,-16
    4a80:	e406                	sd	ra,8(sp)
    4a82:	e022                	sd	s0,0(sp)
    4a84:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    4a86:	87aa                	mv	a5,a0
    4a88:	0585                	addi	a1,a1,1
    4a8a:	0785                	addi	a5,a5,1
    4a8c:	fff5c703          	lbu	a4,-1(a1)
    4a90:	fee78fa3          	sb	a4,-1(a5)
    4a94:	fb75                	bnez	a4,4a88 <strcpy+0xa>
    ;
  return os;
}
    4a96:	60a2                	ld	ra,8(sp)
    4a98:	6402                	ld	s0,0(sp)
    4a9a:	0141                	addi	sp,sp,16
    4a9c:	8082                	ret

0000000000004a9e <strcmp>:

int
strcmp (const char *p, const char *q)
{
    4a9e:	1141                	addi	sp,sp,-16
    4aa0:	e406                	sd	ra,8(sp)
    4aa2:	e022                	sd	s0,0(sp)
    4aa4:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    4aa6:	00054783          	lbu	a5,0(a0)
    4aaa:	cb91                	beqz	a5,4abe <strcmp+0x20>
    4aac:	0005c703          	lbu	a4,0(a1)
    4ab0:	00f71763          	bne	a4,a5,4abe <strcmp+0x20>
    p++, q++;
    4ab4:	0505                	addi	a0,a0,1
    4ab6:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    4ab8:	00054783          	lbu	a5,0(a0)
    4abc:	fbe5                	bnez	a5,4aac <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    4abe:	0005c503          	lbu	a0,0(a1)
}
    4ac2:	40a7853b          	subw	a0,a5,a0
    4ac6:	60a2                	ld	ra,8(sp)
    4ac8:	6402                	ld	s0,0(sp)
    4aca:	0141                	addi	sp,sp,16
    4acc:	8082                	ret

0000000000004ace <strlen>:

uint
strlen (const char *s)
{
    4ace:	1141                	addi	sp,sp,-16
    4ad0:	e406                	sd	ra,8(sp)
    4ad2:	e022                	sd	s0,0(sp)
    4ad4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    4ad6:	00054783          	lbu	a5,0(a0)
    4ada:	cf91                	beqz	a5,4af6 <strlen+0x28>
    4adc:	00150793          	addi	a5,a0,1
    4ae0:	86be                	mv	a3,a5
    4ae2:	0785                	addi	a5,a5,1
    4ae4:	fff7c703          	lbu	a4,-1(a5)
    4ae8:	ff65                	bnez	a4,4ae0 <strlen+0x12>
    4aea:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    4aee:	60a2                	ld	ra,8(sp)
    4af0:	6402                	ld	s0,0(sp)
    4af2:	0141                	addi	sp,sp,16
    4af4:	8082                	ret
  for (n = 0; s[n]; n++)
    4af6:	4501                	li	a0,0
    4af8:	bfdd                	j	4aee <strlen+0x20>

0000000000004afa <memset>:

void *
memset (void *dst, int c, uint n)
{
    4afa:	1141                	addi	sp,sp,-16
    4afc:	e406                	sd	ra,8(sp)
    4afe:	e022                	sd	s0,0(sp)
    4b00:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
    4b02:	ca19                	beqz	a2,4b18 <memset+0x1e>
    4b04:	87aa                	mv	a5,a0
    4b06:	1602                	slli	a2,a2,0x20
    4b08:	9201                	srli	a2,a2,0x20
    4b0a:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
    4b0e:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
    4b12:	0785                	addi	a5,a5,1
    4b14:	fee79de3          	bne	a5,a4,4b0e <memset+0x14>
    }
  return dst;
}
    4b18:	60a2                	ld	ra,8(sp)
    4b1a:	6402                	ld	s0,0(sp)
    4b1c:	0141                	addi	sp,sp,16
    4b1e:	8082                	ret

0000000000004b20 <strchr>:

char *
strchr (const char *s, char c)
{
    4b20:	1141                	addi	sp,sp,-16
    4b22:	e406                	sd	ra,8(sp)
    4b24:	e022                	sd	s0,0(sp)
    4b26:	0800                	addi	s0,sp,16
  for (; *s; s++)
    4b28:	00054783          	lbu	a5,0(a0)
    4b2c:	cf81                	beqz	a5,4b44 <strchr+0x24>
    if (*s == c)
    4b2e:	00f58763          	beq	a1,a5,4b3c <strchr+0x1c>
  for (; *s; s++)
    4b32:	0505                	addi	a0,a0,1
    4b34:	00054783          	lbu	a5,0(a0)
    4b38:	fbfd                	bnez	a5,4b2e <strchr+0xe>
      return (char *)s;
  return 0;
    4b3a:	4501                	li	a0,0
}
    4b3c:	60a2                	ld	ra,8(sp)
    4b3e:	6402                	ld	s0,0(sp)
    4b40:	0141                	addi	sp,sp,16
    4b42:	8082                	ret
  return 0;
    4b44:	4501                	li	a0,0
    4b46:	bfdd                	j	4b3c <strchr+0x1c>

0000000000004b48 <gets>:

char *
gets (char *buf, int max)
{
    4b48:	711d                	addi	sp,sp,-96
    4b4a:	ec86                	sd	ra,88(sp)
    4b4c:	e8a2                	sd	s0,80(sp)
    4b4e:	e4a6                	sd	s1,72(sp)
    4b50:	e0ca                	sd	s2,64(sp)
    4b52:	fc4e                	sd	s3,56(sp)
    4b54:	f852                	sd	s4,48(sp)
    4b56:	f456                	sd	s5,40(sp)
    4b58:	f05a                	sd	s6,32(sp)
    4b5a:	ec5e                	sd	s7,24(sp)
    4b5c:	e862                	sd	s8,16(sp)
    4b5e:	1080                	addi	s0,sp,96
    4b60:	8baa                	mv	s7,a0
    4b62:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
    4b64:	892a                	mv	s2,a0
    4b66:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
    4b68:	faf40b13          	addi	s6,s0,-81
    4b6c:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
    4b6e:	8c26                	mv	s8,s1
    4b70:	0014899b          	addiw	s3,s1,1
    4b74:	84ce                	mv	s1,s3
    4b76:	0349d463          	bge	s3,s4,4b9e <gets+0x56>
      cc = read (0, &c, 1);
    4b7a:	8656                	mv	a2,s5
    4b7c:	85da                	mv	a1,s6
    4b7e:	4501                	li	a0,0
    4b80:	190000ef          	jal	4d10 <read>
      if (cc < 1)
    4b84:	00a05d63          	blez	a0,4b9e <gets+0x56>
        break;
      buf[i++] = c;
    4b88:	faf44783          	lbu	a5,-81(s0)
    4b8c:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
    4b90:	0905                	addi	s2,s2,1
    4b92:	ff678713          	addi	a4,a5,-10
    4b96:	c319                	beqz	a4,4b9c <gets+0x54>
    4b98:	17cd                	addi	a5,a5,-13
    4b9a:	fbf1                	bnez	a5,4b6e <gets+0x26>
      buf[i++] = c;
    4b9c:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
    4b9e:	9c5e                	add	s8,s8,s7
    4ba0:	000c0023          	sb	zero,0(s8)
  return buf;
}
    4ba4:	855e                	mv	a0,s7
    4ba6:	60e6                	ld	ra,88(sp)
    4ba8:	6446                	ld	s0,80(sp)
    4baa:	64a6                	ld	s1,72(sp)
    4bac:	6906                	ld	s2,64(sp)
    4bae:	79e2                	ld	s3,56(sp)
    4bb0:	7a42                	ld	s4,48(sp)
    4bb2:	7aa2                	ld	s5,40(sp)
    4bb4:	7b02                	ld	s6,32(sp)
    4bb6:	6be2                	ld	s7,24(sp)
    4bb8:	6c42                	ld	s8,16(sp)
    4bba:	6125                	addi	sp,sp,96
    4bbc:	8082                	ret

0000000000004bbe <stat>:

int
stat (const char *n, struct stat *st)
{
    4bbe:	1101                	addi	sp,sp,-32
    4bc0:	ec06                	sd	ra,24(sp)
    4bc2:	e822                	sd	s0,16(sp)
    4bc4:	e04a                	sd	s2,0(sp)
    4bc6:	1000                	addi	s0,sp,32
    4bc8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
    4bca:	4581                	li	a1,0
    4bcc:	16c000ef          	jal	4d38 <open>
  if (fd < 0)
    4bd0:	02054263          	bltz	a0,4bf4 <stat+0x36>
    4bd4:	e426                	sd	s1,8(sp)
    4bd6:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
    4bd8:	85ca                	mv	a1,s2
    4bda:	176000ef          	jal	4d50 <fstat>
    4bde:	892a                	mv	s2,a0
  close (fd);
    4be0:	8526                	mv	a0,s1
    4be2:	13e000ef          	jal	4d20 <close>
  return r;
    4be6:	64a2                	ld	s1,8(sp)
}
    4be8:	854a                	mv	a0,s2
    4bea:	60e2                	ld	ra,24(sp)
    4bec:	6442                	ld	s0,16(sp)
    4bee:	6902                	ld	s2,0(sp)
    4bf0:	6105                	addi	sp,sp,32
    4bf2:	8082                	ret
    return -1;
    4bf4:	57fd                	li	a5,-1
    4bf6:	893e                	mv	s2,a5
    4bf8:	bfc5                	j	4be8 <stat+0x2a>

0000000000004bfa <atoi>:

int
atoi (const char *s)
{
    4bfa:	1141                	addi	sp,sp,-16
    4bfc:	e406                	sd	ra,8(sp)
    4bfe:	e022                	sd	s0,0(sp)
    4c00:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    4c02:	00054683          	lbu	a3,0(a0)
    4c06:	fd06879b          	addiw	a5,a3,-48
    4c0a:	0ff7f793          	zext.b	a5,a5
    4c0e:	4625                	li	a2,9
    4c10:	02f66963          	bltu	a2,a5,4c42 <atoi+0x48>
    4c14:	872a                	mv	a4,a0
  n = 0;
    4c16:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    4c18:	0705                	addi	a4,a4,1
    4c1a:	0025179b          	slliw	a5,a0,0x2
    4c1e:	9fa9                	addw	a5,a5,a0
    4c20:	0017979b          	slliw	a5,a5,0x1
    4c24:	9fb5                	addw	a5,a5,a3
    4c26:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    4c2a:	00074683          	lbu	a3,0(a4)
    4c2e:	fd06879b          	addiw	a5,a3,-48
    4c32:	0ff7f793          	zext.b	a5,a5
    4c36:	fef671e3          	bgeu	a2,a5,4c18 <atoi+0x1e>
  return n;
}
    4c3a:	60a2                	ld	ra,8(sp)
    4c3c:	6402                	ld	s0,0(sp)
    4c3e:	0141                	addi	sp,sp,16
    4c40:	8082                	ret
  n = 0;
    4c42:	4501                	li	a0,0
    4c44:	bfdd                	j	4c3a <atoi+0x40>

0000000000004c46 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
    4c46:	1141                	addi	sp,sp,-16
    4c48:	e406                	sd	ra,8(sp)
    4c4a:	e022                	sd	s0,0(sp)
    4c4c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
    4c4e:	02b57563          	bgeu	a0,a1,4c78 <memmove+0x32>
    {
      while (n-- > 0)
    4c52:	00c05f63          	blez	a2,4c70 <memmove+0x2a>
    4c56:	1602                	slli	a2,a2,0x20
    4c58:	9201                	srli	a2,a2,0x20
    4c5a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    4c5e:	872a                	mv	a4,a0
        *dst++ = *src++;
    4c60:	0585                	addi	a1,a1,1
    4c62:	0705                	addi	a4,a4,1
    4c64:	fff5c683          	lbu	a3,-1(a1)
    4c68:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
    4c6c:	fee79ae3          	bne	a5,a4,4c60 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
    4c70:	60a2                	ld	ra,8(sp)
    4c72:	6402                	ld	s0,0(sp)
    4c74:	0141                	addi	sp,sp,16
    4c76:	8082                	ret
      while (n-- > 0)
    4c78:	fec05ce3          	blez	a2,4c70 <memmove+0x2a>
      dst += n;
    4c7c:	00c50733          	add	a4,a0,a2
      src += n;
    4c80:	95b2                	add	a1,a1,a2
    4c82:	fff6079b          	addiw	a5,a2,-1
    4c86:	1782                	slli	a5,a5,0x20
    4c88:	9381                	srli	a5,a5,0x20
    4c8a:	fff7c793          	not	a5,a5
    4c8e:	97ba                	add	a5,a5,a4
        *--dst = *--src;
    4c90:	15fd                	addi	a1,a1,-1
    4c92:	177d                	addi	a4,a4,-1
    4c94:	0005c683          	lbu	a3,0(a1)
    4c98:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
    4c9c:	fef71ae3          	bne	a4,a5,4c90 <memmove+0x4a>
    4ca0:	bfc1                	j	4c70 <memmove+0x2a>

0000000000004ca2 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
    4ca2:	1141                	addi	sp,sp,-16
    4ca4:	e406                	sd	ra,8(sp)
    4ca6:	e022                	sd	s0,0(sp)
    4ca8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
    4caa:	c61d                	beqz	a2,4cd8 <memcmp+0x36>
    4cac:	1602                	slli	a2,a2,0x20
    4cae:	9201                	srli	a2,a2,0x20
    4cb0:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
    4cb4:	00054783          	lbu	a5,0(a0)
    4cb8:	0005c703          	lbu	a4,0(a1)
    4cbc:	00e79863          	bne	a5,a4,4ccc <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
    4cc0:	0505                	addi	a0,a0,1
      p2++;
    4cc2:	0585                	addi	a1,a1,1
  while (n-- > 0)
    4cc4:	fed518e3          	bne	a0,a3,4cb4 <memcmp+0x12>
    }
  return 0;
    4cc8:	4501                	li	a0,0
    4cca:	a019                	j	4cd0 <memcmp+0x2e>
          return *p1 - *p2;
    4ccc:	40e7853b          	subw	a0,a5,a4
}
    4cd0:	60a2                	ld	ra,8(sp)
    4cd2:	6402                	ld	s0,0(sp)
    4cd4:	0141                	addi	sp,sp,16
    4cd6:	8082                	ret
  return 0;
    4cd8:	4501                	li	a0,0
    4cda:	bfdd                	j	4cd0 <memcmp+0x2e>

0000000000004cdc <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
    4cdc:	1141                	addi	sp,sp,-16
    4cde:	e406                	sd	ra,8(sp)
    4ce0:	e022                	sd	s0,0(sp)
    4ce2:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
    4ce4:	f63ff0ef          	jal	4c46 <memmove>
}
    4ce8:	60a2                	ld	ra,8(sp)
    4cea:	6402                	ld	s0,0(sp)
    4cec:	0141                	addi	sp,sp,16
    4cee:	8082                	ret

0000000000004cf0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    4cf0:	4885                	li	a7,1
 ecall
    4cf2:	00000073          	ecall
 ret
    4cf6:	8082                	ret

0000000000004cf8 <exit>:
.global exit
exit:
 li a7, SYS_exit
    4cf8:	4889                	li	a7,2
 ecall
    4cfa:	00000073          	ecall
 ret
    4cfe:	8082                	ret

0000000000004d00 <wait>:
.global wait
wait:
 li a7, SYS_wait
    4d00:	488d                	li	a7,3
 ecall
    4d02:	00000073          	ecall
 ret
    4d06:	8082                	ret

0000000000004d08 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4d08:	4891                	li	a7,4
 ecall
    4d0a:	00000073          	ecall
 ret
    4d0e:	8082                	ret

0000000000004d10 <read>:
.global read
read:
 li a7, SYS_read
    4d10:	4895                	li	a7,5
 ecall
    4d12:	00000073          	ecall
 ret
    4d16:	8082                	ret

0000000000004d18 <write>:
.global write
write:
 li a7, SYS_write
    4d18:	48c1                	li	a7,16
 ecall
    4d1a:	00000073          	ecall
 ret
    4d1e:	8082                	ret

0000000000004d20 <close>:
.global close
close:
 li a7, SYS_close
    4d20:	48d5                	li	a7,21
 ecall
    4d22:	00000073          	ecall
 ret
    4d26:	8082                	ret

0000000000004d28 <kill>:
.global kill
kill:
 li a7, SYS_kill
    4d28:	4899                	li	a7,6
 ecall
    4d2a:	00000073          	ecall
 ret
    4d2e:	8082                	ret

0000000000004d30 <exec>:
.global exec
exec:
 li a7, SYS_exec
    4d30:	489d                	li	a7,7
 ecall
    4d32:	00000073          	ecall
 ret
    4d36:	8082                	ret

0000000000004d38 <open>:
.global open
open:
 li a7, SYS_open
    4d38:	48bd                	li	a7,15
 ecall
    4d3a:	00000073          	ecall
 ret
    4d3e:	8082                	ret

0000000000004d40 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4d40:	48c5                	li	a7,17
 ecall
    4d42:	00000073          	ecall
 ret
    4d46:	8082                	ret

0000000000004d48 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4d48:	48c9                	li	a7,18
 ecall
    4d4a:	00000073          	ecall
 ret
    4d4e:	8082                	ret

0000000000004d50 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4d50:	48a1                	li	a7,8
 ecall
    4d52:	00000073          	ecall
 ret
    4d56:	8082                	ret

0000000000004d58 <link>:
.global link
link:
 li a7, SYS_link
    4d58:	48cd                	li	a7,19
 ecall
    4d5a:	00000073          	ecall
 ret
    4d5e:	8082                	ret

0000000000004d60 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4d60:	48d1                	li	a7,20
 ecall
    4d62:	00000073          	ecall
 ret
    4d66:	8082                	ret

0000000000004d68 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4d68:	48a5                	li	a7,9
 ecall
    4d6a:	00000073          	ecall
 ret
    4d6e:	8082                	ret

0000000000004d70 <dup>:
.global dup
dup:
 li a7, SYS_dup
    4d70:	48a9                	li	a7,10
 ecall
    4d72:	00000073          	ecall
 ret
    4d76:	8082                	ret

0000000000004d78 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4d78:	48ad                	li	a7,11
 ecall
    4d7a:	00000073          	ecall
 ret
    4d7e:	8082                	ret

0000000000004d80 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    4d80:	48b1                	li	a7,12
 ecall
    4d82:	00000073          	ecall
 ret
    4d86:	8082                	ret

0000000000004d88 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    4d88:	48b5                	li	a7,13
 ecall
    4d8a:	00000073          	ecall
 ret
    4d8e:	8082                	ret

0000000000004d90 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4d90:	48b9                	li	a7,14
 ecall
    4d92:	00000073          	ecall
 ret
    4d96:	8082                	ret

0000000000004d98 <trace>:
.global trace
trace:
 li a7, SYS_trace
    4d98:	48d9                	li	a7,22
 ecall
    4d9a:	00000073          	ecall
 ret
    4d9e:	8082                	ret

0000000000004da0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4da0:	1101                	addi	sp,sp,-32
    4da2:	ec06                	sd	ra,24(sp)
    4da4:	e822                	sd	s0,16(sp)
    4da6:	1000                	addi	s0,sp,32
    4da8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4dac:	4605                	li	a2,1
    4dae:	fef40593          	addi	a1,s0,-17
    4db2:	f67ff0ef          	jal	4d18 <write>
}
    4db6:	60e2                	ld	ra,24(sp)
    4db8:	6442                	ld	s0,16(sp)
    4dba:	6105                	addi	sp,sp,32
    4dbc:	8082                	ret

0000000000004dbe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4dbe:	7139                	addi	sp,sp,-64
    4dc0:	fc06                	sd	ra,56(sp)
    4dc2:	f822                	sd	s0,48(sp)
    4dc4:	f04a                	sd	s2,32(sp)
    4dc6:	ec4e                	sd	s3,24(sp)
    4dc8:	0080                	addi	s0,sp,64
    4dca:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4dcc:	cac9                	beqz	a3,4e5e <printint+0xa0>
    4dce:	01f5d79b          	srliw	a5,a1,0x1f
    4dd2:	c7d1                	beqz	a5,4e5e <printint+0xa0>
    neg = 1;
    x = -xx;
    4dd4:	40b005bb          	negw	a1,a1
    neg = 1;
    4dd8:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    4dda:	fc040993          	addi	s3,s0,-64
  neg = 0;
    4dde:	86ce                	mv	a3,s3
  i = 0;
    4de0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    4de2:	00003817          	auipc	a6,0x3
    4de6:	90e80813          	addi	a6,a6,-1778 # 76f0 <digits>
    4dea:	88ba                	mv	a7,a4
    4dec:	0017051b          	addiw	a0,a4,1
    4df0:	872a                	mv	a4,a0
    4df2:	02c5f7bb          	remuw	a5,a1,a2
    4df6:	1782                	slli	a5,a5,0x20
    4df8:	9381                	srli	a5,a5,0x20
    4dfa:	97c2                	add	a5,a5,a6
    4dfc:	0007c783          	lbu	a5,0(a5)
    4e00:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    4e04:	87ae                	mv	a5,a1
    4e06:	02c5d5bb          	divuw	a1,a1,a2
    4e0a:	0685                	addi	a3,a3,1
    4e0c:	fcc7ffe3          	bgeu	a5,a2,4dea <printint+0x2c>
  if(neg)
    4e10:	00030c63          	beqz	t1,4e28 <printint+0x6a>
    buf[i++] = '-';
    4e14:	fd050793          	addi	a5,a0,-48
    4e18:	00878533          	add	a0,a5,s0
    4e1c:	02d00793          	li	a5,45
    4e20:	fef50823          	sb	a5,-16(a0)
    4e24:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    4e28:	02e05563          	blez	a4,4e52 <printint+0x94>
    4e2c:	f426                	sd	s1,40(sp)
    4e2e:	377d                	addiw	a4,a4,-1
    4e30:	00e984b3          	add	s1,s3,a4
    4e34:	19fd                	addi	s3,s3,-1
    4e36:	99ba                	add	s3,s3,a4
    4e38:	1702                	slli	a4,a4,0x20
    4e3a:	9301                	srli	a4,a4,0x20
    4e3c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    4e40:	0004c583          	lbu	a1,0(s1)
    4e44:	854a                	mv	a0,s2
    4e46:	f5bff0ef          	jal	4da0 <putc>
  while(--i >= 0)
    4e4a:	14fd                	addi	s1,s1,-1
    4e4c:	ff349ae3          	bne	s1,s3,4e40 <printint+0x82>
    4e50:	74a2                	ld	s1,40(sp)
}
    4e52:	70e2                	ld	ra,56(sp)
    4e54:	7442                	ld	s0,48(sp)
    4e56:	7902                	ld	s2,32(sp)
    4e58:	69e2                	ld	s3,24(sp)
    4e5a:	6121                	addi	sp,sp,64
    4e5c:	8082                	ret
  neg = 0;
    4e5e:	4301                	li	t1,0
    4e60:	bfad                	j	4dda <printint+0x1c>

0000000000004e62 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    4e62:	711d                	addi	sp,sp,-96
    4e64:	ec86                	sd	ra,88(sp)
    4e66:	e8a2                	sd	s0,80(sp)
    4e68:	e4a6                	sd	s1,72(sp)
    4e6a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    4e6c:	0005c483          	lbu	s1,0(a1)
    4e70:	20048963          	beqz	s1,5082 <vprintf+0x220>
    4e74:	e0ca                	sd	s2,64(sp)
    4e76:	fc4e                	sd	s3,56(sp)
    4e78:	f852                	sd	s4,48(sp)
    4e7a:	f456                	sd	s5,40(sp)
    4e7c:	f05a                	sd	s6,32(sp)
    4e7e:	ec5e                	sd	s7,24(sp)
    4e80:	e862                	sd	s8,16(sp)
    4e82:	8b2a                	mv	s6,a0
    4e84:	8a2e                	mv	s4,a1
    4e86:	8bb2                	mv	s7,a2
  state = 0;
    4e88:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    4e8a:	4901                	li	s2,0
    4e8c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    4e8e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    4e92:	06400c13          	li	s8,100
    4e96:	a00d                	j	4eb8 <vprintf+0x56>
        putc(fd, c0);
    4e98:	85a6                	mv	a1,s1
    4e9a:	855a                	mv	a0,s6
    4e9c:	f05ff0ef          	jal	4da0 <putc>
    4ea0:	a019                	j	4ea6 <vprintf+0x44>
    } else if(state == '%'){
    4ea2:	03598363          	beq	s3,s5,4ec8 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
    4ea6:	0019079b          	addiw	a5,s2,1
    4eaa:	893e                	mv	s2,a5
    4eac:	873e                	mv	a4,a5
    4eae:	97d2                	add	a5,a5,s4
    4eb0:	0007c483          	lbu	s1,0(a5)
    4eb4:	1c048063          	beqz	s1,5074 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
    4eb8:	0004879b          	sext.w	a5,s1
    if(state == 0){
    4ebc:	fe0993e3          	bnez	s3,4ea2 <vprintf+0x40>
      if(c0 == '%'){
    4ec0:	fd579ce3          	bne	a5,s5,4e98 <vprintf+0x36>
        state = '%';
    4ec4:	89be                	mv	s3,a5
    4ec6:	b7c5                	j	4ea6 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
    4ec8:	00ea06b3          	add	a3,s4,a4
    4ecc:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
    4ed0:	1a060e63          	beqz	a2,508c <vprintf+0x22a>
      if(c0 == 'd'){
    4ed4:	03878763          	beq	a5,s8,4f02 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    4ed8:	f9478693          	addi	a3,a5,-108
    4edc:	0016b693          	seqz	a3,a3
    4ee0:	f9c60593          	addi	a1,a2,-100
    4ee4:	e99d                	bnez	a1,4f1a <vprintf+0xb8>
    4ee6:	ca95                	beqz	a3,4f1a <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
    4ee8:	008b8493          	addi	s1,s7,8
    4eec:	4685                	li	a3,1
    4eee:	4629                	li	a2,10
    4ef0:	000ba583          	lw	a1,0(s7)
    4ef4:	855a                	mv	a0,s6
    4ef6:	ec9ff0ef          	jal	4dbe <printint>
        i += 1;
    4efa:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    4efc:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    4efe:	4981                	li	s3,0
    4f00:	b75d                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
    4f02:	008b8493          	addi	s1,s7,8
    4f06:	4685                	li	a3,1
    4f08:	4629                	li	a2,10
    4f0a:	000ba583          	lw	a1,0(s7)
    4f0e:	855a                	mv	a0,s6
    4f10:	eafff0ef          	jal	4dbe <printint>
    4f14:	8ba6                	mv	s7,s1
      state = 0;
    4f16:	4981                	li	s3,0
    4f18:	b779                	j	4ea6 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
    4f1a:	9752                	add	a4,a4,s4
    4f1c:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    4f20:	f9460713          	addi	a4,a2,-108
    4f24:	00173713          	seqz	a4,a4
    4f28:	8f75                	and	a4,a4,a3
    4f2a:	f9c58513          	addi	a0,a1,-100
    4f2e:	16051963          	bnez	a0,50a0 <vprintf+0x23e>
    4f32:	16070763          	beqz	a4,50a0 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
    4f36:	008b8493          	addi	s1,s7,8
    4f3a:	4685                	li	a3,1
    4f3c:	4629                	li	a2,10
    4f3e:	000ba583          	lw	a1,0(s7)
    4f42:	855a                	mv	a0,s6
    4f44:	e7bff0ef          	jal	4dbe <printint>
        i += 2;
    4f48:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    4f4a:	8ba6                	mv	s7,s1
      state = 0;
    4f4c:	4981                	li	s3,0
        i += 2;
    4f4e:	bfa1                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
    4f50:	008b8493          	addi	s1,s7,8
    4f54:	4681                	li	a3,0
    4f56:	4629                	li	a2,10
    4f58:	000ba583          	lw	a1,0(s7)
    4f5c:	855a                	mv	a0,s6
    4f5e:	e61ff0ef          	jal	4dbe <printint>
    4f62:	8ba6                	mv	s7,s1
      state = 0;
    4f64:	4981                	li	s3,0
    4f66:	b781                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4f68:	008b8493          	addi	s1,s7,8
    4f6c:	4681                	li	a3,0
    4f6e:	4629                	li	a2,10
    4f70:	000ba583          	lw	a1,0(s7)
    4f74:	855a                	mv	a0,s6
    4f76:	e49ff0ef          	jal	4dbe <printint>
        i += 1;
    4f7a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    4f7c:	8ba6                	mv	s7,s1
      state = 0;
    4f7e:	4981                	li	s3,0
    4f80:	b71d                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
    4f82:	008b8493          	addi	s1,s7,8
    4f86:	4681                	li	a3,0
    4f88:	4629                	li	a2,10
    4f8a:	000ba583          	lw	a1,0(s7)
    4f8e:	855a                	mv	a0,s6
    4f90:	e2fff0ef          	jal	4dbe <printint>
        i += 2;
    4f94:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    4f96:	8ba6                	mv	s7,s1
      state = 0;
    4f98:	4981                	li	s3,0
        i += 2;
    4f9a:	b731                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
    4f9c:	008b8493          	addi	s1,s7,8
    4fa0:	4681                	li	a3,0
    4fa2:	4641                	li	a2,16
    4fa4:	000ba583          	lw	a1,0(s7)
    4fa8:	855a                	mv	a0,s6
    4faa:	e15ff0ef          	jal	4dbe <printint>
    4fae:	8ba6                	mv	s7,s1
      state = 0;
    4fb0:	4981                	li	s3,0
    4fb2:	bdd5                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    4fb4:	008b8493          	addi	s1,s7,8
    4fb8:	4681                	li	a3,0
    4fba:	4641                	li	a2,16
    4fbc:	000ba583          	lw	a1,0(s7)
    4fc0:	855a                	mv	a0,s6
    4fc2:	dfdff0ef          	jal	4dbe <printint>
        i += 1;
    4fc6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    4fc8:	8ba6                	mv	s7,s1
      state = 0;
    4fca:	4981                	li	s3,0
    4fcc:	bde9                	j	4ea6 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
    4fce:	008b8493          	addi	s1,s7,8
    4fd2:	4681                	li	a3,0
    4fd4:	4641                	li	a2,16
    4fd6:	000ba583          	lw	a1,0(s7)
    4fda:	855a                	mv	a0,s6
    4fdc:	de3ff0ef          	jal	4dbe <printint>
        i += 2;
    4fe0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    4fe2:	8ba6                	mv	s7,s1
      state = 0;
    4fe4:	4981                	li	s3,0
        i += 2;
    4fe6:	b5c1                	j	4ea6 <vprintf+0x44>
    4fe8:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
    4fea:	008b8793          	addi	a5,s7,8
    4fee:	8cbe                	mv	s9,a5
    4ff0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    4ff4:	03000593          	li	a1,48
    4ff8:	855a                	mv	a0,s6
    4ffa:	da7ff0ef          	jal	4da0 <putc>
  putc(fd, 'x');
    4ffe:	07800593          	li	a1,120
    5002:	855a                	mv	a0,s6
    5004:	d9dff0ef          	jal	4da0 <putc>
    5008:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    500a:	00002b97          	auipc	s7,0x2
    500e:	6e6b8b93          	addi	s7,s7,1766 # 76f0 <digits>
    5012:	03c9d793          	srli	a5,s3,0x3c
    5016:	97de                	add	a5,a5,s7
    5018:	0007c583          	lbu	a1,0(a5)
    501c:	855a                	mv	a0,s6
    501e:	d83ff0ef          	jal	4da0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5022:	0992                	slli	s3,s3,0x4
    5024:	34fd                	addiw	s1,s1,-1
    5026:	f4f5                	bnez	s1,5012 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
    5028:	8be6                	mv	s7,s9
      state = 0;
    502a:	4981                	li	s3,0
    502c:	6ca2                	ld	s9,8(sp)
    502e:	bda5                	j	4ea6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
    5030:	008b8993          	addi	s3,s7,8
    5034:	000bb483          	ld	s1,0(s7)
    5038:	cc91                	beqz	s1,5054 <vprintf+0x1f2>
        for(; *s; s++)
    503a:	0004c583          	lbu	a1,0(s1)
    503e:	c985                	beqz	a1,506e <vprintf+0x20c>
          putc(fd, *s);
    5040:	855a                	mv	a0,s6
    5042:	d5fff0ef          	jal	4da0 <putc>
        for(; *s; s++)
    5046:	0485                	addi	s1,s1,1
    5048:	0004c583          	lbu	a1,0(s1)
    504c:	f9f5                	bnez	a1,5040 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
    504e:	8bce                	mv	s7,s3
      state = 0;
    5050:	4981                	li	s3,0
    5052:	bd91                	j	4ea6 <vprintf+0x44>
          s = "(null)";
    5054:	00002497          	auipc	s1,0x2
    5058:	61c48493          	addi	s1,s1,1564 # 7670 <malloc+0x2488>
        for(; *s; s++)
    505c:	02800593          	li	a1,40
    5060:	b7c5                	j	5040 <vprintf+0x1de>
        putc(fd, '%');
    5062:	85be                	mv	a1,a5
    5064:	855a                	mv	a0,s6
    5066:	d3bff0ef          	jal	4da0 <putc>
      state = 0;
    506a:	4981                	li	s3,0
    506c:	bd2d                	j	4ea6 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
    506e:	8bce                	mv	s7,s3
      state = 0;
    5070:	4981                	li	s3,0
    5072:	bd15                	j	4ea6 <vprintf+0x44>
    5074:	6906                	ld	s2,64(sp)
    5076:	79e2                	ld	s3,56(sp)
    5078:	7a42                	ld	s4,48(sp)
    507a:	7aa2                	ld	s5,40(sp)
    507c:	7b02                	ld	s6,32(sp)
    507e:	6be2                	ld	s7,24(sp)
    5080:	6c42                	ld	s8,16(sp)
    }
  }
}
    5082:	60e6                	ld	ra,88(sp)
    5084:	6446                	ld	s0,80(sp)
    5086:	64a6                	ld	s1,72(sp)
    5088:	6125                	addi	sp,sp,96
    508a:	8082                	ret
      if(c0 == 'd'){
    508c:	06400713          	li	a4,100
    5090:	e6e789e3          	beq	a5,a4,4f02 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
    5094:	f9478693          	addi	a3,a5,-108
    5098:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
    509c:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    509e:	4701                	li	a4,0
      } else if(c0 == 'u'){
    50a0:	07500513          	li	a0,117
    50a4:	eaa786e3          	beq	a5,a0,4f50 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
    50a8:	f8b60513          	addi	a0,a2,-117
    50ac:	e119                	bnez	a0,50b2 <vprintf+0x250>
    50ae:	ea069de3          	bnez	a3,4f68 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    50b2:	f8b58513          	addi	a0,a1,-117
    50b6:	e119                	bnez	a0,50bc <vprintf+0x25a>
    50b8:	ec0715e3          	bnez	a4,4f82 <vprintf+0x120>
      } else if(c0 == 'x'){
    50bc:	07800513          	li	a0,120
    50c0:	eca78ee3          	beq	a5,a0,4f9c <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
    50c4:	f8860613          	addi	a2,a2,-120
    50c8:	e219                	bnez	a2,50ce <vprintf+0x26c>
    50ca:	ee0695e3          	bnez	a3,4fb4 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    50ce:	f8858593          	addi	a1,a1,-120
    50d2:	e199                	bnez	a1,50d8 <vprintf+0x276>
    50d4:	ee071de3          	bnez	a4,4fce <vprintf+0x16c>
      } else if(c0 == 'p'){
    50d8:	07000713          	li	a4,112
    50dc:	f0e786e3          	beq	a5,a4,4fe8 <vprintf+0x186>
      } else if(c0 == 's'){
    50e0:	07300713          	li	a4,115
    50e4:	f4e786e3          	beq	a5,a4,5030 <vprintf+0x1ce>
      } else if(c0 == '%'){
    50e8:	02500713          	li	a4,37
    50ec:	f6e78be3          	beq	a5,a4,5062 <vprintf+0x200>
        putc(fd, '%');
    50f0:	02500593          	li	a1,37
    50f4:	855a                	mv	a0,s6
    50f6:	cabff0ef          	jal	4da0 <putc>
        putc(fd, c0);
    50fa:	85a6                	mv	a1,s1
    50fc:	855a                	mv	a0,s6
    50fe:	ca3ff0ef          	jal	4da0 <putc>
      state = 0;
    5102:	4981                	li	s3,0
    5104:	b34d                	j	4ea6 <vprintf+0x44>

0000000000005106 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5106:	715d                	addi	sp,sp,-80
    5108:	ec06                	sd	ra,24(sp)
    510a:	e822                	sd	s0,16(sp)
    510c:	1000                	addi	s0,sp,32
    510e:	e010                	sd	a2,0(s0)
    5110:	e414                	sd	a3,8(s0)
    5112:	e818                	sd	a4,16(s0)
    5114:	ec1c                	sd	a5,24(s0)
    5116:	03043023          	sd	a6,32(s0)
    511a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    511e:	8622                	mv	a2,s0
    5120:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5124:	d3fff0ef          	jal	4e62 <vprintf>
}
    5128:	60e2                	ld	ra,24(sp)
    512a:	6442                	ld	s0,16(sp)
    512c:	6161                	addi	sp,sp,80
    512e:	8082                	ret

0000000000005130 <printf>:

void
printf(const char *fmt, ...)
{
    5130:	711d                	addi	sp,sp,-96
    5132:	ec06                	sd	ra,24(sp)
    5134:	e822                	sd	s0,16(sp)
    5136:	1000                	addi	s0,sp,32
    5138:	e40c                	sd	a1,8(s0)
    513a:	e810                	sd	a2,16(s0)
    513c:	ec14                	sd	a3,24(s0)
    513e:	f018                	sd	a4,32(s0)
    5140:	f41c                	sd	a5,40(s0)
    5142:	03043823          	sd	a6,48(s0)
    5146:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    514a:	00840613          	addi	a2,s0,8
    514e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5152:	85aa                	mv	a1,a0
    5154:	4505                	li	a0,1
    5156:	d0dff0ef          	jal	4e62 <vprintf>
}
    515a:	60e2                	ld	ra,24(sp)
    515c:	6442                	ld	s0,16(sp)
    515e:	6125                	addi	sp,sp,96
    5160:	8082                	ret

0000000000005162 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
    5162:	1141                	addi	sp,sp,-16
    5164:	e406                	sd	ra,8(sp)
    5166:	e022                	sd	s0,0(sp)
    5168:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    516a:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    516e:	00004797          	auipc	a5,0x4
    5172:	2e27b783          	ld	a5,738(a5) # 9450 <freep>
    5176:	a039                	j	5184 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5178:	6398                	ld	a4,0(a5)
    517a:	00e7e463          	bltu	a5,a4,5182 <free+0x20>
    517e:	00e6ea63          	bltu	a3,a4,5192 <free+0x30>
{
    5182:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5184:	fed7fae3          	bgeu	a5,a3,5178 <free+0x16>
    5188:	6398                	ld	a4,0(a5)
    518a:	00e6e463          	bltu	a3,a4,5192 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    518e:	fee7eae3          	bltu	a5,a4,5182 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
    5192:	ff852583          	lw	a1,-8(a0)
    5196:	6390                	ld	a2,0(a5)
    5198:	02059813          	slli	a6,a1,0x20
    519c:	01c85713          	srli	a4,a6,0x1c
    51a0:	9736                	add	a4,a4,a3
    51a2:	02e60563          	beq	a2,a4,51cc <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
    51a6:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
    51aa:	4790                	lw	a2,8(a5)
    51ac:	02061593          	slli	a1,a2,0x20
    51b0:	01c5d713          	srli	a4,a1,0x1c
    51b4:	973e                	add	a4,a4,a5
    51b6:	02e68263          	beq	a3,a4,51da <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
    51ba:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
    51bc:	00004717          	auipc	a4,0x4
    51c0:	28f73a23          	sd	a5,660(a4) # 9450 <freep>
}
    51c4:	60a2                	ld	ra,8(sp)
    51c6:	6402                	ld	s0,0(sp)
    51c8:	0141                	addi	sp,sp,16
    51ca:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
    51cc:	4618                	lw	a4,8(a2)
    51ce:	9f2d                	addw	a4,a4,a1
    51d0:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
    51d4:	6398                	ld	a4,0(a5)
    51d6:	6310                	ld	a2,0(a4)
    51d8:	b7f9                	j	51a6 <free+0x44>
      p->s.size += bp->s.size;
    51da:	ff852703          	lw	a4,-8(a0)
    51de:	9f31                	addw	a4,a4,a2
    51e0:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
    51e2:	ff053683          	ld	a3,-16(a0)
    51e6:	bfd1                	j	51ba <free+0x58>

00000000000051e8 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
    51e8:	7139                	addi	sp,sp,-64
    51ea:	fc06                	sd	ra,56(sp)
    51ec:	f822                	sd	s0,48(sp)
    51ee:	f04a                	sd	s2,32(sp)
    51f0:	ec4e                	sd	s3,24(sp)
    51f2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
    51f4:	02051993          	slli	s3,a0,0x20
    51f8:	0209d993          	srli	s3,s3,0x20
    51fc:	09bd                	addi	s3,s3,15
    51fe:	0049d993          	srli	s3,s3,0x4
    5202:	2985                	addiw	s3,s3,1
    5204:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
    5206:	00004517          	auipc	a0,0x4
    520a:	24a53503          	ld	a0,586(a0) # 9450 <freep>
    520e:	c905                	beqz	a0,523e <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    5210:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
    5212:	4798                	lw	a4,8(a5)
    5214:	09377663          	bgeu	a4,s3,52a0 <malloc+0xb8>
    5218:	f426                	sd	s1,40(sp)
    521a:	e852                	sd	s4,16(sp)
    521c:	e456                	sd	s5,8(sp)
    521e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    5220:	8a4e                	mv	s4,s3
    5222:	6705                	lui	a4,0x1
    5224:	00e9f363          	bgeu	s3,a4,522a <malloc+0x42>
    5228:	6a05                	lui	s4,0x1
    522a:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
    522e:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
    5232:	00004497          	auipc	s1,0x4
    5236:	21e48493          	addi	s1,s1,542 # 9450 <freep>
  if (p == (char *)-1)
    523a:	5afd                	li	s5,-1
    523c:	a83d                	j	527a <malloc+0x92>
    523e:	f426                	sd	s1,40(sp)
    5240:	e852                	sd	s4,16(sp)
    5242:	e456                	sd	s5,8(sp)
    5244:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
    5246:	0000b797          	auipc	a5,0xb
    524a:	a3278793          	addi	a5,a5,-1486 # fc78 <base>
    524e:	00004717          	auipc	a4,0x4
    5252:	20f73123          	sd	a5,514(a4) # 9450 <freep>
    5256:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
    5258:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
    525c:	b7d1                	j	5220 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
    525e:	6398                	ld	a4,0(a5)
    5260:	e118                	sd	a4,0(a0)
    5262:	a899                	j	52b8 <malloc+0xd0>
  hp->s.size = nu;
    5264:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
    5268:	0541                	addi	a0,a0,16
    526a:	ef9ff0ef          	jal	5162 <free>
  return freep;
    526e:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
    5270:	c125                	beqz	a0,52d0 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    5272:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
    5274:	4798                	lw	a4,8(a5)
    5276:	03277163          	bgeu	a4,s2,5298 <malloc+0xb0>
      if (p == freep)
    527a:	6098                	ld	a4,0(s1)
    527c:	853e                	mv	a0,a5
    527e:	fef71ae3          	bne	a4,a5,5272 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
    5282:	8552                	mv	a0,s4
    5284:	afdff0ef          	jal	4d80 <sbrk>
  if (p == (char *)-1)
    5288:	fd551ee3          	bne	a0,s5,5264 <malloc+0x7c>
          return 0;
    528c:	4501                	li	a0,0
    528e:	74a2                	ld	s1,40(sp)
    5290:	6a42                	ld	s4,16(sp)
    5292:	6aa2                	ld	s5,8(sp)
    5294:	6b02                	ld	s6,0(sp)
    5296:	a03d                	j	52c4 <malloc+0xdc>
    5298:	74a2                	ld	s1,40(sp)
    529a:	6a42                	ld	s4,16(sp)
    529c:	6aa2                	ld	s5,8(sp)
    529e:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
    52a0:	fae90fe3          	beq	s2,a4,525e <malloc+0x76>
              p->s.size -= nunits;
    52a4:	4137073b          	subw	a4,a4,s3
    52a8:	c798                	sw	a4,8(a5)
              p += p->s.size;
    52aa:	02071693          	slli	a3,a4,0x20
    52ae:	01c6d713          	srli	a4,a3,0x1c
    52b2:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
    52b4:	0137a423          	sw	s3,8(a5)
          freep = prevp;
    52b8:	00004717          	auipc	a4,0x4
    52bc:	18a73c23          	sd	a0,408(a4) # 9450 <freep>
          return (void *)(p + 1);
    52c0:	01078513          	addi	a0,a5,16
    }
}
    52c4:	70e2                	ld	ra,56(sp)
    52c6:	7442                	ld	s0,48(sp)
    52c8:	7902                	ld	s2,32(sp)
    52ca:	69e2                	ld	s3,24(sp)
    52cc:	6121                	addi	sp,sp,64
    52ce:	8082                	ret
    52d0:	74a2                	ld	s1,40(sp)
    52d2:	6a42                	ld	s4,16(sp)
    52d4:	6aa2                	ld	s5,8(sp)
    52d6:	6b02                	ld	s6,0(sp)
    52d8:	b7f5                	j	52c4 <malloc+0xdc>
