
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	2ae000ef          	jal	2ba <strlen>
  10:	02051793          	slli	a5,a0,0x20
  14:	9381                	srli	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	addi	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	286000ef          	jal	2ba <strlen>
  38:	47b5                	li	a5,13
  3a:	00a7f863          	bgeu	a5,a0,4a <fmtname+0x4a>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  3e:	8526                	mv	a0,s1
  40:	60e2                	ld	ra,24(sp)
  42:	6442                	ld	s0,16(sp)
  44:	64a2                	ld	s1,8(sp)
  46:	6105                	addi	sp,sp,32
  48:	8082                	ret
  4a:	e04a                	sd	s2,0(sp)
  memmove(buf, p, strlen(p));
  4c:	8526                	mv	a0,s1
  4e:	26c000ef          	jal	2ba <strlen>
  52:	862a                	mv	a2,a0
  54:	85a6                	mv	a1,s1
  56:	00001517          	auipc	a0,0x1
  5a:	fba50513          	addi	a0,a0,-70 # 1010 <buf.0>
  5e:	3d4000ef          	jal	432 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  62:	8526                	mv	a0,s1
  64:	256000ef          	jal	2ba <strlen>
  68:	892a                	mv	s2,a0
  6a:	8526                	mv	a0,s1
  6c:	24e000ef          	jal	2ba <strlen>
  70:	02091793          	slli	a5,s2,0x20
  74:	9381                	srli	a5,a5,0x20
  76:	4639                	li	a2,14
  78:	9e09                	subw	a2,a2,a0
  7a:	02000593          	li	a1,32
  7e:	00001517          	auipc	a0,0x1
  82:	f9250513          	addi	a0,a0,-110 # 1010 <buf.0>
  86:	953e                	add	a0,a0,a5
  88:	25e000ef          	jal	2e6 <memset>
  return buf;
  8c:	00001497          	auipc	s1,0x1
  90:	f8448493          	addi	s1,s1,-124 # 1010 <buf.0>
  94:	6902                	ld	s2,0(sp)
  96:	b765                	j	3e <fmtname+0x3e>

0000000000000098 <ls>:

void
ls(char *path)
{
  98:	da010113          	addi	sp,sp,-608
  9c:	24113c23          	sd	ra,600(sp)
  a0:	24813823          	sd	s0,592(sp)
  a4:	25213023          	sd	s2,576(sp)
  a8:	1480                	addi	s0,sp,608
  aa:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  ac:	4581                	li	a1,0
  ae:	476000ef          	jal	524 <open>
  b2:	06054363          	bltz	a0,118 <ls+0x80>
  b6:	24913423          	sd	s1,584(sp)
  ba:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  bc:	da840593          	addi	a1,s0,-600
  c0:	47c000ef          	jal	53c <fstat>
  c4:	06054363          	bltz	a0,12a <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c8:	db041783          	lh	a5,-592(s0)
  cc:	4705                	li	a4,1
  ce:	06e78c63          	beq	a5,a4,146 <ls+0xae>
  d2:	37f9                	addiw	a5,a5,-2
  d4:	17c2                	slli	a5,a5,0x30
  d6:	93c1                	srli	a5,a5,0x30
  d8:	02f76263          	bltu	a4,a5,fc <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  dc:	854a                	mv	a0,s2
  de:	f23ff0ef          	jal	0 <fmtname>
  e2:	85aa                	mv	a1,a0
  e4:	db842703          	lw	a4,-584(s0)
  e8:	dac42683          	lw	a3,-596(s0)
  ec:	db041603          	lh	a2,-592(s0)
  f0:	00001517          	auipc	a0,0x1
  f4:	a1050513          	addi	a0,a0,-1520 # b00 <malloc+0x12c>
  f8:	025000ef          	jal	91c <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
  fc:	8526                	mv	a0,s1
  fe:	40e000ef          	jal	50c <close>
 102:	24813483          	ld	s1,584(sp)
}
 106:	25813083          	ld	ra,600(sp)
 10a:	25013403          	ld	s0,592(sp)
 10e:	24013903          	ld	s2,576(sp)
 112:	26010113          	addi	sp,sp,608
 116:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 118:	864a                	mv	a2,s2
 11a:	00001597          	auipc	a1,0x1
 11e:	9b658593          	addi	a1,a1,-1610 # ad0 <malloc+0xfc>
 122:	4509                	li	a0,2
 124:	7ce000ef          	jal	8f2 <fprintf>
    return;
 128:	bff9                	j	106 <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 12a:	864a                	mv	a2,s2
 12c:	00001597          	auipc	a1,0x1
 130:	9bc58593          	addi	a1,a1,-1604 # ae8 <malloc+0x114>
 134:	4509                	li	a0,2
 136:	7bc000ef          	jal	8f2 <fprintf>
    close(fd);
 13a:	8526                	mv	a0,s1
 13c:	3d0000ef          	jal	50c <close>
    return;
 140:	24813483          	ld	s1,584(sp)
 144:	b7c9                	j	106 <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 146:	854a                	mv	a0,s2
 148:	172000ef          	jal	2ba <strlen>
 14c:	2541                	addiw	a0,a0,16
 14e:	20000793          	li	a5,512
 152:	00a7f963          	bgeu	a5,a0,164 <ls+0xcc>
      printf("ls: path too long\n");
 156:	00001517          	auipc	a0,0x1
 15a:	9ba50513          	addi	a0,a0,-1606 # b10 <malloc+0x13c>
 15e:	7be000ef          	jal	91c <printf>
      break;
 162:	bf69                	j	fc <ls+0x64>
 164:	23313c23          	sd	s3,568(sp)
    strcpy(buf, path);
 168:	85ca                	mv	a1,s2
 16a:	dd040513          	addi	a0,s0,-560
 16e:	0fc000ef          	jal	26a <strcpy>
    p = buf+strlen(buf);
 172:	dd040513          	addi	a0,s0,-560
 176:	144000ef          	jal	2ba <strlen>
 17a:	1502                	slli	a0,a0,0x20
 17c:	9101                	srli	a0,a0,0x20
 17e:	dd040793          	addi	a5,s0,-560
 182:	00a78733          	add	a4,a5,a0
 186:	893a                	mv	s2,a4
    *p++ = '/';
 188:	00170793          	addi	a5,a4,1
 18c:	89be                	mv	s3,a5
 18e:	02f00793          	li	a5,47
 192:	00f70023          	sb	a5,0(a4)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 196:	a809                	j	1a8 <ls+0x110>
        printf("ls: cannot stat %s\n", buf);
 198:	dd040593          	addi	a1,s0,-560
 19c:	00001517          	auipc	a0,0x1
 1a0:	94c50513          	addi	a0,a0,-1716 # ae8 <malloc+0x114>
 1a4:	778000ef          	jal	91c <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a8:	4641                	li	a2,16
 1aa:	dc040593          	addi	a1,s0,-576
 1ae:	8526                	mv	a0,s1
 1b0:	34c000ef          	jal	4fc <read>
 1b4:	47c1                	li	a5,16
 1b6:	04f51763          	bne	a0,a5,204 <ls+0x16c>
      if(de.inum == 0)
 1ba:	dc045783          	lhu	a5,-576(s0)
 1be:	d7ed                	beqz	a5,1a8 <ls+0x110>
      memmove(p, de.name, DIRSIZ);
 1c0:	4639                	li	a2,14
 1c2:	dc240593          	addi	a1,s0,-574
 1c6:	854e                	mv	a0,s3
 1c8:	26a000ef          	jal	432 <memmove>
      p[DIRSIZ] = 0;
 1cc:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1d0:	da840593          	addi	a1,s0,-600
 1d4:	dd040513          	addi	a0,s0,-560
 1d8:	1d2000ef          	jal	3aa <stat>
 1dc:	fa054ee3          	bltz	a0,198 <ls+0x100>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1e0:	dd040513          	addi	a0,s0,-560
 1e4:	e1dff0ef          	jal	0 <fmtname>
 1e8:	85aa                	mv	a1,a0
 1ea:	db842703          	lw	a4,-584(s0)
 1ee:	dac42683          	lw	a3,-596(s0)
 1f2:	db041603          	lh	a2,-592(s0)
 1f6:	00001517          	auipc	a0,0x1
 1fa:	90a50513          	addi	a0,a0,-1782 # b00 <malloc+0x12c>
 1fe:	71e000ef          	jal	91c <printf>
 202:	b75d                	j	1a8 <ls+0x110>
 204:	23813983          	ld	s3,568(sp)
 208:	bdd5                	j	fc <ls+0x64>

