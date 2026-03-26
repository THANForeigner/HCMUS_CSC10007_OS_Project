
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	20000d93          	li	s11,512
  32:	00001d17          	auipc	s10,0x1
  36:	fded0d13          	addi	s10,s10,-34 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	994a0a13          	addi	s4,s4,-1644 # 9d0 <malloc+0xf8>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a035                	j	70 <wc+0x70>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	1c8000ef          	jal	210 <strchr>
  4c:	c919                	beqz	a0,62 <wc+0x62>
        inword = 0;
  4e:	4901                	li	s2,0
    for(i=0; i<n; i++){
  50:	0485                	addi	s1,s1,1
  52:	01348d63          	beq	s1,s3,6c <wc+0x6c>
      if(buf[i] == '\n')
  56:	0004c583          	lbu	a1,0(s1)
  5a:	ff5596e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  5e:	2b85                	addiw	s7,s7,1
  60:	b7dd                	j	46 <wc+0x46>
      else if(!inword){
  62:	fe0917e3          	bnez	s2,50 <wc+0x50>
        w++;
  66:	2c05                	addiw	s8,s8,1
        inword = 1;
  68:	4905                	li	s2,1
  6a:	b7dd                	j	50 <wc+0x50>
  6c:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  70:	866e                	mv	a2,s11
  72:	85ea                	mv	a1,s10
  74:	f8843503          	ld	a0,-120(s0)
  78:	388000ef          	jal	400 <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	addi	s1,s1,-114 # 1010 <buf>
  8a:	009b09b3          	add	s3,s6,s1
  8e:	b7e1                	j	56 <wc+0x56>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86e6                	mv	a3,s9
  9a:	8662                	mv	a2,s8
  9c:	85de                	mv	a1,s7
  9e:	00001517          	auipc	a0,0x1
  a2:	95250513          	addi	a0,a0,-1710 # 9f0 <malloc+0x118>
  a6:	77a000ef          	jal	820 <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	addi	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	91850513          	addi	a0,a0,-1768 # 9e0 <malloc+0x108>
  d0:	750000ef          	jal	820 <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	312000ef          	jal	3e8 <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	addi	s2,a1,8
  f2:	ffe5099b          	addiw	s3,a0,-2
  f6:	02099793          	slli	a5,s3,0x20
  fa:	01d7d993          	srli	s3,a5,0x1d
  fe:	05c1                	addi	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	320000ef          	jal	428 <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	2f4000ef          	jal	410 <close>
  for(i = 1; i < argc; i++){
 120:	0921                	addi	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	2c0000ef          	jal	3e8 <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
    wc(0, "");
 132:	00001597          	auipc	a1,0x1
 136:	8a658593          	addi	a1,a1,-1882 # 9d8 <malloc+0x100>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
    exit(0);
 140:	4501                	li	a0,0
 142:	2a6000ef          	jal	3e8 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	8b650513          	addi	a0,a0,-1866 # a00 <malloc+0x128>
 152:	6ce000ef          	jal	820 <printf>
      exit(1);
 156:	4505                	li	a0,1
 158:	290000ef          	jal	3e8 <exit>

000000000000015c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start ()
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	addi	s0,sp,16
  extern int main ();
  main ();
 164:	f77ff0ef          	jal	da <main>
  exit (0);
 168:	4501                	li	a0,0
 16a:	27e000ef          	jal	3e8 <exit>

000000000000016e <strcpy>:
}

char *
strcpy (char *s, const char *t)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e406                	sd	ra,8(sp)
 172:	e022                	sd	s0,0(sp)
 174:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 176:	87aa                	mv	a5,a0
 178:	0585                	addi	a1,a1,1
 17a:	0785                	addi	a5,a5,1
 17c:	fff5c703          	lbu	a4,-1(a1)
 180:	fee78fa3          	sb	a4,-1(a5)
 184:	fb75                	bnez	a4,178 <strcpy+0xa>
    ;
  return os;
}
 186:	60a2                	ld	ra,8(sp)
 188:	6402                	ld	s0,0(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <strcmp>:

int
strcmp (const char *p, const char *q)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 196:	00054783          	lbu	a5,0(a0)
 19a:	cb91                	beqz	a5,1ae <strcmp+0x20>
 19c:	0005c703          	lbu	a4,0(a1)
 1a0:	00f71763          	bne	a4,a5,1ae <strcmp+0x20>
    p++, q++;
 1a4:	0505                	addi	a0,a0,1
 1a6:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	fbe5                	bnez	a5,19c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1ae:	0005c503          	lbu	a0,0(a1)
}
 1b2:	40a7853b          	subw	a0,a5,a0
 1b6:	60a2                	ld	ra,8(sp)
 1b8:	6402                	ld	s0,0(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strlen>:

uint
strlen (const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf91                	beqz	a5,1e6 <strlen+0x28>
 1cc:	00150793          	addi	a5,a0,1
 1d0:	86be                	mv	a3,a5
 1d2:	0785                	addi	a5,a5,1
 1d4:	fff7c703          	lbu	a4,-1(a5)
 1d8:	ff65                	bnez	a4,1d0 <strlen+0x12>
 1da:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 1de:	60a2                	ld	ra,8(sp)
 1e0:	6402                	ld	s0,0(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret
  for (n = 0; s[n]; n++)
 1e6:	4501                	li	a0,0
 1e8:	bfdd                	j	1de <strlen+0x20>

00000000000001ea <memset>:

void *
memset (void *dst, int c, uint n)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 1f2:	ca19                	beqz	a2,208 <memset+0x1e>
 1f4:	87aa                	mv	a5,a0
 1f6:	1602                	slli	a2,a2,0x20
 1f8:	9201                	srli	a2,a2,0x20
 1fa:	00a60733          	add	a4,a2,a0
    {
      cdst[i] = c;
 1fe:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 202:	0785                	addi	a5,a5,1
 204:	fee79de3          	bne	a5,a4,1fe <memset+0x14>
    }
  return dst;
}
 208:	60a2                	ld	ra,8(sp)
 20a:	6402                	ld	s0,0(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret

0000000000000210 <strchr>:

char *
strchr (const char *s, char c)
{
 210:	1141                	addi	sp,sp,-16
 212:	e406                	sd	ra,8(sp)
 214:	e022                	sd	s0,0(sp)
 216:	0800                	addi	s0,sp,16
  for (; *s; s++)
 218:	00054783          	lbu	a5,0(a0)
 21c:	cf81                	beqz	a5,234 <strchr+0x24>
    if (*s == c)
 21e:	00f58763          	beq	a1,a5,22c <strchr+0x1c>
  for (; *s; s++)
 222:	0505                	addi	a0,a0,1
 224:	00054783          	lbu	a5,0(a0)
 228:	fbfd                	bnez	a5,21e <strchr+0xe>
      return (char *)s;
  return 0;
 22a:	4501                	li	a0,0
}
 22c:	60a2                	ld	ra,8(sp)
 22e:	6402                	ld	s0,0(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret
  return 0;
 234:	4501                	li	a0,0
 236:	bfdd                	j	22c <strchr+0x1c>

0000000000000238 <gets>:

char *
gets (char *buf, int max)
{
 238:	711d                	addi	sp,sp,-96
 23a:	ec86                	sd	ra,88(sp)
 23c:	e8a2                	sd	s0,80(sp)
 23e:	e4a6                	sd	s1,72(sp)
 240:	e0ca                	sd	s2,64(sp)
 242:	fc4e                	sd	s3,56(sp)
 244:	f852                	sd	s4,48(sp)
 246:	f456                	sd	s5,40(sp)
 248:	f05a                	sd	s6,32(sp)
 24a:	ec5e                	sd	s7,24(sp)
 24c:	e862                	sd	s8,16(sp)
 24e:	1080                	addi	s0,sp,96
 250:	8baa                	mv	s7,a0
 252:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 254:	892a                	mv	s2,a0
 256:	4481                	li	s1,0
    {
      cc = read (0, &c, 1);
 258:	faf40b13          	addi	s6,s0,-81
 25c:	4a85                	li	s5,1
  for (i = 0; i + 1 < max;)
 25e:	8c26                	mv	s8,s1
 260:	0014899b          	addiw	s3,s1,1
 264:	84ce                	mv	s1,s3
 266:	0349d463          	bge	s3,s4,28e <gets+0x56>
      cc = read (0, &c, 1);
 26a:	8656                	mv	a2,s5
 26c:	85da                	mv	a1,s6
 26e:	4501                	li	a0,0
 270:	190000ef          	jal	400 <read>
      if (cc < 1)
 274:	00a05d63          	blez	a0,28e <gets+0x56>
        break;
      buf[i++] = c;
 278:	faf44783          	lbu	a5,-81(s0)
 27c:	00f90023          	sb	a5,0(s2)
      if (c == '\n' || c == '\r')
 280:	0905                	addi	s2,s2,1
 282:	ff678713          	addi	a4,a5,-10
 286:	c319                	beqz	a4,28c <gets+0x54>
 288:	17cd                	addi	a5,a5,-13
 28a:	fbf1                	bnez	a5,25e <gets+0x26>
      buf[i++] = c;
 28c:	8c4e                	mv	s8,s3
        break;
    }
  buf[i] = '\0';
 28e:	9c5e                	add	s8,s8,s7
 290:	000c0023          	sb	zero,0(s8)
  return buf;
}
 294:	855e                	mv	a0,s7
 296:	60e6                	ld	ra,88(sp)
 298:	6446                	ld	s0,80(sp)
 29a:	64a6                	ld	s1,72(sp)
 29c:	6906                	ld	s2,64(sp)
 29e:	79e2                	ld	s3,56(sp)
 2a0:	7a42                	ld	s4,48(sp)
 2a2:	7aa2                	ld	s5,40(sp)
 2a4:	7b02                	ld	s6,32(sp)
 2a6:	6be2                	ld	s7,24(sp)
 2a8:	6c42                	ld	s8,16(sp)
 2aa:	6125                	addi	sp,sp,96
 2ac:	8082                	ret

00000000000002ae <stat>:

int
stat (const char *n, struct stat *st)
{
 2ae:	1101                	addi	sp,sp,-32
 2b0:	ec06                	sd	ra,24(sp)
 2b2:	e822                	sd	s0,16(sp)
 2b4:	e04a                	sd	s2,0(sp)
 2b6:	1000                	addi	s0,sp,32
 2b8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open (n, O_RDONLY);
 2ba:	4581                	li	a1,0
 2bc:	16c000ef          	jal	428 <open>
  if (fd < 0)
 2c0:	02054263          	bltz	a0,2e4 <stat+0x36>
 2c4:	e426                	sd	s1,8(sp)
 2c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat (fd, st);
 2c8:	85ca                	mv	a1,s2
 2ca:	176000ef          	jal	440 <fstat>
 2ce:	892a                	mv	s2,a0
  close (fd);
 2d0:	8526                	mv	a0,s1
 2d2:	13e000ef          	jal	410 <close>
  return r;
 2d6:	64a2                	ld	s1,8(sp)
}
 2d8:	854a                	mv	a0,s2
 2da:	60e2                	ld	ra,24(sp)
 2dc:	6442                	ld	s0,16(sp)
 2de:	6902                	ld	s2,0(sp)
 2e0:	6105                	addi	sp,sp,32
 2e2:	8082                	ret
    return -1;
 2e4:	57fd                	li	a5,-1
 2e6:	893e                	mv	s2,a5
 2e8:	bfc5                	j	2d8 <stat+0x2a>

00000000000002ea <atoi>:

int
atoi (const char *s)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 2f2:	00054683          	lbu	a3,0(a0)
 2f6:	fd06879b          	addiw	a5,a3,-48
 2fa:	0ff7f793          	zext.b	a5,a5
 2fe:	4625                	li	a2,9
 300:	02f66963          	bltu	a2,a5,332 <atoi+0x48>
 304:	872a                	mv	a4,a0
  n = 0;
 306:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 308:	0705                	addi	a4,a4,1
 30a:	0025179b          	slliw	a5,a0,0x2
 30e:	9fa9                	addw	a5,a5,a0
 310:	0017979b          	slliw	a5,a5,0x1
 314:	9fb5                	addw	a5,a5,a3
 316:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 31a:	00074683          	lbu	a3,0(a4)
 31e:	fd06879b          	addiw	a5,a3,-48
 322:	0ff7f793          	zext.b	a5,a5
 326:	fef671e3          	bgeu	a2,a5,308 <atoi+0x1e>
  return n;
}
 32a:	60a2                	ld	ra,8(sp)
 32c:	6402                	ld	s0,0(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
  n = 0;
 332:	4501                	li	a0,0
 334:	bfdd                	j	32a <atoi+0x40>

0000000000000336 <memmove>:

void *
memmove (void *vdst, const void *vsrc, int n)
{
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 33e:	02b57563          	bgeu	a0,a1,368 <memmove+0x32>
    {
      while (n-- > 0)
 342:	00c05f63          	blez	a2,360 <memmove+0x2a>
 346:	1602                	slli	a2,a2,0x20
 348:	9201                	srli	a2,a2,0x20
 34a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 34e:	872a                	mv	a4,a0
        *dst++ = *src++;
 350:	0585                	addi	a1,a1,1
 352:	0705                	addi	a4,a4,1
 354:	fff5c683          	lbu	a3,-1(a1)
 358:	fed70fa3          	sb	a3,-1(a4)
      while (n-- > 0)
 35c:	fee79ae3          	bne	a5,a4,350 <memmove+0x1a>
      src += n;
      while (n-- > 0)
        *--dst = *--src;
    }
  return vdst;
}
 360:	60a2                	ld	ra,8(sp)
 362:	6402                	ld	s0,0(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret
      while (n-- > 0)
 368:	fec05ce3          	blez	a2,360 <memmove+0x2a>
      dst += n;
 36c:	00c50733          	add	a4,a0,a2
      src += n;
 370:	95b2                	add	a1,a1,a2
 372:	fff6079b          	addiw	a5,a2,-1
 376:	1782                	slli	a5,a5,0x20
 378:	9381                	srli	a5,a5,0x20
 37a:	fff7c793          	not	a5,a5
 37e:	97ba                	add	a5,a5,a4
        *--dst = *--src;
 380:	15fd                	addi	a1,a1,-1
 382:	177d                	addi	a4,a4,-1
 384:	0005c683          	lbu	a3,0(a1)
 388:	00d70023          	sb	a3,0(a4)
      while (n-- > 0)
 38c:	fef71ae3          	bne	a4,a5,380 <memmove+0x4a>
 390:	bfc1                	j	360 <memmove+0x2a>

0000000000000392 <memcmp>:

int
memcmp (const void *s1, const void *s2, uint n)
{
 392:	1141                	addi	sp,sp,-16
 394:	e406                	sd	ra,8(sp)
 396:	e022                	sd	s0,0(sp)
 398:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 39a:	c61d                	beqz	a2,3c8 <memcmp+0x36>
 39c:	1602                	slli	a2,a2,0x20
 39e:	9201                	srli	a2,a2,0x20
 3a0:	00c506b3          	add	a3,a0,a2
    {
      if (*p1 != *p2)
 3a4:	00054783          	lbu	a5,0(a0)
 3a8:	0005c703          	lbu	a4,0(a1)
 3ac:	00e79863          	bne	a5,a4,3bc <memcmp+0x2a>
        {
          return *p1 - *p2;
        }
      p1++;
 3b0:	0505                	addi	a0,a0,1
      p2++;
 3b2:	0585                	addi	a1,a1,1
  while (n-- > 0)
 3b4:	fed518e3          	bne	a0,a3,3a4 <memcmp+0x12>
    }
  return 0;
 3b8:	4501                	li	a0,0
 3ba:	a019                	j	3c0 <memcmp+0x2e>
          return *p1 - *p2;
 3bc:	40e7853b          	subw	a0,a5,a4
}
 3c0:	60a2                	ld	ra,8(sp)
 3c2:	6402                	ld	s0,0(sp)
 3c4:	0141                	addi	sp,sp,16
 3c6:	8082                	ret
  return 0;
 3c8:	4501                	li	a0,0
 3ca:	bfdd                	j	3c0 <memcmp+0x2e>

00000000000003cc <memcpy>:

void *
memcpy (void *dst, const void *src, uint n)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e406                	sd	ra,8(sp)
 3d0:	e022                	sd	s0,0(sp)
 3d2:	0800                	addi	s0,sp,16
  return memmove (dst, src, n);
 3d4:	f63ff0ef          	jal	336 <memmove>
}
 3d8:	60a2                	ld	ra,8(sp)
 3da:	6402                	ld	s0,0(sp)
 3dc:	0141                	addi	sp,sp,16
 3de:	8082                	ret

00000000000003e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e0:	4885                	li	a7,1
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e8:	4889                	li	a7,2
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f0:	488d                	li	a7,3
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f8:	4891                	li	a7,4
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <read>:
.global read
read:
 li a7, SYS_read
 400:	4895                	li	a7,5
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <write>:
.global write
write:
 li a7, SYS_write
 408:	48c1                	li	a7,16
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <close>:
.global close
close:
 li a7, SYS_close
 410:	48d5                	li	a7,21
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <kill>:
.global kill
kill:
 li a7, SYS_kill
 418:	4899                	li	a7,6
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <exec>:
.global exec
exec:
 li a7, SYS_exec
 420:	489d                	li	a7,7
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <open>:
.global open
open:
 li a7, SYS_open
 428:	48bd                	li	a7,15
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 430:	48c5                	li	a7,17
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 438:	48c9                	li	a7,18
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 440:	48a1                	li	a7,8
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <link>:
.global link
link:
 li a7, SYS_link
 448:	48cd                	li	a7,19
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 450:	48d1                	li	a7,20
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 458:	48a5                	li	a7,9
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <dup>:
.global dup
dup:
 li a7, SYS_dup
 460:	48a9                	li	a7,10
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 468:	48ad                	li	a7,11
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 470:	48b1                	li	a7,12
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 478:	48b5                	li	a7,13
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 480:	48b9                	li	a7,14
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <trace>:
.global trace
trace:
 li a7, SYS_trace
 488:	48d9                	li	a7,22
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 490:	1101                	addi	sp,sp,-32
 492:	ec06                	sd	ra,24(sp)
 494:	e822                	sd	s0,16(sp)
 496:	1000                	addi	s0,sp,32
 498:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 49c:	4605                	li	a2,1
 49e:	fef40593          	addi	a1,s0,-17
 4a2:	f67ff0ef          	jal	408 <write>
}
 4a6:	60e2                	ld	ra,24(sp)
 4a8:	6442                	ld	s0,16(sp)
 4aa:	6105                	addi	sp,sp,32
 4ac:	8082                	ret

00000000000004ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ae:	7139                	addi	sp,sp,-64
 4b0:	fc06                	sd	ra,56(sp)
 4b2:	f822                	sd	s0,48(sp)
 4b4:	f04a                	sd	s2,32(sp)
 4b6:	ec4e                	sd	s3,24(sp)
 4b8:	0080                	addi	s0,sp,64
 4ba:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bc:	cac9                	beqz	a3,54e <printint+0xa0>
 4be:	01f5d79b          	srliw	a5,a1,0x1f
 4c2:	c7d1                	beqz	a5,54e <printint+0xa0>
    neg = 1;
    x = -xx;
 4c4:	40b005bb          	negw	a1,a1
    neg = 1;
 4c8:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4ca:	fc040993          	addi	s3,s0,-64
  neg = 0;
 4ce:	86ce                	mv	a3,s3
  i = 0;
 4d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4d2:	00000817          	auipc	a6,0x0
 4d6:	54e80813          	addi	a6,a6,1358 # a20 <digits>
 4da:	88ba                	mv	a7,a4
 4dc:	0017051b          	addiw	a0,a4,1
 4e0:	872a                	mv	a4,a0
 4e2:	02c5f7bb          	remuw	a5,a1,a2
 4e6:	1782                	slli	a5,a5,0x20
 4e8:	9381                	srli	a5,a5,0x20
 4ea:	97c2                	add	a5,a5,a6
 4ec:	0007c783          	lbu	a5,0(a5)
 4f0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4f4:	87ae                	mv	a5,a1
 4f6:	02c5d5bb          	divuw	a1,a1,a2
 4fa:	0685                	addi	a3,a3,1
 4fc:	fcc7ffe3          	bgeu	a5,a2,4da <printint+0x2c>
  if(neg)
 500:	00030c63          	beqz	t1,518 <printint+0x6a>
    buf[i++] = '-';
 504:	fd050793          	addi	a5,a0,-48
 508:	00878533          	add	a0,a5,s0
 50c:	02d00793          	li	a5,45
 510:	fef50823          	sb	a5,-16(a0)
 514:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 518:	02e05563          	blez	a4,542 <printint+0x94>
 51c:	f426                	sd	s1,40(sp)
 51e:	377d                	addiw	a4,a4,-1
 520:	00e984b3          	add	s1,s3,a4
 524:	19fd                	addi	s3,s3,-1
 526:	99ba                	add	s3,s3,a4
 528:	1702                	slli	a4,a4,0x20
 52a:	9301                	srli	a4,a4,0x20
 52c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 530:	0004c583          	lbu	a1,0(s1)
 534:	854a                	mv	a0,s2
 536:	f5bff0ef          	jal	490 <putc>
  while(--i >= 0)
 53a:	14fd                	addi	s1,s1,-1
 53c:	ff349ae3          	bne	s1,s3,530 <printint+0x82>
 540:	74a2                	ld	s1,40(sp)
}
 542:	70e2                	ld	ra,56(sp)
 544:	7442                	ld	s0,48(sp)
 546:	7902                	ld	s2,32(sp)
 548:	69e2                	ld	s3,24(sp)
 54a:	6121                	addi	sp,sp,64
 54c:	8082                	ret
  neg = 0;
 54e:	4301                	li	t1,0
 550:	bfad                	j	4ca <printint+0x1c>

0000000000000552 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 552:	711d                	addi	sp,sp,-96
 554:	ec86                	sd	ra,88(sp)
 556:	e8a2                	sd	s0,80(sp)
 558:	e4a6                	sd	s1,72(sp)
 55a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 55c:	0005c483          	lbu	s1,0(a1)
 560:	20048963          	beqz	s1,772 <vprintf+0x220>
 564:	e0ca                	sd	s2,64(sp)
 566:	fc4e                	sd	s3,56(sp)
 568:	f852                	sd	s4,48(sp)
 56a:	f456                	sd	s5,40(sp)
 56c:	f05a                	sd	s6,32(sp)
 56e:	ec5e                	sd	s7,24(sp)
 570:	e862                	sd	s8,16(sp)
 572:	8b2a                	mv	s6,a0
 574:	8a2e                	mv	s4,a1
 576:	8bb2                	mv	s7,a2
  state = 0;
 578:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 57a:	4901                	li	s2,0
 57c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 57e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 582:	06400c13          	li	s8,100
 586:	a00d                	j	5a8 <vprintf+0x56>
        putc(fd, c0);
 588:	85a6                	mv	a1,s1
 58a:	855a                	mv	a0,s6
 58c:	f05ff0ef          	jal	490 <putc>
 590:	a019                	j	596 <vprintf+0x44>
    } else if(state == '%'){
 592:	03598363          	beq	s3,s5,5b8 <vprintf+0x66>
  for(i = 0; fmt[i]; i++){
 596:	0019079b          	addiw	a5,s2,1
 59a:	893e                	mv	s2,a5
 59c:	873e                	mv	a4,a5
 59e:	97d2                	add	a5,a5,s4
 5a0:	0007c483          	lbu	s1,0(a5)
 5a4:	1c048063          	beqz	s1,764 <vprintf+0x212>
    c0 = fmt[i] & 0xff;
 5a8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5ac:	fe0993e3          	bnez	s3,592 <vprintf+0x40>
      if(c0 == '%'){
 5b0:	fd579ce3          	bne	a5,s5,588 <vprintf+0x36>
        state = '%';
 5b4:	89be                	mv	s3,a5
 5b6:	b7c5                	j	596 <vprintf+0x44>
      if(c0) c1 = fmt[i+1] & 0xff;
 5b8:	00ea06b3          	add	a3,s4,a4
 5bc:	0016c603          	lbu	a2,1(a3)
      if(c1) c2 = fmt[i+2] & 0xff;
 5c0:	1a060e63          	beqz	a2,77c <vprintf+0x22a>
      if(c0 == 'd'){
 5c4:	03878763          	beq	a5,s8,5f2 <vprintf+0xa0>
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5c8:	f9478693          	addi	a3,a5,-108
 5cc:	0016b693          	seqz	a3,a3
 5d0:	f9c60593          	addi	a1,a2,-100
 5d4:	e99d                	bnez	a1,60a <vprintf+0xb8>
 5d6:	ca95                	beqz	a3,60a <vprintf+0xb8>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d8:	008b8493          	addi	s1,s7,8
 5dc:	4685                	li	a3,1
 5de:	4629                	li	a2,10
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	ec9ff0ef          	jal	4ae <printint>
        i += 1;
 5ea:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ec:	8ba6                	mv	s7,s1
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	b75d                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 1);
 5f2:	008b8493          	addi	s1,s7,8
 5f6:	4685                	li	a3,1
 5f8:	4629                	li	a2,10
 5fa:	000ba583          	lw	a1,0(s7)
 5fe:	855a                	mv	a0,s6
 600:	eafff0ef          	jal	4ae <printint>
 604:	8ba6                	mv	s7,s1
      state = 0;
 606:	4981                	li	s3,0
 608:	b779                	j	596 <vprintf+0x44>
      if(c1) c2 = fmt[i+2] & 0xff;
 60a:	9752                	add	a4,a4,s4
 60c:	00274583          	lbu	a1,2(a4)
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 610:	f9460713          	addi	a4,a2,-108
 614:	00173713          	seqz	a4,a4
 618:	8f75                	and	a4,a4,a3
 61a:	f9c58513          	addi	a0,a1,-100
 61e:	16051963          	bnez	a0,790 <vprintf+0x23e>
 622:	16070763          	beqz	a4,790 <vprintf+0x23e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 626:	008b8493          	addi	s1,s7,8
 62a:	4685                	li	a3,1
 62c:	4629                	li	a2,10
 62e:	000ba583          	lw	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	e7bff0ef          	jal	4ae <printint>
        i += 2;
 638:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 63a:	8ba6                	mv	s7,s1
      state = 0;
 63c:	4981                	li	s3,0
        i += 2;
 63e:	bfa1                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 10, 0);
 640:	008b8493          	addi	s1,s7,8
 644:	4681                	li	a3,0
 646:	4629                	li	a2,10
 648:	000ba583          	lw	a1,0(s7)
 64c:	855a                	mv	a0,s6
 64e:	e61ff0ef          	jal	4ae <printint>
 652:	8ba6                	mv	s7,s1
      state = 0;
 654:	4981                	li	s3,0
 656:	b781                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 658:	008b8493          	addi	s1,s7,8
 65c:	4681                	li	a3,0
 65e:	4629                	li	a2,10
 660:	000ba583          	lw	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e49ff0ef          	jal	4ae <printint>
        i += 1;
 66a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 66c:	8ba6                	mv	s7,s1
      state = 0;
 66e:	4981                	li	s3,0
 670:	b71d                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 672:	008b8493          	addi	s1,s7,8
 676:	4681                	li	a3,0
 678:	4629                	li	a2,10
 67a:	000ba583          	lw	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	e2fff0ef          	jal	4ae <printint>
        i += 2;
 684:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 686:	8ba6                	mv	s7,s1
      state = 0;
 688:	4981                	li	s3,0
        i += 2;
 68a:	b731                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 68c:	008b8493          	addi	s1,s7,8
 690:	4681                	li	a3,0
 692:	4641                	li	a2,16
 694:	000ba583          	lw	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	e15ff0ef          	jal	4ae <printint>
 69e:	8ba6                	mv	s7,s1
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bdd5                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a4:	008b8493          	addi	s1,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4641                	li	a2,16
 6ac:	000ba583          	lw	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dfdff0ef          	jal	4ae <printint>
        i += 1;
 6b6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b8:	8ba6                	mv	s7,s1
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bde9                	j	596 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4641                	li	a2,16
 6c6:	000ba583          	lw	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	de3ff0ef          	jal	4ae <printint>
        i += 2;
 6d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
        i += 2;
 6d6:	b5c1                	j	596 <vprintf+0x44>
 6d8:	e466                	sd	s9,8(sp)
        printptr(fd, va_arg(ap, uint64));
 6da:	008b8793          	addi	a5,s7,8
 6de:	8cbe                	mv	s9,a5
 6e0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e4:	03000593          	li	a1,48
 6e8:	855a                	mv	a0,s6
 6ea:	da7ff0ef          	jal	490 <putc>
  putc(fd, 'x');
 6ee:	07800593          	li	a1,120
 6f2:	855a                	mv	a0,s6
 6f4:	d9dff0ef          	jal	490 <putc>
 6f8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fa:	00000b97          	auipc	s7,0x0
 6fe:	326b8b93          	addi	s7,s7,806 # a20 <digits>
 702:	03c9d793          	srli	a5,s3,0x3c
 706:	97de                	add	a5,a5,s7
 708:	0007c583          	lbu	a1,0(a5)
 70c:	855a                	mv	a0,s6
 70e:	d83ff0ef          	jal	490 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 712:	0992                	slli	s3,s3,0x4
 714:	34fd                	addiw	s1,s1,-1
 716:	f4f5                	bnez	s1,702 <vprintf+0x1b0>
        printptr(fd, va_arg(ap, uint64));
 718:	8be6                	mv	s7,s9
      state = 0;
 71a:	4981                	li	s3,0
 71c:	6ca2                	ld	s9,8(sp)
 71e:	bda5                	j	596 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 720:	008b8993          	addi	s3,s7,8
 724:	000bb483          	ld	s1,0(s7)
 728:	cc91                	beqz	s1,744 <vprintf+0x1f2>
        for(; *s; s++)
 72a:	0004c583          	lbu	a1,0(s1)
 72e:	c985                	beqz	a1,75e <vprintf+0x20c>
          putc(fd, *s);
 730:	855a                	mv	a0,s6
 732:	d5fff0ef          	jal	490 <putc>
        for(; *s; s++)
 736:	0485                	addi	s1,s1,1
 738:	0004c583          	lbu	a1,0(s1)
 73c:	f9f5                	bnez	a1,730 <vprintf+0x1de>
        if((s = va_arg(ap, char*)) == 0)
 73e:	8bce                	mv	s7,s3
      state = 0;
 740:	4981                	li	s3,0
 742:	bd91                	j	596 <vprintf+0x44>
          s = "(null)";
 744:	00000497          	auipc	s1,0x0
 748:	2d448493          	addi	s1,s1,724 # a18 <malloc+0x140>
        for(; *s; s++)
 74c:	02800593          	li	a1,40
 750:	b7c5                	j	730 <vprintf+0x1de>
        putc(fd, '%');
 752:	85be                	mv	a1,a5
 754:	855a                	mv	a0,s6
 756:	d3bff0ef          	jal	490 <putc>
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bd2d                	j	596 <vprintf+0x44>
        if((s = va_arg(ap, char*)) == 0)
 75e:	8bce                	mv	s7,s3
      state = 0;
 760:	4981                	li	s3,0
 762:	bd15                	j	596 <vprintf+0x44>
 764:	6906                	ld	s2,64(sp)
 766:	79e2                	ld	s3,56(sp)
 768:	7a42                	ld	s4,48(sp)
 76a:	7aa2                	ld	s5,40(sp)
 76c:	7b02                	ld	s6,32(sp)
 76e:	6be2                	ld	s7,24(sp)
 770:	6c42                	ld	s8,16(sp)
    }
  }
}
 772:	60e6                	ld	ra,88(sp)
 774:	6446                	ld	s0,80(sp)
 776:	64a6                	ld	s1,72(sp)
 778:	6125                	addi	sp,sp,96
 77a:	8082                	ret
      if(c0 == 'd'){
 77c:	06400713          	li	a4,100
 780:	e6e789e3          	beq	a5,a4,5f2 <vprintf+0xa0>
      } else if(c0 == 'l' && c1 == 'd'){
 784:	f9478693          	addi	a3,a5,-108
 788:	0016b693          	seqz	a3,a3
      c1 = c2 = 0;
 78c:	85b2                	mv	a1,a2
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 78e:	4701                	li	a4,0
      } else if(c0 == 'u'){
 790:	07500513          	li	a0,117
 794:	eaa786e3          	beq	a5,a0,640 <vprintf+0xee>
      } else if(c0 == 'l' && c1 == 'u'){
 798:	f8b60513          	addi	a0,a2,-117
 79c:	e119                	bnez	a0,7a2 <vprintf+0x250>
 79e:	ea069de3          	bnez	a3,658 <vprintf+0x106>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7a2:	f8b58513          	addi	a0,a1,-117
 7a6:	e119                	bnez	a0,7ac <vprintf+0x25a>
 7a8:	ec0715e3          	bnez	a4,672 <vprintf+0x120>
      } else if(c0 == 'x'){
 7ac:	07800513          	li	a0,120
 7b0:	eca78ee3          	beq	a5,a0,68c <vprintf+0x13a>
      } else if(c0 == 'l' && c1 == 'x'){
 7b4:	f8860613          	addi	a2,a2,-120
 7b8:	e219                	bnez	a2,7be <vprintf+0x26c>
 7ba:	ee0695e3          	bnez	a3,6a4 <vprintf+0x152>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7be:	f8858593          	addi	a1,a1,-120
 7c2:	e199                	bnez	a1,7c8 <vprintf+0x276>
 7c4:	ee071de3          	bnez	a4,6be <vprintf+0x16c>
      } else if(c0 == 'p'){
 7c8:	07000713          	li	a4,112
 7cc:	f0e786e3          	beq	a5,a4,6d8 <vprintf+0x186>
      } else if(c0 == 's'){
 7d0:	07300713          	li	a4,115
 7d4:	f4e786e3          	beq	a5,a4,720 <vprintf+0x1ce>
      } else if(c0 == '%'){
 7d8:	02500713          	li	a4,37
 7dc:	f6e78be3          	beq	a5,a4,752 <vprintf+0x200>
        putc(fd, '%');
 7e0:	02500593          	li	a1,37
 7e4:	855a                	mv	a0,s6
 7e6:	cabff0ef          	jal	490 <putc>
        putc(fd, c0);
 7ea:	85a6                	mv	a1,s1
 7ec:	855a                	mv	a0,s6
 7ee:	ca3ff0ef          	jal	490 <putc>
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	b34d                	j	596 <vprintf+0x44>

00000000000007f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f6:	715d                	addi	sp,sp,-80
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	e010                	sd	a2,0(s0)
 800:	e414                	sd	a3,8(s0)
 802:	e818                	sd	a4,16(s0)
 804:	ec1c                	sd	a5,24(s0)
 806:	03043023          	sd	a6,32(s0)
 80a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80e:	8622                	mv	a2,s0
 810:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 814:	d3fff0ef          	jal	552 <vprintf>
}
 818:	60e2                	ld	ra,24(sp)
 81a:	6442                	ld	s0,16(sp)
 81c:	6161                	addi	sp,sp,80
 81e:	8082                	ret

0000000000000820 <printf>:

void
printf(const char *fmt, ...)
{
 820:	711d                	addi	sp,sp,-96
 822:	ec06                	sd	ra,24(sp)
 824:	e822                	sd	s0,16(sp)
 826:	1000                	addi	s0,sp,32
 828:	e40c                	sd	a1,8(s0)
 82a:	e810                	sd	a2,16(s0)
 82c:	ec14                	sd	a3,24(s0)
 82e:	f018                	sd	a4,32(s0)
 830:	f41c                	sd	a5,40(s0)
 832:	03043823          	sd	a6,48(s0)
 836:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83a:	00840613          	addi	a2,s0,8
 83e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 842:	85aa                	mv	a1,a0
 844:	4505                	li	a0,1
 846:	d0dff0ef          	jal	552 <vprintf>
}
 84a:	60e2                	ld	ra,24(sp)
 84c:	6442                	ld	s0,16(sp)
 84e:	6125                	addi	sp,sp,96
 850:	8082                	ret

0000000000000852 <free>:
static Header base;
static Header *freep;

void
free (void *ap)
{
 852:	1141                	addi	sp,sp,-16
 854:	e406                	sd	ra,8(sp)
 856:	e022                	sd	s0,0(sp)
 858:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header *)ap - 1;
 85a:	ff050693          	addi	a3,a0,-16
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85e:	00000797          	auipc	a5,0x0
 862:	7a27b783          	ld	a5,1954(a5) # 1000 <freep>
 866:	a039                	j	874 <free+0x22>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 868:	6398                	ld	a4,0(a5)
 86a:	00e7e463          	bltu	a5,a4,872 <free+0x20>
 86e:	00e6ea63          	bltu	a3,a4,882 <free+0x30>
{
 872:	87ba                	mv	a5,a4
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 874:	fed7fae3          	bgeu	a5,a3,868 <free+0x16>
 878:	6398                	ld	a4,0(a5)
 87a:	00e6e463          	bltu	a3,a4,882 <free+0x30>
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87e:	fee7eae3          	bltu	a5,a4,872 <free+0x20>
      break;
  if (bp + bp->s.size == p->s.ptr)
 882:	ff852583          	lw	a1,-8(a0)
 886:	6390                	ld	a2,0(a5)
 888:	02059813          	slli	a6,a1,0x20
 88c:	01c85713          	srli	a4,a6,0x1c
 890:	9736                	add	a4,a4,a3
 892:	02e60563          	beq	a2,a4,8bc <free+0x6a>
    {
      bp->s.size += p->s.ptr->s.size;
      bp->s.ptr = p->s.ptr->s.ptr;
 896:	fec53823          	sd	a2,-16(a0)
    }
  else
    bp->s.ptr = p->s.ptr;
  if (p + p->s.size == bp)
 89a:	4790                	lw	a2,8(a5)
 89c:	02061593          	slli	a1,a2,0x20
 8a0:	01c5d713          	srli	a4,a1,0x1c
 8a4:	973e                	add	a4,a4,a5
 8a6:	02e68263          	beq	a3,a4,8ca <free+0x78>
    {
      p->s.size += bp->s.size;
      p->s.ptr = bp->s.ptr;
 8aa:	e394                	sd	a3,0(a5)
    }
  else
    p->s.ptr = bp;
  freep = p;
 8ac:	00000717          	auipc	a4,0x0
 8b0:	74f73a23          	sd	a5,1876(a4) # 1000 <freep>
}
 8b4:	60a2                	ld	ra,8(sp)
 8b6:	6402                	ld	s0,0(sp)
 8b8:	0141                	addi	sp,sp,16
 8ba:	8082                	ret
      bp->s.size += p->s.ptr->s.size;
 8bc:	4618                	lw	a4,8(a2)
 8be:	9f2d                	addw	a4,a4,a1
 8c0:	fee52c23          	sw	a4,-8(a0)
      bp->s.ptr = p->s.ptr->s.ptr;
 8c4:	6398                	ld	a4,0(a5)
 8c6:	6310                	ld	a2,0(a4)
 8c8:	b7f9                	j	896 <free+0x44>
      p->s.size += bp->s.size;
 8ca:	ff852703          	lw	a4,-8(a0)
 8ce:	9f31                	addw	a4,a4,a2
 8d0:	c798                	sw	a4,8(a5)
      p->s.ptr = bp->s.ptr;
 8d2:	ff053683          	ld	a3,-16(a0)
 8d6:	bfd1                	j	8aa <free+0x58>

00000000000008d8 <malloc>:
  return freep;
}

