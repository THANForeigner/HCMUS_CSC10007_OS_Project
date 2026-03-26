
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       8:	611c                	ld	a5,0(a0)
       a:	0017d693          	srli	a3,a5,0x1
       e:	c0000737          	lui	a4,0xc0000
      12:	0705                	addi	a4,a4,1 # ffffffffc0000001 <base+0xffffffffbfffdbf9>
      14:	1706                	slli	a4,a4,0x21
      16:	0725                	addi	a4,a4,9
      18:	02e6b733          	mulhu	a4,a3,a4
      1c:	8375                	srli	a4,a4,0x1d
      1e:	01e71693          	slli	a3,a4,0x1e
      22:	40e68733          	sub	a4,a3,a4
      26:	0706                	slli	a4,a4,0x1
      28:	8f99                	sub	a5,a5,a4
      2a:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      2c:	1fe406b7          	lui	a3,0x1fe40
      30:	b7968693          	addi	a3,a3,-1159 # 1fe3fb79 <base+0x1fe3d771>
      34:	41a70737          	lui	a4,0x41a70
      38:	5af70713          	addi	a4,a4,1455 # 41a705af <base+0x41a6e1a7>
      3c:	1702                	slli	a4,a4,0x20
      3e:	9736                	add	a4,a4,a3
      40:	02e79733          	mulh	a4,a5,a4
      44:	873d                	srai	a4,a4,0xf
      46:	43f7d693          	srai	a3,a5,0x3f
      4a:	8f15                	sub	a4,a4,a3
      4c:	66fd                	lui	a3,0x1f
      4e:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      52:	02d706b3          	mul	a3,a4,a3
      56:	8f95                	sub	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      58:	6691                	lui	a3,0x4
      5a:	1a768693          	addi	a3,a3,423 # 41a7 <base+0x1d9f>
      5e:	02d787b3          	mul	a5,a5,a3
      62:	76fd                	lui	a3,0xfffff
      64:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      68:	02d70733          	mul	a4,a4,a3
      6c:	97ba                	add	a5,a5,a4
    if (x < 0)
      6e:	0007ca63          	bltz	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      72:	17fd                	addi	a5,a5,-1
    *ctx = x;
      74:	e11c                	sd	a5,0(a0)
    return (x);
}
      76:	0007851b          	sext.w	a0,a5
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
        x += 0x7fffffff;
      82:	80000737          	lui	a4,0x80000
      86:	fff74713          	not	a4,a4
      8a:	97ba                	add	a5,a5,a4
      8c:	b7dd                	j	72 <do_rand+0x72>

000000000000008e <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      8e:	1141                	addi	sp,sp,-16
      90:	e406                	sd	ra,8(sp)
      92:	e022                	sd	s0,0(sp)
      94:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      96:	00002517          	auipc	a0,0x2
      9a:	f6a50513          	addi	a0,a0,-150 # 2000 <rand_next>
      9e:	f63ff0ef          	jal	0 <do_rand>
}
      a2:	60a2                	ld	ra,8(sp)
      a4:	6402                	ld	s0,0(sp)
      a6:	0141                	addi	sp,sp,16
      a8:	8082                	ret

00000000000000aa <go>:

void
go(int which_child)
{
      aa:	7171                	addi	sp,sp,-176
      ac:	f506                	sd	ra,168(sp)
      ae:	f122                	sd	s0,160(sp)
      b0:	ed26                	sd	s1,152(sp)
      b2:	1900                	addi	s0,sp,176
      b4:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      b6:	4501                	li	a0,0
      b8:	3e3000ef          	jal	c9a <sbrk>
      bc:	f4a43c23          	sd	a0,-168(s0)
  uint64 iters = 0;

  mkdir("grindir");
      c0:	00001517          	auipc	a0,0x1
      c4:	14050513          	addi	a0,a0,320 # 1200 <malloc+0xfe>
      c8:	3b3000ef          	jal	c7a <mkdir>
  if(chdir("grindir") != 0){
      cc:	00001517          	auipc	a0,0x1
      d0:	13450513          	addi	a0,a0,308 # 1200 <malloc+0xfe>
      d4:	3af000ef          	jal	c82 <chdir>
      d8:	c505                	beqz	a0,100 <go+0x56>
      da:	e94a                	sd	s2,144(sp)
      dc:	e54e                	sd	s3,136(sp)
      de:	e152                	sd	s4,128(sp)
      e0:	fcd6                	sd	s5,120(sp)
      e2:	f8da                	sd	s6,112(sp)
      e4:	f4de                	sd	s7,104(sp)
      e6:	f0e2                	sd	s8,96(sp)
      e8:	ece6                	sd	s9,88(sp)
      ea:	e8ea                	sd	s10,80(sp)
      ec:	e4ee                	sd	s11,72(sp)
    printf("grind: chdir grindir failed\n");
      ee:	00001517          	auipc	a0,0x1
      f2:	11a50513          	addi	a0,a0,282 # 1208 <malloc+0x106>
      f6:	755000ef          	jal	104a <printf>
    exit(1);
      fa:	4505                	li	a0,1
      fc:	317000ef          	jal	c12 <exit>
     100:	e94a                	sd	s2,144(sp)
     102:	e54e                	sd	s3,136(sp)
     104:	e152                	sd	s4,128(sp)
     106:	fcd6                	sd	s5,120(sp)
     108:	f8da                	sd	s6,112(sp)
     10a:	f4de                	sd	s7,104(sp)
     10c:	f0e2                	sd	s8,96(sp)
     10e:	ece6                	sd	s9,88(sp)
     110:	e8ea                	sd	s10,80(sp)
     112:	e4ee                	sd	s11,72(sp)
  }
  chdir("/");
     114:	00001517          	auipc	a0,0x1
     118:	11c50513          	addi	a0,a0,284 # 1230 <malloc+0x12e>
     11c:	367000ef          	jal	c82 <chdir>
     120:	00001c17          	auipc	s8,0x1
     124:	120c0c13          	addi	s8,s8,288 # 1240 <malloc+0x13e>
     128:	c489                	beqz	s1,132 <go+0x88>
     12a:	00001c17          	auipc	s8,0x1
     12e:	10ec0c13          	addi	s8,s8,270 # 1238 <malloc+0x136>
  uint64 iters = 0;
     132:	4481                	li	s1,0
  int fd = -1;
     134:	5cfd                	li	s9,-1
  
  while(1){
    iters++;
    if((iters % 500) == 0)
     136:	106259b7          	lui	s3,0x10625
     13a:	dd398993          	addi	s3,s3,-557 # 10624dd3 <base+0x106229cb>
     13e:	09be                	slli	s3,s3,0xf
     140:	8d598993          	addi	s3,s3,-1835
     144:	09ca                	slli	s3,s3,0x12
     146:	80098993          	addi	s3,s3,-2048
     14a:	fcf98993          	addi	s3,s3,-49
     14e:	1f400b93          	li	s7,500
      write(1, which_child?"B":"A", 1);
     152:	4a05                	li	s4,1
    int what = rand() % 23;
     154:	b2164ab7          	lui	s5,0xb2164
     158:	2c9a8a93          	addi	s5,s5,713 # ffffffffb21642c9 <base+0xffffffffb2161ec1>
     15c:	4b59                	li	s6,22
     15e:	00001917          	auipc	s2,0x1
     162:	3b290913          	addi	s2,s2,946 # 1510 <malloc+0x40e>
      close(fd1);
      unlink("c");
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     166:	f6840d93          	addi	s11,s0,-152
     16a:	a819                	j	180 <go+0xd6>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     16c:	20200593          	li	a1,514
     170:	00001517          	auipc	a0,0x1
     174:	0d850513          	addi	a0,a0,216 # 1248 <malloc+0x146>
     178:	2db000ef          	jal	c52 <open>
     17c:	2bf000ef          	jal	c3a <close>
    iters++;
     180:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     182:	0024d793          	srli	a5,s1,0x2
     186:	0337b7b3          	mulhu	a5,a5,s3
     18a:	8391                	srli	a5,a5,0x4
     18c:	037787b3          	mul	a5,a5,s7
     190:	00f49763          	bne	s1,a5,19e <go+0xf4>
      write(1, which_child?"B":"A", 1);
     194:	8652                	mv	a2,s4
     196:	85e2                	mv	a1,s8
     198:	8552                	mv	a0,s4
     19a:	299000ef          	jal	c32 <write>
    int what = rand() % 23;
     19e:	ef1ff0ef          	jal	8e <rand>
     1a2:	035507b3          	mul	a5,a0,s5
     1a6:	9381                	srli	a5,a5,0x20
     1a8:	9fa9                	addw	a5,a5,a0
     1aa:	4047d79b          	sraiw	a5,a5,0x4
     1ae:	41f5571b          	sraiw	a4,a0,0x1f
     1b2:	9f99                	subw	a5,a5,a4
     1b4:	0017971b          	slliw	a4,a5,0x1
     1b8:	9f3d                	addw	a4,a4,a5
     1ba:	0037171b          	slliw	a4,a4,0x3
     1be:	40f707bb          	subw	a5,a4,a5
     1c2:	9d1d                	subw	a0,a0,a5
     1c4:	faab6ee3          	bltu	s6,a0,180 <go+0xd6>
     1c8:	02051793          	slli	a5,a0,0x20
     1cc:	01e7d513          	srli	a0,a5,0x1e
     1d0:	954a                	add	a0,a0,s2
     1d2:	411c                	lw	a5,0(a0)
     1d4:	97ca                	add	a5,a5,s2
     1d6:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     1d8:	20200593          	li	a1,514
     1dc:	00001517          	auipc	a0,0x1
     1e0:	07c50513          	addi	a0,a0,124 # 1258 <malloc+0x156>
     1e4:	26f000ef          	jal	c52 <open>
     1e8:	253000ef          	jal	c3a <close>
     1ec:	bf51                	j	180 <go+0xd6>
      unlink("grindir/../a");
     1ee:	00001517          	auipc	a0,0x1
     1f2:	05a50513          	addi	a0,a0,90 # 1248 <malloc+0x146>
     1f6:	26d000ef          	jal	c62 <unlink>
     1fa:	b759                	j	180 <go+0xd6>
      if(chdir("grindir") != 0){
     1fc:	00001517          	auipc	a0,0x1
     200:	00450513          	addi	a0,a0,4 # 1200 <malloc+0xfe>
     204:	27f000ef          	jal	c82 <chdir>
     208:	ed11                	bnez	a0,224 <go+0x17a>
      unlink("../b");
     20a:	00001517          	auipc	a0,0x1
     20e:	06650513          	addi	a0,a0,102 # 1270 <malloc+0x16e>
     212:	251000ef          	jal	c62 <unlink>
      chdir("/");
     216:	00001517          	auipc	a0,0x1
     21a:	01a50513          	addi	a0,a0,26 # 1230 <malloc+0x12e>
     21e:	265000ef          	jal	c82 <chdir>
     222:	bfb9                	j	180 <go+0xd6>
        printf("grind: chdir grindir failed\n");
     224:	00001517          	auipc	a0,0x1
     228:	fe450513          	addi	a0,a0,-28 # 1208 <malloc+0x106>
     22c:	61f000ef          	jal	104a <printf>
        exit(1);
     230:	4505                	li	a0,1
     232:	1e1000ef          	jal	c12 <exit>
      close(fd);
     236:	8566                	mv	a0,s9
     238:	203000ef          	jal	c3a <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     23c:	20200593          	li	a1,514
     240:	00001517          	auipc	a0,0x1
     244:	03850513          	addi	a0,a0,56 # 1278 <malloc+0x176>
     248:	20b000ef          	jal	c52 <open>
     24c:	8caa                	mv	s9,a0
     24e:	bf0d                	j	180 <go+0xd6>
      close(fd);
     250:	8566                	mv	a0,s9
     252:	1e9000ef          	jal	c3a <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     256:	20200593          	li	a1,514
     25a:	00001517          	auipc	a0,0x1
     25e:	02e50513          	addi	a0,a0,46 # 1288 <malloc+0x186>
     262:	1f1000ef          	jal	c52 <open>
     266:	8caa                	mv	s9,a0
     268:	bf21                	j	180 <go+0xd6>
      write(fd, buf, sizeof(buf));
     26a:	3e700613          	li	a2,999
     26e:	00002597          	auipc	a1,0x2
     272:	db258593          	addi	a1,a1,-590 # 2020 <buf.0>
     276:	8566                	mv	a0,s9
     278:	1bb000ef          	jal	c32 <write>
     27c:	b711                	j	180 <go+0xd6>
      read(fd, buf, sizeof(buf));
     27e:	3e700613          	li	a2,999
     282:	00002597          	auipc	a1,0x2
     286:	d9e58593          	addi	a1,a1,-610 # 2020 <buf.0>
     28a:	8566                	mv	a0,s9
     28c:	19f000ef          	jal	c2a <read>
     290:	bdc5                	j	180 <go+0xd6>
      mkdir("grindir/../a");
     292:	00001517          	auipc	a0,0x1
     296:	fb650513          	addi	a0,a0,-74 # 1248 <malloc+0x146>
     29a:	1e1000ef          	jal	c7a <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     29e:	20200593          	li	a1,514
     2a2:	00001517          	auipc	a0,0x1
     2a6:	ffe50513          	addi	a0,a0,-2 # 12a0 <malloc+0x19e>
     2aa:	1a9000ef          	jal	c52 <open>
     2ae:	18d000ef          	jal	c3a <close>
      unlink("a/a");
     2b2:	00001517          	auipc	a0,0x1
     2b6:	ffe50513          	addi	a0,a0,-2 # 12b0 <malloc+0x1ae>
     2ba:	1a9000ef          	jal	c62 <unlink>
     2be:	b5c9                	j	180 <go+0xd6>
      mkdir("/../b");
     2c0:	00001517          	auipc	a0,0x1
     2c4:	ff850513          	addi	a0,a0,-8 # 12b8 <malloc+0x1b6>
     2c8:	1b3000ef          	jal	c7a <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2cc:	20200593          	li	a1,514
     2d0:	00001517          	auipc	a0,0x1
     2d4:	ff050513          	addi	a0,a0,-16 # 12c0 <malloc+0x1be>
     2d8:	17b000ef          	jal	c52 <open>
     2dc:	15f000ef          	jal	c3a <close>
      unlink("b/b");
     2e0:	00001517          	auipc	a0,0x1
     2e4:	ff050513          	addi	a0,a0,-16 # 12d0 <malloc+0x1ce>
     2e8:	17b000ef          	jal	c62 <unlink>
     2ec:	bd51                	j	180 <go+0xd6>
      unlink("b");
     2ee:	00001517          	auipc	a0,0x1
     2f2:	fea50513          	addi	a0,a0,-22 # 12d8 <malloc+0x1d6>
     2f6:	16d000ef          	jal	c62 <unlink>
      link("../grindir/./../a", "../b");
     2fa:	00001597          	auipc	a1,0x1
     2fe:	f7658593          	addi	a1,a1,-138 # 1270 <malloc+0x16e>
     302:	00001517          	auipc	a0,0x1
     306:	fde50513          	addi	a0,a0,-34 # 12e0 <malloc+0x1de>
     30a:	169000ef          	jal	c72 <link>
     30e:	bd8d                	j	180 <go+0xd6>
      unlink("../grindir/../a");
     310:	00001517          	auipc	a0,0x1
     314:	fe850513          	addi	a0,a0,-24 # 12f8 <malloc+0x1f6>
     318:	14b000ef          	jal	c62 <unlink>
      link(".././b", "/grindir/../a");
     31c:	00001597          	auipc	a1,0x1
     320:	f5c58593          	addi	a1,a1,-164 # 1278 <malloc+0x176>
     324:	00001517          	auipc	a0,0x1
     328:	fe450513          	addi	a0,a0,-28 # 1308 <malloc+0x206>
     32c:	147000ef          	jal	c72 <link>
     330:	bd81                	j	180 <go+0xd6>
      int pid = fork();
     332:	0d9000ef          	jal	c0a <fork>
      if(pid == 0){
     336:	c519                	beqz	a0,344 <go+0x29a>
      } else if(pid < 0){
     338:	00054863          	bltz	a0,348 <go+0x29e>
      wait(0);
     33c:	4501                	li	a0,0
     33e:	0dd000ef          	jal	c1a <wait>
     342:	bd3d                	j	180 <go+0xd6>
        exit(0);
     344:	0cf000ef          	jal	c12 <exit>
        printf("grind: fork failed\n");
     348:	00001517          	auipc	a0,0x1
     34c:	fc850513          	addi	a0,a0,-56 # 1310 <malloc+0x20e>
     350:	4fb000ef          	jal	104a <printf>
        exit(1);
     354:	4505                	li	a0,1
     356:	0bd000ef          	jal	c12 <exit>
      int pid = fork();
     35a:	0b1000ef          	jal	c0a <fork>
      if(pid == 0){
     35e:	c519                	beqz	a0,36c <go+0x2c2>
      } else if(pid < 0){
     360:	00054d63          	bltz	a0,37a <go+0x2d0>
      wait(0);
     364:	4501                	li	a0,0
     366:	0b5000ef          	jal	c1a <wait>
     36a:	bd19                	j	180 <go+0xd6>
        fork();
     36c:	09f000ef          	jal	c0a <fork>
        fork();
     370:	09b000ef          	jal	c0a <fork>
        exit(0);
     374:	4501                	li	a0,0
     376:	09d000ef          	jal	c12 <exit>
        printf("grind: fork failed\n");
     37a:	00001517          	auipc	a0,0x1
     37e:	f9650513          	addi	a0,a0,-106 # 1310 <malloc+0x20e>
     382:	4c9000ef          	jal	104a <printf>
        exit(1);
     386:	4505                	li	a0,1
     388:	08b000ef          	jal	c12 <exit>
      sbrk(6011);
     38c:	6505                	lui	a0,0x1
     38e:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x20b>
     392:	109000ef          	jal	c9a <sbrk>
     396:	b3ed                	j	180 <go+0xd6>
      if(sbrk(0) > break0)
     398:	4501                	li	a0,0
     39a:	101000ef          	jal	c9a <sbrk>
     39e:	f5843783          	ld	a5,-168(s0)
     3a2:	dca7ffe3          	bgeu	a5,a0,180 <go+0xd6>
        sbrk(-(sbrk(0) - break0));
     3a6:	4501                	li	a0,0
     3a8:	0f3000ef          	jal	c9a <sbrk>
     3ac:	f5843783          	ld	a5,-168(s0)
     3b0:	40a7853b          	subw	a0,a5,a0
     3b4:	0e7000ef          	jal	c9a <sbrk>
     3b8:	b3e1                	j	180 <go+0xd6>
      int pid = fork();
     3ba:	051000ef          	jal	c0a <fork>
     3be:	8d2a                	mv	s10,a0
      if(pid == 0){
     3c0:	c10d                	beqz	a0,3e2 <go+0x338>
      } else if(pid < 0){
     3c2:	02054d63          	bltz	a0,3fc <go+0x352>
      if(chdir("../grindir/..") != 0){
     3c6:	00001517          	auipc	a0,0x1
     3ca:	f6a50513          	addi	a0,a0,-150 # 1330 <malloc+0x22e>
     3ce:	0b5000ef          	jal	c82 <chdir>
     3d2:	ed15                	bnez	a0,40e <go+0x364>
      kill(pid);
     3d4:	856a                	mv	a0,s10
     3d6:	06d000ef          	jal	c42 <kill>
      wait(0);
     3da:	4501                	li	a0,0
     3dc:	03f000ef          	jal	c1a <wait>
     3e0:	b345                	j	180 <go+0xd6>
        close(open("a", O_CREATE|O_RDWR));
     3e2:	20200593          	li	a1,514
     3e6:	00001517          	auipc	a0,0x1
     3ea:	f4250513          	addi	a0,a0,-190 # 1328 <malloc+0x226>
     3ee:	065000ef          	jal	c52 <open>
     3f2:	049000ef          	jal	c3a <close>
        exit(0);
     3f6:	4501                	li	a0,0
     3f8:	01b000ef          	jal	c12 <exit>
        printf("grind: fork failed\n");
     3fc:	00001517          	auipc	a0,0x1
     400:	f1450513          	addi	a0,a0,-236 # 1310 <malloc+0x20e>
     404:	447000ef          	jal	104a <printf>
        exit(1);
     408:	4505                	li	a0,1
     40a:	009000ef          	jal	c12 <exit>
        printf("grind: chdir failed\n");
     40e:	00001517          	auipc	a0,0x1
     412:	f3250513          	addi	a0,a0,-206 # 1340 <malloc+0x23e>
     416:	435000ef          	jal	104a <printf>
        exit(1);
     41a:	4505                	li	a0,1
     41c:	7f6000ef          	jal	c12 <exit>
      int pid = fork();
     420:	7ea000ef          	jal	c0a <fork>
      if(pid == 0){
     424:	c519                	beqz	a0,432 <go+0x388>
      } else if(pid < 0){
     426:	00054d63          	bltz	a0,440 <go+0x396>
      wait(0);
     42a:	4501                	li	a0,0
     42c:	7ee000ef          	jal	c1a <wait>
     430:	bb81                	j	180 <go+0xd6>
        kill(getpid());
     432:	061000ef          	jal	c92 <getpid>
     436:	00d000ef          	jal	c42 <kill>
        exit(0);
     43a:	4501                	li	a0,0
     43c:	7d6000ef          	jal	c12 <exit>
        printf("grind: fork failed\n");
     440:	00001517          	auipc	a0,0x1
     444:	ed050513          	addi	a0,a0,-304 # 1310 <malloc+0x20e>
     448:	403000ef          	jal	104a <printf>
        exit(1);
     44c:	4505                	li	a0,1
     44e:	7c4000ef          	jal	c12 <exit>
      if(pipe(fds) < 0){
     452:	f7840513          	addi	a0,s0,-136
     456:	7cc000ef          	jal	c22 <pipe>
     45a:	02054363          	bltz	a0,480 <go+0x3d6>
      int pid = fork();
     45e:	7ac000ef          	jal	c0a <fork>
      if(pid == 0){
     462:	c905                	beqz	a0,492 <go+0x3e8>
      } else if(pid < 0){
     464:	08054263          	bltz	a0,4e8 <go+0x43e>
      close(fds[0]);
     468:	f7842503          	lw	a0,-136(s0)
     46c:	7ce000ef          	jal	c3a <close>
      close(fds[1]);
     470:	f7c42503          	lw	a0,-132(s0)
     474:	7c6000ef          	jal	c3a <close>
      wait(0);
     478:	4501                	li	a0,0
     47a:	7a0000ef          	jal	c1a <wait>
     47e:	b309                	j	180 <go+0xd6>
        printf("grind: pipe failed\n");
     480:	00001517          	auipc	a0,0x1
     484:	ed850513          	addi	a0,a0,-296 # 1358 <malloc+0x256>
     488:	3c3000ef          	jal	104a <printf>
        exit(1);
     48c:	4505                	li	a0,1
     48e:	784000ef          	jal	c12 <exit>
        fork();
     492:	778000ef          	jal	c0a <fork>
        fork();
     496:	774000ef          	jal	c0a <fork>
        if(write(fds[1], "x", 1) != 1)
     49a:	4605                	li	a2,1
     49c:	00001597          	auipc	a1,0x1
     4a0:	ed458593          	addi	a1,a1,-300 # 1370 <malloc+0x26e>
     4a4:	f7c42503          	lw	a0,-132(s0)
     4a8:	78a000ef          	jal	c32 <write>
     4ac:	4785                	li	a5,1
     4ae:	00f51f63          	bne	a0,a5,4cc <go+0x422>
        if(read(fds[0], &c, 1) != 1)
     4b2:	4605                	li	a2,1
     4b4:	f7040593          	addi	a1,s0,-144
     4b8:	f7842503          	lw	a0,-136(s0)
     4bc:	76e000ef          	jal	c2a <read>
     4c0:	4785                	li	a5,1
     4c2:	00f51c63          	bne	a0,a5,4da <go+0x430>
        exit(0);
     4c6:	4501                	li	a0,0
     4c8:	74a000ef          	jal	c12 <exit>
          printf("grind: pipe write failed\n");
     4cc:	00001517          	auipc	a0,0x1
     4d0:	eac50513          	addi	a0,a0,-340 # 1378 <malloc+0x276>
     4d4:	377000ef          	jal	104a <printf>
     4d8:	bfe9                	j	4b2 <go+0x408>
          printf("grind: pipe read failed\n");
     4da:	00001517          	auipc	a0,0x1
     4de:	ebe50513          	addi	a0,a0,-322 # 1398 <malloc+0x296>
     4e2:	369000ef          	jal	104a <printf>
     4e6:	b7c5                	j	4c6 <go+0x41c>
        printf("grind: fork failed\n");
     4e8:	00001517          	auipc	a0,0x1
     4ec:	e2850513          	addi	a0,a0,-472 # 1310 <malloc+0x20e>
     4f0:	35b000ef          	jal	104a <printf>
        exit(1);
     4f4:	4505                	li	a0,1
     4f6:	71c000ef          	jal	c12 <exit>
      int pid = fork();
     4fa:	710000ef          	jal	c0a <fork>
      if(pid == 0){
     4fe:	c519                	beqz	a0,50c <go+0x462>
      } else if(pid < 0){
     500:	04054f63          	bltz	a0,55e <go+0x4b4>
      wait(0);
     504:	4501                	li	a0,0
     506:	714000ef          	jal	c1a <wait>
     50a:	b99d                	j	180 <go+0xd6>
        unlink("a");
     50c:	00001517          	auipc	a0,0x1
     510:	e1c50513          	addi	a0,a0,-484 # 1328 <malloc+0x226>
     514:	74e000ef          	jal	c62 <unlink>
        mkdir("a");
     518:	00001517          	auipc	a0,0x1
     51c:	e1050513          	addi	a0,a0,-496 # 1328 <malloc+0x226>
     520:	75a000ef          	jal	c7a <mkdir>
        chdir("a");
     524:	00001517          	auipc	a0,0x1
     528:	e0450513          	addi	a0,a0,-508 # 1328 <malloc+0x226>
     52c:	756000ef          	jal	c82 <chdir>
        unlink("../a");
     530:	00001517          	auipc	a0,0x1
     534:	e8850513          	addi	a0,a0,-376 # 13b8 <malloc+0x2b6>
     538:	72a000ef          	jal	c62 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     53c:	20200593          	li	a1,514
     540:	00001517          	auipc	a0,0x1
     544:	e3050513          	addi	a0,a0,-464 # 1370 <malloc+0x26e>
     548:	70a000ef          	jal	c52 <open>
        unlink("x");
     54c:	00001517          	auipc	a0,0x1
     550:	e2450513          	addi	a0,a0,-476 # 1370 <malloc+0x26e>
     554:	70e000ef          	jal	c62 <unlink>
        exit(0);
     558:	4501                	li	a0,0
     55a:	6b8000ef          	jal	c12 <exit>
        printf("grind: fork failed\n");
     55e:	00001517          	auipc	a0,0x1
     562:	db250513          	addi	a0,a0,-590 # 1310 <malloc+0x20e>
     566:	2e5000ef          	jal	104a <printf>
        exit(1);
     56a:	4505                	li	a0,1
     56c:	6a6000ef          	jal	c12 <exit>
      unlink("c");
     570:	00001517          	auipc	a0,0x1
     574:	e5050513          	addi	a0,a0,-432 # 13c0 <malloc+0x2be>
     578:	6ea000ef          	jal	c62 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     57c:	20200593          	li	a1,514
     580:	00001517          	auipc	a0,0x1
     584:	e4050513          	addi	a0,a0,-448 # 13c0 <malloc+0x2be>
     588:	6ca000ef          	jal	c52 <open>
     58c:	8d2a                	mv	s10,a0
      if(fd1 < 0){
     58e:	04054563          	bltz	a0,5d8 <go+0x52e>
      if(write(fd1, "x", 1) != 1){
     592:	8652                	mv	a2,s4
     594:	00001597          	auipc	a1,0x1
     598:	ddc58593          	addi	a1,a1,-548 # 1370 <malloc+0x26e>
     59c:	696000ef          	jal	c32 <write>
     5a0:	05451563          	bne	a0,s4,5ea <go+0x540>
      if(fstat(fd1, &st) != 0){
     5a4:	f7840593          	addi	a1,s0,-136
     5a8:	856a                	mv	a0,s10
     5aa:	6c0000ef          	jal	c6a <fstat>
     5ae:	e539                	bnez	a0,5fc <go+0x552>
      if(st.size != 1){
     5b0:	f8843583          	ld	a1,-120(s0)
     5b4:	05459d63          	bne	a1,s4,60e <go+0x564>
      if(st.ino > 200){
     5b8:	f7c42583          	lw	a1,-132(s0)
     5bc:	0c800793          	li	a5,200
     5c0:	06b7e163          	bltu	a5,a1,622 <go+0x578>
      close(fd1);
     5c4:	856a                	mv	a0,s10
     5c6:	674000ef          	jal	c3a <close>
      unlink("c");
     5ca:	00001517          	auipc	a0,0x1
     5ce:	df650513          	addi	a0,a0,-522 # 13c0 <malloc+0x2be>
     5d2:	690000ef          	jal	c62 <unlink>
     5d6:	b66d                	j	180 <go+0xd6>
        printf("grind: create c failed\n");
     5d8:	00001517          	auipc	a0,0x1
     5dc:	df050513          	addi	a0,a0,-528 # 13c8 <malloc+0x2c6>
     5e0:	26b000ef          	jal	104a <printf>
        exit(1);
     5e4:	4505                	li	a0,1
     5e6:	62c000ef          	jal	c12 <exit>
        printf("grind: write c failed\n");
     5ea:	00001517          	auipc	a0,0x1
     5ee:	df650513          	addi	a0,a0,-522 # 13e0 <malloc+0x2de>
     5f2:	259000ef          	jal	104a <printf>
        exit(1);
     5f6:	4505                	li	a0,1
     5f8:	61a000ef          	jal	c12 <exit>
        printf("grind: fstat failed\n");
     5fc:	00001517          	auipc	a0,0x1
     600:	dfc50513          	addi	a0,a0,-516 # 13f8 <malloc+0x2f6>
     604:	247000ef          	jal	104a <printf>
        exit(1);
     608:	4505                	li	a0,1
     60a:	608000ef          	jal	c12 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     60e:	2581                	sext.w	a1,a1
     610:	00001517          	auipc	a0,0x1
     614:	e0050513          	addi	a0,a0,-512 # 1410 <malloc+0x30e>
     618:	233000ef          	jal	104a <printf>
        exit(1);
     61c:	4505                	li	a0,1
     61e:	5f4000ef          	jal	c12 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     622:	00001517          	auipc	a0,0x1
     626:	e1650513          	addi	a0,a0,-490 # 1438 <malloc+0x336>
     62a:	221000ef          	jal	104a <printf>
        exit(1);
     62e:	4505                	li	a0,1
     630:	5e2000ef          	jal	c12 <exit>
      if(pipe(aa) < 0){
     634:	856e                	mv	a0,s11
     636:	5ec000ef          	jal	c22 <pipe>
     63a:	0a054863          	bltz	a0,6ea <go+0x640>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     63e:	f7040513          	addi	a0,s0,-144
     642:	5e0000ef          	jal	c22 <pipe>
     646:	0a054c63          	bltz	a0,6fe <go+0x654>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     64a:	5c0000ef          	jal	c0a <fork>
      if(pid1 == 0){
     64e:	0c050263          	beqz	a0,712 <go+0x668>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     652:	14054463          	bltz	a0,79a <go+0x6f0>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     656:	5b4000ef          	jal	c0a <fork>
      if(pid2 == 0){
     65a:	14050a63          	beqz	a0,7ae <go+0x704>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     65e:	1e054863          	bltz	a0,84e <go+0x7a4>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     662:	f6842503          	lw	a0,-152(s0)
     666:	5d4000ef          	jal	c3a <close>
      close(aa[1]);
     66a:	f6c42503          	lw	a0,-148(s0)
     66e:	5cc000ef          	jal	c3a <close>
      close(bb[1]);
     672:	f7442503          	lw	a0,-140(s0)
     676:	5c4000ef          	jal	c3a <close>
      char buf[4] = { 0, 0, 0, 0 };
     67a:	f6042023          	sw	zero,-160(s0)
      read(bb[0], buf+0, 1);
     67e:	8652                	mv	a2,s4
     680:	f6040593          	addi	a1,s0,-160
     684:	f7042503          	lw	a0,-144(s0)
     688:	5a2000ef          	jal	c2a <read>
      read(bb[0], buf+1, 1);
     68c:	8652                	mv	a2,s4
     68e:	f6140593          	addi	a1,s0,-159
     692:	f7042503          	lw	a0,-144(s0)
     696:	594000ef          	jal	c2a <read>
      read(bb[0], buf+2, 1);
     69a:	8652                	mv	a2,s4
     69c:	f6240593          	addi	a1,s0,-158
     6a0:	f7042503          	lw	a0,-144(s0)
     6a4:	586000ef          	jal	c2a <read>
      close(bb[0]);
     6a8:	f7042503          	lw	a0,-144(s0)
     6ac:	58e000ef          	jal	c3a <close>
      int st1, st2;
      wait(&st1);
     6b0:	f6440513          	addi	a0,s0,-156
     6b4:	566000ef          	jal	c1a <wait>
      wait(&st2);
     6b8:	f7840513          	addi	a0,s0,-136
     6bc:	55e000ef          	jal	c1a <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     6c0:	f6442783          	lw	a5,-156(s0)
     6c4:	f7842703          	lw	a4,-136(s0)
     6c8:	f4e43823          	sd	a4,-176(s0)
     6cc:	00e7ed33          	or	s10,a5,a4
     6d0:	180d1963          	bnez	s10,862 <go+0x7b8>
     6d4:	00001597          	auipc	a1,0x1
     6d8:	e0458593          	addi	a1,a1,-508 # 14d8 <malloc+0x3d6>
     6dc:	f6040513          	addi	a0,s0,-160
     6e0:	2d8000ef          	jal	9b8 <strcmp>
     6e4:	a8050ee3          	beqz	a0,180 <go+0xd6>
     6e8:	aab5                	j	864 <go+0x7ba>
        fprintf(2, "grind: pipe failed\n");
     6ea:	00001597          	auipc	a1,0x1
     6ee:	c6e58593          	addi	a1,a1,-914 # 1358 <malloc+0x256>
     6f2:	4509                	li	a0,2
     6f4:	12d000ef          	jal	1020 <fprintf>
        exit(1);
     6f8:	4505                	li	a0,1
     6fa:	518000ef          	jal	c12 <exit>
        fprintf(2, "grind: pipe failed\n");
     6fe:	00001597          	auipc	a1,0x1
     702:	c5a58593          	addi	a1,a1,-934 # 1358 <malloc+0x256>
     706:	4509                	li	a0,2
     708:	119000ef          	jal	1020 <fprintf>
        exit(1);
     70c:	4505                	li	a0,1
     70e:	504000ef          	jal	c12 <exit>
        close(bb[0]);
     712:	f7042503          	lw	a0,-144(s0)
     716:	524000ef          	jal	c3a <close>
        close(bb[1]);
     71a:	f7442503          	lw	a0,-140(s0)
     71e:	51c000ef          	jal	c3a <close>
        close(aa[0]);
     722:	f6842503          	lw	a0,-152(s0)
     726:	514000ef          	jal	c3a <close>
        close(1);
     72a:	4505                	li	a0,1
     72c:	50e000ef          	jal	c3a <close>
        if(dup(aa[1]) != 1){
     730:	f6c42503          	lw	a0,-148(s0)
     734:	556000ef          	jal	c8a <dup>
     738:	4785                	li	a5,1
     73a:	00f50c63          	beq	a0,a5,752 <go+0x6a8>
          fprintf(2, "grind: dup failed\n");
     73e:	00001597          	auipc	a1,0x1
     742:	d2258593          	addi	a1,a1,-734 # 1460 <malloc+0x35e>
     746:	4509                	li	a0,2
     748:	0d9000ef          	jal	1020 <fprintf>
          exit(1);
     74c:	4505                	li	a0,1
     74e:	4c4000ef          	jal	c12 <exit>
        close(aa[1]);
     752:	f6c42503          	lw	a0,-148(s0)
     756:	4e4000ef          	jal	c3a <close>
        char *args[3] = { "echo", "hi", 0 };
     75a:	00001797          	auipc	a5,0x1
     75e:	d1e78793          	addi	a5,a5,-738 # 1478 <malloc+0x376>
     762:	f6f43c23          	sd	a5,-136(s0)
     766:	00001797          	auipc	a5,0x1
     76a:	d1a78793          	addi	a5,a5,-742 # 1480 <malloc+0x37e>
     76e:	f8f43023          	sd	a5,-128(s0)
     772:	f8043423          	sd	zero,-120(s0)
        exec("grindir/../echo", args);
     776:	f7840593          	addi	a1,s0,-136
     77a:	00001517          	auipc	a0,0x1
     77e:	d0e50513          	addi	a0,a0,-754 # 1488 <malloc+0x386>
     782:	4c8000ef          	jal	c4a <exec>
        fprintf(2, "grind: echo: not found\n");
     786:	00001597          	auipc	a1,0x1
     78a:	d1258593          	addi	a1,a1,-750 # 1498 <malloc+0x396>
     78e:	4509                	li	a0,2
     790:	091000ef          	jal	1020 <fprintf>
        exit(2);
     794:	4509                	li	a0,2
     796:	47c000ef          	jal	c12 <exit>
        fprintf(2, "grind: fork failed\n");
     79a:	00001597          	auipc	a1,0x1
     79e:	b7658593          	addi	a1,a1,-1162 # 1310 <malloc+0x20e>
     7a2:	4509                	li	a0,2
     7a4:	07d000ef          	jal	1020 <fprintf>
        exit(3);
     7a8:	450d                	li	a0,3
     7aa:	468000ef          	jal	c12 <exit>
        close(aa[1]);
     7ae:	f6c42503          	lw	a0,-148(s0)
     7b2:	488000ef          	jal	c3a <close>
        close(bb[0]);
     7b6:	f7042503          	lw	a0,-144(s0)
     7ba:	480000ef          	jal	c3a <close>
        close(0);
     7be:	4501                	li	a0,0
     7c0:	47a000ef          	jal	c3a <close>
        if(dup(aa[0]) != 0){
     7c4:	f6842503          	lw	a0,-152(s0)
     7c8:	4c2000ef          	jal	c8a <dup>
     7cc:	c919                	beqz	a0,7e2 <go+0x738>
          fprintf(2, "grind: dup failed\n");
     7ce:	00001597          	auipc	a1,0x1
     7d2:	c9258593          	addi	a1,a1,-878 # 1460 <malloc+0x35e>
     7d6:	4509                	li	a0,2
     7d8:	049000ef          	jal	1020 <fprintf>
          exit(4);
     7dc:	4511                	li	a0,4
     7de:	434000ef          	jal	c12 <exit>
        close(aa[0]);
     7e2:	f6842503          	lw	a0,-152(s0)
     7e6:	454000ef          	jal	c3a <close>
        close(1);
     7ea:	4505                	li	a0,1
     7ec:	44e000ef          	jal	c3a <close>
        if(dup(bb[1]) != 1){
     7f0:	f7442503          	lw	a0,-140(s0)
     7f4:	496000ef          	jal	c8a <dup>
     7f8:	4785                	li	a5,1
     7fa:	00f50c63          	beq	a0,a5,812 <go+0x768>
          fprintf(2, "grind: dup failed\n");
     7fe:	00001597          	auipc	a1,0x1
     802:	c6258593          	addi	a1,a1,-926 # 1460 <malloc+0x35e>
     806:	4509                	li	a0,2
     808:	019000ef          	jal	1020 <fprintf>
          exit(5);
     80c:	4515                	li	a0,5
     80e:	404000ef          	jal	c12 <exit>
        close(bb[1]);
     812:	f7442503          	lw	a0,-140(s0)
     816:	424000ef          	jal	c3a <close>
        char *args[2] = { "cat", 0 };
     81a:	00001797          	auipc	a5,0x1
     81e:	c9678793          	addi	a5,a5,-874 # 14b0 <malloc+0x3ae>
     822:	f6f43c23          	sd	a5,-136(s0)
     826:	f8043023          	sd	zero,-128(s0)
        exec("/cat", args);
     82a:	f7840593          	addi	a1,s0,-136
     82e:	00001517          	auipc	a0,0x1
     832:	c8a50513          	addi	a0,a0,-886 # 14b8 <malloc+0x3b6>
     836:	414000ef          	jal	c4a <exec>
        fprintf(2, "grind: cat: not found\n");
     83a:	00001597          	auipc	a1,0x1
     83e:	c8658593          	addi	a1,a1,-890 # 14c0 <malloc+0x3be>
     842:	4509                	li	a0,2
     844:	7dc000ef          	jal	1020 <fprintf>
        exit(6);
     848:	4519                	li	a0,6
     84a:	3c8000ef          	jal	c12 <exit>
        fprintf(2, "grind: fork failed\n");
     84e:	00001597          	auipc	a1,0x1
     852:	ac258593          	addi	a1,a1,-1342 # 1310 <malloc+0x20e>
     856:	4509                	li	a0,2
     858:	7c8000ef          	jal	1020 <fprintf>
        exit(7);
     85c:	451d                	li	a0,7
     85e:	3b4000ef          	jal	c12 <exit>
     862:	8d3e                	mv	s10,a5
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     864:	f6040693          	addi	a3,s0,-160
     868:	f5043603          	ld	a2,-176(s0)
     86c:	85ea                	mv	a1,s10
     86e:	00001517          	auipc	a0,0x1
     872:	c7250513          	addi	a0,a0,-910 # 14e0 <malloc+0x3de>
     876:	7d4000ef          	jal	104a <printf>
        exit(1);
     87a:	4505                	li	a0,1
     87c:	396000ef          	jal	c12 <exit>

0000000000000880 <iter>:
  }
}

void
iter()
{
     880:	7179                	addi	sp,sp,-48
     882:	f406                	sd	ra,40(sp)
     884:	f022                	sd	s0,32(sp)
     886:	1800                	addi	s0,sp,48
  unlink("a");
     888:	00001517          	auipc	a0,0x1
     88c:	aa050513          	addi	a0,a0,-1376 # 1328 <malloc+0x226>
     890:	3d2000ef          	jal	c62 <unlink>
  unlink("b");
     894:	00001517          	auipc	a0,0x1
     898:	a4450513          	addi	a0,a0,-1468 # 12d8 <malloc+0x1d6>
     89c:	3c6000ef          	jal	c62 <unlink>
  
  int pid1 = fork();
     8a0:	36a000ef          	jal	c0a <fork>
  if(pid1 < 0){
     8a4:	02054163          	bltz	a0,8c6 <iter+0x46>
     8a8:	ec26                	sd	s1,24(sp)
     8aa:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     8ac:	e905                	bnez	a0,8dc <iter+0x5c>
     8ae:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     8b0:	00001717          	auipc	a4,0x1
     8b4:	75070713          	addi	a4,a4,1872 # 2000 <rand_next>
     8b8:	631c                	ld	a5,0(a4)
     8ba:	01f7c793          	xori	a5,a5,31
     8be:	e31c                	sd	a5,0(a4)
    go(0);
     8c0:	4501                	li	a0,0
     8c2:	fe8ff0ef          	jal	aa <go>
     8c6:	ec26                	sd	s1,24(sp)
     8c8:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     8ca:	00001517          	auipc	a0,0x1
     8ce:	a4650513          	addi	a0,a0,-1466 # 1310 <malloc+0x20e>
     8d2:	778000ef          	jal	104a <printf>
    exit(1);
     8d6:	4505                	li	a0,1
     8d8:	33a000ef          	jal	c12 <exit>
     8dc:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     8de:	32c000ef          	jal	c0a <fork>
     8e2:	892a                	mv	s2,a0
  if(pid2 < 0){
     8e4:	02054063          	bltz	a0,904 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     8e8:	e51d                	bnez	a0,916 <iter+0x96>
    rand_next ^= 7177;
     8ea:	00001697          	auipc	a3,0x1
     8ee:	71668693          	addi	a3,a3,1814 # 2000 <rand_next>
     8f2:	629c                	ld	a5,0(a3)
     8f4:	6709                	lui	a4,0x2
     8f6:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x699>
     8fa:	8fb9                	xor	a5,a5,a4
     8fc:	e29c                	sd	a5,0(a3)
    go(1);
     8fe:	4505                	li	a0,1
     900:	faaff0ef          	jal	aa <go>
    printf("grind: fork failed\n");
     904:	00001517          	auipc	a0,0x1
     908:	a0c50513          	addi	a0,a0,-1524 # 1310 <malloc+0x20e>
     90c:	73e000ef          	jal	104a <printf>
    exit(1);
     910:	4505                	li	a0,1
     912:	300000ef          	jal	c12 <exit>
    exit(0);
  }

  int st1 = -1;
     916:	57fd                	li	a5,-1
     918:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     91c:	fdc40513          	addi	a0,s0,-36
     920:	2fa000ef          	jal	c1a <wait>
  if(st1 != 0){
     924:	fdc42783          	lw	a5,-36(s0)
     928:	eb99                	bnez	a5,93e <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     92a:	57fd                	li	a5,-1
     92c:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     930:	fd840513          	addi	a0,s0,-40
     934:	2e6000ef          	jal	c1a <wait>

  exit(0);
     938:	4501                	li	a0,0
     93a:	2d8000ef          	jal	c12 <exit>
    kill(pid1);
     93e:	8526                	mv	a0,s1
     940:	302000ef          	jal	c42 <kill>
    kill(pid2);
     944:	854a                	mv	a0,s2
     946:	2fc000ef          	jal	c42 <kill>
     94a:	b7c5                	j	92a <iter+0xaa>

000000000000094c <main>:
}

int
main()
{
     94c:	1101                	addi	sp,sp,-32
     94e:	ec06                	sd	ra,24(sp)
     950:	e822                	sd	s0,16(sp)
     952:	e426                	sd	s1,8(sp)
     954:	e04a                	sd	s2,0(sp)
     956:	1000                	addi	s0,sp,32
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     958:	4951                	li	s2,20
    rand_next += 1;
     95a:	00001497          	auipc	s1,0x1
     95e:	6a648493          	addi	s1,s1,1702 # 2000 <rand_next>
     962:	a809                	j	974 <main+0x28>
      iter();
     964:	f1dff0ef          	jal	880 <iter>
    sleep(20);
     968:	854a                	mv	a0,s2
     96a:	338000ef          	jal	ca2 <sleep>
    rand_next += 1;
     96e:	609c                	ld	a5,0(s1)
     970:	0785                	addi	a5,a5,1
     972:	e09c                	sd	a5,0(s1)
    int pid = fork();
     974:	296000ef          	jal	c0a <fork>
    if(pid == 0){
     978:	d575                	beqz	a0,964 <main+0x18>
    if(pid > 0){
     97a:	fea057e3          	blez	a0,968 <main+0x1c>
      wait(0);
     97e:	4501                	li	a0,0
     980:	29a000ef          	jal	c1a <wait>
     984:	b7d5                	j	968 <main+0x1c>

0000000000000986 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
     986:	1141                	addi	sp,sp,-16
     988:	e406                	sd	ra,8(sp)
     98a:	e022                	sd	s0,0(sp)
     98c:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
     98e:	fbfff0ef          	jal	94c <main>
  exit (0);
     992:	4501                	li	a0,0
     994:	27e000ef          	jal	c12 <exit>

0000000000000998 <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
     998:	1141                	addi	sp,sp,-16
     99a:	e406                	sd	ra,8(sp)
     99c:	e022                	sd	s0,0(sp)
     99e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
     9a0:	87aa                	mv	a5,a0
     9a2:	0585                	addi	a1,a1,1
     9a4:	0785                	addi	a5,a5,1
     9a6:	fff5c703          	lbu	a4,-1(a1)
     9aa:	fee78fa3          	sb	a4,-1(a5)
     9ae:	fb75                	bnez	a4,9a2 <strcpy+0xa>
    ;
  return os;
}
     9b0:	60a2                	ld	ra,8(sp)
     9b2:	6402                	ld	s0,0(sp)
     9b4:	0141                	addi	sp,sp,16
     9b6:	8082                	ret

00000000000009b8 <strcmp>:

int
strcmp (const char *p, const char *q)
{
     9b8:	1141                	addi	sp,sp,-16
     9ba:	e406                	sd	ra,8(sp)
     9bc:	e022                	sd	s0,0(sp)
     9be:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
     9c0:	00054783          	lbu	a5,0(a0)
     9c4:	cb91                	beqz	a5,9d8 <strcmp+0x20>
     9c6:	0005c703          	lbu	a4,0(a1)
     9ca:	00f71763          	bne	a4,a5,9d8 <strcmp+0x20>
    p++, q++;
     9ce:	0505                	addi	a0,a0,1
     9d0:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
     9d2:	00054783          	lbu	a5,0(a0)
     9d6:	fbe5                	bnez	a5,9c6 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     9d8:	0005c503          	lbu	a0,0(a1)
}
     9dc:	40a7853b          	subw	a0,a5,a0
     9e0:	60a2                	ld	ra,8(sp)
     9e2:	6402                	ld	s0,0(sp)
     9e4:	0141                	addi	sp,sp,16
     9e6:	8082                	ret

00000000000009e8 <strlen>:

uint
strlen (const char *s)
{
     9e8:	1141                	addi	sp,sp,-16
     9ea:	e406                	sd	ra,8(sp)
     9ec:	e022                	sd	s0,0(sp)
     9ee:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
     9f0:	00054783          	lbu	a5,0(a0)
     9f4:	cf91                	beqz	a5,a10 <strlen+0x28>
     9f6:	00150793          	addi	a5,a0,1
     9fa:	86be                	mv	a3,a5
     9fc:	0785                	addi	a5,a5,1
     9fe:	fff7c703          	lbu	a4,-1(a5)
     a02:	ff65                	bnez	a4,9fa <strlen+0x12>
     a04:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     a08:	60a2                	ld	ra,8(sp)
     a0a:	6402                	ld	s0,0(sp)
     a0c:	0141                	addi	sp,sp,16
     a0e:	8082                	ret
  for (n = 0; s[n]; n++)
     a10:	4501                	li	a0,0
     a12:	bfdd                	j	a08 <strlen+0x20>

0000000000000a14 <memset>:

void *
memset (void *dst, int c, uint n)
{
     a14:	1141                	addi	sp,sp,-16
     a16:	e406                	sd	ra,8(sp)
     a18:	e022                	sd	s0,0(sp)
     a1a:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
     a1c:	ca19                	beqz	a2,a32 <memset+0x1e>
     a1e:	87aa                	mv	a5,a0
     a20:	1602                	slli	a2,a2,0x20
     a22:	9201                	srli	a2,a2,0x20
     a24:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
     a28:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
     a2c:	0785                	addi	a5,a5,1
     a2e:	fee79de3          	bne	a5,a4,a28 <memset+0x14>
    }
  return dst;
}
     a32:	60a2                	ld	ra,8(sp)
     a34:	6402                	ld	s0,0(sp)
     a36:	0141                	addi	sp,sp,16
     a38:	8082                	ret

0000000000000a3a <strchr>:

char *
strchr (const char *s, char c)
{
     a3a:	1141                	addi	sp,sp,-16
     a3c:	e406                	sd	ra,8(sp)
     a3e:	e022                	sd	s0,0(sp)
     a40:	0800                	addi	s0,sp,16
  for (; *s; s++)
     a42:	00054783          	lbu	a5,0(a0)
     a46:	cf81                	beqz	a5,a5e <strchr+0x24>
    if (*s == c)
     a48:	00f58763          	beq	a1,a5,a56 <strchr+0x1c>
  for (; *s; s++)
     a4c:	0505                	addi	a0,a0,1
     a4e:	00054783          	lbu	a5,0(a0)
     a52:	fbfd                	bnez	a5,a48 <strchr+0xe>
      return (char *)s;
  return 0;
     a54:	4501                	li	a0,0
}
     a56:	60a2                	ld	ra,8(sp)
     a58:	6402                	ld	s0,0(sp)
     a5a:	0141                	addi	sp,sp,16
     a5c:	8082                	ret
  return 0;
     a5e:	4501                	li	a0,0
     a60:	bfdd                	j	a56 <strchr+0x1c>

0000000000000a62 <gets>:

char *
gets (char *buf, int max)
{
     a62:	711d                	addi	sp,sp,-96
     a64:	ec86                	sd	ra,88(sp)
     a66:	e8a2                	sd	s0,80(sp)
     a68:	e4a6                	sd	s1,72(sp)
     a6a:	e0ca                	sd	s2,64(sp)
     a6c:	fc4e                	sd	s3,56(sp)
     a6e:	f852                	sd	s4,48(sp)
     a70:	f456                	sd	s5,40(sp)
     a72:	f05a                	sd	s6,32(sp)
     a74:	ec5e                	sd	s7,24(sp)
     a76:	e862                	sd	s8,16(sp)
     a78:	1080                	addi	s0,sp,96
     a7a:	8baa                	mv	s7,a0
     a7c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
     a7e:	892a                	mv	s2,a0
     a80:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
     a82:	faf40b13          	addi	s6,s0,-81
     a86:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
     a88:	8c26                	mv	s8,s1
     a8a:	0014899b          	addiw	s3,s1,1
     a8e:	84ce                	mv	s1,s3
     a90:	0349d463          	bge	s3,s4,ab8 <gets+0x56>
      cc = read (0, &c, 1);
     a94:	8656                	mv	a2,s5
     a96:	85da                	mv	a1,s6
     a98:	4501                	li	a0,0
     a9a:	190000ef          	jal	c2a <read>
      if (cc < 1)
     a9e:	00a05d63          	blez	a0,ab8 <gets+0x56>
        break;
      buf[i++] = c;
     aa2:	faf44783          	lbu	a5,-81(s0)
     aa6:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
     aaa:	0905                	addi	s2,s2,1
     aac:	ff678713          	addi	a4,a5,-10
     ab0:	c319                	beqz	a4,ab6 <gets+0x54>
     ab2:	17cd                	addi	a5,a5,-13
     ab4:	fbf1                	bnez	a5,a88 <gets+0x26>
      buf[i++] = c;
     ab6:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
     ab8:	9c5e                	add	s8,s8,s7
     aba:	000c0023          	sb	zero,0(s8)
  return buf;
}
     abe:	855e                	mv	a0,s7
     ac0:	60e6                	ld	ra,88(sp)
     ac2:	6446                	ld	s0,80(sp)
     ac4:	64a6                	ld	s1,72(sp)
     ac6:	6906                	ld	s2,64(sp)
     ac8:	79e2                	ld	s3,56(sp)
     aca:	7a42                	ld	s4,48(sp)
     acc:	7aa2                	ld	s5,40(sp)
     ace:	7b02                	ld	s6,32(sp)
     ad0:	6be2                	ld	s7,24(sp)
     ad2:	6c42                	ld	s8,16(sp)
     ad4:	6125                	addi	sp,sp,96
     ad6:	8082                	ret

0000000000000ad8 <stat>:

int
stat (const char *n, struct stat *st)
{
     ad8:	1101                	addi	sp,sp,-32
     ada:	ec06                	sd	ra,24(sp)
     adc:	e822                	sd	s0,16(sp)
     ade:	e04a                	sd	s2,0(sp)
     ae0:	1000                	addi	s0,sp,32
     ae2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
     ae4:	4581                	li	a1,0
     ae6:	16c000ef          	jal	c52 <open>
  if (fd < 0)
     aea:	02054263          	bltz	a0,b0e <stat+0x36>
     aee:	e426                	sd	s1,8(sp)
     af0:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
     af2:	85ca                	mv	a1,s2
     af4:	176000ef          	jal	c6a <fstat>
     af8:	892a                	mv	s2,a0
  close (fd);
     afa:	8526                	mv	a0,s1
     afc:	13e000ef          	jal	c3a <close>
  return r;
     b00:	64a2                	ld	s1,8(sp)
}
     b02:	854a                	mv	a0,s2
     b04:	60e2                	ld	ra,24(sp)
     b06:	6442                	ld	s0,16(sp)
     b08:	6902                	ld	s2,0(sp)
     b0a:	6105                	addi	sp,sp,32
     b0c:	8082                	ret
    return -1;
     b0e:	57fd                	li	a5,-1
     b10:	893e                	mv	s2,a5
     b12:	bfc5                	j	b02 <stat+0x2a>

0000000000000b14 <atoi>:

int
atoi (const char *s)
{
     b14:	1141                	addi	sp,sp,-16
     b16:	e406                	sd	ra,8(sp)
     b18:	e022                	sd	s0,0(sp)
     b1a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
     b1c:	00054683          	lbu	a3,0(a0)
     b20:	fd06879b          	addiw	a5,a3,-48
     b24:	0ff7f793          	zext.b	a5,a5
     b28:	4625                	li	a2,9
     b2a:	02f66963          	bltu	a2,a5,b5c <atoi+0x48>
     b2e:	872a                	mv	a4,a0
  n = 0;
     b30:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
     b32:	0705                	addi	a4,a4,1
     b34:	0025179b          	slliw	a5,a0,0x2
     b38:	9fa9                	addw	a5,a5,a0
     b3a:	0017979b          	slliw	a5,a5,0x1
     b3e:	9fb5                	addw	a5,a5,a3
     b40:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
     b44:	00074683          	lbu	a3,0(a4)
     b48:	fd06879b          	addiw	a5,a3,-48
     b4c:	0ff7f793          	zext.b	a5,a5
     b50:	fef671e3          	bgeu	a2,a5,b32 <atoi+0x1e>
  return n;
}
     b54:	60a2                	ld	ra,8(sp)
     b56:	6402                	ld	s0,0(sp)
     b58:	0141                	addi	sp,sp,16
     b5a:	8082                	ret
  n = 0;
     b5c:	4501                	li	a0,0
     b5e:	bfdd                	j	b54 <atoi+0x40>

0000000000000b60 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
     b60:	1141                	addi	sp,sp,-16
     b62:	e406                	sd	ra,8(sp)
     b64:	e022                	sd	s0,0(sp)
     b66:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
     b68:	02b57563          	bgeu	a0,a1,b92 <memmove+0x32>
    {
      while (n-- > 0)
     b6c:	00c05f63          	blez	a2,b8a <memmove+0x2a>
     b70:	1602                	slli	a2,a2,0x20
     b72:	9201                	srli	a2,a2,0x20
     b74:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b78:	872a                	mv	a4,a0
        *dst++ = *src++;
     b7a:	0585                	addi	a1,a1,1
     b7c:	0705                	addi	a4,a4,1
     b7e:	fff5c683          	lbu	a3,-1(a1)
     b82:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
     b86:	fee79ae3          	bne	a5,a4,b7a <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
     b8a:	60a2                	ld	ra,8(sp)
     b8c:	6402                	ld	s0,0(sp)
     b8e:	0141                	addi	sp,sp,16
     b90:	8082                	ret
      while (n-- > 0)
     b92:	fec05ce3          	blez	a2,b8a <memmove+0x2a>
      dst += n;
     b96:	00c50733          	add	a4,a0,a2
      src += n;
     b9a:	95b2                	add	a1,a1,a2
     b9c:	fff6079b          	addiw	a5,a2,-1
     ba0:	1782                	slli	a5,a5,0x20
     ba2:	9381                	srli	a5,a5,0x20
     ba4:	fff7c793          	not	a5,a5
     ba8:	97ba                	add	a5,a5,a4
        *--dst = *--src;
     baa:	15fd                	addi	a1,a1,-1
     bac:	177d                	addi	a4,a4,-1
     bae:	0005c683          	lbu	a3,0(a1)
     bb2:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
     bb6:	fef71ae3          	bne	a4,a5,baa <memmove+0x4a>
     bba:	bfc1                	j	b8a <memmove+0x2a>

0000000000000bbc <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
     bbc:	1141                	addi	sp,sp,-16
     bbe:	e406                	sd	ra,8(sp)
     bc0:	e022                	sd	s0,0(sp)
     bc2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
     bc4:	c61d                	beqz	a2,bf2 <memcmp+0x36>
     bc6:	1602                	slli	a2,a2,0x20
     bc8:	9201                	srli	a2,a2,0x20
     bca:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
     bce:	00054783          	lbu	a5,0(a0)
     bd2:	0005c703          	lbu	a4,0(a1)
     bd6:	00e79863          	bne	a5,a4,be6 <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
     bda:	0505                	addi	a0,a0,1
      p2++;
     bdc:	0585                	addi	a1,a1,1
  while (n-- > 0)
     bde:	fed518e3          	bne	a0,a3,bce <memcmp+0x12>
    }
  return 0;
     be2:	4501                	li	a0,0
     be4:	a019                	j	bea <memcmp+0x2e>
          return *p1 - *p2;
     be6:	40e7853b          	subw	a0,a5,a4
}
     bea:	60a2                	ld	ra,8(sp)
     bec:	6402                	ld	s0,0(sp)
     bee:	0141                	addi	sp,sp,16
     bf0:	8082                	ret
  return 0;
     bf2:	4501                	li	a0,0
     bf4:	bfdd                	j	bea <memcmp+0x2e>

0000000000000bf6 <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
     bf6:	1141                	addi	sp,sp,-16
     bf8:	e406                	sd	ra,8(sp)
     bfa:	e022                	sd	s0,0(sp)
     bfc:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
     bfe:	f63ff0ef          	jal	b60 <memmove>
}
     c02:	60a2                	ld	ra,8(sp)
     c04:	6402                	ld	s0,0(sp)
     c06:	0141                	addi	sp,sp,16
     c08:	8082                	ret

0000000000000c0a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c0a:	4885                	li	a7,1
 ecall
     c0c:	00000073          	ecall
 ret
     c10:	8082                	ret

0000000000000c12 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c12:	4889                	li	a7,2
 ecall
     c14:	00000073          	ecall
 ret
     c18:	8082                	ret

0000000000000c1a <wait>:
.global wait
wait:
 li a7, SYS_wait
     c1a:	488d                	li	a7,3
 ecall
     c1c:	00000073          	ecall
 ret
     c20:	8082                	ret

0000000000000c22 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c22:	4891                	li	a7,4
 ecall
     c24:	00000073          	ecall
 ret
     c28:	8082                	ret

0000000000000c2a <read>:
.global read
read:
 li a7, SYS_read
     c2a:	4895                	li	a7,5
 ecall
     c2c:	00000073          	ecall
 ret
     c30:	8082                	ret

0000000000000c32 <write>:
.global write
write:
 li a7, SYS_write
     c32:	48c1                	li	a7,16
 ecall
     c34:	00000073          	ecall
 ret
     c38:	8082                	ret

0000000000000c3a <close>:
.global close
close:
 li a7, SYS_close
     c3a:	48d5                	li	a7,21
 ecall
     c3c:	00000073          	ecall
 ret
     c40:	8082                	ret

0000000000000c42 <kill>:
.global kill
kill:
 li a7, SYS_kill
     c42:	4899                	li	a7,6
 ecall
     c44:	00000073          	ecall
 ret
     c48:	8082                	ret

0000000000000c4a <exec>:
.global exec
exec:
 li a7, SYS_exec
     c4a:	489d                	li	a7,7
 ecall
     c4c:	00000073          	ecall
 ret
     c50:	8082                	ret

0000000000000c52 <open>:
.global open
open:
 li a7, SYS_open
     c52:	48bd                	li	a7,15
 ecall
     c54:	00000073          	ecall
 ret
     c58:	8082                	ret

0000000000000c5a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c5a:	48c5                	li	a7,17
 ecall
     c5c:	00000073          	ecall
 ret
     c60:	8082                	ret

0000000000000c62 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c62:	48c9                	li	a7,18
 ecall
     c64:	00000073          	ecall
 ret
     c68:	8082                	ret

0000000000000c6a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c6a:	48a1                	li	a7,8
 ecall
     c6c:	00000073          	ecall
 ret
     c70:	8082                	ret

0000000000000c72 <link>:
.global link
link:
 li a7, SYS_link
     c72:	48cd                	li	a7,19
 ecall
     c74:	00000073          	ecall
 ret
     c78:	8082                	ret

0000000000000c7a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c7a:	48d1                	li	a7,20
 ecall
     c7c:	00000073          	ecall
 ret
     c80:	8082                	ret

0000000000000c82 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c82:	48a5                	li	a7,9
 ecall
     c84:	00000073          	ecall
 ret
     c88:	8082                	ret

0000000000000c8a <dup>:
.global dup
dup:
 li a7, SYS_dup
     c8a:	48a9                	li	a7,10
 ecall
     c8c:	00000073          	ecall
 ret
     c90:	8082                	ret

0000000000000c92 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c92:	48ad                	li	a7,11
 ecall
     c94:	00000073          	ecall
 ret
     c98:	8082                	ret

0000000000000c9a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     c9a:	48b1                	li	a7,12
 ecall
     c9c:	00000073          	ecall
 ret
     ca0:	8082                	ret

0000000000000ca2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     ca2:	48b5                	li	a7,13
 ecall
     ca4:	00000073          	ecall
 ret
     ca8:	8082                	ret

0000000000000caa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     caa:	48b9                	li	a7,14
 ecall
     cac:	00000073          	ecall
 ret
     cb0:	8082                	ret

0000000000000cb2 <trace>:
.global trace
trace:
 li a7, SYS_trace
     cb2:	48d9                	li	a7,22
 ecall
     cb4:	00000073          	ecall
 ret
     cb8:	8082                	ret

0000000000000cba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     cba:	1101                	addi	sp,sp,-32
     cbc:	ec06                	sd	ra,24(sp)
     cbe:	e822                	sd	s0,16(sp)
     cc0:	1000                	addi	s0,sp,32
     cc2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     cc6:	4605                	li	a2,1
     cc8:	fef40593          	addi	a1,s0,-17
     ccc:	f67ff0ef          	jal	c32 <write>
}
     cd0:	60e2                	ld	ra,24(sp)
     cd2:	6442                	ld	s0,16(sp)
     cd4:	6105                	addi	sp,sp,32
     cd6:	8082                	ret

0000000000000cd8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     cd8:	7139                	addi	sp,sp,-64
     cda:	fc06                	sd	ra,56(sp)
     cdc:	f822                	sd	s0,48(sp)
     cde:	f04a                	sd	s2,32(sp)
     ce0:	ec4e                	sd	s3,24(sp)
     ce2:	0080                	addi	s0,sp,64
     ce4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ce6:	cac9                	beqz	a3,d78 <printint+0xa0>
     ce8:	01f5d79b          	srliw	a5,a1,0x1f
     cec:	c7d1                	beqz	a5,d78 <printint+0xa0>
    neg = 1;
    x = -xx;
     cee:	40b005bb          	negw	a1,a1
    neg = 1;
     cf2:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
     cf4:	fc040993          	addi	s3,s0,-64
  neg = 0;
     cf8:	86ce                	mv	a3,s3
  i = 0;
     cfa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     cfc:	00001817          	auipc	a6,0x1
     d00:	87480813          	addi	a6,a6,-1932 # 1570 <digits>
     d04:	88ba                	mv	a7,a4
     d06:	0017051b          	addiw	a0,a4,1
     d0a:	872a                	mv	a4,a0
     d0c:	02c5f7bb          	remuw	a5,a1,a2
     d10:	1782                	slli	a5,a5,0x20
     d12:	9381                	srli	a5,a5,0x20
     d14:	97c2                	add	a5,a5,a6
     d16:	0007c783          	lbu	a5,0(a5)
     d1a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     d1e:	87ae                	mv	a5,a1
     d20:	02c5d5bb          	divuw	a1,a1,a2
     d24:	0685                	addi	a3,a3,1
     d26:	fcc7ffe3          	bgeu	a5,a2,d04 <printint+0x2c>
  if(neg)
     d2a:	00030c63          	beqz	t1,d42 <printint+0x6a>
    buf[i++] = '-';
     d2e:	fd050793          	addi	a5,a0,-48
     d32:	00878533          	add	a0,a5,s0
     d36:	02d00793          	li	a5,45
     d3a:	fef50823          	sb	a5,-16(a0)
     d3e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
     d42:	02e05563          	blez	a4,d6c <printint+0x94>
     d46:	f426                	sd	s1,40(sp)
     d48:	377d                	addiw	a4,a4,-1
     d4a:	00e984b3          	add	s1,s3,a4
     d4e:	19fd                	addi	s3,s3,-1
     d50:	99ba                	add	s3,s3,a4
     d52:	1702                	slli	a4,a4,0x20
     d54:	9301                	srli	a4,a4,0x20
     d56:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     d5a:	0004c583          	lbu	a1,0(s1)
     d5e:	854a                	mv	a0,s2
     d60:	f5bff0ef          	jal	cba <putc>
  while(--i >= 0)
     d64:	14fd                	addi	s1,s1,-1
     d66:	ff349ae3          	bne	s1,s3,d5a <printint+0x82>
     d6a:	74a2                	ld	s1,40(sp)
}
     d6c:	70e2                	ld	ra,56(sp)
     d6e:	7442                	ld	s0,48(sp)
     d70:	7902                	ld	s2,32(sp)
     d72:	69e2                	ld	s3,24(sp)
     d74:	6121                	addi	sp,sp,64
     d76:	8082                	ret
  neg = 0;
     d78:	4301                	li	t1,0
     d7a:	bfad                	j	cf4 <printint+0x1c>

0000000000000d7c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d7c:	711d                	addi	sp,sp,-96
     d7e:	ec86                	sd	ra,88(sp)
     d80:	e8a2                	sd	s0,80(sp)
     d82:	e4a6                	sd	s1,72(sp)
     d84:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d86:	0005c483          	lbu	s1,0(a1)
     d8a:	20048963          	beqz	s1,f9c <vprintf+0x220>
     d8e:	e0ca                	sd	s2,64(sp)
     d90:	fc4e                	sd	s3,56(sp)
     d92:	f852                	sd	s4,48(sp)
     d94:	f456                	sd	s5,40(sp)
     d96:	f05a                	sd	s6,32(sp)
     d98:	ec5e                	sd	s7,24(sp)
     d9a:	e862                	sd	s8,16(sp)
     d9c:	8b2a                	mv	s6,a0
     d9e:	8a2e                	mv	s4,a1
     da0:	8bb2                	mv	s7,a2
  state = 0;
     da2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     da4:	4901                	li	s2,0
     da6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     da8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     dac:	06400c13          	li	s8,100
     db0:	a00d                	j	dd2 <vprintf+0x56>
        putc(fd, c0);
     db2:	85a6                	mv	a1,s1
     db4:	855a                	mv	a0,s6
     db6:	f05ff0ef          	jal	cba <putc>
     dba:	a019                	j	dc0 <vprintf+0x44>
    } else if(state == '%'){
     dbc:	03598363          	beq	s3,s5,de2 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
     dc0:	0019079b          	addiw	a5,s2,1
     dc4:	893e                	mv	s2,a5
     dc6:	873e                	mv	a4,a5
     dc8:	97d2                	add	a5,a5,s4
     dca:	0007c483          	lbu	s1,0(a5)
     dce:	1c048063          	beqz	s1,f8e <vprintf+0x212>
    c0 = fmt[i] & 0xff;
     dd2:	0004879b          	sext.w	a5,s1
    if(state == 0){
     dd6:	fe0993e3          	bnez	s3,dbc <vprintf+0x40>
      if(c0 == '%'){
     dda:	fd579ce3          	bne	a5,s5,db2 <vprintf+0x36>
        state = '%';
     dde:	89be                	mv	s3,a5
     de0:	b7c5                	j	dc0 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
     de2:	00ea06b3          	add	a3,s4,a4
     de6:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
     dea:	1a060e63          	beqz	a2,fa6 <vprintf+0x22a>
      if(c0 == 'd'){
     dee:	03878763          	beq	a5,s8,e1c <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     df2:	f9478693          	addi	a3,a5,-108
     df6:	0016b693          	seqz	a3,a3
     dfa:	f9c60593          	addi	a1,a2,-100
     dfe:	e99d                	bnez	a1,e34 <vprintf+0xb8>
     e00:	ca95                	beqz	a3,e34 <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e02:	008b8493          	addi	s1,s7,8
     e06:	4685                	li	a3,1
     e08:	4629                	li	a2,10
     e0a:	000ba583          	lw	a1,0(s7)
     e0e:	855a                	mv	a0,s6
     e10:	ec9ff0ef          	jal	cd8 <printint>
        i += 1;
     e14:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     e16:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     e18:	4981                	li	s3,0
     e1a:	b75d                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
     e1c:	008b8493          	addi	s1,s7,8
     e20:	4685                	li	a3,1
     e22:	4629                	li	a2,10
     e24:	000ba583          	lw	a1,0(s7)
     e28:	855a                	mv	a0,s6
     e2a:	eafff0ef          	jal	cd8 <printint>
     e2e:	8ba6                	mv	s7,s1
      state = 0;
     e30:	4981                	li	s3,0
     e32:	b779                	j	dc0 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
     e34:	9752                	add	a4,a4,s4
     e36:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e3a:	f9460713          	addi	a4,a2,-108
     e3e:	00173713          	seqz	a4,a4
     e42:	8f75                	and	a4,a4,a3
     e44:	f9c58513          	addi	a0,a1,-100
     e48:	16051963          	bnez	a0,fba <vprintf+0x23e>
     e4c:	16070763          	beqz	a4,fba <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e50:	008b8493          	addi	s1,s7,8
     e54:	4685                	li	a3,1
     e56:	4629                	li	a2,10
     e58:	000ba583          	lw	a1,0(s7)
     e5c:	855a                	mv	a0,s6
     e5e:	e7bff0ef          	jal	cd8 <printint>
        i += 2;
     e62:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     e64:	8ba6                	mv	s7,s1
      state = 0;
     e66:	4981                	li	s3,0
        i += 2;
     e68:	bfa1                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
     e6a:	008b8493          	addi	s1,s7,8
     e6e:	4681                	li	a3,0
     e70:	4629                	li	a2,10
     e72:	000ba583          	lw	a1,0(s7)
     e76:	855a                	mv	a0,s6
     e78:	e61ff0ef          	jal	cd8 <printint>
     e7c:	8ba6                	mv	s7,s1
      state = 0;
     e7e:	4981                	li	s3,0
     e80:	b781                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e82:	008b8493          	addi	s1,s7,8
     e86:	4681                	li	a3,0
     e88:	4629                	li	a2,10
     e8a:	000ba583          	lw	a1,0(s7)
     e8e:	855a                	mv	a0,s6
     e90:	e49ff0ef          	jal	cd8 <printint>
        i += 1;
     e94:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     e96:	8ba6                	mv	s7,s1
      state = 0;
     e98:	4981                	li	s3,0
     e9a:	b71d                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e9c:	008b8493          	addi	s1,s7,8
     ea0:	4681                	li	a3,0
     ea2:	4629                	li	a2,10
     ea4:	000ba583          	lw	a1,0(s7)
     ea8:	855a                	mv	a0,s6
     eaa:	e2fff0ef          	jal	cd8 <printint>
        i += 2;
     eae:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     eb0:	8ba6                	mv	s7,s1
      state = 0;
     eb2:	4981                	li	s3,0
        i += 2;
     eb4:	b731                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
     eb6:	008b8493          	addi	s1,s7,8
     eba:	4681                	li	a3,0
     ebc:	4641                	li	a2,16
     ebe:	000ba583          	lw	a1,0(s7)
     ec2:	855a                	mv	a0,s6
     ec4:	e15ff0ef          	jal	cd8 <printint>
     ec8:	8ba6                	mv	s7,s1
      state = 0;
     eca:	4981                	li	s3,0
     ecc:	bdd5                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     ece:	008b8493          	addi	s1,s7,8
     ed2:	4681                	li	a3,0
     ed4:	4641                	li	a2,16
     ed6:	000ba583          	lw	a1,0(s7)
     eda:	855a                	mv	a0,s6
     edc:	dfdff0ef          	jal	cd8 <printint>
        i += 1;
     ee0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     ee2:	8ba6                	mv	s7,s1
      state = 0;
     ee4:	4981                	li	s3,0
     ee6:	bde9                	j	dc0 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
     ee8:	008b8493          	addi	s1,s7,8
     eec:	4681                	li	a3,0
     eee:	4641                	li	a2,16
     ef0:	000ba583          	lw	a1,0(s7)
     ef4:	855a                	mv	a0,s6
     ef6:	de3ff0ef          	jal	cd8 <printint>
        i += 2;
     efa:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     efc:	8ba6                	mv	s7,s1
      state = 0;
     efe:	4981                	li	s3,0
        i += 2;
     f00:	b5c1                	j	dc0 <vprintf+0x44>
     f02:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
     f04:	008b8793          	addi	a5,s7,8
     f08:	8cbe                	mv	s9,a5
     f0a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f0e:	03000593          	li	a1,48
     f12:	855a                	mv	a0,s6
     f14:	da7ff0ef          	jal	cba <putc>
  putc(fd, 'x');
     f18:	07800593          	li	a1,120
     f1c:	855a                	mv	a0,s6
     f1e:	d9dff0ef          	jal	cba <putc>
     f22:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f24:	00000b97          	auipc	s7,0x0
     f28:	64cb8b93          	addi	s7,s7,1612 # 1570 <digits>
     f2c:	03c9d793          	srli	a5,s3,0x3c
     f30:	97de                	add	a5,a5,s7
     f32:	0007c583          	lbu	a1,0(a5)
     f36:	855a                	mv	a0,s6
     f38:	d83ff0ef          	jal	cba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     f3c:	0992                	slli	s3,s3,0x4
     f3e:	34fd                	addiw	s1,s1,-1
     f40:	f4f5                	bnez	s1,f2c <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
     f42:	8be6                	mv	s7,s9
      state = 0;
     f44:	4981                	li	s3,0
     f46:	6ca2                	ld	s9,8(sp)
     f48:	bda5                	j	dc0 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
     f4a:	008b8993          	addi	s3,s7,8
     f4e:	000bb483          	ld	s1,0(s7)
     f52:	cc91                	beqz	s1,f6e <vprintf+0x1f2>
        for(; *s; s++)
     f54:	0004c583          	lbu	a1,0(s1)
     f58:	c985                	beqz	a1,f88 <vprintf+0x20c>
          putc(fd, *s);
     f5a:	855a                	mv	a0,s6
     f5c:	d5fff0ef          	jal	cba <putc>
        for(; *s; s++)
     f60:	0485                	addi	s1,s1,1
     f62:	0004c583          	lbu	a1,0(s1)
     f66:	f9f5                	bnez	a1,f5a <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
     f68:	8bce                	mv	s7,s3
      state = 0;
     f6a:	4981                	li	s3,0
     f6c:	bd91                	j	dc0 <vprintf+0x44>
          s = "(null)";
     f6e:	00000497          	auipc	s1,0x0
     f72:	59a48493          	addi	s1,s1,1434 # 1508 <malloc+0x406>
        for(; *s; s++)
     f76:	02800593          	li	a1,40
     f7a:	b7c5                	j	f5a <vprintf+0x1de>
        putc(fd, '%');
     f7c:	85be                	mv	a1,a5
     f7e:	855a                	mv	a0,s6
     f80:	d3bff0ef          	jal	cba <putc>
      state = 0;
     f84:	4981                	li	s3,0
     f86:	bd2d                	j	dc0 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
     f88:	8bce                	mv	s7,s3
      state = 0;
     f8a:	4981                	li	s3,0
     f8c:	bd15                	j	dc0 <vprintf+0x44>
     f8e:	6906                	ld	s2,64(sp)
     f90:	79e2                	ld	s3,56(sp)
     f92:	7a42                	ld	s4,48(sp)
     f94:	7aa2                	ld	s5,40(sp)
     f96:	7b02                	ld	s6,32(sp)
     f98:	6be2                	ld	s7,24(sp)
     f9a:	6c42                	ld	s8,16(sp)
    }
  }
}
     f9c:	60e6                	ld	ra,88(sp)
     f9e:	6446                	ld	s0,80(sp)
     fa0:	64a6                	ld	s1,72(sp)
     fa2:	6125                	addi	sp,sp,96
     fa4:	8082                	ret
      if(c0 == 'd'){
     fa6:	06400713          	li	a4,100
     faa:	e6e789e3          	beq	a5,a4,e1c <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
     fae:	f9478693          	addi	a3,a5,-108
     fb2:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
     fb6:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     fb8:	4701                	li	a4,0
      } else if(c0 == 'u'){
     fba:	07500513          	li	a0,117
     fbe:	eaa786e3          	beq	a5,a0,e6a <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
     fc2:	f8b60513          	addi	a0,a2,-117
     fc6:	e119                	bnez	a0,fcc <vprintf+0x250>
     fc8:	ea069de3          	bnez	a3,e82 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     fcc:	f8b58513          	addi	a0,a1,-117
     fd0:	e119                	bnez	a0,fd6 <vprintf+0x25a>
     fd2:	ec0715e3          	bnez	a4,e9c <vprintf+0x120>
      } else if(c0 == 'x'){
     fd6:	07800513          	li	a0,120
     fda:	eca78ee3          	beq	a5,a0,eb6 <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
     fde:	f8860613          	addi	a2,a2,-120
     fe2:	e219                	bnez	a2,fe8 <vprintf+0x26c>
     fe4:	ee0695e3          	bnez	a3,ece <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     fe8:	f8858593          	addi	a1,a1,-120
     fec:	e199                	bnez	a1,ff2 <vprintf+0x276>
     fee:	ee071de3          	bnez	a4,ee8 <vprintf+0x16c>
      } else if(c0 == 'p'){
     ff2:	07000713          	li	a4,112
     ff6:	f0e786e3          	beq	a5,a4,f02 <vprintf+0x186>
      } else if(c0 == 's'){
     ffa:	07300713          	li	a4,115
     ffe:	f4e786e3          	beq	a5,a4,f4a <vprintf+0x1ce>
      } else if(c0 == '%'){
    1002:	02500713          	li	a4,37
    1006:	f6e78be3          	beq	a5,a4,f7c <vprintf+0x200>
        putc(fd, '%');
    100a:	02500593          	li	a1,37
    100e:	855a                	mv	a0,s6
    1010:	cabff0ef          	jal	cba <putc>
        putc(fd, c0);
    1014:	85a6                	mv	a1,s1
    1016:	855a                	mv	a0,s6
    1018:	ca3ff0ef          	jal	cba <putc>
      state = 0;
    101c:	4981                	li	s3,0
    101e:	b34d                	j	dc0 <vprintf+0x44>

0000000000001020 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1020:	715d                	addi	sp,sp,-80
    1022:	ec06                	sd	ra,24(sp)
    1024:	e822                	sd	s0,16(sp)
    1026:	1000                	addi	s0,sp,32
    1028:	e010                	sd	a2,0(s0)
    102a:	e414                	sd	a3,8(s0)
    102c:	e818                	sd	a4,16(s0)
    102e:	ec1c                	sd	a5,24(s0)
    1030:	03043023          	sd	a6,32(s0)
    1034:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1038:	8622                	mv	a2,s0
    103a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    103e:	d3fff0ef          	jal	d7c <vprintf>
}
    1042:	60e2                	ld	ra,24(sp)
    1044:	6442                	ld	s0,16(sp)
    1046:	6161                	addi	sp,sp,80
    1048:	8082                	ret

000000000000104a <printf>:

void
printf(const char *fmt, ...)
{
    104a:	711d                	addi	sp,sp,-96
    104c:	ec06                	sd	ra,24(sp)
    104e:	e822                	sd	s0,16(sp)
    1050:	1000                	addi	s0,sp,32
    1052:	e40c                	sd	a1,8(s0)
    1054:	e810                	sd	a2,16(s0)
    1056:	ec14                	sd	a3,24(s0)
    1058:	f018                	sd	a4,32(s0)
    105a:	f41c                	sd	a5,40(s0)
    105c:	03043823          	sd	a6,48(s0)
    1060:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1064:	00840613          	addi	a2,s0,8
    1068:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    106c:	85aa                	mv	a1,a0
    106e:	4505                	li	a0,1
    1070:	d0dff0ef          	jal	d7c <vprintf>
}
    1074:	60e2                	ld	ra,24(sp)
    1076:	6442                	ld	s0,16(sp)
    1078:	6125                	addi	sp,sp,96
    107a:	8082                	ret

000000000000107c <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
    107c:	1141                	addi	sp,sp,-16
    107e:	e406                	sd	ra,8(sp)
    1080:	e022                	sd	s0,0(sp)
    1082:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
    1084:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1088:	00001797          	auipc	a5,0x1
    108c:	f887b783          	ld	a5,-120(a5) # 2010 <freep>
    1090:	a039                	j	109e <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1092:	6398                	ld	a4,0(a5)
    1094:	00e7e463          	bltu	a5,a4,109c <free+0x20>
    1098:	00e6ea63          	bltu	a3,a4,10ac <free+0x30>
{
    109c:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    109e:	fed7fae3          	bgeu	a5,a3,1092 <free+0x16>
    10a2:	6398                	ld	a4,0(a5)
    10a4:	00e6e463          	bltu	a3,a4,10ac <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10a8:	fee7eae3          	bltu	a5,a4,109c <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
    10ac:	ff852583          	lw	a1,-8(a0)
    10b0:	6390                	ld	a2,0(a5)
    10b2:	02059813          	slli	a6,a1,0x20
    10b6:	01c85713          	srli	a4,a6,0x1c
    10ba:	9736                	add	a4,a4,a3
    10bc:	02e60563          	beq	a2,a4,10e6 <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
    10c0:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
    10c4:	4790                	lw	a2,8(a5)
    10c6:	02061593          	slli	a1,a2,0x20
    10ca:	01c5d713          	srli	a4,a1,0x1c
    10ce:	973e                	add	a4,a4,a5
    10d0:	02e68263          	beq	a3,a4,10f4 <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
    10d4:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
    10d6:	00001717          	auipc	a4,0x1
    10da:	f2f73d23          	sd	a5,-198(a4) # 2010 <freep>
}
    10de:	60a2                	ld	ra,8(sp)
    10e0:	6402                	ld	s0,0(sp)
    10e2:	0141                	addi	sp,sp,16
    10e4:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
    10e6:	4618                	lw	a4,8(a2)
    10e8:	9f2d                	addw	a4,a4,a1
    10ea:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
    10ee:	6398                	ld	a4,0(a5)
    10f0:	6310                	ld	a2,0(a4)
    10f2:	b7f9                	j	10c0 <free+0x44>
      p->s.size += bp->s.size;
    10f4:	ff852703          	lw	a4,-8(a0)
    10f8:	9f31                	addw	a4,a4,a2
    10fa:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
    10fc:	ff053683          	ld	a3,-16(a0)
    1100:	bfd1                	j	10d4 <free+0x58>

0000000000001102 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
    1102:	7139                	addi	sp,sp,-64
    1104:	fc06                	sd	ra,56(sp)
    1106:	f822                	sd	s0,48(sp)
    1108:	f04a                	sd	s2,32(sp)
    110a:	ec4e                	sd	s3,24(sp)
    110c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
    110e:	02051993          	slli	s3,a0,0x20
    1112:	0209d993          	srli	s3,s3,0x20
    1116:	09bd                	addi	s3,s3,15
    1118:	0049d993          	srli	s3,s3,0x4
    111c:	2985                	addiw	s3,s3,1
    111e:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
    1120:	00001517          	auipc	a0,0x1
    1124:	ef053503          	ld	a0,-272(a0) # 2010 <freep>
    1128:	c905                	beqz	a0,1158 <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    112a:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
    112c:	4798                	lw	a4,8(a5)
    112e:	09377663          	bgeu	a4,s3,11ba <malloc+0xb8>
    1132:	f426                	sd	s1,40(sp)
    1134:	e852                	sd	s4,16(sp)
    1136:	e456                	sd	s5,8(sp)
    1138:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
    113a:	8a4e                	mv	s4,s3
    113c:	6705                	lui	a4,0x1
    113e:	00e9f363          	bgeu	s3,a4,1144 <malloc+0x42>
    1142:	6a05                	lui	s4,0x1
    1144:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
    1148:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
    114c:	00001497          	auipc	s1,0x1
    1150:	ec448493          	addi	s1,s1,-316 # 2010 <freep>
  if (p == (char *)-1)
    1154:	5afd                	li	s5,-1
    1156:	a83d                	j	1194 <malloc+0x92>
    1158:	f426                	sd	s1,40(sp)
    115a:	e852                	sd	s4,16(sp)
    115c:	e456                	sd	s5,8(sp)
    115e:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
    1160:	00001797          	auipc	a5,0x1
    1164:	2a878793          	addi	a5,a5,680 # 2408 <base>
    1168:	00001717          	auipc	a4,0x1
    116c:	eaf73423          	sd	a5,-344(a4) # 2010 <freep>
    1170:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
    1172:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
    1176:	b7d1                	j	113a <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
    1178:	6398                	ld	a4,0(a5)
    117a:	e118                	sd	a4,0(a0)
    117c:	a899                	j	11d2 <malloc+0xd0>
  hp->s.size = nu;
    117e:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
    1182:	0541                	addi	a0,a0,16
    1184:	ef9ff0ef          	jal	107c <free>
  return freep;
    1188:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
    118a:	c125                	beqz	a0,11ea <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
    118c:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
    118e:	4798                	lw	a4,8(a5)
    1190:	03277163          	bgeu	a4,s2,11b2 <malloc+0xb0>
      if (p == freep)
    1194:	6098                	ld	a4,0(s1)
    1196:	853e                	mv	a0,a5
    1198:	fef71ae3          	bne	a4,a5,118c <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
    119c:	8552                	mv	a0,s4
    119e:	afdff0ef          	jal	c9a <sbrk>
  if (p == (char *)-1)
    11a2:	fd551ee3          	bne	a0,s5,117e <malloc+0x7c>
          return 0;
    11a6:	4501                	li	a0,0
    11a8:	74a2                	ld	s1,40(sp)
    11aa:	6a42                	ld	s4,16(sp)
    11ac:	6aa2                	ld	s5,8(sp)
    11ae:	6b02                	ld	s6,0(sp)
    11b0:	a03d                	j	11de <malloc+0xdc>
    11b2:	74a2                	ld	s1,40(sp)
    11b4:	6a42                	ld	s4,16(sp)
    11b6:	6aa2                	ld	s5,8(sp)
    11b8:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
    11ba:	fae90fe3          	beq	s2,a4,1178 <malloc+0x76>
              p->s.size -= nunits;
    11be:	4137073b          	subw	a4,a4,s3
    11c2:	c798                	sw	a4,8(a5)
              p += p->s.size;
    11c4:	02071693          	slli	a3,a4,0x20
    11c8:	01c6d713          	srli	a4,a3,0x1c
    11cc:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
    11ce:	0137a423          	sw	s3,8(a5)
          freep = prevp;
    11d2:	00001717          	auipc	a4,0x1
    11d6:	e2a73f23          	sd	a0,-450(a4) # 2010 <freep>
          return (void *)(p + 1);
    11da:	01078513          	addi	a0,a5,16
    }
}
    11de:	70e2                	ld	ra,56(sp)
    11e0:	7442                	ld	s0,48(sp)
    11e2:	7902                	ld	s2,32(sp)
    11e4:	69e2                	ld	s3,24(sp)
    11e6:	6121                	addi	sp,sp,64
    11e8:	8082                	ret
    11ea:	74a2                	ld	s1,40(sp)
    11ec:	6a42                	ld	s4,16(sp)
    11ee:	6aa2                	ld	s5,8(sp)
    11f0:	6b02                	ld	s6,0(sp)
    11f2:	b7f5                	j	11de <malloc+0xdc>