000000000000020a <main>:

int
main(int argc, char *argv[])
{
 20a:	1101                	addi	sp,sp,-32
 20c:	ec06                	sd	ra,24(sp)
 20e:	e822                	sd	s0,16(sp)
 210:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 212:	4785                	li	a5,1
 214:	02a7d763          	bge	a5,a0,242 <main+0x38>
 218:	e426                	sd	s1,8(sp)
 21a:	e04a                	sd	s2,0(sp)
 21c:	00858493          	addi	s1,a1,8
 220:	ffe5091b          	addiw	s2,a0,-2
 224:	02091793          	slli	a5,s2,0x20
 228:	01d7d913          	srli	s2,a5,0x1d
 22c:	05c1                	addi	a1,a1,16
 22e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 230:	6088                	ld	a0,0(s1)
 232:	e67ff0ef          	jal	98 <ls>
  for(i=1; i<argc; i++)
 236:	04a1                	addi	s1,s1,8
 238:	ff249ce3          	bne	s1,s2,230 <main+0x26>
  exit(0);
 23c:	4501                	li	a0,0
 23e:	2a6000ef          	jal	4e4 <exit>
 242:	e426                	sd	s1,8(sp)
 244:	e04a                	sd	s2,0(sp)
    ls(".");
 246:	00001517          	auipc	a0,0x1
 24a:	8e250513          	addi	a0,a0,-1822 # b28 <malloc+0x154>
 24e:	e4bff0ef          	jal	98 <ls>
    exit(0);
 252:	4501                	li	a0,0
 254:	290000ef          	jal	4e4 <exit>

0000000000000258 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
 258:	1141                	addi	sp,sp,-16
 25a:	e406                	sd	ra,8(sp)
 25c:	e022                	sd	s0,0(sp)
 25e:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
 260:	fabff0ef          	jal	20a <main>
  exit (0);
 264:	4501                	li	a0,0
 266:	27e000ef          	jal	4e4 <exit>

000000000000026a <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 272:	87aa                	mv	a5,a0
 274:	0585                	addi	a1,a1,1
 276:	0785                	addi	a5,a5,1
 278:	fff5c703          	lbu	a4,-1(a1)
 27c:	fee78fa3          	sb	a4,-1(a5)
 280:	fb75                	bnez	a4,274 <strcpy+0xa>
    ;
  return os;
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret

000000000000028a <strcmp>:

int
strcmp (const char *p, const char *q)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 292:	00054783          	lbu	a5,0(a0)
 296:	cb91                	beqz	a5,2aa <strcmp+0x20>
 298:	0005c703          	lbu	a4,0(a1)
 29c:	00f71763          	bne	a4,a5,2aa <strcmp+0x20>
    p++, q++;
 2a0:	0505                	addi	a0,a0,1
 2a2:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 2a4:	00054783          	lbu	a5,0(a0)
 2a8:	fbe5                	bnez	a5,298 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2aa:	0005c503          	lbu	a0,0(a1)
}
 2ae:	40a7853b          	subw	a0,a5,a0
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strlen>:

uint
strlen (const char *s)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e406                	sd	ra,8(sp)
 2be:	e022                	sd	s0,0(sp)
 2c0:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cf91                	beqz	a5,2e2 <strlen+0x28>
 2c8:	00150793          	addi	a5,a0,1
 2cc:	86be                	mv	a3,a5
 2ce:	0785                	addi	a5,a5,1
 2d0:	fff7c703          	lbu	a4,-1(a5)
 2d4:	ff65                	bnez	a4,2cc <strlen+0x12>
 2d6:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret
  for (n = 0; s[n]; n++)
 2e2:	4501                	li	a0,0
 2e4:	bfdd                	j	2da <strlen+0x20>

00000000000002e6 <memset>:

void *
memset (void *dst, int c, uint n)
{
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e406                	sd	ra,8(sp)
 2ea:	e022                	sd	s0,0(sp)
 2ec:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 2ee:	ca19                	beqz	a2,304 <memset+0x1e>
 2f0:	87aa                	mv	a5,a0
 2f2:	1602                	slli	a2,a2,0x20
 2f4:	9201                	srli	a2,a2,0x20
 2f6:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 2fa:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 2fe:	0785                	addi	a5,a5,1
 300:	fee79de3          	bne	a5,a4,2fa <memset+0x14>
    }
  return dst;
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <strchr>:

char *
strchr (const char *s, char c)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e406                	sd	ra,8(sp)
 310:	e022                	sd	s0,0(sp)
 312:	0800                	addi	s0,sp,16
  for (; *s; s++)
 314:	00054783          	lbu	a5,0(a0)
 318:	cf81                	beqz	a5,330 <strchr+0x24>
    if (*s == c)
 31a:	00f58763          	beq	a1,a5,328 <strchr+0x1c>
  for (; *s; s++)
 31e:	0505                	addi	a0,a0,1
 320:	00054783          	lbu	a5,0(a0)
 324:	fbfd                	bnez	a5,31a <strchr+0xe>
      return (char *)s;
  return 0;
 326:	4501                	li	a0,0
}
 328:	60a2                	ld	ra,8(sp)
 32a:	6402                	ld	s0,0(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
  return 0;
 330:	4501                	li	a0,0
 332:	bfdd                	j	328 <strchr+0x1c>

0000000000000334 <gets>:

char *
gets (char *buf, int max)
{
 334:	711d                	addi	sp,sp,-96
 336:	ec86                	sd	ra,88(sp)
 338:	e8a2                	sd	s0,80(sp)
 33a:	e4a6                	sd	s1,72(sp)
 33c:	e0ca                	sd	s2,64(sp)
 33e:	fc4e                	sd	s3,56(sp)
 340:	f852                	sd	s4,48(sp)
 342:	f456                	sd	s5,40(sp)
 344:	f05a                	sd	s6,32(sp)
 346:	ec5e                	sd	s7,24(sp)
 348:	e862                	sd	s8,16(sp)
 34a:	1080                	addi	s0,sp,96
 34c:	8baa                	mv	s7,a0
 34e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 350:	892a                	mv	s2,a0
 352:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 354:	faf40b13          	addi	s6,s0,-81
 358:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 35a:	8c26                	mv	s8,s1
 35c:	0014899b          	addiw	s3,s1,1
 360:	84ce                	mv	s1,s3
 362:	0349d463          	bge	s3,s4,38a <gets+0x56>
      cc = read (0, &c, 1);
 366:	8656                	mv	a2,s5
 368:	85da                	mv	a1,s6
 36a:	4501                	li	a0,0
 36c:	190000ef          	jal	4fc <read>
      if (cc < 1)
 370:	00a05d63          	blez	a0,38a <gets+0x56>
        break;
      buf[i++] = c;
 374:	faf44783          	lbu	a5,-81(s0)
 378:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 37c:	0905                	addi	s2,s2,1
 37e:	ff678713          	addi	a4,a5,-10
 382:	c319                	beqz	a4,388 <gets+0x54>
 384:	17cd                	addi	a5,a5,-13
 386:	fbf1                	bnez	a5,35a <gets+0x26>
      buf[i++] = c;
 388:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 38a:	9c5e                	add	s8,s8,s7
 38c:	000c0023          	sb	zero,0(s8)
  return buf;
}
 390:	855e                	mv	a0,s7
 392:	60e6                	ld	ra,88(sp)
 394:	6446                	ld	s0,80(sp)
 396:	64a6                	ld	s1,72(sp)
 398:	6906                	ld	s2,64(sp)
 39a:	79e2                	ld	s3,56(sp)
 39c:	7a42                	ld	s4,48(sp)
 39e:	7aa2                	ld	s5,40(sp)
 3a0:	7b02                	ld	s6,32(sp)
 3a2:	6be2                	ld	s7,24(sp)
 3a4:	6c42                	ld	s8,16(sp)
 3a6:	6125                	addi	sp,sp,96
 3a8:	8082                	ret

00000000000003aa <stat>:

int
stat (const char *n, struct stat *st)
{
 3aa:	1101                	addi	sp,sp,-32
 3ac:	ec06                	sd	ra,24(sp)
 3ae:	e822                	sd	s0,16(sp)
 3b0:	e04a                	sd	s2,0(sp)
 3b2:	1000                	addi	s0,sp,32
 3b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 3b6:	4581                	li	a1,0
 3b8:	16c000ef          	jal	524 <open>
  if (fd < 0)
 3bc:	02054263          	bltz	a0,3e0 <stat+0x36>
 3c0:	e426                	sd	s1,8(sp)
 3c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 3c4:	85ca                	mv	a1,s2
 3c6:	176000ef          	jal	53c <fstat>
 3ca:	892a                	mv	s2,a0
  close (fd);
 3cc:	8526                	mv	a0,s1
 3ce:	13e000ef          	jal	50c <close>
  return r;
 3d2:	64a2                	ld	s1,8(sp)
}
 3d4:	854a                	mv	a0,s2
 3d6:	60e2                	ld	ra,24(sp)
 3d8:	6442                	ld	s0,16(sp)
 3da:	6902                	ld	s2,0(sp)
 3dc:	6105                	addi	sp,sp,32
 3de:	8082                	ret
    return -1;
 3e0:	57fd                	li	a5,-1
 3e2:	893e                	mv	s2,a5
 3e4:	bfc5                	j	3d4 <stat+0x2a>

00000000000003e6 <atoi>:

int
atoi (const char *s)
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 3ee:	00054683          	lbu	a3,0(a0)
 3f2:	fd06879b          	addiw	a5,a3,-48
 3f6:	0ff7f793          	zext.b	a5,a5
 3fa:	4625                	li	a2,9
 3fc:	02f66963          	bltu	a2,a5,42e <atoi+0x48>
 400:	872a                	mv	a4,a0
  n = 0;
 402:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 404:	0705                	addi	a4,a4,1
 406:	0025179b          	slliw	a5,a0,0x2
 40a:	9fa9                	addw	a5,a5,a0
 40c:	0017979b          	slliw	a5,a5,0x1
 410:	9fb5                	addw	a5,a5,a3
 412:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 416:	00074683          	lbu	a3,0(a4)
 41a:	fd06879b          	addiw	a5,a3,-48
 41e:	0ff7f793          	zext.b	a5,a5
 422:	fef671e3          	bgeu	a2,a5,404 <atoi+0x1e>
  return n;
}
 426:	60a2                	ld	ra,8(sp)
 428:	6402                	ld	s0,0(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
  n = 0;
 42e:	4501                	li	a0,0
 430:	bfdd                	j	426 <atoi+0x40>

0000000000000432 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e406                	sd	ra,8(sp)
 436:	e022                	sd	s0,0(sp)
 438:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 43a:	02b57563          	bgeu	a0,a1,464 <memmove+0x32>
    {
      while (n-- > 0)
 43e:	00c05f63          	blez	a2,45c <memmove+0x2a>
 442:	1602                	slli	a2,a2,0x20
 444:	9201                	srli	a2,a2,0x20
 446:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 44a:	872a                	mv	a4,a0
        *dst++ = *src++;
 44c:	0585                	addi	a1,a1,1
 44e:	0705                	addi	a4,a4,1
 450:	fff5c683          	lbu	a3,-1(a1)
 454:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 458:	fee79ae3          	bne	a5,a4,44c <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 45c:	60a2                	ld	ra,8(sp)
 45e:	6402                	ld	s0,0(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret
      while (n-- > 0)
 464:	fec05ce3          	blez	a2,45c <memmove+0x2a>
      dst += n;
 468:	00c50733          	add	a4,a0,a2
      src += n;
 46c:	95b2                	add	a1,a1,a2
 46e:	fff6079b          	addiw	a5,a2,-1
 472:	1782                	slli	a5,a5,0x20
 474:	9381                	srli	a5,a5,0x20
 476:	fff7c793          	not	a5,a5
 47a:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 47c:	15fd                	addi	a1,a1,-1
 47e:	177d                	addi	a4,a4,-1
 480:	0005c683          	lbu	a3,0(a1)
 484:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 488:	fef71ae3          	bne	a4,a5,47c <memmove+0x4a>
 48c:	bfc1                	j	45c <memmove+0x2a>

000000000000048e <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e406                	sd	ra,8(sp)
 492:	e022                	sd	s0,0(sp)
 494:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 496:	c61d                	beqz	a2,4c4 <memcmp+0x36>
 498:	1602                	slli	a2,a2,0x20
 49a:	9201                	srli	a2,a2,0x20
 49c:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 4a0:	00054783          	lbu	a5,0(a0)
 4a4:	0005c703          	lbu	a4,0(a1)
 4a8:	00e79863          	bne	a5,a4,4b8 <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 4ac:	0505                	addi	a0,a0,1
      p2++;
 4ae:	0585                	addi	a1,a1,1
  while (n-- > 0)
 4b0:	fed518e3          	bne	a0,a3,4a0 <memcmp+0x12>
    }
  return 0;
 4b4:	4501                	li	a0,0
 4b6:	a019                	j	4bc <memcmp+0x2e>
          return *p1 - *p2;
 4b8:	40e7853b          	subw	a0,a5,a4
}
 4bc:	60a2                	ld	ra,8(sp)
 4be:	6402                	ld	s0,0(sp)
 4c0:	0141                	addi	sp,sp,16
 4c2:	8082                	ret
  return 0;
 4c4:	4501                	li	a0,0
 4c6:	bfdd                	j	4bc <memcmp+0x2e>

00000000000004c8 <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e406                	sd	ra,8(sp)
 4cc:	e022                	sd	s0,0(sp)
 4ce:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 4d0:	f63ff0ef          	jal	432 <memmove>
}
 4d4:	60a2                	ld	ra,8(sp)
 4d6:	6402                	ld	s0,0(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret

00000000000004dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4dc:	4885                	li	a7,1
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e4:	4889                	li	a7,2
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ec:	488d                	li	a7,3
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f4:	4891                	li	a7,4
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <read>:
.global read
read:
 li a7, SYS_read
 4fc:	4895                	li	a7,5
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <write>:
.global write
write:
 li a7, SYS_write
 504:	48c1                	li	a7,16
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <close>:
.global close
close:
 li a7, SYS_close
 50c:	48d5                	li	a7,21
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <kill>:
.global kill
kill:
 li a7, SYS_kill
 514:	4899                	li	a7,6
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <exec>:
.global exec
exec:
 li a7, SYS_exec
 51c:	489d                	li	a7,7
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <open>:
.global open
open:
 li a7, SYS_open
 524:	48bd                	li	a7,15
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 52c:	48c5                	li	a7,17
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 534:	48c9                	li	a7,18
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 53c:	48a1                	li	a7,8
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <link>:
.global link
link:
 li a7, SYS_link
 544:	48cd                	li	a7,19
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 54c:	48d1                	li	a7,20
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 554:	48a5                	li	a7,9
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <dup>:
.global dup
dup:
 li a7, SYS_dup
 55c:	48a9                	li	a7,10
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 564:	48ad                	li	a7,11
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 56c:	48b1                	li	a7,12
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 574:	48b5                	li	a7,13
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 57c:	48b9                	li	a7,14
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <trace>:
.global trace
trace:
 li a7, SYS_trace
 584:	48d9                	li	a7,22
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58c:	1101                	addi	sp,sp,-32
 58e:	ec06                	sd	ra,24(sp)
 590:	e822                	sd	s0,16(sp)
 592:	1000                	addi	s0,sp,32
 594:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 598:	4605                	li	a2,1
 59a:	fef40593          	addi	a1,s0,-17
 59e:	f67ff0ef          	jal	504 <write>
}
 5a2:	60e2                	ld	ra,24(sp)
 5a4:	6442                	ld	s0,16(sp)
 5a6:	6105                	addi	sp,sp,32
 5a8:	8082                	ret