void *
malloc (uint nbytes)
{
 8d8:	7139                	addi	sp,sp,-64
 8da:	fc06                	sd	ra,56(sp)
 8dc:	f822                	sd	s0,48(sp)
 8de:	f04a                	sd	s2,32(sp)
 8e0:	ec4e                	sd	s3,24(sp)
 8e2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof (Header) - 1) / sizeof (Header) + 1;
 8e4:	02051993          	slli	s3,a0,0x20
 8e8:	0209d993          	srli	s3,s3,0x20
 8ec:	09bd                	addi	s3,s3,15
 8ee:	0049d993          	srli	s3,s3,0x4
 8f2:	2985                	addiw	s3,s3,1
 8f4:	894e                	mv	s2,s3
  if ((prevp = freep) == 0)
 8f6:	00000517          	auipc	a0,0x0
 8fa:	70a53503          	ld	a0,1802(a0) # 1000 <freep>
 8fe:	c905                	beqz	a0,92e <malloc+0x56>
    {
      base.s.ptr = freep = prevp = &base;
      base.s.size = 0;
    }
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 900:	611c                	ld	a5,0(a0)
    {
      if (p->s.size >= nunits)
 902:	4798                	lw	a4,8(a5)
 904:	09377663          	bgeu	a4,s3,990 <malloc+0xb8>
 908:	f426                	sd	s1,40(sp)
 90a:	e852                	sd	s4,16(sp)
 90c:	e456                	sd	s5,8(sp)
 90e:	e05a                	sd	s6,0(sp)
  if (nu < 4096)
 910:	8a4e                	mv	s4,s3
 912:	6705                	lui	a4,0x1
 914:	00e9f363          	bgeu	s3,a4,91a <malloc+0x42>
 918:	6a05                	lui	s4,0x1
 91a:	000a0b1b          	sext.w	s6,s4
  p = sbrk (nu * sizeof (Header));
 91e:	004a1a1b          	slliw	s4,s4,0x4
              p->s.size = nunits;
            }
          freep = prevp;
          return (void *)(p + 1);
        }
      if (p == freep)
 922:	00000497          	auipc	s1,0x0
 926:	6de48493          	addi	s1,s1,1758 # 1000 <freep>
  if (p == (char *)-1)
 92a:	5afd                	li	s5,-1
 92c:	a83d                	j	96a <malloc+0x92>
 92e:	f426                	sd	s1,40(sp)
 930:	e852                	sd	s4,16(sp)
 932:	e456                	sd	s5,8(sp)
 934:	e05a                	sd	s6,0(sp)
      base.s.ptr = freep = prevp = &base;
 936:	00001797          	auipc	a5,0x1
 93a:	8da78793          	addi	a5,a5,-1830 # 1210 <base>
 93e:	00000717          	auipc	a4,0x0
 942:	6cf73123          	sd	a5,1730(a4) # 1000 <freep>
 946:	e39c                	sd	a5,0(a5)
      base.s.size = 0;
 948:	0007a423          	sw	zero,8(a5)
      if (p->s.size >= nunits)
 94c:	b7d1                	j	910 <malloc+0x38>
            prevp->s.ptr = p->s.ptr;
 94e:	6398                	ld	a4,0(a5)
 950:	e118                	sd	a4,0(a0)
 952:	a899                	j	9a8 <malloc+0xd0>
  hp->s.size = nu;
 954:	01652423          	sw	s6,8(a0)
  free ((void *)(hp + 1));
 958:	0541                	addi	a0,a0,16
 95a:	ef9ff0ef          	jal	852 <free>
  return freep;
 95e:	6088                	ld	a0,0(s1)
        if ((p = morecore (nunits)) == 0)
 960:	c125                	beqz	a0,9c0 <malloc+0xe8>
  for (p = prevp->s.ptr;; prevp = p, p = p->s.ptr)
 962:	611c                	ld	a5,0(a0)
      if (p->s.size >= nunits)
 964:	4798                	lw	a4,8(a5)
 966:	03277163          	bgeu	a4,s2,988 <malloc+0xb0>
      if (p == freep)
 96a:	6098                	ld	a4,0(s1)
 96c:	853e                	mv	a0,a5
 96e:	fef71ae3          	bne	a4,a5,962 <malloc+0x8a>
  p = sbrk (nu * sizeof (Header));
 972:	8552                	mv	a0,s4
 974:	afdff0ef          	jal	470 <sbrk>
  if (p == (char *)-1)
 978:	fd551ee3          	bne	a0,s5,954 <malloc+0x7c>
          return 0;
 97c:	4501                	li	a0,0
 97e:	74a2                	ld	s1,40(sp)
 980:	6a42                	ld	s4,16(sp)
 982:	6aa2                	ld	s5,8(sp)
 984:	6b02                	ld	s6,0(sp)
 986:	a03d                	j	9b4 <malloc+0xdc>
 988:	74a2                	ld	s1,40(sp)
 98a:	6a42                	ld	s4,16(sp)
 98c:	6aa2                	ld	s5,8(sp)
 98e:	6b02                	ld	s6,0(sp)
          if (p->s.size == nunits)
 990:	fae90fe3          	beq	s2,a4,94e <malloc+0x76>
              p->s.size -= nunits;
 994:	4137073b          	subw	a4,a4,s3
 998:	c798                	sw	a4,8(a5)
              p += p->s.size;
 99a:	02071693          	slli	a3,a4,0x20
 99e:	01c6d713          	srli	a4,a3,0x1c
 9a2:	97ba                	add	a5,a5,a4
              p->s.size = nunits;
 9a4:	0137a423          	sw	s3,8(a5)
          freep = prevp;
 9a8:	00000717          	auipc	a4,0x0
 9ac:	64a73c23          	sd	a0,1624(a4) # 1000 <freep>
          return (void *)(p + 1);
 9b0:	01078513          	addi	a0,a5,16
    }
}
 9b4:	70e2                	ld	ra,56(sp)
 9b6:	7442                	ld	s0,48(sp)
 9b8:	7902                	ld	s2,32(sp)
 9ba:	69e2                	ld	s3,24(sp)
 9bc:	6121                	addi	sp,sp,64
 9be:	8082                	ret
 9c0:	74a2                	ld	s1,40(sp)
 9c2:	6a42                	ld	s4,16(sp)
 9c4:	6aa2                	ld	s5,8(sp)
 9c6:	6b02                	ld	s6,0(sp)
 9c8:	b7f5                	j	9b4 <malloc+0xdc>