00000000000005aa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5aa:	7139                	addi	sp,sp,-64
 5ac:	fc06                	sd	ra,56(sp)
 5ae:	f822                	sd	s0,48(sp)
 5b0:	f04a                	sd	s2,32(sp)
 5b2:	ec4e                	sd	s3,24(sp)
 5b4:	0080                	addi	s0,sp,64
 5b6:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b8:	cac9                	beqz	a3,64a <printint+0xa0>
 5ba:	01f5d79b          	srliw	a5,a1,0x1f
 5be:	c7d1                	beqz	a5,64a <printint+0xa0>
    neg = 1;
    x = -xx;
 5c0:	40b005bb          	negw	a1,a1
    neg = 1;
 5c4:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 5c6:	fc040993          	addi	s3,s0,-64
  neg = 0;
 5ca:	86ce                	mv	a3,s3
  i = 0;
 5cc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ce:	00000817          	auipc	a6,0x0
 5d2:	56a80813          	addi	a6,a6,1386 # b38 <digits>
 5d6:	88ba                	mv	a7,a4
 5d8:	0017051b          	addiw	a0,a4,1
 5dc:	872a                	mv	a4,a0
 5de:	02c5f7bb          	remuw	a5,a1,a2
 5e2:	1782                	slli	a5,a5,0x20
 5e4:	9381                	srli	a5,a5,0x20
 5e6:	97c2                	add	a5,a5,a6
 5e8:	0007c783          	lbu	a5,0(a5)
 5ec:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5f0:	87ae                	mv	a5,a1
 5f2:	02c5d5bb          	divuw	a1,a1,a2
 5f6:	0685                	addi	a3,a3,1
 5f8:	fcc7ffe3          	bgeu	a5,a2,5d6 <printint+0x2c>
  if(neg)
 5fc:	00030c63          	beqz	t1,614 <printint+0x6a>
    buf[i++] = '-';
 600:	fd050793          	addi	a5,a0,-48
 604:	00878533          	add	a0,a5,s0
 608:	02d00793          	li	a5,45
 60c:	fef50823          	sb	a5,-16(a0)
 610:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 614:	02e05563          	blez	a4,63e <printint+0x94>
 618:	f426                	sd	s1,40(sp)
 61a:	377d                	addiw	a4,a4,-1
 61c:	00e984b3          	add	s1,s3,a4
 620:	19fd                	addi	s3,s3,-1
 622:	99ba                	add	s3,s3,a4
 624:	1702                	slli	a4,a4,0x20
 626:	9301                	srli	a4,a4,0x20
 628:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 62c:	0004c583          	lbu	a1,0(s1)
 630:	854a                	mv	a0,s2
 632:	f5bff0ef          	jal	58c <putc>
  while(--i >= 0)
 636:	14fd                	addi	s1,s1,-1
 638:	ff349ae3          	bne	s1,s3,62c <printint+0x82>
 63c:	74a2                	ld	s1,40(sp)
}
 63e:	70e2                	ld	ra,56(sp)
 640:	7442                	ld	s0,48(sp)
 642:	7902                	ld	s2,32(sp)
 644:	69e2                	ld	s3,24(sp)
 646:	6121                	addi	sp,sp,64
 648:	8082                	ret
  neg = 0;
 64a:	4301                	li	t1,0
 64c:	bfad                	j	5c6 <printint+0x1c>

000000000000064e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 64e:	711d                	addi	sp,sp,-96
 650:	ec86                	sd	ra,88(sp)
 652:	e8a2                	sd	s0,80(sp)
 654:	e4a6                	sd	s1,72(sp)
 656:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 658:	0005c483          	lbu	s1,0(a1)
 65c:	20048963          	beqz	s1,86e <vprintf+0x220>
 660:	e0ca                	sd	s2,64(sp)
 662:	fc4e                	sd	s3,56(sp)
 664:	f852                	sd	s4,48(sp)
 666:	f456                	sd	s5,40(sp)
 668:	f05a                	sd	s6,32(sp)
 66a:	ec5e                	sd	s7,24(sp)
 66c:	e862                	sd	s8,16(sp)
 66e:	8b2a                	mv	s6,a0
 670:	8a2e                	mv	s4,a1
 672:	8bb2                	mv	s7,a2
  state = 0;
 674:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 676:	4901                	li	s2,0
 678:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 67a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 67e:	06400c13          	li	s8,100
 682:	a00d                	j	6a4 <vprintf+0x56>
        putc(fd, c0);
 684:	85a6                	mv	a1,s1
 686:	855a                	mv	a0,s6
 688:	f05ff0ef          	jal	58c <putc>
 68c:	a019                	j	692 <vprintf+0x44>
    } else if(state == '%'){
 68e:	03598363          	beq	s3,s5,6b4 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 692:	0019079b          	addiw	a5,s2,1
 696:	893e                	mv	s2,a5
 698:	873e                	mv	a4,a5
 69a:	97d2                	add	a5,a5,s4
 69c:	0007c483          	lbu	s1,0(a5)
 6a0:	1c048063          	beqz	s1,860 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 6a4:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6a8:	fe0993e3          	bnez	s3,68e <vprintf+0x40>
      if(c0 == '%'){
 6ac:	fd579ce3          	bne	a5,s5,684 <vprintf+0x36>
        state = '%';
 6b0:	89be                	mv	s3,a5
 6b2:	b7c5                	j	692 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 6b4:	00ea06b3          	add	a3,s4,a4
 6b8:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 6bc:	1a060e63          	beqz	a2,878 <vprintf+0x22a>
      if(c0 == 'd'){
 6c0:	03878763          	beq	a5,s8,6ee <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6c4:	f9478693          	addi	a3,a5,-108
 6c8:	0016b693          	seqz	a3,a3
 6cc:	f9c60593          	addi	a1,a2,-100
 6d0:	e99d                	bnez	a1,706 <vprintf+0xb8>
 6d2:	ca95                	beqz	a3,706 <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d4:	008b8493          	addi	s1,s7,8
 6d8:	4685                	li	a3,1
 6da:	4629                	li	a2,10
 6dc:	000ba583          	lw	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	ec9ff0ef          	jal	5aa <printint>
        i += 1;
 6e6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e8:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b75d                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 6ee:	008b8493          	addi	s1,s7,8
 6f2:	4685                	li	a3,1
 6f4:	4629                	li	a2,10
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	eafff0ef          	jal	5aa <printint>
 700:	8ba6                	mv	s7,s1
      state = 0;
 702:	4981                	li	s3,0
 704:	b779                	j	692 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 706:	9752                	add	a4,a4,s4
 708:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 70c:	f9460713          	addi	a4,a2,-108
 710:	00173713          	seqz	a4,a4
 714:	8f75                	and	a4,a4,a3
 716:	f9c58513          	addi	a0,a1,-100
 71a:	16051963          	bnez	a0,88c <vprintf+0x23e>
 71e:	16070763          	beqz	a4,88c <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 722:	008b8493          	addi	s1,s7,8
 726:	4685                	li	a3,1
 728:	4629                	li	a2,10
 72a:	000ba583          	lw	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	e7bff0ef          	jal	5aa <printint>
        i += 2;
 734:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 736:	8ba6                	mv	s7,s1
      state = 0;
 738:	4981                	li	s3,0
        i += 2;
 73a:	bfa1                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 73c:	008b8493          	addi	s1,s7,8
 740:	4681                	li	a3,0
 742:	4629                	li	a2,10
 744:	000ba583          	lw	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	e61ff0ef          	jal	5aa <printint>
 74e:	8ba6                	mv	s7,s1
      state = 0;
 750:	4981                	li	s3,0
 752:	b781                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 754:	008b8493          	addi	s1,s7,8
 758:	4681                	li	a3,0
 75a:	4629                	li	a2,10
 75c:	000ba583          	lw	a1,0(s7)
 760:	855a                	mv	a0,s6
 762:	e49ff0ef          	jal	5aa <printint>
        i += 1;
 766:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 768:	8ba6                	mv	s7,s1
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b71d                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76e:	008b8493          	addi	s1,s7,8
 772:	4681                	li	a3,0
 774:	4629                	li	a2,10
 776:	000ba583          	lw	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	e2fff0ef          	jal	5aa <printint>
        i += 2;
 780:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 782:	8ba6                	mv	s7,s1
      state = 0;
 784:	4981                	li	s3,0
        i += 2;
 786:	b731                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 788:	008b8493          	addi	s1,s7,8
 78c:	4681                	li	a3,0
 78e:	4641                	li	a2,16
 790:	000ba583          	lw	a1,0(s7)
 794:	855a                	mv	a0,s6
 796:	e15ff0ef          	jal	5aa <printint>
 79a:	8ba6                	mv	s7,s1
      state = 0;
 79c:	4981                	li	s3,0
 79e:	bdd5                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a0:	008b8493          	addi	s1,s7,8
 7a4:	4681                	li	a3,0
 7a6:	4641                	li	a2,16
 7a8:	000ba583          	lw	a1,0(s7)
 7ac:	855a                	mv	a0,s6
 7ae:	dfdff0ef          	jal	5aa <printint>
        i += 1;
 7b2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b4:	8ba6                	mv	s7,s1
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	bde9                	j	692 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ba:	008b8493          	addi	s1,s7,8
 7be:	4681                	li	a3,0
 7c0:	4641                	li	a2,16
 7c2:	000ba583          	lw	a1,0(s7)
 7c6:	855a                	mv	a0,s6
 7c8:	de3ff0ef          	jal	5aa <printint>
        i += 2;
 7cc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ce:	8ba6                	mv	s7,s1
      state = 0;
 7d0:	4981                	li	s3,0
        i += 2;
 7d2:	b5c1                	j	692 <vprintf+0x44>
 7d4:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 7d6:	008b8793          	addi	a5,s7,8
 7da:	8cbe                	mv	s9,a5
 7dc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e0:	03000593          	li	a1,48
 7e4:	855a                	mv	a0,s6
 7e6:	da7ff0ef          	jal	58c <putc>
  putc(fd, 'x');
 7ea:	07800593          	li	a1,120
 7ee:	855a                	mv	a0,s6
 7f0:	d9dff0ef          	jal	58c <putc>
 7f4:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7f6:	00000b97          	auipc	s7,0x0
 7fa:	342b8b93          	addi	s7,s7,834 # b38 <digits>
 7fe:	03c9d793          	srli	a5,s3,0x3c
 802:	97de                	add	a5,a5,s7
 804:	0007c583          	lbu	a1,0(a5)
 808:	855a                	mv	a0,s6
 80a:	d83ff0ef          	jal	58c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 80e:	0992                	slli	s3,s3,0x4
 810:	34fd                	addiw	s1,s1,-1
 812:	f4f5                	bnez	s1,7fe <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 814:	8be6                	mv	s7,s9
      state = 0;
 816:	4981                	li	s3,0
 818:	6ca2                	ld	s9,8(sp)
 81a:	bda5                	j	692 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 81c:	008b8993          	addi	s3,s7,8
 820:	000bb483          	ld	s1,0(s7)
 824:	cc91                	beqz	s1,840 <vprintf+0x1f2>
        for(; *s; s++)
 826:	0004c583          	lbu	a1,0(s1)
 82a:	c985                	beqz	a1,85a <vprintf+0x20c>
          putc(fd, *s);
 82c:	855a                	mv	a0,s6
 82e:	d5fff0ef          	jal	58c <putc>
        for(; *s; s++)
 832:	0485                	addi	s1,s1,1
 834:	0004c583          	lbu	a1,0(s1)
 838:	f9f5                	bnez	a1,82c <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 83a:	8bce                	mv	s7,s3
      state = 0;
 83c:	4981                	li	s3,0
 83e:	bd91                	j	692 <vprintf+0x44>
          s = "(null)";
 840:	00000497          	auipc	s1,0x0
 844:	2f048493          	addi	s1,s1,752 # b30 <malloc+0x15c>
        for(; *s; s++)
 848:	02800593          	li	a1,40
 84c:	b7c5                	j	82c <vprintf+0x1de>
        putc(fd, '%');
 84e:	85be                	mv	a1,a5
 850:	855a                	mv	a0,s6
 852:	d3bff0ef          	jal	58c <putc>
      state = 0;
 856:	4981                	li	s3,0
 858:	bd2d                	j	692 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 85a:	8bce                	mv	s7,s3
      state = 0;
 85c:	4981                	li	s3,0
 85e:	bd15                	j	692 <vprintf+0x44>
 860:	6906                	ld	s2,64(sp)
 862:	79e2                	ld	s3,56(sp)
 864:	7a42                	ld	s4,48(sp)
 866:	7aa2                	ld	s5,40(sp)
 868:	7b02                	ld	s6,32(sp)
 86a:	6be2                	ld	s7,24(sp)
 86c:	6c42                	ld	s8,16(sp)
    }
  }
}
 86e:	60e6                	ld	ra,88(sp)
 870:	6446                	ld	s0,80(sp)
 872:	64a6                	ld	s1,72(sp)
 874:	6125                	addi	sp,sp,96
 876:	8082                	ret
      if(c0 == 'd'){
 878:	06400713          	li	a4,100
 87c:	e6e789e3          	beq	a5,a4,6ee <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 880:	f9478693          	addi	a3,a5,-108
 884:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 888:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 88a:	4701                	li	a4,0
      } else if(c0 == 'u'){
 88c:	07500513          	li	a0,117
 890:	eaa786e3          	beq	a5,a0,73c <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 894:	f8b60513          	addi	a0,a2,-117
 898:	e119                	bnez	a0,89e <vprintf+0x250>
 89a:	ea069de3          	bnez	a3,754 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 89e:	f8b58513          	addi	a0,a1,-117
 8a2:	e119                	bnez	a0,8a8 <vprintf+0x25a>
 8a4:	ec0715e3          	bnez	a4,76e <vprintf+0x120>
      } else if(c0 == 'x'){
 8a8:	07800513          	li	a0,120
 8ac:	eca78ee3          	beq	a5,a0,788 <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 8b0:	f8860613          	addi	a2,a2,-120
 8b4:	e219                	bnez	a2,8ba <vprintf+0x26c>
 8b6:	ee0695e3          	bnez	a3,7a0 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 8ba:	f8858593          	addi	a1,a1,-120
 8be:	e199                	bnez	a1,8c4 <vprintf+0x276>
 8c0:	ee071de3          	bnez	a4,7ba <vprintf+0x16c>
      } else if(c0 == 'p'){
 8c4:	07000713          	li	a4,112
 8c8:	f0e786e3          	beq	a5,a4,7d4 <vprintf+0x186>
      } else if(c0 == 's'){
 8cc:	07300713          	li	a4,115
 8d0:	f4e786e3          	beq	a5,a4,81c <vprintf+0x1ce>
      } else if(c0 == '%'){
 8d4:	02500713          	li	a4,37
 8d8:	f6e78be3          	beq	a5,a4,84e <vprintf+0x200>
        putc(fd, '%');
 8dc:	02500593          	li	a1,37
 8e0:	855a                	mv	a0,s6
 8e2:	cabff0ef          	jal	58c <putc>
        putc(fd, c0);
 8e6:	85a6                	mv	a1,s1
 8e8:	855a                	mv	a0,s6
 8ea:	ca3ff0ef          	jal	58c <putc>
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	b34d                	j	692 <vprintf+0x44>

00000000000008f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f2:	715d                	addi	sp,sp,-80
 8f4:	ec06                	sd	ra,24(sp)
 8f6:	e822                	sd	s0,16(sp)
 8f8:	1000                	addi	s0,sp,32
 8fa:	e010                	sd	a2,0(s0)
 8fc:	e414                	sd	a3,8(s0)
 8fe:	e818                	sd	a4,16(s0)
 900:	ec1c                	sd	a5,24(s0)
 902:	03043023          	sd	a6,32(s0)
 906:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90a:	8622                	mv	a2,s0
 90c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 910:	d3fff0ef          	jal	64e <vprintf>
}
 914:	60e2                	ld	ra,24(sp)
 916:	6442                	ld	s0,16(sp)
 918:	6161                	addi	sp,sp,80
 91a:	8082                	ret

000000000000091c <printf>:

void
printf(const char *fmt, ...)
{
 91c:	711d                	addi	sp,sp,-96
 91e:	ec06                	sd	ra,24(sp)
 920:	e822                	sd	s0,16(sp)
 922:	1000                	addi	s0,sp,32
 924:	e40c                	sd	a1,8(s0)
 926:	e810                	sd	a2,16(s0)
 928:	ec14                	sd	a3,24(s0)
 92a:	f018                	sd	a4,32(s0)
 92c:	f41c                	sd	a5,40(s0)
 92e:	03043823          	sd	a6,48(s0)
 932:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 936:	00840613          	addi	a2,s0,8
 93a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 93e:	85aa                	mv	a1,a0
 940:	4505                	li	a0,1
 942:	d0dff0ef          	jal	64e <vprintf>
}
 946:	60e2                	ld	ra,24(sp)
 948:	6442                	ld	s0,16(sp)
 94a:	6125                	addi	sp,sp,96
 94c:	8082                	ret

000000000000094e <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 94e:	1141                	addi	sp,sp,-16
 950:	e406                	sd	ra,8(sp)
 952:	e022                	sd	s0,0(sp)
 954:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 956:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95a:	00000797          	auipc	a5,0x0
 95e:	6a67b783          	ld	a5,1702(a5) # 1000 <freep>
 962:	a039                	j	970 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 964:	6398                	ld	a4,0(a5)
 966:	00e7e463          	bltu	a5,a4,96e <free+0x20>
 96a:	00e6ea63          	bltu	a3,a4,97e <free+0x30>
{
 96e:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 970:	fed7fae3          	bgeu	a5,a3,964 <free+0x16>
 974:	6398                	ld	a4,0(a5)
 976:	00e6e463          	bltu	a3,a4,97e <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97a:	fee7eae3          	bltu	a5,a4,96e <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 97e:	ff852583          	lw	a1,-8(a0)
 982:	6390                	ld	a2,0(a5)
 984:	02059813          	slli	a6,a1,0x20
 988:	01c85713          	srli	a4,a6,0x1c
 98c:	9736                	add	a4,a4,a3
 98e:	02e60563          	beq	a2,a4,9b8 <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 992:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 996:	4790                	lw	a2,8(a5)
 998:	02061593          	slli	a1,a2,0x20
 99c:	01c5d713          	srli	a4,a1,0x1c
 9a0:	973e                	add	a4,a4,a5
 9a2:	02e68263          	beq	a3,a4,9c6 <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 9a6:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 9a8:	00000717          	auipc	a4,0x0
 9ac:	64f73c23          	sd	a5,1624(a4) # 1000 <freep>
}
 9b0:	60a2                	ld	ra,8(sp)
 9b2:	6402                	ld	s0,0(sp)
 9b4:	0141                	addi	sp,sp,16
 9b6:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 9b8:	4618                	lw	a4,8(a2)
 9ba:	9f2d                	addw	a4,a4,a1
 9bc:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 9c0:	6398                	ld	a4,0(a5)
 9c2:	6310                	ld	a2,0(a4)
 9c4:	b7f9                	j	992 <free+0x44>
      p->s.size += bp->s.size;
 9c6:	ff852703          	lw	a4,-8(a0)
 9ca:	9f31                	addw	a4,a4,a2
 9cc:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 9ce:	ff053683          	ld	a3,-16(a0)
 9d2:	bfd1                	j	9a6 <free+0x58>

00000000000009d4 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 9d4:	7139                	addi	sp,sp,-64
 9d6:	fc06                	sd	ra,56(sp)
 9d8:	f822                	sd	s0,48(sp)
 9da:	f04a                	sd	s2,32(sp)
 9dc:	ec4e                	sd	s3,24(sp)
 9de:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 9e0:	02051993          	slli	s3,a0,0x20
 9e4:	0209d993          	srli	s3,s3,0x20
 9e8:	09bd                	addi	s3,s3,15
 9ea:	0049d993          	srli	s3,s3,0x4
 9ee:	2985                	addiw	s3,s3,1
 9f0:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 9f2:	00000517          	auipc	a0,0x0
 9f6:	60e53503          	ld	a0,1550(a0) # 1000 <freep>
 9fa:	c905                	beqz	a0,a2a <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 9fc:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 9fe:	4798                	lw	a4,8(a5)
 a00:	09377663          	bgeu	a4,s3,a8c <malloc+0xb8>
 a04:	f426                	sd	s1,40(sp)
 a06:	e852                	sd	s4,16(sp)
 a08:	e456                	sd	s5,8(sp)
 a0a:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 a0c:	8a4e                	mv	s4,s3
 a0e:	6705                	lui	a4,0x1
 a10:	00e9f363          	bgeu	s3,a4,a16 <malloc+0x42>
 a14:	6a05                	lui	s4,0x1
 a16:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 a1a:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 a1e:	00000497          	auipc	s1,0x0
 a22:	5e248493          	addi	s1,s1,1506 # 1000 <freep>
  if (p == (char *)-1)
 a26:	5afd                	li	s5,-1
 a28:	a83d                	j	a66 <malloc+0x92>
 a2a:	f426                	sd	s1,40(sp)
 a2c:	e852                	sd	s4,16(sp)
 a2e:	e456                	sd	s5,8(sp)
 a30:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 a32:	00000797          	auipc	a5,0x0
 a36:	5ee78793          	addi	a5,a5,1518 # 1020 <base>
 a3a:	00000717          	auipc	a4,0x0
 a3e:	5cf73323          	sd	a5,1478(a4) # 1000 <freep>
 a42:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 a44:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 a48:	b7d1                	j	a0c <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 a4a:	6398                	ld	a4,0(a5)
 a4c:	e118                	sd	a4,0(a0)
 a4e:	a899                	j	aa4 <malloc+0xd0>
  hp->s.size = nu;
 a50:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 a54:	0541                	addi	a0,a0,16
 a56:	ef9ff0ef          	jal	94e <free>
  return freep;
 a5a:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 a5c:	c125                	beqz	a0,abc <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 a5e:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 a60:	4798                	lw	a4,8(a5)
 a62:	03277163          	bgeu	a4,s2,a84 <malloc+0xb0>
      if (p == freep)
 a66:	6098                	ld	a4,0(s1)
 a68:	853e                	mv	a0,a5
 a6a:	fef71ae3          	bne	a4,a5,a5e <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 a6e:	8552                	mv	a0,s4
 a70:	afdff0ef          	jal	56c <sbrk>
  if (p == (char *)-1)
 a74:	fd551ee3          	bne	a0,s5,a50 <malloc+0x7c>
          return 0;
 a78:	4501                	li	a0,0
 a7a:	74a2                	ld	s1,40(sp)
 a7c:	6a42                	ld	s4,16(sp)
 a7e:	6aa2                	ld	s5,8(sp)
 a80:	6b02                	ld	s6,0(sp)
 a82:	a03d                	j	ab0 <malloc+0xdc>
 a84:	74a2                	ld	s1,40(sp)
 a86:	6a42                	ld	s4,16(sp)
 a88:	6aa2                	ld	s5,8(sp)
 a8a:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 a8c:	fae90fe3          	beq	s2,a4,a4a <malloc+0x76>
              p->s.size -= nunits;
 a90:	4137073b          	subw	a4,a4,s3
 a94:	c798                	sw	a4,8(a5)
              p += p->s.size;
 a96:	02071693          	slli	a3,a4,0x20
 a9a:	01c6d713          	srli	a4,a3,0x1c
 a9e:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 aa0:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 aa4:	00000717          	auipc	a4,0x0
 aa8:	54a73e23          	sd	a0,1372(a4) # 1000 <freep>
          return (void *)(p + 1);
 aac:	01078513          	addi	a0,a5,16
    }
}
 ab0:	70e2                	ld	ra,56(sp)
 ab2:	7442                	ld	s0,48(sp)
 ab4:	7902                	ld	s2,32(sp)
 ab6:	69e2                	ld	s3,24(sp)
 ab8:	6121                	addi	sp,sp,64
 aba:	8082                	ret
 abc:	74a2                	ld	s1,40(sp)
 abe:	6a42                	ld	s4,16(sp)
 ac0:	6aa2                	ld	s5,8(sp)
 ac2:	6b02                	ld	s6,0(sp)
 ac4:	b7f5                	j	ab0 <malloc+0xdc>
