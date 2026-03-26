
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	3a013103          	ld	sp,928(sp) # 8000a3a0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	551040ef          	jal	80004d66 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	00023797          	auipc	a5,0x23
    8000002c:	6f878793          	addi	a5,a5,1784 # 80023720 <end>
    80000030:	00f53733          	sltu	a4,a0,a5
    80000034:	47c5                	li	a5,17
    80000036:	07ee                	slli	a5,a5,0x1b
    80000038:	17fd                	addi	a5,a5,-1
    8000003a:	00a7b7b3          	sltu	a5,a5,a0
    8000003e:	8fd9                	or	a5,a5,a4
    80000040:	ef95                	bnez	a5,8000007c <kfree+0x60>
    80000042:	84aa                	mv	s1,a0
    80000044:	03451793          	slli	a5,a0,0x34
    80000048:	eb95                	bnez	a5,8000007c <kfree+0x60>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    8000004a:	6605                	lui	a2,0x1
    8000004c:	4585                	li	a1,1
    8000004e:	110000ef          	jal	8000015e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000052:	0000a917          	auipc	s2,0xa
    80000056:	39e90913          	addi	s2,s2,926 # 8000a3f0 <kmem>
    8000005a:	854a                	mv	a0,s2
    8000005c:	7c0050ef          	jal	8000581c <acquire>
  r->next = kmem.freelist;
    80000060:	01893783          	ld	a5,24(s2)
    80000064:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000066:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006a:	854a                	mv	a0,s2
    8000006c:	045050ef          	jal	800058b0 <release>
}
    80000070:	60e2                	ld	ra,24(sp)
    80000072:	6442                	ld	s0,16(sp)
    80000074:	64a2                	ld	s1,8(sp)
    80000076:	6902                	ld	s2,0(sp)
    80000078:	6105                	addi	sp,sp,32
    8000007a:	8082                	ret
    panic("kfree");
    8000007c:	00007517          	auipc	a0,0x7
    80000080:	f8450513          	addi	a0,a0,-124 # 80007000 <etext>
    80000084:	45a050ef          	jal	800054de <panic>

0000000080000088 <freerange>:
{
    80000088:	7179                	addi	sp,sp,-48
    8000008a:	f406                	sd	ra,40(sp)
    8000008c:	f022                	sd	s0,32(sp)
    8000008e:	ec26                	sd	s1,24(sp)
    80000090:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000092:	6785                	lui	a5,0x1
    80000094:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000098:	00e504b3          	add	s1,a0,a4
    8000009c:	777d                	lui	a4,0xfffff
    8000009e:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000a0:	94be                	add	s1,s1,a5
    800000a2:	0295e263          	bltu	a1,s1,800000c6 <freerange+0x3e>
    800000a6:	e84a                	sd	s2,16(sp)
    800000a8:	e44e                	sd	s3,8(sp)
    800000aa:	e052                	sd	s4,0(sp)
    800000ac:	892e                	mv	s2,a1
    kfree(p);
    800000ae:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	89be                	mv	s3,a5
    kfree(p);
    800000b2:	01448533          	add	a0,s1,s4
    800000b6:	f67ff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	94ce                	add	s1,s1,s3
    800000bc:	fe997be3          	bgeu	s2,s1,800000b2 <freerange+0x2a>
    800000c0:	6942                	ld	s2,16(sp)
    800000c2:	69a2                	ld	s3,8(sp)
    800000c4:	6a02                	ld	s4,0(sp)
}
    800000c6:	70a2                	ld	ra,40(sp)
    800000c8:	7402                	ld	s0,32(sp)
    800000ca:	64e2                	ld	s1,24(sp)
    800000cc:	6145                	addi	sp,sp,48
    800000ce:	8082                	ret

00000000800000d0 <kinit>:
{
    800000d0:	1141                	addi	sp,sp,-16
    800000d2:	e406                	sd	ra,8(sp)
    800000d4:	e022                	sd	s0,0(sp)
    800000d6:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000d8:	00007597          	auipc	a1,0x7
    800000dc:	f3058593          	addi	a1,a1,-208 # 80007008 <etext+0x8>
    800000e0:	0000a517          	auipc	a0,0xa
    800000e4:	31050513          	addi	a0,a0,784 # 8000a3f0 <kmem>
    800000e8:	6aa050ef          	jal	80005792 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000ec:	45c5                	li	a1,17
    800000ee:	05ee                	slli	a1,a1,0x1b
    800000f0:	00023517          	auipc	a0,0x23
    800000f4:	63050513          	addi	a0,a0,1584 # 80023720 <end>
    800000f8:	f91ff0ef          	jal	80000088 <freerange>
}
    800000fc:	60a2                	ld	ra,8(sp)
    800000fe:	6402                	ld	s0,0(sp)
    80000100:	0141                	addi	sp,sp,16
    80000102:	8082                	ret

0000000080000104 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000104:	1101                	addi	sp,sp,-32
    80000106:	ec06                	sd	ra,24(sp)
    80000108:	e822                	sd	s0,16(sp)
    8000010a:	e426                	sd	s1,8(sp)
    8000010c:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000010e:	0000a517          	auipc	a0,0xa
    80000112:	2e250513          	addi	a0,a0,738 # 8000a3f0 <kmem>
    80000116:	706050ef          	jal	8000581c <acquire>
  r = kmem.freelist;
    8000011a:	0000a497          	auipc	s1,0xa
    8000011e:	2ee4b483          	ld	s1,750(s1) # 8000a408 <kmem+0x18>
  if(r)
    80000122:	c49d                	beqz	s1,80000150 <kalloc+0x4c>
    kmem.freelist = r->next;
    80000124:	609c                	ld	a5,0(s1)
    80000126:	0000a717          	auipc	a4,0xa
    8000012a:	2ef73123          	sd	a5,738(a4) # 8000a408 <kmem+0x18>
  release(&kmem.lock);
    8000012e:	0000a517          	auipc	a0,0xa
    80000132:	2c250513          	addi	a0,a0,706 # 8000a3f0 <kmem>
    80000136:	77a050ef          	jal	800058b0 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000013a:	6605                	lui	a2,0x1
    8000013c:	4595                	li	a1,5
    8000013e:	8526                	mv	a0,s1
    80000140:	01e000ef          	jal	8000015e <memset>
  return (void*)r;
}
    80000144:	8526                	mv	a0,s1
    80000146:	60e2                	ld	ra,24(sp)
    80000148:	6442                	ld	s0,16(sp)
    8000014a:	64a2                	ld	s1,8(sp)
    8000014c:	6105                	addi	sp,sp,32
    8000014e:	8082                	ret
  release(&kmem.lock);
    80000150:	0000a517          	auipc	a0,0xa
    80000154:	2a050513          	addi	a0,a0,672 # 8000a3f0 <kmem>
    80000158:	758050ef          	jal	800058b0 <release>
  if(r)
    8000015c:	b7e5                	j	80000144 <kalloc+0x40>

000000008000015e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000015e:	1141                	addi	sp,sp,-16
    80000160:	e406                	sd	ra,8(sp)
    80000162:	e022                	sd	s0,0(sp)
    80000164:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000166:	ca19                	beqz	a2,8000017c <memset+0x1e>
    80000168:	87aa                	mv	a5,a0
    8000016a:	1602                	slli	a2,a2,0x20
    8000016c:	9201                	srli	a2,a2,0x20
    8000016e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000172:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000176:	0785                	addi	a5,a5,1
    80000178:	fee79de3          	bne	a5,a4,80000172 <memset+0x14>
  }
  return dst;
}
    8000017c:	60a2                	ld	ra,8(sp)
    8000017e:	6402                	ld	s0,0(sp)
    80000180:	0141                	addi	sp,sp,16
    80000182:	8082                	ret

0000000080000184 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000184:	1141                	addi	sp,sp,-16
    80000186:	e406                	sd	ra,8(sp)
    80000188:	e022                	sd	s0,0(sp)
    8000018a:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    8000018c:	c61d                	beqz	a2,800001ba <memcmp+0x36>
    8000018e:	1602                	slli	a2,a2,0x20
    80000190:	9201                	srli	a2,a2,0x20
    80000192:	00c506b3          	add	a3,a0,a2
    if(*s1 != *s2)
    80000196:	00054783          	lbu	a5,0(a0)
    8000019a:	0005c703          	lbu	a4,0(a1)
    8000019e:	00e79863          	bne	a5,a4,800001ae <memcmp+0x2a>
      return *s1 - *s2;
    s1++, s2++;
    800001a2:	0505                	addi	a0,a0,1
    800001a4:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001a6:	fed518e3          	bne	a0,a3,80000196 <memcmp+0x12>
  }

  return 0;
    800001aa:	4501                	li	a0,0
    800001ac:	a019                	j	800001b2 <memcmp+0x2e>
      return *s1 - *s2;
    800001ae:	40e7853b          	subw	a0,a5,a4
}
    800001b2:	60a2                	ld	ra,8(sp)
    800001b4:	6402                	ld	s0,0(sp)
    800001b6:	0141                	addi	sp,sp,16
    800001b8:	8082                	ret
  return 0;
    800001ba:	4501                	li	a0,0
    800001bc:	bfdd                	j	800001b2 <memcmp+0x2e>

00000000800001be <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001be:	1141                	addi	sp,sp,-16
    800001c0:	e406                	sd	ra,8(sp)
    800001c2:	e022                	sd	s0,0(sp)
    800001c4:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001c6:	c205                	beqz	a2,800001e6 <memmove+0x28>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001c8:	02a5e363          	bltu	a1,a0,800001ee <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001cc:	1602                	slli	a2,a2,0x20
    800001ce:	9201                	srli	a2,a2,0x20
    800001d0:	00c587b3          	add	a5,a1,a2
{
    800001d4:	872a                	mv	a4,a0
      *d++ = *s++;
    800001d6:	0585                	addi	a1,a1,1
    800001d8:	0705                	addi	a4,a4,1
    800001da:	fff5c683          	lbu	a3,-1(a1)
    800001de:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001e2:	feb79ae3          	bne	a5,a1,800001d6 <memmove+0x18>

  return dst;
}
    800001e6:	60a2                	ld	ra,8(sp)
    800001e8:	6402                	ld	s0,0(sp)
    800001ea:	0141                	addi	sp,sp,16
    800001ec:	8082                	ret
  if(s < d && s + n > d){
    800001ee:	02061693          	slli	a3,a2,0x20
    800001f2:	9281                	srli	a3,a3,0x20
    800001f4:	00d58733          	add	a4,a1,a3
    800001f8:	fce57ae3          	bgeu	a0,a4,800001cc <memmove+0xe>
    d += n;
    800001fc:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800001fe:	fff6079b          	addiw	a5,a2,-1 # fff <_entry-0x7ffff001>
    80000202:	1782                	slli	a5,a5,0x20
    80000204:	9381                	srli	a5,a5,0x20
    80000206:	fff7c793          	not	a5,a5
    8000020a:	97ba                	add	a5,a5,a4
      *--d = *--s;
    8000020c:	177d                	addi	a4,a4,-1
    8000020e:	16fd                	addi	a3,a3,-1
    80000210:	00074603          	lbu	a2,0(a4)
    80000214:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000218:	fee79ae3          	bne	a5,a4,8000020c <memmove+0x4e>
    8000021c:	b7e9                	j	800001e6 <memmove+0x28>

000000008000021e <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000021e:	1141                	addi	sp,sp,-16
    80000220:	e406                	sd	ra,8(sp)
    80000222:	e022                	sd	s0,0(sp)
    80000224:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000226:	f99ff0ef          	jal	800001be <memmove>
}
    8000022a:	60a2                	ld	ra,8(sp)
    8000022c:	6402                	ld	s0,0(sp)
    8000022e:	0141                	addi	sp,sp,16
    80000230:	8082                	ret

0000000080000232 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000232:	1141                	addi	sp,sp,-16
    80000234:	e406                	sd	ra,8(sp)
    80000236:	e022                	sd	s0,0(sp)
    80000238:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000023a:	ce11                	beqz	a2,80000256 <strncmp+0x24>
    8000023c:	00054783          	lbu	a5,0(a0)
    80000240:	cf89                	beqz	a5,8000025a <strncmp+0x28>
    80000242:	0005c703          	lbu	a4,0(a1)
    80000246:	00f71a63          	bne	a4,a5,8000025a <strncmp+0x28>
    n--, p++, q++;
    8000024a:	367d                	addiw	a2,a2,-1
    8000024c:	0505                	addi	a0,a0,1
    8000024e:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000250:	f675                	bnez	a2,8000023c <strncmp+0xa>
  if(n == 0)
    return 0;
    80000252:	4501                	li	a0,0
    80000254:	a801                	j	80000264 <strncmp+0x32>
    80000256:	4501                	li	a0,0
    80000258:	a031                	j	80000264 <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    8000025a:	00054503          	lbu	a0,0(a0)
    8000025e:	0005c783          	lbu	a5,0(a1)
    80000262:	9d1d                	subw	a0,a0,a5
}
    80000264:	60a2                	ld	ra,8(sp)
    80000266:	6402                	ld	s0,0(sp)
    80000268:	0141                	addi	sp,sp,16
    8000026a:	8082                	ret

000000008000026c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000026c:	1141                	addi	sp,sp,-16
    8000026e:	e406                	sd	ra,8(sp)
    80000270:	e022                	sd	s0,0(sp)
    80000272:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000274:	87aa                	mv	a5,a0
    80000276:	a011                	j	8000027a <strncpy+0xe>
    80000278:	8636                	mv	a2,a3
    8000027a:	02c05863          	blez	a2,800002aa <strncpy+0x3e>
    8000027e:	fff6069b          	addiw	a3,a2,-1
    80000282:	8836                	mv	a6,a3
    80000284:	0785                	addi	a5,a5,1
    80000286:	0005c703          	lbu	a4,0(a1)
    8000028a:	fee78fa3          	sb	a4,-1(a5)
    8000028e:	0585                	addi	a1,a1,1
    80000290:	f765                	bnez	a4,80000278 <strncpy+0xc>
    ;
  while(n-- > 0)
    80000292:	873e                	mv	a4,a5
    80000294:	01005b63          	blez	a6,800002aa <strncpy+0x3e>
    80000298:	9fb1                	addw	a5,a5,a2
    8000029a:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    8000029c:	0705                	addi	a4,a4,1
    8000029e:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002a2:	40e786bb          	subw	a3,a5,a4
    800002a6:	fed04be3          	bgtz	a3,8000029c <strncpy+0x30>
  return os;
}
    800002aa:	60a2                	ld	ra,8(sp)
    800002ac:	6402                	ld	s0,0(sp)
    800002ae:	0141                	addi	sp,sp,16
    800002b0:	8082                	ret

00000000800002b2 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002b2:	1141                	addi	sp,sp,-16
    800002b4:	e406                	sd	ra,8(sp)
    800002b6:	e022                	sd	s0,0(sp)
    800002b8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002ba:	02c05363          	blez	a2,800002e0 <safestrcpy+0x2e>
    800002be:	fff6069b          	addiw	a3,a2,-1
    800002c2:	1682                	slli	a3,a3,0x20
    800002c4:	9281                	srli	a3,a3,0x20
    800002c6:	96ae                	add	a3,a3,a1
    800002c8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002ca:	00d58963          	beq	a1,a3,800002dc <safestrcpy+0x2a>
    800002ce:	0585                	addi	a1,a1,1
    800002d0:	0785                	addi	a5,a5,1
    800002d2:	fff5c703          	lbu	a4,-1(a1)
    800002d6:	fee78fa3          	sb	a4,-1(a5)
    800002da:	fb65                	bnez	a4,800002ca <safestrcpy+0x18>
    ;
  *s = 0;
    800002dc:	00078023          	sb	zero,0(a5)
  return os;
}
    800002e0:	60a2                	ld	ra,8(sp)
    800002e2:	6402                	ld	s0,0(sp)
    800002e4:	0141                	addi	sp,sp,16
    800002e6:	8082                	ret

00000000800002e8 <strlen>:

int
strlen(const char *s)
{
    800002e8:	1141                	addi	sp,sp,-16
    800002ea:	e406                	sd	ra,8(sp)
    800002ec:	e022                	sd	s0,0(sp)
    800002ee:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002f0:	00054783          	lbu	a5,0(a0)
    800002f4:	cf91                	beqz	a5,80000310 <strlen+0x28>
    800002f6:	00150793          	addi	a5,a0,1
    800002fa:	86be                	mv	a3,a5
    800002fc:	0785                	addi	a5,a5,1
    800002fe:	fff7c703          	lbu	a4,-1(a5)
    80000302:	ff65                	bnez	a4,800002fa <strlen+0x12>
    80000304:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    80000308:	60a2                	ld	ra,8(sp)
    8000030a:	6402                	ld	s0,0(sp)
    8000030c:	0141                	addi	sp,sp,16
    8000030e:	8082                	ret
  for(n = 0; s[n]; n++)
    80000310:	4501                	li	a0,0
    80000312:	bfdd                	j	80000308 <strlen+0x20>

0000000080000314 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000314:	1141                	addi	sp,sp,-16
    80000316:	e406                	sd	ra,8(sp)
    80000318:	e022                	sd	s0,0(sp)
    8000031a:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000031c:	233000ef          	jal	80000d4e <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000320:	0000a717          	auipc	a4,0xa
    80000324:	0a070713          	addi	a4,a4,160 # 8000a3c0 <started>
  if(cpuid() == 0){
    80000328:	c51d                	beqz	a0,80000356 <main+0x42>
    while(started == 0)
    8000032a:	431c                	lw	a5,0(a4)
    8000032c:	2781                	sext.w	a5,a5
    8000032e:	dff5                	beqz	a5,8000032a <main+0x16>
      ;
    __sync_synchronize();
    80000330:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000334:	21b000ef          	jal	80000d4e <cpuid>
    80000338:	85aa                	mv	a1,a0
    8000033a:	00007517          	auipc	a0,0x7
    8000033e:	cee50513          	addi	a0,a0,-786 # 80007028 <etext+0x28>
    80000342:	68d040ef          	jal	800051ce <printf>
    kvminithart();    // turn on paging
    80000346:	080000ef          	jal	800003c6 <kvminithart>
    trapinithart();   // install kernel trap vector
    8000034a:	532010ef          	jal	8000187c <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    8000034e:	45a040ef          	jal	800047a8 <plicinithart>
  }

  scheduler();        
    80000352:	66f000ef          	jal	800011c0 <scheduler>
    consoleinit();
    80000356:	59f040ef          	jal	800050f4 <consoleinit>
    printfinit();
    8000035a:	1be050ef          	jal	80005518 <printfinit>
    printf("\n");
    8000035e:	00007517          	auipc	a0,0x7
    80000362:	cda50513          	addi	a0,a0,-806 # 80007038 <etext+0x38>
    80000366:	669040ef          	jal	800051ce <printf>
    printf("xv6 kernel is booting\n");
    8000036a:	00007517          	auipc	a0,0x7
    8000036e:	ca650513          	addi	a0,a0,-858 # 80007010 <etext+0x10>
    80000372:	65d040ef          	jal	800051ce <printf>
    printf("\n");
    80000376:	00007517          	auipc	a0,0x7
    8000037a:	cc250513          	addi	a0,a0,-830 # 80007038 <etext+0x38>
    8000037e:	651040ef          	jal	800051ce <printf>
    kinit();         // physical page allocator
    80000382:	d4fff0ef          	jal	800000d0 <kinit>
    kvminit();       // create kernel page table
    80000386:	2cc000ef          	jal	80000652 <kvminit>
    kvminithart();   // turn on paging
    8000038a:	03c000ef          	jal	800003c6 <kvminithart>
    procinit();      // process table
    8000038e:	10b000ef          	jal	80000c98 <procinit>
    trapinit();      // trap vectors
    80000392:	4c6010ef          	jal	80001858 <trapinit>
    trapinithart();  // install kernel trap vector
    80000396:	4e6010ef          	jal	8000187c <trapinithart>
    plicinit();      // set up interrupt controller
    8000039a:	3f4040ef          	jal	8000478e <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000039e:	40a040ef          	jal	800047a8 <plicinithart>
    binit();         // buffer cache
    800003a2:	36d010ef          	jal	80001f0e <binit>
    iinit();         // inode table
    800003a6:	128020ef          	jal	800024ce <iinit>
    fileinit();      // file table
    800003aa:	70f020ef          	jal	800032b8 <fileinit>
    virtio_disk_init(); // emulated hard disk
    800003ae:	4ea040ef          	jal	80004898 <virtio_disk_init>
    userinit();      // first user process
    800003b2:	43b000ef          	jal	80000fec <userinit>
    __sync_synchronize();
    800003b6:	0330000f          	fence	rw,rw
    started = 1;
    800003ba:	4785                	li	a5,1
    800003bc:	0000a717          	auipc	a4,0xa
    800003c0:	00f72223          	sw	a5,4(a4) # 8000a3c0 <started>
    800003c4:	b779                	j	80000352 <main+0x3e>

00000000800003c6 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    800003c6:	1141                	addi	sp,sp,-16
    800003c8:	e406                	sd	ra,8(sp)
    800003ca:	e022                	sd	s0,0(sp)
    800003cc:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800003ce:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800003d2:	0000a797          	auipc	a5,0xa
    800003d6:	ff67b783          	ld	a5,-10(a5) # 8000a3c8 <kernel_pagetable>
    800003da:	83b1                	srli	a5,a5,0xc
    800003dc:	577d                	li	a4,-1
    800003de:	177e                	slli	a4,a4,0x3f
    800003e0:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800003e2:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800003e6:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800003ea:	60a2                	ld	ra,8(sp)
    800003ec:	6402                	ld	s0,0(sp)
    800003ee:	0141                	addi	sp,sp,16
    800003f0:	8082                	ret

00000000800003f2 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800003f2:	7139                	addi	sp,sp,-64
    800003f4:	fc06                	sd	ra,56(sp)
    800003f6:	f822                	sd	s0,48(sp)
    800003f8:	f426                	sd	s1,40(sp)
    800003fa:	f04a                	sd	s2,32(sp)
    800003fc:	ec4e                	sd	s3,24(sp)
    800003fe:	e852                	sd	s4,16(sp)
    80000400:	e456                	sd	s5,8(sp)
    80000402:	e05a                	sd	s6,0(sp)
    80000404:	0080                	addi	s0,sp,64
    80000406:	84aa                	mv	s1,a0
    80000408:	89ae                	mv	s3,a1
    8000040a:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    8000040c:	57fd                	li	a5,-1
    8000040e:	83e9                	srli	a5,a5,0x1a
    80000410:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000412:	4ab1                	li	s5,12
  if(va >= MAXVA)
    80000414:	04b7e263          	bltu	a5,a1,80000458 <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    80000418:	0149d933          	srl	s2,s3,s4
    8000041c:	1ff97913          	andi	s2,s2,511
    80000420:	090e                	slli	s2,s2,0x3
    80000422:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000424:	00093483          	ld	s1,0(s2)
    80000428:	0014f793          	andi	a5,s1,1
    8000042c:	cf85                	beqz	a5,80000464 <walk+0x72>
      pagetable = (pagetable_t)PTE2PA(*pte);
    8000042e:	80a9                	srli	s1,s1,0xa
    80000430:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    80000432:	3a5d                	addiw	s4,s4,-9
    80000434:	ff5a12e3          	bne	s4,s5,80000418 <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    80000438:	00c9d513          	srli	a0,s3,0xc
    8000043c:	1ff57513          	andi	a0,a0,511
    80000440:	050e                	slli	a0,a0,0x3
    80000442:	9526                	add	a0,a0,s1
}
    80000444:	70e2                	ld	ra,56(sp)
    80000446:	7442                	ld	s0,48(sp)
    80000448:	74a2                	ld	s1,40(sp)
    8000044a:	7902                	ld	s2,32(sp)
    8000044c:	69e2                	ld	s3,24(sp)
    8000044e:	6a42                	ld	s4,16(sp)
    80000450:	6aa2                	ld	s5,8(sp)
    80000452:	6b02                	ld	s6,0(sp)
    80000454:	6121                	addi	sp,sp,64
    80000456:	8082                	ret
    panic("walk");
    80000458:	00007517          	auipc	a0,0x7
    8000045c:	be850513          	addi	a0,a0,-1048 # 80007040 <etext+0x40>
    80000460:	07e050ef          	jal	800054de <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000464:	020b0263          	beqz	s6,80000488 <walk+0x96>
    80000468:	c9dff0ef          	jal	80000104 <kalloc>
    8000046c:	84aa                	mv	s1,a0
    8000046e:	d979                	beqz	a0,80000444 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    80000470:	6605                	lui	a2,0x1
    80000472:	4581                	li	a1,0
    80000474:	cebff0ef          	jal	8000015e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000478:	00c4d793          	srli	a5,s1,0xc
    8000047c:	07aa                	slli	a5,a5,0xa
    8000047e:	0017e793          	ori	a5,a5,1
    80000482:	00f93023          	sd	a5,0(s2)
    80000486:	b775                	j	80000432 <walk+0x40>
        return 0;
    80000488:	4501                	li	a0,0
    8000048a:	bf6d                	j	80000444 <walk+0x52>

000000008000048c <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000048c:	57fd                	li	a5,-1
    8000048e:	83e9                	srli	a5,a5,0x1a
    80000490:	00b7f463          	bgeu	a5,a1,80000498 <walkaddr+0xc>
    return 0;
    80000494:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000496:	8082                	ret
{
    80000498:	1141                	addi	sp,sp,-16
    8000049a:	e406                	sd	ra,8(sp)
    8000049c:	e022                	sd	s0,0(sp)
    8000049e:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    800004a0:	4601                	li	a2,0
    800004a2:	f51ff0ef          	jal	800003f2 <walk>
  if(pte == 0)
    800004a6:	c901                	beqz	a0,800004b6 <walkaddr+0x2a>
  if((*pte & PTE_V) == 0)
    800004a8:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    800004aa:	0117f693          	andi	a3,a5,17
    800004ae:	4745                	li	a4,17
    return 0;
    800004b0:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800004b2:	00e68663          	beq	a3,a4,800004be <walkaddr+0x32>
}
    800004b6:	60a2                	ld	ra,8(sp)
    800004b8:	6402                	ld	s0,0(sp)
    800004ba:	0141                	addi	sp,sp,16
    800004bc:	8082                	ret
  pa = PTE2PA(*pte);
    800004be:	83a9                	srli	a5,a5,0xa
    800004c0:	00c79513          	slli	a0,a5,0xc
  return pa;
    800004c4:	bfcd                	j	800004b6 <walkaddr+0x2a>

00000000800004c6 <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800004c6:	715d                	addi	sp,sp,-80
    800004c8:	e486                	sd	ra,72(sp)
    800004ca:	e0a2                	sd	s0,64(sp)
    800004cc:	fc26                	sd	s1,56(sp)
    800004ce:	f84a                	sd	s2,48(sp)
    800004d0:	f44e                	sd	s3,40(sp)
    800004d2:	f052                	sd	s4,32(sp)
    800004d4:	ec56                	sd	s5,24(sp)
    800004d6:	e85a                	sd	s6,16(sp)
    800004d8:	e45e                	sd	s7,8(sp)
    800004da:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800004dc:	03459793          	slli	a5,a1,0x34
    800004e0:	eba1                	bnez	a5,80000530 <mappages+0x6a>
    800004e2:	8a2a                	mv	s4,a0
    800004e4:	8aba                	mv	s5,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800004e6:	03461793          	slli	a5,a2,0x34
    800004ea:	eba9                	bnez	a5,8000053c <mappages+0x76>
    panic("mappages: size not aligned");

  if(size == 0)
    800004ec:	ce31                	beqz	a2,80000548 <mappages+0x82>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800004ee:	80060613          	addi	a2,a2,-2048 # 800 <_entry-0x7ffff800>
    800004f2:	80060613          	addi	a2,a2,-2048
    800004f6:	00b60933          	add	s2,a2,a1
  a = va;
    800004fa:	84ae                	mv	s1,a1
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    800004fc:	4b05                	li	s6,1
    800004fe:	40b689b3          	sub	s3,a3,a1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000502:	6b85                	lui	s7,0x1
    if((pte = walk(pagetable, a, 1)) == 0)
    80000504:	865a                	mv	a2,s6
    80000506:	85a6                	mv	a1,s1
    80000508:	8552                	mv	a0,s4
    8000050a:	ee9ff0ef          	jal	800003f2 <walk>
    8000050e:	c929                	beqz	a0,80000560 <mappages+0x9a>
    if(*pte & PTE_V)
    80000510:	611c                	ld	a5,0(a0)
    80000512:	8b85                	andi	a5,a5,1
    80000514:	e3a1                	bnez	a5,80000554 <mappages+0x8e>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000516:	013487b3          	add	a5,s1,s3
    8000051a:	83b1                	srli	a5,a5,0xc
    8000051c:	07aa                	slli	a5,a5,0xa
    8000051e:	0157e7b3          	or	a5,a5,s5
    80000522:	0017e793          	ori	a5,a5,1
    80000526:	e11c                	sd	a5,0(a0)
    if(a == last)
    80000528:	05248863          	beq	s1,s2,80000578 <mappages+0xb2>
    a += PGSIZE;
    8000052c:	94de                	add	s1,s1,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    8000052e:	bfd9                	j	80000504 <mappages+0x3e>
    panic("mappages: va not aligned");
    80000530:	00007517          	auipc	a0,0x7
    80000534:	b1850513          	addi	a0,a0,-1256 # 80007048 <etext+0x48>
    80000538:	7a7040ef          	jal	800054de <panic>
    panic("mappages: size not aligned");
    8000053c:	00007517          	auipc	a0,0x7
    80000540:	b2c50513          	addi	a0,a0,-1236 # 80007068 <etext+0x68>
    80000544:	79b040ef          	jal	800054de <panic>
    panic("mappages: size");
    80000548:	00007517          	auipc	a0,0x7
    8000054c:	b4050513          	addi	a0,a0,-1216 # 80007088 <etext+0x88>
    80000550:	78f040ef          	jal	800054de <panic>
      panic("mappages: remap");
    80000554:	00007517          	auipc	a0,0x7
    80000558:	b4450513          	addi	a0,a0,-1212 # 80007098 <etext+0x98>
    8000055c:	783040ef          	jal	800054de <panic>
      return -1;
    80000560:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000562:	60a6                	ld	ra,72(sp)
    80000564:	6406                	ld	s0,64(sp)
    80000566:	74e2                	ld	s1,56(sp)
    80000568:	7942                	ld	s2,48(sp)
    8000056a:	79a2                	ld	s3,40(sp)
    8000056c:	7a02                	ld	s4,32(sp)
    8000056e:	6ae2                	ld	s5,24(sp)
    80000570:	6b42                	ld	s6,16(sp)
    80000572:	6ba2                	ld	s7,8(sp)
    80000574:	6161                	addi	sp,sp,80
    80000576:	8082                	ret
  return 0;
    80000578:	4501                	li	a0,0
    8000057a:	b7e5                	j	80000562 <mappages+0x9c>

000000008000057c <kvmmap>:
{
    8000057c:	1141                	addi	sp,sp,-16
    8000057e:	e406                	sd	ra,8(sp)
    80000580:	e022                	sd	s0,0(sp)
    80000582:	0800                	addi	s0,sp,16
    80000584:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000586:	86b2                	mv	a3,a2
    80000588:	863e                	mv	a2,a5
    8000058a:	f3dff0ef          	jal	800004c6 <mappages>
    8000058e:	e509                	bnez	a0,80000598 <kvmmap+0x1c>
}
    80000590:	60a2                	ld	ra,8(sp)
    80000592:	6402                	ld	s0,0(sp)
    80000594:	0141                	addi	sp,sp,16
    80000596:	8082                	ret
    panic("kvmmap");
    80000598:	00007517          	auipc	a0,0x7
    8000059c:	b1050513          	addi	a0,a0,-1264 # 800070a8 <etext+0xa8>
    800005a0:	73f040ef          	jal	800054de <panic>

00000000800005a4 <kvmmake>:
{
    800005a4:	1101                	addi	sp,sp,-32
    800005a6:	ec06                	sd	ra,24(sp)
    800005a8:	e822                	sd	s0,16(sp)
    800005aa:	e426                	sd	s1,8(sp)
    800005ac:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    800005ae:	b57ff0ef          	jal	80000104 <kalloc>
    800005b2:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800005b4:	6605                	lui	a2,0x1
    800005b6:	4581                	li	a1,0
    800005b8:	ba7ff0ef          	jal	8000015e <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800005bc:	4719                	li	a4,6
    800005be:	6685                	lui	a3,0x1
    800005c0:	10000637          	lui	a2,0x10000
    800005c4:	85b2                	mv	a1,a2
    800005c6:	8526                	mv	a0,s1
    800005c8:	fb5ff0ef          	jal	8000057c <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800005cc:	4719                	li	a4,6
    800005ce:	6685                	lui	a3,0x1
    800005d0:	10001637          	lui	a2,0x10001
    800005d4:	85b2                	mv	a1,a2
    800005d6:	8526                	mv	a0,s1
    800005d8:	fa5ff0ef          	jal	8000057c <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800005dc:	4719                	li	a4,6
    800005de:	040006b7          	lui	a3,0x4000
    800005e2:	0c000637          	lui	a2,0xc000
    800005e6:	85b2                	mv	a1,a2
    800005e8:	8526                	mv	a0,s1
    800005ea:	f93ff0ef          	jal	8000057c <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800005ee:	4729                	li	a4,10
    800005f0:	80007697          	auipc	a3,0x80007
    800005f4:	a1068693          	addi	a3,a3,-1520 # 7000 <_entry-0x7fff9000>
    800005f8:	4605                	li	a2,1
    800005fa:	067e                	slli	a2,a2,0x1f
    800005fc:	85b2                	mv	a1,a2
    800005fe:	8526                	mv	a0,s1
    80000600:	f7dff0ef          	jal	8000057c <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000604:	4719                	li	a4,6
    80000606:	00007697          	auipc	a3,0x7
    8000060a:	9fa68693          	addi	a3,a3,-1542 # 80007000 <etext>
    8000060e:	47c5                	li	a5,17
    80000610:	07ee                	slli	a5,a5,0x1b
    80000612:	40d786b3          	sub	a3,a5,a3
    80000616:	00007617          	auipc	a2,0x7
    8000061a:	9ea60613          	addi	a2,a2,-1558 # 80007000 <etext>
    8000061e:	85b2                	mv	a1,a2
    80000620:	8526                	mv	a0,s1
    80000622:	f5bff0ef          	jal	8000057c <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80000626:	4729                	li	a4,10
    80000628:	6685                	lui	a3,0x1
    8000062a:	00006617          	auipc	a2,0x6
    8000062e:	9d660613          	addi	a2,a2,-1578 # 80006000 <_trampoline>
    80000632:	040005b7          	lui	a1,0x4000
    80000636:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000638:	05b2                	slli	a1,a1,0xc
    8000063a:	8526                	mv	a0,s1
    8000063c:	f41ff0ef          	jal	8000057c <kvmmap>
  proc_mapstacks(kpgtbl);
    80000640:	8526                	mv	a0,s1
    80000642:	5b2000ef          	jal	80000bf4 <proc_mapstacks>
}
    80000646:	8526                	mv	a0,s1
    80000648:	60e2                	ld	ra,24(sp)
    8000064a:	6442                	ld	s0,16(sp)
    8000064c:	64a2                	ld	s1,8(sp)
    8000064e:	6105                	addi	sp,sp,32
    80000650:	8082                	ret

0000000080000652 <kvminit>:
{
    80000652:	1141                	addi	sp,sp,-16
    80000654:	e406                	sd	ra,8(sp)
    80000656:	e022                	sd	s0,0(sp)
    80000658:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000065a:	f4bff0ef          	jal	800005a4 <kvmmake>
    8000065e:	0000a797          	auipc	a5,0xa
    80000662:	d6a7b523          	sd	a0,-662(a5) # 8000a3c8 <kernel_pagetable>
}
    80000666:	60a2                	ld	ra,8(sp)
    80000668:	6402                	ld	s0,0(sp)
    8000066a:	0141                	addi	sp,sp,16
    8000066c:	8082                	ret

000000008000066e <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000066e:	715d                	addi	sp,sp,-80
    80000670:	e486                	sd	ra,72(sp)
    80000672:	e0a2                	sd	s0,64(sp)
    80000674:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000676:	03459793          	slli	a5,a1,0x34
    8000067a:	e39d                	bnez	a5,800006a0 <uvmunmap+0x32>
    8000067c:	f84a                	sd	s2,48(sp)
    8000067e:	f44e                	sd	s3,40(sp)
    80000680:	f052                	sd	s4,32(sp)
    80000682:	ec56                	sd	s5,24(sp)
    80000684:	e85a                	sd	s6,16(sp)
    80000686:	e45e                	sd	s7,8(sp)
    80000688:	8a2a                	mv	s4,a0
    8000068a:	892e                	mv	s2,a1
    8000068c:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000068e:	0632                	slli	a2,a2,0xc
    80000690:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000694:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000696:	6b05                	lui	s6,0x1
    80000698:	0735ff63          	bgeu	a1,s3,80000716 <uvmunmap+0xa8>
    8000069c:	fc26                	sd	s1,56(sp)
    8000069e:	a0a9                	j	800006e8 <uvmunmap+0x7a>
    800006a0:	fc26                	sd	s1,56(sp)
    800006a2:	f84a                	sd	s2,48(sp)
    800006a4:	f44e                	sd	s3,40(sp)
    800006a6:	f052                	sd	s4,32(sp)
    800006a8:	ec56                	sd	s5,24(sp)
    800006aa:	e85a                	sd	s6,16(sp)
    800006ac:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    800006ae:	00007517          	auipc	a0,0x7
    800006b2:	a0250513          	addi	a0,a0,-1534 # 800070b0 <etext+0xb0>
    800006b6:	629040ef          	jal	800054de <panic>
      panic("uvmunmap: walk");
    800006ba:	00007517          	auipc	a0,0x7
    800006be:	a0e50513          	addi	a0,a0,-1522 # 800070c8 <etext+0xc8>
    800006c2:	61d040ef          	jal	800054de <panic>
      panic("uvmunmap: not mapped");
    800006c6:	00007517          	auipc	a0,0x7
    800006ca:	a1250513          	addi	a0,a0,-1518 # 800070d8 <etext+0xd8>
    800006ce:	611040ef          	jal	800054de <panic>
      panic("uvmunmap: not a leaf");
    800006d2:	00007517          	auipc	a0,0x7
    800006d6:	a1e50513          	addi	a0,a0,-1506 # 800070f0 <etext+0xf0>
    800006da:	605040ef          	jal	800054de <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800006de:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800006e2:	995a                	add	s2,s2,s6
    800006e4:	03397863          	bgeu	s2,s3,80000714 <uvmunmap+0xa6>
    if((pte = walk(pagetable, a, 0)) == 0)
    800006e8:	4601                	li	a2,0
    800006ea:	85ca                	mv	a1,s2
    800006ec:	8552                	mv	a0,s4
    800006ee:	d05ff0ef          	jal	800003f2 <walk>
    800006f2:	84aa                	mv	s1,a0
    800006f4:	d179                	beqz	a0,800006ba <uvmunmap+0x4c>
    if((*pte & PTE_V) == 0)
    800006f6:	6108                	ld	a0,0(a0)
    800006f8:	00157793          	andi	a5,a0,1
    800006fc:	d7e9                	beqz	a5,800006c6 <uvmunmap+0x58>
    if(PTE_FLAGS(*pte) == PTE_V)
    800006fe:	3ff57793          	andi	a5,a0,1023
    80000702:	fd7788e3          	beq	a5,s7,800006d2 <uvmunmap+0x64>
    if(do_free){
    80000706:	fc0a8ce3          	beqz	s5,800006de <uvmunmap+0x70>
      uint64 pa = PTE2PA(*pte);
    8000070a:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    8000070c:	0532                	slli	a0,a0,0xc
    8000070e:	90fff0ef          	jal	8000001c <kfree>
    80000712:	b7f1                	j	800006de <uvmunmap+0x70>
    80000714:	74e2                	ld	s1,56(sp)
    80000716:	7942                	ld	s2,48(sp)
    80000718:	79a2                	ld	s3,40(sp)
    8000071a:	7a02                	ld	s4,32(sp)
    8000071c:	6ae2                	ld	s5,24(sp)
    8000071e:	6b42                	ld	s6,16(sp)
    80000720:	6ba2                	ld	s7,8(sp)
  }
}
    80000722:	60a6                	ld	ra,72(sp)
    80000724:	6406                	ld	s0,64(sp)
    80000726:	6161                	addi	sp,sp,80
    80000728:	8082                	ret

000000008000072a <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    8000072a:	1101                	addi	sp,sp,-32
    8000072c:	ec06                	sd	ra,24(sp)
    8000072e:	e822                	sd	s0,16(sp)
    80000730:	e426                	sd	s1,8(sp)
    80000732:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000734:	9d1ff0ef          	jal	80000104 <kalloc>
    80000738:	84aa                	mv	s1,a0
  if(pagetable == 0)
    8000073a:	c509                	beqz	a0,80000744 <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000073c:	6605                	lui	a2,0x1
    8000073e:	4581                	li	a1,0
    80000740:	a1fff0ef          	jal	8000015e <memset>
  return pagetable;
}
    80000744:	8526                	mv	a0,s1
    80000746:	60e2                	ld	ra,24(sp)
    80000748:	6442                	ld	s0,16(sp)
    8000074a:	64a2                	ld	s1,8(sp)
    8000074c:	6105                	addi	sp,sp,32
    8000074e:	8082                	ret

0000000080000750 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000750:	7179                	addi	sp,sp,-48
    80000752:	f406                	sd	ra,40(sp)
    80000754:	f022                	sd	s0,32(sp)
    80000756:	ec26                	sd	s1,24(sp)
    80000758:	e84a                	sd	s2,16(sp)
    8000075a:	e44e                	sd	s3,8(sp)
    8000075c:	e052                	sd	s4,0(sp)
    8000075e:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000760:	6785                	lui	a5,0x1
    80000762:	04f67063          	bgeu	a2,a5,800007a2 <uvmfirst+0x52>
    80000766:	89aa                	mv	s3,a0
    80000768:	8a2e                	mv	s4,a1
    8000076a:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    8000076c:	999ff0ef          	jal	80000104 <kalloc>
    80000770:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000772:	6605                	lui	a2,0x1
    80000774:	4581                	li	a1,0
    80000776:	9e9ff0ef          	jal	8000015e <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000077a:	4779                	li	a4,30
    8000077c:	86ca                	mv	a3,s2
    8000077e:	6605                	lui	a2,0x1
    80000780:	4581                	li	a1,0
    80000782:	854e                	mv	a0,s3
    80000784:	d43ff0ef          	jal	800004c6 <mappages>
  memmove(mem, src, sz);
    80000788:	8626                	mv	a2,s1
    8000078a:	85d2                	mv	a1,s4
    8000078c:	854a                	mv	a0,s2
    8000078e:	a31ff0ef          	jal	800001be <memmove>
}
    80000792:	70a2                	ld	ra,40(sp)
    80000794:	7402                	ld	s0,32(sp)
    80000796:	64e2                	ld	s1,24(sp)
    80000798:	6942                	ld	s2,16(sp)
    8000079a:	69a2                	ld	s3,8(sp)
    8000079c:	6a02                	ld	s4,0(sp)
    8000079e:	6145                	addi	sp,sp,48
    800007a0:	8082                	ret
    panic("uvmfirst: more than a page");
    800007a2:	00007517          	auipc	a0,0x7
    800007a6:	96650513          	addi	a0,a0,-1690 # 80007108 <etext+0x108>
    800007aa:	535040ef          	jal	800054de <panic>

00000000800007ae <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800007ae:	1101                	addi	sp,sp,-32
    800007b0:	ec06                	sd	ra,24(sp)
    800007b2:	e822                	sd	s0,16(sp)
    800007b4:	e426                	sd	s1,8(sp)
    800007b6:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800007b8:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800007ba:	00b67d63          	bgeu	a2,a1,800007d4 <uvmdealloc+0x26>
    800007be:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800007c0:	6785                	lui	a5,0x1
    800007c2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800007c4:	00f60733          	add	a4,a2,a5
    800007c8:	76fd                	lui	a3,0xfffff
    800007ca:	8f75                	and	a4,a4,a3
    800007cc:	97ae                	add	a5,a5,a1
    800007ce:	8ff5                	and	a5,a5,a3
    800007d0:	00f76863          	bltu	a4,a5,800007e0 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800007d4:	8526                	mv	a0,s1
    800007d6:	60e2                	ld	ra,24(sp)
    800007d8:	6442                	ld	s0,16(sp)
    800007da:	64a2                	ld	s1,8(sp)
    800007dc:	6105                	addi	sp,sp,32
    800007de:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800007e0:	8f99                	sub	a5,a5,a4
    800007e2:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800007e4:	4685                	li	a3,1
    800007e6:	0007861b          	sext.w	a2,a5
    800007ea:	85ba                	mv	a1,a4
    800007ec:	e83ff0ef          	jal	8000066e <uvmunmap>
    800007f0:	b7d5                	j	800007d4 <uvmdealloc+0x26>

00000000800007f2 <uvmalloc>:
  if(newsz < oldsz)
    800007f2:	0ab66163          	bltu	a2,a1,80000894 <uvmalloc+0xa2>
{
    800007f6:	715d                	addi	sp,sp,-80
    800007f8:	e486                	sd	ra,72(sp)
    800007fa:	e0a2                	sd	s0,64(sp)
    800007fc:	f84a                	sd	s2,48(sp)
    800007fe:	f052                	sd	s4,32(sp)
    80000800:	ec56                	sd	s5,24(sp)
    80000802:	e45e                	sd	s7,8(sp)
    80000804:	0880                	addi	s0,sp,80
    80000806:	8aaa                	mv	s5,a0
    80000808:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000080a:	6785                	lui	a5,0x1
    8000080c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000080e:	95be                	add	a1,a1,a5
    80000810:	77fd                	lui	a5,0xfffff
    80000812:	00f5f933          	and	s2,a1,a5
    80000816:	8bca                	mv	s7,s2
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000818:	08c97063          	bgeu	s2,a2,80000898 <uvmalloc+0xa6>
    8000081c:	fc26                	sd	s1,56(sp)
    8000081e:	f44e                	sd	s3,40(sp)
    80000820:	e85a                	sd	s6,16(sp)
    memset(mem, 0, PGSIZE);
    80000822:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000824:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    80000828:	8ddff0ef          	jal	80000104 <kalloc>
    8000082c:	84aa                	mv	s1,a0
    if(mem == 0){
    8000082e:	c50d                	beqz	a0,80000858 <uvmalloc+0x66>
    memset(mem, 0, PGSIZE);
    80000830:	864e                	mv	a2,s3
    80000832:	4581                	li	a1,0
    80000834:	92bff0ef          	jal	8000015e <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000838:	875a                	mv	a4,s6
    8000083a:	86a6                	mv	a3,s1
    8000083c:	864e                	mv	a2,s3
    8000083e:	85ca                	mv	a1,s2
    80000840:	8556                	mv	a0,s5
    80000842:	c85ff0ef          	jal	800004c6 <mappages>
    80000846:	e915                	bnez	a0,8000087a <uvmalloc+0x88>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000848:	994e                	add	s2,s2,s3
    8000084a:	fd496fe3          	bltu	s2,s4,80000828 <uvmalloc+0x36>
  return newsz;
    8000084e:	8552                	mv	a0,s4
    80000850:	74e2                	ld	s1,56(sp)
    80000852:	79a2                	ld	s3,40(sp)
    80000854:	6b42                	ld	s6,16(sp)
    80000856:	a811                	j	8000086a <uvmalloc+0x78>
      uvmdealloc(pagetable, a, oldsz);
    80000858:	865e                	mv	a2,s7
    8000085a:	85ca                	mv	a1,s2
    8000085c:	8556                	mv	a0,s5
    8000085e:	f51ff0ef          	jal	800007ae <uvmdealloc>
      return 0;
    80000862:	4501                	li	a0,0
    80000864:	74e2                	ld	s1,56(sp)
    80000866:	79a2                	ld	s3,40(sp)
    80000868:	6b42                	ld	s6,16(sp)
}
    8000086a:	60a6                	ld	ra,72(sp)
    8000086c:	6406                	ld	s0,64(sp)
    8000086e:	7942                	ld	s2,48(sp)
    80000870:	7a02                	ld	s4,32(sp)
    80000872:	6ae2                	ld	s5,24(sp)
    80000874:	6ba2                	ld	s7,8(sp)
    80000876:	6161                	addi	sp,sp,80
    80000878:	8082                	ret
      kfree(mem);
    8000087a:	8526                	mv	a0,s1
    8000087c:	fa0ff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000880:	865e                	mv	a2,s7
    80000882:	85ca                	mv	a1,s2
    80000884:	8556                	mv	a0,s5
    80000886:	f29ff0ef          	jal	800007ae <uvmdealloc>
      return 0;
    8000088a:	4501                	li	a0,0
    8000088c:	74e2                	ld	s1,56(sp)
    8000088e:	79a2                	ld	s3,40(sp)
    80000890:	6b42                	ld	s6,16(sp)
    80000892:	bfe1                	j	8000086a <uvmalloc+0x78>
    return oldsz;
    80000894:	852e                	mv	a0,a1
}
    80000896:	8082                	ret
  return newsz;
    80000898:	8532                	mv	a0,a2
    8000089a:	bfc1                	j	8000086a <uvmalloc+0x78>

000000008000089c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000089c:	7179                	addi	sp,sp,-48
    8000089e:	f406                	sd	ra,40(sp)
    800008a0:	f022                	sd	s0,32(sp)
    800008a2:	ec26                	sd	s1,24(sp)
    800008a4:	e84a                	sd	s2,16(sp)
    800008a6:	e44e                	sd	s3,8(sp)
    800008a8:	1800                	addi	s0,sp,48
    800008aa:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800008ac:	84aa                	mv	s1,a0
    800008ae:	6905                	lui	s2,0x1
    800008b0:	992a                	add	s2,s2,a0
    800008b2:	a811                	j	800008c6 <freewalk+0x2a>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if(pte & PTE_V){
      panic("freewalk: leaf");
    800008b4:	00007517          	auipc	a0,0x7
    800008b8:	87450513          	addi	a0,a0,-1932 # 80007128 <etext+0x128>
    800008bc:	423040ef          	jal	800054de <panic>
  for(int i = 0; i < 512; i++){
    800008c0:	04a1                	addi	s1,s1,8
    800008c2:	03248163          	beq	s1,s2,800008e4 <freewalk+0x48>
    pte_t pte = pagetable[i];
    800008c6:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800008c8:	0017f713          	andi	a4,a5,1
    800008cc:	db75                	beqz	a4,800008c0 <freewalk+0x24>
    800008ce:	00e7f713          	andi	a4,a5,14
    800008d2:	f36d                	bnez	a4,800008b4 <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    800008d4:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800008d6:	00c79513          	slli	a0,a5,0xc
    800008da:	fc3ff0ef          	jal	8000089c <freewalk>
      pagetable[i] = 0;
    800008de:	0004b023          	sd	zero,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800008e2:	bff9                	j	800008c0 <freewalk+0x24>
    }
  }
  kfree((void*)pagetable);
    800008e4:	854e                	mv	a0,s3
    800008e6:	f36ff0ef          	jal	8000001c <kfree>
}
    800008ea:	70a2                	ld	ra,40(sp)
    800008ec:	7402                	ld	s0,32(sp)
    800008ee:	64e2                	ld	s1,24(sp)
    800008f0:	6942                	ld	s2,16(sp)
    800008f2:	69a2                	ld	s3,8(sp)
    800008f4:	6145                	addi	sp,sp,48
    800008f6:	8082                	ret

00000000800008f8 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800008f8:	1101                	addi	sp,sp,-32
    800008fa:	ec06                	sd	ra,24(sp)
    800008fc:	e822                	sd	s0,16(sp)
    800008fe:	e426                	sd	s1,8(sp)
    80000900:	1000                	addi	s0,sp,32
    80000902:	84aa                	mv	s1,a0
  if(sz > 0)
    80000904:	e989                	bnez	a1,80000916 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000906:	8526                	mv	a0,s1
    80000908:	f95ff0ef          	jal	8000089c <freewalk>
}
    8000090c:	60e2                	ld	ra,24(sp)
    8000090e:	6442                	ld	s0,16(sp)
    80000910:	64a2                	ld	s1,8(sp)
    80000912:	6105                	addi	sp,sp,32
    80000914:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000916:	6785                	lui	a5,0x1
    80000918:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000091a:	95be                	add	a1,a1,a5
    8000091c:	4685                	li	a3,1
    8000091e:	00c5d613          	srli	a2,a1,0xc
    80000922:	4581                	li	a1,0
    80000924:	d4bff0ef          	jal	8000066e <uvmunmap>
    80000928:	bff9                	j	80000906 <uvmfree+0xe>

000000008000092a <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    8000092a:	c64d                	beqz	a2,800009d4 <uvmcopy+0xaa>
{
    8000092c:	715d                	addi	sp,sp,-80
    8000092e:	e486                	sd	ra,72(sp)
    80000930:	e0a2                	sd	s0,64(sp)
    80000932:	fc26                	sd	s1,56(sp)
    80000934:	f84a                	sd	s2,48(sp)
    80000936:	f44e                	sd	s3,40(sp)
    80000938:	f052                	sd	s4,32(sp)
    8000093a:	ec56                	sd	s5,24(sp)
    8000093c:	e85a                	sd	s6,16(sp)
    8000093e:	e45e                	sd	s7,8(sp)
    80000940:	0880                	addi	s0,sp,80
    80000942:	8b2a                	mv	s6,a0
    80000944:	8aae                	mv	s5,a1
    80000946:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000948:	4901                	li	s2,0
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000094a:	6985                	lui	s3,0x1
    if((pte = walk(old, i, 0)) == 0)
    8000094c:	4601                	li	a2,0
    8000094e:	85ca                	mv	a1,s2
    80000950:	855a                	mv	a0,s6
    80000952:	aa1ff0ef          	jal	800003f2 <walk>
    80000956:	cd0d                	beqz	a0,80000990 <uvmcopy+0x66>
    if((*pte & PTE_V) == 0)
    80000958:	00053b83          	ld	s7,0(a0)
    8000095c:	001bf793          	andi	a5,s7,1
    80000960:	cf95                	beqz	a5,8000099c <uvmcopy+0x72>
    if((mem = kalloc()) == 0)
    80000962:	fa2ff0ef          	jal	80000104 <kalloc>
    80000966:	84aa                	mv	s1,a0
    80000968:	c139                	beqz	a0,800009ae <uvmcopy+0x84>
    pa = PTE2PA(*pte);
    8000096a:	00abd593          	srli	a1,s7,0xa
    memmove(mem, (char*)pa, PGSIZE);
    8000096e:	864e                	mv	a2,s3
    80000970:	05b2                	slli	a1,a1,0xc
    80000972:	84dff0ef          	jal	800001be <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000976:	3ffbf713          	andi	a4,s7,1023
    8000097a:	86a6                	mv	a3,s1
    8000097c:	864e                	mv	a2,s3
    8000097e:	85ca                	mv	a1,s2
    80000980:	8556                	mv	a0,s5
    80000982:	b45ff0ef          	jal	800004c6 <mappages>
    80000986:	e10d                	bnez	a0,800009a8 <uvmcopy+0x7e>
  for(i = 0; i < sz; i += PGSIZE){
    80000988:	994e                	add	s2,s2,s3
    8000098a:	fd4961e3          	bltu	s2,s4,8000094c <uvmcopy+0x22>
    8000098e:	a805                	j	800009be <uvmcopy+0x94>
      panic("uvmcopy: pte should exist");
    80000990:	00006517          	auipc	a0,0x6
    80000994:	7a850513          	addi	a0,a0,1960 # 80007138 <etext+0x138>
    80000998:	347040ef          	jal	800054de <panic>
      panic("uvmcopy: page not present");
    8000099c:	00006517          	auipc	a0,0x6
    800009a0:	7bc50513          	addi	a0,a0,1980 # 80007158 <etext+0x158>
    800009a4:	33b040ef          	jal	800054de <panic>
      kfree(mem);
    800009a8:	8526                	mv	a0,s1
    800009aa:	e72ff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800009ae:	4685                	li	a3,1
    800009b0:	00c95613          	srli	a2,s2,0xc
    800009b4:	4581                	li	a1,0
    800009b6:	8556                	mv	a0,s5
    800009b8:	cb7ff0ef          	jal	8000066e <uvmunmap>
  return -1;
    800009bc:	557d                	li	a0,-1
}
    800009be:	60a6                	ld	ra,72(sp)
    800009c0:	6406                	ld	s0,64(sp)
    800009c2:	74e2                	ld	s1,56(sp)
    800009c4:	7942                	ld	s2,48(sp)
    800009c6:	79a2                	ld	s3,40(sp)
    800009c8:	7a02                	ld	s4,32(sp)
    800009ca:	6ae2                	ld	s5,24(sp)
    800009cc:	6b42                	ld	s6,16(sp)
    800009ce:	6ba2                	ld	s7,8(sp)
    800009d0:	6161                	addi	sp,sp,80
    800009d2:	8082                	ret
  return 0;
    800009d4:	4501                	li	a0,0
}
    800009d6:	8082                	ret

00000000800009d8 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    800009d8:	1141                	addi	sp,sp,-16
    800009da:	e406                	sd	ra,8(sp)
    800009dc:	e022                	sd	s0,0(sp)
    800009de:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800009e0:	4601                	li	a2,0
    800009e2:	a11ff0ef          	jal	800003f2 <walk>
  if(pte == 0)
    800009e6:	c901                	beqz	a0,800009f6 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800009e8:	611c                	ld	a5,0(a0)
    800009ea:	9bbd                	andi	a5,a5,-17
    800009ec:	e11c                	sd	a5,0(a0)
}
    800009ee:	60a2                	ld	ra,8(sp)
    800009f0:	6402                	ld	s0,0(sp)
    800009f2:	0141                	addi	sp,sp,16
    800009f4:	8082                	ret
    panic("uvmclear");
    800009f6:	00006517          	auipc	a0,0x6
    800009fa:	78250513          	addi	a0,a0,1922 # 80007178 <etext+0x178>
    800009fe:	2e1040ef          	jal	800054de <panic>

0000000080000a02 <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    80000a02:	c2d9                	beqz	a3,80000a88 <copyout+0x86>
{
    80000a04:	711d                	addi	sp,sp,-96
    80000a06:	ec86                	sd	ra,88(sp)
    80000a08:	e8a2                	sd	s0,80(sp)
    80000a0a:	e4a6                	sd	s1,72(sp)
    80000a0c:	e0ca                	sd	s2,64(sp)
    80000a0e:	fc4e                	sd	s3,56(sp)
    80000a10:	f852                	sd	s4,48(sp)
    80000a12:	f456                	sd	s5,40(sp)
    80000a14:	f05a                	sd	s6,32(sp)
    80000a16:	ec5e                	sd	s7,24(sp)
    80000a18:	e862                	sd	s8,16(sp)
    80000a1a:	e466                	sd	s9,8(sp)
    80000a1c:	e06a                	sd	s10,0(sp)
    80000a1e:	1080                	addi	s0,sp,96
    80000a20:	8c2a                	mv	s8,a0
    80000a22:	892e                	mv	s2,a1
    80000a24:	8ab2                	mv	s5,a2
    80000a26:	8a36                	mv	s4,a3
    va0 = PGROUNDDOWN(dstva);
    80000a28:	7cfd                	lui	s9,0xfffff
    if(va0 >= MAXVA)
    80000a2a:	5bfd                	li	s7,-1
    80000a2c:	01abdb93          	srli	s7,s7,0x1a
      return -1;
    pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000a30:	4d55                	li	s10,21
       (*pte & PTE_W) == 0)
      return -1;
    pa0 = PTE2PA(*pte);
    n = PGSIZE - (dstva - va0);
    80000a32:	6b05                	lui	s6,0x1
    80000a34:	a015                	j	80000a58 <copyout+0x56>
    pa0 = PTE2PA(*pte);
    80000a36:	83a9                	srli	a5,a5,0xa
    80000a38:	07b2                	slli	a5,a5,0xc
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000a3a:	41390533          	sub	a0,s2,s3
    80000a3e:	0004861b          	sext.w	a2,s1
    80000a42:	85d6                	mv	a1,s5
    80000a44:	953e                	add	a0,a0,a5
    80000a46:	f78ff0ef          	jal	800001be <memmove>

    len -= n;
    80000a4a:	409a0a33          	sub	s4,s4,s1
    src += n;
    80000a4e:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    80000a50:	01698933          	add	s2,s3,s6
  while(len > 0){
    80000a54:	020a0863          	beqz	s4,80000a84 <copyout+0x82>
    va0 = PGROUNDDOWN(dstva);
    80000a58:	019979b3          	and	s3,s2,s9
    if(va0 >= MAXVA)
    80000a5c:	033be863          	bltu	s7,s3,80000a8c <copyout+0x8a>
    pte = walk(pagetable, va0, 0);
    80000a60:	4601                	li	a2,0
    80000a62:	85ce                	mv	a1,s3
    80000a64:	8562                	mv	a0,s8
    80000a66:	98dff0ef          	jal	800003f2 <walk>
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80000a6a:	c11d                	beqz	a0,80000a90 <copyout+0x8e>
    80000a6c:	611c                	ld	a5,0(a0)
    80000a6e:	0157f713          	andi	a4,a5,21
    80000a72:	03a71163          	bne	a4,s10,80000a94 <copyout+0x92>
    n = PGSIZE - (dstva - va0);
    80000a76:	412984b3          	sub	s1,s3,s2
    80000a7a:	94da                	add	s1,s1,s6
    if(n > len)
    80000a7c:	fa9a7de3          	bgeu	s4,s1,80000a36 <copyout+0x34>
    80000a80:	84d2                	mv	s1,s4
    80000a82:	bf55                	j	80000a36 <copyout+0x34>
  }
  return 0;
    80000a84:	4501                	li	a0,0
    80000a86:	a801                	j	80000a96 <copyout+0x94>
    80000a88:	4501                	li	a0,0
}
    80000a8a:	8082                	ret
      return -1;
    80000a8c:	557d                	li	a0,-1
    80000a8e:	a021                	j	80000a96 <copyout+0x94>
      return -1;
    80000a90:	557d                	li	a0,-1
    80000a92:	a011                	j	80000a96 <copyout+0x94>
    80000a94:	557d                	li	a0,-1
}
    80000a96:	60e6                	ld	ra,88(sp)
    80000a98:	6446                	ld	s0,80(sp)
    80000a9a:	64a6                	ld	s1,72(sp)
    80000a9c:	6906                	ld	s2,64(sp)
    80000a9e:	79e2                	ld	s3,56(sp)
    80000aa0:	7a42                	ld	s4,48(sp)
    80000aa2:	7aa2                	ld	s5,40(sp)
    80000aa4:	7b02                	ld	s6,32(sp)
    80000aa6:	6be2                	ld	s7,24(sp)
    80000aa8:	6c42                	ld	s8,16(sp)
    80000aaa:	6ca2                	ld	s9,8(sp)
    80000aac:	6d02                	ld	s10,0(sp)
    80000aae:	6125                	addi	sp,sp,96
    80000ab0:	8082                	ret

0000000080000ab2 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000ab2:	c6a5                	beqz	a3,80000b1a <copyin+0x68>
{
    80000ab4:	715d                	addi	sp,sp,-80
    80000ab6:	e486                	sd	ra,72(sp)
    80000ab8:	e0a2                	sd	s0,64(sp)
    80000aba:	fc26                	sd	s1,56(sp)
    80000abc:	f84a                	sd	s2,48(sp)
    80000abe:	f44e                	sd	s3,40(sp)
    80000ac0:	f052                	sd	s4,32(sp)
    80000ac2:	ec56                	sd	s5,24(sp)
    80000ac4:	e85a                	sd	s6,16(sp)
    80000ac6:	e45e                	sd	s7,8(sp)
    80000ac8:	e062                	sd	s8,0(sp)
    80000aca:	0880                	addi	s0,sp,80
    80000acc:	8b2a                	mv	s6,a0
    80000ace:	8a2e                	mv	s4,a1
    80000ad0:	8c32                	mv	s8,a2
    80000ad2:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000ad4:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000ad6:	6a85                	lui	s5,0x1
    80000ad8:	a00d                	j	80000afa <copyin+0x48>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000ada:	018505b3          	add	a1,a0,s8
    80000ade:	0004861b          	sext.w	a2,s1
    80000ae2:	412585b3          	sub	a1,a1,s2
    80000ae6:	8552                	mv	a0,s4
    80000ae8:	ed6ff0ef          	jal	800001be <memmove>

    len -= n;
    80000aec:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000af0:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000af2:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000af6:	02098063          	beqz	s3,80000b16 <copyin+0x64>
    va0 = PGROUNDDOWN(srcva);
    80000afa:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000afe:	85ca                	mv	a1,s2
    80000b00:	855a                	mv	a0,s6
    80000b02:	98bff0ef          	jal	8000048c <walkaddr>
    if(pa0 == 0)
    80000b06:	cd01                	beqz	a0,80000b1e <copyin+0x6c>
    n = PGSIZE - (srcva - va0);
    80000b08:	418904b3          	sub	s1,s2,s8
    80000b0c:	94d6                	add	s1,s1,s5
    if(n > len)
    80000b0e:	fc99f6e3          	bgeu	s3,s1,80000ada <copyin+0x28>
    80000b12:	84ce                	mv	s1,s3
    80000b14:	b7d9                	j	80000ada <copyin+0x28>
  }
  return 0;
    80000b16:	4501                	li	a0,0
    80000b18:	a021                	j	80000b20 <copyin+0x6e>
    80000b1a:	4501                	li	a0,0
}
    80000b1c:	8082                	ret
      return -1;
    80000b1e:	557d                	li	a0,-1
}
    80000b20:	60a6                	ld	ra,72(sp)
    80000b22:	6406                	ld	s0,64(sp)
    80000b24:	74e2                	ld	s1,56(sp)
    80000b26:	7942                	ld	s2,48(sp)
    80000b28:	79a2                	ld	s3,40(sp)
    80000b2a:	7a02                	ld	s4,32(sp)
    80000b2c:	6ae2                	ld	s5,24(sp)
    80000b2e:	6b42                	ld	s6,16(sp)
    80000b30:	6ba2                	ld	s7,8(sp)
    80000b32:	6c02                	ld	s8,0(sp)
    80000b34:	6161                	addi	sp,sp,80
    80000b36:	8082                	ret

0000000080000b38 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000b38:	cac5                	beqz	a3,80000be8 <copyinstr+0xb0>
{
    80000b3a:	715d                	addi	sp,sp,-80
    80000b3c:	e486                	sd	ra,72(sp)
    80000b3e:	e0a2                	sd	s0,64(sp)
    80000b40:	fc26                	sd	s1,56(sp)
    80000b42:	f84a                	sd	s2,48(sp)
    80000b44:	f44e                	sd	s3,40(sp)
    80000b46:	f052                	sd	s4,32(sp)
    80000b48:	ec56                	sd	s5,24(sp)
    80000b4a:	e85a                	sd	s6,16(sp)
    80000b4c:	e45e                	sd	s7,8(sp)
    80000b4e:	0880                	addi	s0,sp,80
    80000b50:	8aaa                	mv	s5,a0
    80000b52:	84ae                	mv	s1,a1
    80000b54:	8bb2                	mv	s7,a2
    80000b56:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000b58:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000b5a:	6a05                	lui	s4,0x1
    80000b5c:	a82d                	j	80000b96 <copyinstr+0x5e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000b5e:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80000b62:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000b64:	0017c793          	xori	a5,a5,1
    80000b68:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000b6c:	60a6                	ld	ra,72(sp)
    80000b6e:	6406                	ld	s0,64(sp)
    80000b70:	74e2                	ld	s1,56(sp)
    80000b72:	7942                	ld	s2,48(sp)
    80000b74:	79a2                	ld	s3,40(sp)
    80000b76:	7a02                	ld	s4,32(sp)
    80000b78:	6ae2                	ld	s5,24(sp)
    80000b7a:	6b42                	ld	s6,16(sp)
    80000b7c:	6ba2                	ld	s7,8(sp)
    80000b7e:	6161                	addi	sp,sp,80
    80000b80:	8082                	ret
    80000b82:	fff98713          	addi	a4,s3,-1 # fff <_entry-0x7ffff001>
    80000b86:	9726                	add	a4,a4,s1
      --max;
    80000b88:	40b709b3          	sub	s3,a4,a1
    srcva = va0 + PGSIZE;
    80000b8c:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80000b90:	04e58463          	beq	a1,a4,80000bd8 <copyinstr+0xa0>
{
    80000b94:	84be                	mv	s1,a5
    va0 = PGROUNDDOWN(srcva);
    80000b96:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80000b9a:	85ca                	mv	a1,s2
    80000b9c:	8556                	mv	a0,s5
    80000b9e:	8efff0ef          	jal	8000048c <walkaddr>
    if(pa0 == 0)
    80000ba2:	cd0d                	beqz	a0,80000bdc <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000ba4:	417906b3          	sub	a3,s2,s7
    80000ba8:	96d2                	add	a3,a3,s4
    if(n > max)
    80000baa:	00d9f363          	bgeu	s3,a3,80000bb0 <copyinstr+0x78>
    80000bae:	86ce                	mv	a3,s3
    while(n > 0){
    80000bb0:	ca85                	beqz	a3,80000be0 <copyinstr+0xa8>
    char *p = (char *) (pa0 + (srcva - va0));
    80000bb2:	01750633          	add	a2,a0,s7
    80000bb6:	41260633          	sub	a2,a2,s2
    80000bba:	87a6                	mv	a5,s1
      if(*p == '\0'){
    80000bbc:	8e05                	sub	a2,a2,s1
    while(n > 0){
    80000bbe:	96a6                	add	a3,a3,s1
    80000bc0:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000bc2:	00f60733          	add	a4,a2,a5
    80000bc6:	00074703          	lbu	a4,0(a4)
    80000bca:	db51                	beqz	a4,80000b5e <copyinstr+0x26>
        *dst = *p;
    80000bcc:	00e78023          	sb	a4,0(a5)
      dst++;
    80000bd0:	0785                	addi	a5,a5,1
    while(n > 0){
    80000bd2:	fed797e3          	bne	a5,a3,80000bc0 <copyinstr+0x88>
    80000bd6:	b775                	j	80000b82 <copyinstr+0x4a>
    80000bd8:	4781                	li	a5,0
    80000bda:	b769                	j	80000b64 <copyinstr+0x2c>
      return -1;
    80000bdc:	557d                	li	a0,-1
    80000bde:	b779                	j	80000b6c <copyinstr+0x34>
    srcva = va0 + PGSIZE;
    80000be0:	6b85                	lui	s7,0x1
    80000be2:	9bca                	add	s7,s7,s2
    80000be4:	87a6                	mv	a5,s1
    80000be6:	b77d                	j	80000b94 <copyinstr+0x5c>
  int got_null = 0;
    80000be8:	4781                	li	a5,0
  if(got_null){
    80000bea:	0017c793          	xori	a5,a5,1
    80000bee:	40f0053b          	negw	a0,a5
}
    80000bf2:	8082                	ret

0000000080000bf4 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks (pagetable_t kpgtbl)
{
    80000bf4:	715d                	addi	sp,sp,-80
    80000bf6:	e486                	sd	ra,72(sp)
    80000bf8:	e0a2                	sd	s0,64(sp)
    80000bfa:	fc26                	sd	s1,56(sp)
    80000bfc:	f84a                	sd	s2,48(sp)
    80000bfe:	f44e                	sd	s3,40(sp)
    80000c00:	f052                	sd	s4,32(sp)
    80000c02:	ec56                	sd	s5,24(sp)
    80000c04:	e85a                	sd	s6,16(sp)
    80000c06:	e45e                	sd	s7,8(sp)
    80000c08:	e062                	sd	s8,0(sp)
    80000c0a:	0880                	addi	s0,sp,80
    80000c0c:	8a2a                	mv	s4,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    80000c0e:	0000a497          	auipc	s1,0xa
    80000c12:	c3248493          	addi	s1,s1,-974 # 8000a840 <proc>
    {
      char *pa = kalloc ();
      if (pa == 0)
        panic ("kalloc");
      uint64 va = KSTACK ((int)(p - proc));
    80000c16:	8c26                	mv	s8,s1
    80000c18:	000a57b7          	lui	a5,0xa5
    80000c1c:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80000c20:	07b2                	slli	a5,a5,0xc
    80000c22:	fa578793          	addi	a5,a5,-91
    80000c26:	4fa50937          	lui	s2,0x4fa50
    80000c2a:	a4f90913          	addi	s2,s2,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80000c2e:	1902                	slli	s2,s2,0x20
    80000c30:	993e                	add	s2,s2,a5
    80000c32:	040009b7          	lui	s3,0x4000
    80000c36:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000c38:	09b2                	slli	s3,s3,0xc
      kvmmap (kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c3a:	4b99                	li	s7,6
    80000c3c:	6b05                	lui	s6,0x1
  for (p = proc; p < &proc[NPROC]; p++)
    80000c3e:	0000fa97          	auipc	s5,0xf
    80000c42:	602a8a93          	addi	s5,s5,1538 # 80010240 <tickslock>
      char *pa = kalloc ();
    80000c46:	cbeff0ef          	jal	80000104 <kalloc>
    80000c4a:	862a                	mv	a2,a0
      if (pa == 0)
    80000c4c:	c121                	beqz	a0,80000c8c <proc_mapstacks+0x98>
      uint64 va = KSTACK ((int)(p - proc));
    80000c4e:	418485b3          	sub	a1,s1,s8
    80000c52:	858d                	srai	a1,a1,0x3
    80000c54:	032585b3          	mul	a1,a1,s2
    80000c58:	05b6                	slli	a1,a1,0xd
    80000c5a:	6789                	lui	a5,0x2
    80000c5c:	9dbd                	addw	a1,a1,a5
      kvmmap (kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c5e:	875e                	mv	a4,s7
    80000c60:	86da                	mv	a3,s6
    80000c62:	40b985b3          	sub	a1,s3,a1
    80000c66:	8552                	mv	a0,s4
    80000c68:	915ff0ef          	jal	8000057c <kvmmap>
  for (p = proc; p < &proc[NPROC]; p++)
    80000c6c:	16848493          	addi	s1,s1,360
    80000c70:	fd549be3          	bne	s1,s5,80000c46 <proc_mapstacks+0x52>
    }
}
    80000c74:	60a6                	ld	ra,72(sp)
    80000c76:	6406                	ld	s0,64(sp)
    80000c78:	74e2                	ld	s1,56(sp)
    80000c7a:	7942                	ld	s2,48(sp)
    80000c7c:	79a2                	ld	s3,40(sp)
    80000c7e:	7a02                	ld	s4,32(sp)
    80000c80:	6ae2                	ld	s5,24(sp)
    80000c82:	6b42                	ld	s6,16(sp)
    80000c84:	6ba2                	ld	s7,8(sp)
    80000c86:	6c02                	ld	s8,0(sp)
    80000c88:	6161                	addi	sp,sp,80
    80000c8a:	8082                	ret
        panic ("kalloc");
    80000c8c:	00006517          	auipc	a0,0x6
    80000c90:	4fc50513          	addi	a0,a0,1276 # 80007188 <etext+0x188>
    80000c94:	04b040ef          	jal	800054de <panic>

0000000080000c98 <procinit>:

// initialize the proc table.
void
procinit (void)
{
    80000c98:	7139                	addi	sp,sp,-64
    80000c9a:	fc06                	sd	ra,56(sp)
    80000c9c:	f822                	sd	s0,48(sp)
    80000c9e:	f426                	sd	s1,40(sp)
    80000ca0:	f04a                	sd	s2,32(sp)
    80000ca2:	ec4e                	sd	s3,24(sp)
    80000ca4:	e852                	sd	s4,16(sp)
    80000ca6:	e456                	sd	s5,8(sp)
    80000ca8:	e05a                	sd	s6,0(sp)
    80000caa:	0080                	addi	s0,sp,64
  struct proc *p;

  initlock (&pid_lock, "nextpid");
    80000cac:	00006597          	auipc	a1,0x6
    80000cb0:	4e458593          	addi	a1,a1,1252 # 80007190 <etext+0x190>
    80000cb4:	00009517          	auipc	a0,0x9
    80000cb8:	75c50513          	addi	a0,a0,1884 # 8000a410 <pid_lock>
    80000cbc:	2d7040ef          	jal	80005792 <initlock>
  initlock (&wait_lock, "wait_lock");
    80000cc0:	00006597          	auipc	a1,0x6
    80000cc4:	4d858593          	addi	a1,a1,1240 # 80007198 <etext+0x198>
    80000cc8:	00009517          	auipc	a0,0x9
    80000ccc:	76050513          	addi	a0,a0,1888 # 8000a428 <wait_lock>
    80000cd0:	2c3040ef          	jal	80005792 <initlock>
  for (p = proc; p < &proc[NPROC]; p++)
    80000cd4:	0000a497          	auipc	s1,0xa
    80000cd8:	b6c48493          	addi	s1,s1,-1172 # 8000a840 <proc>
    {
      initlock (&p->lock, "proc");
    80000cdc:	00006b17          	auipc	s6,0x6
    80000ce0:	4ccb0b13          	addi	s6,s6,1228 # 800071a8 <etext+0x1a8>
      p->state = UNUSED;
      p->kstack = KSTACK ((int)(p - proc));
    80000ce4:	8aa6                	mv	s5,s1
    80000ce6:	000a57b7          	lui	a5,0xa5
    80000cea:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80000cee:	07b2                	slli	a5,a5,0xc
    80000cf0:	fa578793          	addi	a5,a5,-91
    80000cf4:	4fa50937          	lui	s2,0x4fa50
    80000cf8:	a4f90913          	addi	s2,s2,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80000cfc:	1902                	slli	s2,s2,0x20
    80000cfe:	993e                	add	s2,s2,a5
    80000d00:	040009b7          	lui	s3,0x4000
    80000d04:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000d06:	09b2                	slli	s3,s3,0xc
  for (p = proc; p < &proc[NPROC]; p++)
    80000d08:	0000fa17          	auipc	s4,0xf
    80000d0c:	538a0a13          	addi	s4,s4,1336 # 80010240 <tickslock>
      initlock (&p->lock, "proc");
    80000d10:	85da                	mv	a1,s6
    80000d12:	8526                	mv	a0,s1
    80000d14:	27f040ef          	jal	80005792 <initlock>
      p->state = UNUSED;
    80000d18:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK ((int)(p - proc));
    80000d1c:	415487b3          	sub	a5,s1,s5
    80000d20:	878d                	srai	a5,a5,0x3
    80000d22:	032787b3          	mul	a5,a5,s2
    80000d26:	07b6                	slli	a5,a5,0xd
    80000d28:	6709                	lui	a4,0x2
    80000d2a:	9fb9                	addw	a5,a5,a4
    80000d2c:	40f987b3          	sub	a5,s3,a5
    80000d30:	e0bc                	sd	a5,64(s1)
  for (p = proc; p < &proc[NPROC]; p++)
    80000d32:	16848493          	addi	s1,s1,360
    80000d36:	fd449de3          	bne	s1,s4,80000d10 <procinit+0x78>
    }
}
    80000d3a:	70e2                	ld	ra,56(sp)
    80000d3c:	7442                	ld	s0,48(sp)
    80000d3e:	74a2                	ld	s1,40(sp)
    80000d40:	7902                	ld	s2,32(sp)
    80000d42:	69e2                	ld	s3,24(sp)
    80000d44:	6a42                	ld	s4,16(sp)
    80000d46:	6aa2                	ld	s5,8(sp)
    80000d48:	6b02                	ld	s6,0(sp)
    80000d4a:	6121                	addi	sp,sp,64
    80000d4c:	8082                	ret

0000000080000d4e <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid ()
{
    80000d4e:	1141                	addi	sp,sp,-16
    80000d50:	e406                	sd	ra,8(sp)
    80000d52:	e022                	sd	s0,0(sp)
    80000d54:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000d56:	8512                	mv	a0,tp
  int id = r_tp ();
  return id;
}
    80000d58:	2501                	sext.w	a0,a0
    80000d5a:	60a2                	ld	ra,8(sp)
    80000d5c:	6402                	ld	s0,0(sp)
    80000d5e:	0141                	addi	sp,sp,16
    80000d60:	8082                	ret

0000000080000d62 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu *
mycpu (void)
{
    80000d62:	1141                	addi	sp,sp,-16
    80000d64:	e406                	sd	ra,8(sp)
    80000d66:	e022                	sd	s0,0(sp)
    80000d68:	0800                	addi	s0,sp,16
    80000d6a:	8792                	mv	a5,tp
  int id = cpuid ();
  struct cpu *c = &cpus[id];
    80000d6c:	2781                	sext.w	a5,a5
    80000d6e:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d70:	00009517          	auipc	a0,0x9
    80000d74:	6d050513          	addi	a0,a0,1744 # 8000a440 <cpus>
    80000d78:	953e                	add	a0,a0,a5
    80000d7a:	60a2                	ld	ra,8(sp)
    80000d7c:	6402                	ld	s0,0(sp)
    80000d7e:	0141                	addi	sp,sp,16
    80000d80:	8082                	ret

0000000080000d82 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc *
myproc (void)
{
    80000d82:	1101                	addi	sp,sp,-32
    80000d84:	ec06                	sd	ra,24(sp)
    80000d86:	e822                	sd	s0,16(sp)
    80000d88:	e426                	sd	s1,8(sp)
    80000d8a:	1000                	addi	s0,sp,32
  push_off ();
    80000d8c:	24d040ef          	jal	800057d8 <push_off>
    80000d90:	8792                	mv	a5,tp
  struct cpu *c = mycpu ();
  struct proc *p = c->proc;
    80000d92:	2781                	sext.w	a5,a5
    80000d94:	079e                	slli	a5,a5,0x7
    80000d96:	00009717          	auipc	a4,0x9
    80000d9a:	67a70713          	addi	a4,a4,1658 # 8000a410 <pid_lock>
    80000d9e:	97ba                	add	a5,a5,a4
    80000da0:	7b9c                	ld	a5,48(a5)
    80000da2:	84be                	mv	s1,a5
  pop_off ();
    80000da4:	2bd040ef          	jal	80005860 <pop_off>
  return p;
}
    80000da8:	8526                	mv	a0,s1
    80000daa:	60e2                	ld	ra,24(sp)
    80000dac:	6442                	ld	s0,16(sp)
    80000dae:	64a2                	ld	s1,8(sp)
    80000db0:	6105                	addi	sp,sp,32
    80000db2:	8082                	ret

0000000080000db4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret (void)
{
    80000db4:	1141                	addi	sp,sp,-16
    80000db6:	e406                	sd	ra,8(sp)
    80000db8:	e022                	sd	s0,0(sp)
    80000dba:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release (&myproc ()->lock);
    80000dbc:	fc7ff0ef          	jal	80000d82 <myproc>
    80000dc0:	2f1040ef          	jal	800058b0 <release>

  if (first)
    80000dc4:	00009797          	auipc	a5,0x9
    80000dc8:	58c7a783          	lw	a5,1420(a5) # 8000a350 <first.1>
    80000dcc:	e799                	bnez	a5,80000dda <forkret+0x26>
      first = 0;
      // ensure other cores see first=0.
      __sync_synchronize ();
    }

  usertrapret ();
    80000dce:	2cb000ef          	jal	80001898 <usertrapret>
}
    80000dd2:	60a2                	ld	ra,8(sp)
    80000dd4:	6402                	ld	s0,0(sp)
    80000dd6:	0141                	addi	sp,sp,16
    80000dd8:	8082                	ret
      fsinit (ROOTDEV);
    80000dda:	4505                	li	a0,1
    80000ddc:	688010ef          	jal	80002464 <fsinit>
      first = 0;
    80000de0:	00009797          	auipc	a5,0x9
    80000de4:	5607a823          	sw	zero,1392(a5) # 8000a350 <first.1>
      __sync_synchronize ();
    80000de8:	0330000f          	fence	rw,rw
    80000dec:	b7cd                	j	80000dce <forkret+0x1a>

0000000080000dee <allocpid>:
{
    80000dee:	1101                	addi	sp,sp,-32
    80000df0:	ec06                	sd	ra,24(sp)
    80000df2:	e822                	sd	s0,16(sp)
    80000df4:	e426                	sd	s1,8(sp)
    80000df6:	1000                	addi	s0,sp,32
  acquire (&pid_lock);
    80000df8:	00009517          	auipc	a0,0x9
    80000dfc:	61850513          	addi	a0,a0,1560 # 8000a410 <pid_lock>
    80000e00:	21d040ef          	jal	8000581c <acquire>
  pid = nextpid;
    80000e04:	00009797          	auipc	a5,0x9
    80000e08:	55078793          	addi	a5,a5,1360 # 8000a354 <nextpid>
    80000e0c:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e0e:	0014871b          	addiw	a4,s1,1
    80000e12:	c398                	sw	a4,0(a5)
  release (&pid_lock);
    80000e14:	00009517          	auipc	a0,0x9
    80000e18:	5fc50513          	addi	a0,a0,1532 # 8000a410 <pid_lock>
    80000e1c:	295040ef          	jal	800058b0 <release>
}
    80000e20:	8526                	mv	a0,s1
    80000e22:	60e2                	ld	ra,24(sp)
    80000e24:	6442                	ld	s0,16(sp)
    80000e26:	64a2                	ld	s1,8(sp)
    80000e28:	6105                	addi	sp,sp,32
    80000e2a:	8082                	ret

0000000080000e2c <proc_pagetable>:
{
    80000e2c:	1101                	addi	sp,sp,-32
    80000e2e:	ec06                	sd	ra,24(sp)
    80000e30:	e822                	sd	s0,16(sp)
    80000e32:	e426                	sd	s1,8(sp)
    80000e34:	e04a                	sd	s2,0(sp)
    80000e36:	1000                	addi	s0,sp,32
    80000e38:	892a                	mv	s2,a0
  pagetable = uvmcreate ();
    80000e3a:	8f1ff0ef          	jal	8000072a <uvmcreate>
    80000e3e:	84aa                	mv	s1,a0
  if (pagetable == 0)
    80000e40:	cd05                	beqz	a0,80000e78 <proc_pagetable+0x4c>
  if (mappages (pagetable, TRAMPOLINE, PGSIZE, (uint64)trampoline,
    80000e42:	4729                	li	a4,10
    80000e44:	00005697          	auipc	a3,0x5
    80000e48:	1bc68693          	addi	a3,a3,444 # 80006000 <_trampoline>
    80000e4c:	6605                	lui	a2,0x1
    80000e4e:	040005b7          	lui	a1,0x4000
    80000e52:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000e54:	05b2                	slli	a1,a1,0xc
    80000e56:	e70ff0ef          	jal	800004c6 <mappages>
    80000e5a:	02054663          	bltz	a0,80000e86 <proc_pagetable+0x5a>
  if (mappages (pagetable, TRAPFRAME, PGSIZE, (uint64)(p->trapframe),
    80000e5e:	4719                	li	a4,6
    80000e60:	05893683          	ld	a3,88(s2)
    80000e64:	6605                	lui	a2,0x1
    80000e66:	020005b7          	lui	a1,0x2000
    80000e6a:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000e6c:	05b6                	slli	a1,a1,0xd
    80000e6e:	8526                	mv	a0,s1
    80000e70:	e56ff0ef          	jal	800004c6 <mappages>
    80000e74:	00054f63          	bltz	a0,80000e92 <proc_pagetable+0x66>
}
    80000e78:	8526                	mv	a0,s1
    80000e7a:	60e2                	ld	ra,24(sp)
    80000e7c:	6442                	ld	s0,16(sp)
    80000e7e:	64a2                	ld	s1,8(sp)
    80000e80:	6902                	ld	s2,0(sp)
    80000e82:	6105                	addi	sp,sp,32
    80000e84:	8082                	ret
      uvmfree (pagetable, 0);
    80000e86:	4581                	li	a1,0
    80000e88:	8526                	mv	a0,s1
    80000e8a:	a6fff0ef          	jal	800008f8 <uvmfree>
      return 0;
    80000e8e:	4481                	li	s1,0
    80000e90:	b7e5                	j	80000e78 <proc_pagetable+0x4c>
      uvmunmap (pagetable, TRAMPOLINE, 1, 0);
    80000e92:	4681                	li	a3,0
    80000e94:	4605                	li	a2,1
    80000e96:	040005b7          	lui	a1,0x4000
    80000e9a:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000e9c:	05b2                	slli	a1,a1,0xc
    80000e9e:	8526                	mv	a0,s1
    80000ea0:	fceff0ef          	jal	8000066e <uvmunmap>
      uvmfree (pagetable, 0);
    80000ea4:	4581                	li	a1,0
    80000ea6:	8526                	mv	a0,s1
    80000ea8:	a51ff0ef          	jal	800008f8 <uvmfree>
      return 0;
    80000eac:	4481                	li	s1,0
    80000eae:	b7e9                	j	80000e78 <proc_pagetable+0x4c>

0000000080000eb0 <proc_freepagetable>:
{
    80000eb0:	1101                	addi	sp,sp,-32
    80000eb2:	ec06                	sd	ra,24(sp)
    80000eb4:	e822                	sd	s0,16(sp)
    80000eb6:	e426                	sd	s1,8(sp)
    80000eb8:	e04a                	sd	s2,0(sp)
    80000eba:	1000                	addi	s0,sp,32
    80000ebc:	84aa                	mv	s1,a0
    80000ebe:	892e                	mv	s2,a1
  uvmunmap (pagetable, TRAMPOLINE, 1, 0);
    80000ec0:	4681                	li	a3,0
    80000ec2:	4605                	li	a2,1
    80000ec4:	040005b7          	lui	a1,0x4000
    80000ec8:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000eca:	05b2                	slli	a1,a1,0xc
    80000ecc:	fa2ff0ef          	jal	8000066e <uvmunmap>
  uvmunmap (pagetable, TRAPFRAME, 1, 0);
    80000ed0:	4681                	li	a3,0
    80000ed2:	4605                	li	a2,1
    80000ed4:	020005b7          	lui	a1,0x2000
    80000ed8:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000eda:	05b6                	slli	a1,a1,0xd
    80000edc:	8526                	mv	a0,s1
    80000ede:	f90ff0ef          	jal	8000066e <uvmunmap>
  uvmfree (pagetable, sz);
    80000ee2:	85ca                	mv	a1,s2
    80000ee4:	8526                	mv	a0,s1
    80000ee6:	a13ff0ef          	jal	800008f8 <uvmfree>
}
    80000eea:	60e2                	ld	ra,24(sp)
    80000eec:	6442                	ld	s0,16(sp)
    80000eee:	64a2                	ld	s1,8(sp)
    80000ef0:	6902                	ld	s2,0(sp)
    80000ef2:	6105                	addi	sp,sp,32
    80000ef4:	8082                	ret

0000000080000ef6 <freeproc>:
{
    80000ef6:	1101                	addi	sp,sp,-32
    80000ef8:	ec06                	sd	ra,24(sp)
    80000efa:	e822                	sd	s0,16(sp)
    80000efc:	e426                	sd	s1,8(sp)
    80000efe:	1000                	addi	s0,sp,32
    80000f00:	84aa                	mv	s1,a0
  if (p->trapframe)
    80000f02:	6d28                	ld	a0,88(a0)
    80000f04:	c119                	beqz	a0,80000f0a <freeproc+0x14>
    kfree ((void *)p->trapframe);
    80000f06:	916ff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    80000f0a:	0404bc23          	sd	zero,88(s1)
  if (p->pagetable)
    80000f0e:	68a8                	ld	a0,80(s1)
    80000f10:	c501                	beqz	a0,80000f18 <freeproc+0x22>
    proc_freepagetable (p->pagetable, p->sz);
    80000f12:	64ac                	ld	a1,72(s1)
    80000f14:	f9dff0ef          	jal	80000eb0 <proc_freepagetable>
  p->pagetable = 0;
    80000f18:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f1c:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f20:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f24:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f28:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000f2c:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000f30:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000f34:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000f38:	0004ac23          	sw	zero,24(s1)
}
    80000f3c:	60e2                	ld	ra,24(sp)
    80000f3e:	6442                	ld	s0,16(sp)
    80000f40:	64a2                	ld	s1,8(sp)
    80000f42:	6105                	addi	sp,sp,32
    80000f44:	8082                	ret

0000000080000f46 <allocproc>:
{
    80000f46:	1101                	addi	sp,sp,-32
    80000f48:	ec06                	sd	ra,24(sp)
    80000f4a:	e822                	sd	s0,16(sp)
    80000f4c:	e426                	sd	s1,8(sp)
    80000f4e:	e04a                	sd	s2,0(sp)
    80000f50:	1000                	addi	s0,sp,32
  for (p = proc; p < &proc[NPROC]; p++)
    80000f52:	0000a497          	auipc	s1,0xa
    80000f56:	8ee48493          	addi	s1,s1,-1810 # 8000a840 <proc>
    80000f5a:	0000f917          	auipc	s2,0xf
    80000f5e:	2e690913          	addi	s2,s2,742 # 80010240 <tickslock>
      acquire (&p->lock);
    80000f62:	8526                	mv	a0,s1
    80000f64:	0b9040ef          	jal	8000581c <acquire>
      if (p->state == UNUSED)
    80000f68:	4c9c                	lw	a5,24(s1)
    80000f6a:	cb91                	beqz	a5,80000f7e <allocproc+0x38>
          release (&p->lock);
    80000f6c:	8526                	mv	a0,s1
    80000f6e:	143040ef          	jal	800058b0 <release>
  for (p = proc; p < &proc[NPROC]; p++)
    80000f72:	16848493          	addi	s1,s1,360
    80000f76:	ff2496e3          	bne	s1,s2,80000f62 <allocproc+0x1c>
  return 0;
    80000f7a:	4481                	li	s1,0
    80000f7c:	a089                	j	80000fbe <allocproc+0x78>
  p->pid = allocpid ();
    80000f7e:	e71ff0ef          	jal	80000dee <allocpid>
    80000f82:	d888                	sw	a0,48(s1)
  p->state = USED;
    80000f84:	4785                	li	a5,1
    80000f86:	cc9c                	sw	a5,24(s1)
  if ((p->trapframe = (struct trapframe *)kalloc ()) == 0)
    80000f88:	97cff0ef          	jal	80000104 <kalloc>
    80000f8c:	892a                	mv	s2,a0
    80000f8e:	eca8                	sd	a0,88(s1)
    80000f90:	cd15                	beqz	a0,80000fcc <allocproc+0x86>
  p->pagetable = proc_pagetable (p);
    80000f92:	8526                	mv	a0,s1
    80000f94:	e99ff0ef          	jal	80000e2c <proc_pagetable>
    80000f98:	892a                	mv	s2,a0
    80000f9a:	e8a8                	sd	a0,80(s1)
  if (p->pagetable == 0)
    80000f9c:	c121                	beqz	a0,80000fdc <allocproc+0x96>
  memset (&p->context, 0, sizeof (p->context));
    80000f9e:	07000613          	li	a2,112
    80000fa2:	4581                	li	a1,0
    80000fa4:	06048513          	addi	a0,s1,96
    80000fa8:	9b6ff0ef          	jal	8000015e <memset>
  p->context.ra = (uint64)forkret;
    80000fac:	00000797          	auipc	a5,0x0
    80000fb0:	e0878793          	addi	a5,a5,-504 # 80000db4 <forkret>
    80000fb4:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80000fb6:	60bc                	ld	a5,64(s1)
    80000fb8:	6705                	lui	a4,0x1
    80000fba:	97ba                	add	a5,a5,a4
    80000fbc:	f4bc                	sd	a5,104(s1)
}
    80000fbe:	8526                	mv	a0,s1
    80000fc0:	60e2                	ld	ra,24(sp)
    80000fc2:	6442                	ld	s0,16(sp)
    80000fc4:	64a2                	ld	s1,8(sp)
    80000fc6:	6902                	ld	s2,0(sp)
    80000fc8:	6105                	addi	sp,sp,32
    80000fca:	8082                	ret
      freeproc (p);
    80000fcc:	8526                	mv	a0,s1
    80000fce:	f29ff0ef          	jal	80000ef6 <freeproc>
      release (&p->lock);
    80000fd2:	8526                	mv	a0,s1
    80000fd4:	0dd040ef          	jal	800058b0 <release>
      return 0;
    80000fd8:	84ca                	mv	s1,s2
    80000fda:	b7d5                	j	80000fbe <allocproc+0x78>
      freeproc (p);
    80000fdc:	8526                	mv	a0,s1
    80000fde:	f19ff0ef          	jal	80000ef6 <freeproc>
      release (&p->lock);
    80000fe2:	8526                	mv	a0,s1
    80000fe4:	0cd040ef          	jal	800058b0 <release>
      return 0;
    80000fe8:	84ca                	mv	s1,s2
    80000fea:	bfd1                	j	80000fbe <allocproc+0x78>

0000000080000fec <userinit>:
{
    80000fec:	1101                	addi	sp,sp,-32
    80000fee:	ec06                	sd	ra,24(sp)
    80000ff0:	e822                	sd	s0,16(sp)
    80000ff2:	e426                	sd	s1,8(sp)
    80000ff4:	1000                	addi	s0,sp,32
  p = allocproc ();
    80000ff6:	f51ff0ef          	jal	80000f46 <allocproc>
    80000ffa:	84aa                	mv	s1,a0
  initproc = p;
    80000ffc:	00009797          	auipc	a5,0x9
    80001000:	3ca7ba23          	sd	a0,980(a5) # 8000a3d0 <initproc>
  uvmfirst (p->pagetable, initcode, sizeof (initcode));
    80001004:	03400613          	li	a2,52
    80001008:	00009597          	auipc	a1,0x9
    8000100c:	35858593          	addi	a1,a1,856 # 8000a360 <initcode>
    80001010:	6928                	ld	a0,80(a0)
    80001012:	f3eff0ef          	jal	80000750 <uvmfirst>
  p->sz = PGSIZE;
    80001016:	6785                	lui	a5,0x1
    80001018:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;     // user program counter
    8000101a:	6cb8                	ld	a4,88(s1)
    8000101c:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE; // user stack pointer
    80001020:	6cb8                	ld	a4,88(s1)
    80001022:	fb1c                	sd	a5,48(a4)
  safestrcpy (p->name, "initcode", sizeof (p->name));
    80001024:	4641                	li	a2,16
    80001026:	00006597          	auipc	a1,0x6
    8000102a:	18a58593          	addi	a1,a1,394 # 800071b0 <etext+0x1b0>
    8000102e:	15848513          	addi	a0,s1,344
    80001032:	a80ff0ef          	jal	800002b2 <safestrcpy>
  p->cwd = namei ("/");
    80001036:	00006517          	auipc	a0,0x6
    8000103a:	18a50513          	addi	a0,a0,394 # 800071c0 <etext+0x1c0>
    8000103e:	54f010ef          	jal	80002d8c <namei>
    80001042:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001046:	478d                	li	a5,3
    80001048:	cc9c                	sw	a5,24(s1)
  release (&p->lock);
    8000104a:	8526                	mv	a0,s1
    8000104c:	065040ef          	jal	800058b0 <release>
}
    80001050:	60e2                	ld	ra,24(sp)
    80001052:	6442                	ld	s0,16(sp)
    80001054:	64a2                	ld	s1,8(sp)
    80001056:	6105                	addi	sp,sp,32
    80001058:	8082                	ret

000000008000105a <growproc>:
{
    8000105a:	1101                	addi	sp,sp,-32
    8000105c:	ec06                	sd	ra,24(sp)
    8000105e:	e822                	sd	s0,16(sp)
    80001060:	e426                	sd	s1,8(sp)
    80001062:	e04a                	sd	s2,0(sp)
    80001064:	1000                	addi	s0,sp,32
    80001066:	892a                	mv	s2,a0
  struct proc *p = myproc ();
    80001068:	d1bff0ef          	jal	80000d82 <myproc>
    8000106c:	84aa                	mv	s1,a0
  sz = p->sz;
    8000106e:	652c                	ld	a1,72(a0)
  if (n > 0)
    80001070:	01204c63          	bgtz	s2,80001088 <growproc+0x2e>
  else if (n < 0)
    80001074:	02094463          	bltz	s2,8000109c <growproc+0x42>
  p->sz = sz;
    80001078:	e4ac                	sd	a1,72(s1)
  return 0;
    8000107a:	4501                	li	a0,0
}
    8000107c:	60e2                	ld	ra,24(sp)
    8000107e:	6442                	ld	s0,16(sp)
    80001080:	64a2                	ld	s1,8(sp)
    80001082:	6902                	ld	s2,0(sp)
    80001084:	6105                	addi	sp,sp,32
    80001086:	8082                	ret
      if ((sz = uvmalloc (p->pagetable, sz, sz + n, PTE_W)) == 0)
    80001088:	4691                	li	a3,4
    8000108a:	00b90633          	add	a2,s2,a1
    8000108e:	6928                	ld	a0,80(a0)
    80001090:	f62ff0ef          	jal	800007f2 <uvmalloc>
    80001094:	85aa                	mv	a1,a0
    80001096:	f16d                	bnez	a0,80001078 <growproc+0x1e>
          return -1;
    80001098:	557d                	li	a0,-1
    8000109a:	b7cd                	j	8000107c <growproc+0x22>
      sz = uvmdealloc (p->pagetable, sz, sz + n);
    8000109c:	00b90633          	add	a2,s2,a1
    800010a0:	6928                	ld	a0,80(a0)
    800010a2:	f0cff0ef          	jal	800007ae <uvmdealloc>
    800010a6:	85aa                	mv	a1,a0
    800010a8:	bfc1                	j	80001078 <growproc+0x1e>

00000000800010aa <fork>:
{
    800010aa:	7139                	addi	sp,sp,-64
    800010ac:	fc06                	sd	ra,56(sp)
    800010ae:	f822                	sd	s0,48(sp)
    800010b0:	f426                	sd	s1,40(sp)
    800010b2:	e456                	sd	s5,8(sp)
    800010b4:	0080                	addi	s0,sp,64
  struct proc *p = myproc ();
    800010b6:	ccdff0ef          	jal	80000d82 <myproc>
    800010ba:	8aaa                	mv	s5,a0
  if ((np = allocproc ()) == 0)
    800010bc:	e8bff0ef          	jal	80000f46 <allocproc>
    800010c0:	0e050e63          	beqz	a0,800011bc <fork+0x112>
    800010c4:	ec4e                	sd	s3,24(sp)
    800010c6:	89aa                	mv	s3,a0
  if (uvmcopy (p->pagetable, np->pagetable, p->sz) < 0)
    800010c8:	048ab603          	ld	a2,72(s5)
    800010cc:	692c                	ld	a1,80(a0)
    800010ce:	050ab503          	ld	a0,80(s5)
    800010d2:	859ff0ef          	jal	8000092a <uvmcopy>
    800010d6:	04054c63          	bltz	a0,8000112e <fork+0x84>
    800010da:	f04a                	sd	s2,32(sp)
    800010dc:	e852                	sd	s4,16(sp)
  np->sz = p->sz;
    800010de:	048ab783          	ld	a5,72(s5)
    800010e2:	04f9b423          	sd	a5,72(s3)
  np->mask = p->mask;
    800010e6:	034aa783          	lw	a5,52(s5)
    800010ea:	02f9aa23          	sw	a5,52(s3)
  *(np->trapframe) = *(p->trapframe);
    800010ee:	058ab683          	ld	a3,88(s5)
    800010f2:	87b6                	mv	a5,a3
    800010f4:	0589b703          	ld	a4,88(s3)
    800010f8:	12068693          	addi	a3,a3,288
    800010fc:	6388                	ld	a0,0(a5)
    800010fe:	678c                	ld	a1,8(a5)
    80001100:	6b90                	ld	a2,16(a5)
    80001102:	e308                	sd	a0,0(a4)
    80001104:	e70c                	sd	a1,8(a4)
    80001106:	eb10                	sd	a2,16(a4)
    80001108:	6f90                	ld	a2,24(a5)
    8000110a:	ef10                	sd	a2,24(a4)
    8000110c:	02078793          	addi	a5,a5,32 # 1020 <_entry-0x7fffefe0>
    80001110:	02070713          	addi	a4,a4,32
    80001114:	fed794e3          	bne	a5,a3,800010fc <fork+0x52>
  np->trapframe->a0 = 0;
    80001118:	0589b783          	ld	a5,88(s3)
    8000111c:	0607b823          	sd	zero,112(a5)
  for (i = 0; i < NOFILE; i++)
    80001120:	0d0a8493          	addi	s1,s5,208
    80001124:	0d098913          	addi	s2,s3,208
    80001128:	150a8a13          	addi	s4,s5,336
    8000112c:	a831                	j	80001148 <fork+0x9e>
      freeproc (np);
    8000112e:	854e                	mv	a0,s3
    80001130:	dc7ff0ef          	jal	80000ef6 <freeproc>
      release (&np->lock);
    80001134:	854e                	mv	a0,s3
    80001136:	77a040ef          	jal	800058b0 <release>
      return -1;
    8000113a:	54fd                	li	s1,-1
    8000113c:	69e2                	ld	s3,24(sp)
    8000113e:	a885                	j	800011ae <fork+0x104>
  for (i = 0; i < NOFILE; i++)
    80001140:	04a1                	addi	s1,s1,8
    80001142:	0921                	addi	s2,s2,8
    80001144:	01448963          	beq	s1,s4,80001156 <fork+0xac>
    if (p->ofile[i])
    80001148:	6088                	ld	a0,0(s1)
    8000114a:	d97d                	beqz	a0,80001140 <fork+0x96>
      np->ofile[i] = filedup (p->ofile[i]);
    8000114c:	1ee020ef          	jal	8000333a <filedup>
    80001150:	00a93023          	sd	a0,0(s2)
    80001154:	b7f5                	j	80001140 <fork+0x96>
  np->cwd = idup (p->cwd);
    80001156:	150ab503          	ld	a0,336(s5)
    8000115a:	506010ef          	jal	80002660 <idup>
    8000115e:	14a9b823          	sd	a0,336(s3)
  safestrcpy (np->name, p->name, sizeof (p->name));
    80001162:	4641                	li	a2,16
    80001164:	158a8593          	addi	a1,s5,344
    80001168:	15898513          	addi	a0,s3,344
    8000116c:	946ff0ef          	jal	800002b2 <safestrcpy>
  pid = np->pid;
    80001170:	0309a483          	lw	s1,48(s3)
  release (&np->lock);
    80001174:	854e                	mv	a0,s3
    80001176:	73a040ef          	jal	800058b0 <release>
  acquire (&wait_lock);
    8000117a:	00009517          	auipc	a0,0x9
    8000117e:	2ae50513          	addi	a0,a0,686 # 8000a428 <wait_lock>
    80001182:	69a040ef          	jal	8000581c <acquire>
  np->parent = p;
    80001186:	0359bc23          	sd	s5,56(s3)
  release (&wait_lock);
    8000118a:	00009517          	auipc	a0,0x9
    8000118e:	29e50513          	addi	a0,a0,670 # 8000a428 <wait_lock>
    80001192:	71e040ef          	jal	800058b0 <release>
  acquire (&np->lock);
    80001196:	854e                	mv	a0,s3
    80001198:	684040ef          	jal	8000581c <acquire>
  np->state = RUNNABLE;
    8000119c:	478d                	li	a5,3
    8000119e:	00f9ac23          	sw	a5,24(s3)
  release (&np->lock);
    800011a2:	854e                	mv	a0,s3
    800011a4:	70c040ef          	jal	800058b0 <release>
  return pid;
    800011a8:	7902                	ld	s2,32(sp)
    800011aa:	69e2                	ld	s3,24(sp)
    800011ac:	6a42                	ld	s4,16(sp)
}
    800011ae:	8526                	mv	a0,s1
    800011b0:	70e2                	ld	ra,56(sp)
    800011b2:	7442                	ld	s0,48(sp)
    800011b4:	74a2                	ld	s1,40(sp)
    800011b6:	6aa2                	ld	s5,8(sp)
    800011b8:	6121                	addi	sp,sp,64
    800011ba:	8082                	ret
      return -1;
    800011bc:	54fd                	li	s1,-1
    800011be:	bfc5                	j	800011ae <fork+0x104>

00000000800011c0 <scheduler>:
{
    800011c0:	715d                	addi	sp,sp,-80
    800011c2:	e486                	sd	ra,72(sp)
    800011c4:	e0a2                	sd	s0,64(sp)
    800011c6:	fc26                	sd	s1,56(sp)
    800011c8:	f84a                	sd	s2,48(sp)
    800011ca:	f44e                	sd	s3,40(sp)
    800011cc:	f052                	sd	s4,32(sp)
    800011ce:	ec56                	sd	s5,24(sp)
    800011d0:	e85a                	sd	s6,16(sp)
    800011d2:	e45e                	sd	s7,8(sp)
    800011d4:	e062                	sd	s8,0(sp)
    800011d6:	0880                	addi	s0,sp,80
    800011d8:	8792                	mv	a5,tp
  int id = r_tp ();
    800011da:	2781                	sext.w	a5,a5
  c->proc = 0;
    800011dc:	00779b13          	slli	s6,a5,0x7
    800011e0:	00009717          	auipc	a4,0x9
    800011e4:	23070713          	addi	a4,a4,560 # 8000a410 <pid_lock>
    800011e8:	975a                	add	a4,a4,s6
    800011ea:	02073823          	sd	zero,48(a4)
              swtch (&c->context, &p->context);
    800011ee:	00009717          	auipc	a4,0x9
    800011f2:	25a70713          	addi	a4,a4,602 # 8000a448 <cpus+0x8>
    800011f6:	9b3a                	add	s6,s6,a4
              p->state = RUNNING;
    800011f8:	4c11                	li	s8,4
              c->proc = p;
    800011fa:	079e                	slli	a5,a5,0x7
    800011fc:	00009a17          	auipc	s4,0x9
    80001200:	214a0a13          	addi	s4,s4,532 # 8000a410 <pid_lock>
    80001204:	9a3e                	add	s4,s4,a5
              found = 1;
    80001206:	4b85                	li	s7,1
    80001208:	a0a9                	j	80001252 <scheduler+0x92>
          release (&p->lock);
    8000120a:	8526                	mv	a0,s1
    8000120c:	6a4040ef          	jal	800058b0 <release>
      for (p = proc; p < &proc[NPROC]; p++)
    80001210:	16848493          	addi	s1,s1,360
    80001214:	03248563          	beq	s1,s2,8000123e <scheduler+0x7e>
          acquire (&p->lock);
    80001218:	8526                	mv	a0,s1
    8000121a:	602040ef          	jal	8000581c <acquire>
          if (p->state == RUNNABLE)
    8000121e:	4c9c                	lw	a5,24(s1)
    80001220:	ff3795e3          	bne	a5,s3,8000120a <scheduler+0x4a>
              p->state = RUNNING;
    80001224:	0184ac23          	sw	s8,24(s1)
              c->proc = p;
    80001228:	029a3823          	sd	s1,48(s4)
              swtch (&c->context, &p->context);
    8000122c:	06048593          	addi	a1,s1,96
    80001230:	855a                	mv	a0,s6
    80001232:	5bc000ef          	jal	800017ee <swtch>
              c->proc = 0;
    80001236:	020a3823          	sd	zero,48(s4)
              found = 1;
    8000123a:	8ade                	mv	s5,s7
    8000123c:	b7f9                	j	8000120a <scheduler+0x4a>
      if (found == 0)
    8000123e:	000a9a63          	bnez	s5,80001252 <scheduler+0x92>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001242:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001246:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000124a:	10079073          	csrw	sstatus,a5
          asm volatile ("wfi");
    8000124e:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001252:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001256:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000125a:	10079073          	csrw	sstatus,a5
      int found = 0;
    8000125e:	4a81                	li	s5,0
      for (p = proc; p < &proc[NPROC]; p++)
    80001260:	00009497          	auipc	s1,0x9
    80001264:	5e048493          	addi	s1,s1,1504 # 8000a840 <proc>
          if (p->state == RUNNABLE)
    80001268:	498d                	li	s3,3
      for (p = proc; p < &proc[NPROC]; p++)
    8000126a:	0000f917          	auipc	s2,0xf
    8000126e:	fd690913          	addi	s2,s2,-42 # 80010240 <tickslock>
    80001272:	b75d                	j	80001218 <scheduler+0x58>

0000000080001274 <sched>:
{
    80001274:	7179                	addi	sp,sp,-48
    80001276:	f406                	sd	ra,40(sp)
    80001278:	f022                	sd	s0,32(sp)
    8000127a:	ec26                	sd	s1,24(sp)
    8000127c:	e84a                	sd	s2,16(sp)
    8000127e:	e44e                	sd	s3,8(sp)
    80001280:	1800                	addi	s0,sp,48
  struct proc *p = myproc ();
    80001282:	b01ff0ef          	jal	80000d82 <myproc>
    80001286:	84aa                	mv	s1,a0
  if (!holding (&p->lock))
    80001288:	524040ef          	jal	800057ac <holding>
    8000128c:	c935                	beqz	a0,80001300 <sched+0x8c>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000128e:	8792                	mv	a5,tp
  if (mycpu ()->noff != 1)
    80001290:	2781                	sext.w	a5,a5
    80001292:	079e                	slli	a5,a5,0x7
    80001294:	00009717          	auipc	a4,0x9
    80001298:	17c70713          	addi	a4,a4,380 # 8000a410 <pid_lock>
    8000129c:	97ba                	add	a5,a5,a4
    8000129e:	0a87a703          	lw	a4,168(a5)
    800012a2:	4785                	li	a5,1
    800012a4:	06f71463          	bne	a4,a5,8000130c <sched+0x98>
  if (p->state == RUNNING)
    800012a8:	4c98                	lw	a4,24(s1)
    800012aa:	4791                	li	a5,4
    800012ac:	06f70663          	beq	a4,a5,80001318 <sched+0xa4>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800012b0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800012b4:	8b89                	andi	a5,a5,2
  if (intr_get ())
    800012b6:	e7bd                	bnez	a5,80001324 <sched+0xb0>
  asm volatile("mv %0, tp" : "=r" (x) );
    800012b8:	8792                	mv	a5,tp
  intena = mycpu ()->intena;
    800012ba:	00009917          	auipc	s2,0x9
    800012be:	15690913          	addi	s2,s2,342 # 8000a410 <pid_lock>
    800012c2:	2781                	sext.w	a5,a5
    800012c4:	079e                	slli	a5,a5,0x7
    800012c6:	97ca                	add	a5,a5,s2
    800012c8:	0ac7a983          	lw	s3,172(a5)
    800012cc:	8792                	mv	a5,tp
  swtch (&p->context, &mycpu ()->context);
    800012ce:	2781                	sext.w	a5,a5
    800012d0:	079e                	slli	a5,a5,0x7
    800012d2:	07a1                	addi	a5,a5,8
    800012d4:	00009597          	auipc	a1,0x9
    800012d8:	16c58593          	addi	a1,a1,364 # 8000a440 <cpus>
    800012dc:	95be                	add	a1,a1,a5
    800012de:	06048513          	addi	a0,s1,96
    800012e2:	50c000ef          	jal	800017ee <swtch>
    800012e6:	8792                	mv	a5,tp
  mycpu ()->intena = intena;
    800012e8:	2781                	sext.w	a5,a5
    800012ea:	079e                	slli	a5,a5,0x7
    800012ec:	993e                	add	s2,s2,a5
    800012ee:	0b392623          	sw	s3,172(s2)
}
    800012f2:	70a2                	ld	ra,40(sp)
    800012f4:	7402                	ld	s0,32(sp)
    800012f6:	64e2                	ld	s1,24(sp)
    800012f8:	6942                	ld	s2,16(sp)
    800012fa:	69a2                	ld	s3,8(sp)
    800012fc:	6145                	addi	sp,sp,48
    800012fe:	8082                	ret
    panic ("sched p->lock");
    80001300:	00006517          	auipc	a0,0x6
    80001304:	ec850513          	addi	a0,a0,-312 # 800071c8 <etext+0x1c8>
    80001308:	1d6040ef          	jal	800054de <panic>
    panic ("sched locks");
    8000130c:	00006517          	auipc	a0,0x6
    80001310:	ecc50513          	addi	a0,a0,-308 # 800071d8 <etext+0x1d8>
    80001314:	1ca040ef          	jal	800054de <panic>
    panic ("sched running");
    80001318:	00006517          	auipc	a0,0x6
    8000131c:	ed050513          	addi	a0,a0,-304 # 800071e8 <etext+0x1e8>
    80001320:	1be040ef          	jal	800054de <panic>
    panic ("sched interruptible");
    80001324:	00006517          	auipc	a0,0x6
    80001328:	ed450513          	addi	a0,a0,-300 # 800071f8 <etext+0x1f8>
    8000132c:	1b2040ef          	jal	800054de <panic>

0000000080001330 <yield>:
{
    80001330:	1101                	addi	sp,sp,-32
    80001332:	ec06                	sd	ra,24(sp)
    80001334:	e822                	sd	s0,16(sp)
    80001336:	e426                	sd	s1,8(sp)
    80001338:	1000                	addi	s0,sp,32
  struct proc *p = myproc ();
    8000133a:	a49ff0ef          	jal	80000d82 <myproc>
    8000133e:	84aa                	mv	s1,a0
  acquire (&p->lock);
    80001340:	4dc040ef          	jal	8000581c <acquire>
  p->state = RUNNABLE;
    80001344:	478d                	li	a5,3
    80001346:	cc9c                	sw	a5,24(s1)
  sched ();
    80001348:	f2dff0ef          	jal	80001274 <sched>
  release (&p->lock);
    8000134c:	8526                	mv	a0,s1
    8000134e:	562040ef          	jal	800058b0 <release>
}
    80001352:	60e2                	ld	ra,24(sp)
    80001354:	6442                	ld	s0,16(sp)
    80001356:	64a2                	ld	s1,8(sp)
    80001358:	6105                	addi	sp,sp,32
    8000135a:	8082                	ret

000000008000135c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep (void *chan, struct spinlock *lk)
{
    8000135c:	7179                	addi	sp,sp,-48
    8000135e:	f406                	sd	ra,40(sp)
    80001360:	f022                	sd	s0,32(sp)
    80001362:	ec26                	sd	s1,24(sp)
    80001364:	e84a                	sd	s2,16(sp)
    80001366:	e44e                	sd	s3,8(sp)
    80001368:	1800                	addi	s0,sp,48
    8000136a:	89aa                	mv	s3,a0
    8000136c:	892e                	mv	s2,a1
  struct proc *p = myproc ();
    8000136e:	a15ff0ef          	jal	80000d82 <myproc>
    80001372:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire (&p->lock); // DOC: sleeplock1
    80001374:	4a8040ef          	jal	8000581c <acquire>
  release (lk);
    80001378:	854a                	mv	a0,s2
    8000137a:	536040ef          	jal	800058b0 <release>

  // Go to sleep.
  p->chan = chan;
    8000137e:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001382:	4789                	li	a5,2
    80001384:	cc9c                	sw	a5,24(s1)

  sched ();
    80001386:	eefff0ef          	jal	80001274 <sched>

  // Tidy up.
  p->chan = 0;
    8000138a:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release (&p->lock);
    8000138e:	8526                	mv	a0,s1
    80001390:	520040ef          	jal	800058b0 <release>
  acquire (lk);
    80001394:	854a                	mv	a0,s2
    80001396:	486040ef          	jal	8000581c <acquire>
}
    8000139a:	70a2                	ld	ra,40(sp)
    8000139c:	7402                	ld	s0,32(sp)
    8000139e:	64e2                	ld	s1,24(sp)
    800013a0:	6942                	ld	s2,16(sp)
    800013a2:	69a2                	ld	s3,8(sp)
    800013a4:	6145                	addi	sp,sp,48
    800013a6:	8082                	ret

00000000800013a8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup (void *chan)
{
    800013a8:	7139                	addi	sp,sp,-64
    800013aa:	fc06                	sd	ra,56(sp)
    800013ac:	f822                	sd	s0,48(sp)
    800013ae:	f426                	sd	s1,40(sp)
    800013b0:	f04a                	sd	s2,32(sp)
    800013b2:	ec4e                	sd	s3,24(sp)
    800013b4:	e852                	sd	s4,16(sp)
    800013b6:	e456                	sd	s5,8(sp)
    800013b8:	0080                	addi	s0,sp,64
    800013ba:	8a2a                	mv	s4,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    800013bc:	00009497          	auipc	s1,0x9
    800013c0:	48448493          	addi	s1,s1,1156 # 8000a840 <proc>
    {
      if (p != myproc ())
        {
          acquire (&p->lock);
          if (p->state == SLEEPING && p->chan == chan)
    800013c4:	4989                	li	s3,2
            {
              p->state = RUNNABLE;
    800013c6:	4a8d                	li	s5,3
  for (p = proc; p < &proc[NPROC]; p++)
    800013c8:	0000f917          	auipc	s2,0xf
    800013cc:	e7890913          	addi	s2,s2,-392 # 80010240 <tickslock>
    800013d0:	a801                	j	800013e0 <wakeup+0x38>
            }
          release (&p->lock);
    800013d2:	8526                	mv	a0,s1
    800013d4:	4dc040ef          	jal	800058b0 <release>
  for (p = proc; p < &proc[NPROC]; p++)
    800013d8:	16848493          	addi	s1,s1,360
    800013dc:	03248263          	beq	s1,s2,80001400 <wakeup+0x58>
      if (p != myproc ())
    800013e0:	9a3ff0ef          	jal	80000d82 <myproc>
    800013e4:	fe950ae3          	beq	a0,s1,800013d8 <wakeup+0x30>
          acquire (&p->lock);
    800013e8:	8526                	mv	a0,s1
    800013ea:	432040ef          	jal	8000581c <acquire>
          if (p->state == SLEEPING && p->chan == chan)
    800013ee:	4c9c                	lw	a5,24(s1)
    800013f0:	ff3791e3          	bne	a5,s3,800013d2 <wakeup+0x2a>
    800013f4:	709c                	ld	a5,32(s1)
    800013f6:	fd479ee3          	bne	a5,s4,800013d2 <wakeup+0x2a>
              p->state = RUNNABLE;
    800013fa:	0154ac23          	sw	s5,24(s1)
    800013fe:	bfd1                	j	800013d2 <wakeup+0x2a>
        }
    }
}
    80001400:	70e2                	ld	ra,56(sp)
    80001402:	7442                	ld	s0,48(sp)
    80001404:	74a2                	ld	s1,40(sp)
    80001406:	7902                	ld	s2,32(sp)
    80001408:	69e2                	ld	s3,24(sp)
    8000140a:	6a42                	ld	s4,16(sp)
    8000140c:	6aa2                	ld	s5,8(sp)
    8000140e:	6121                	addi	sp,sp,64
    80001410:	8082                	ret

0000000080001412 <reparent>:
{
    80001412:	7179                	addi	sp,sp,-48
    80001414:	f406                	sd	ra,40(sp)
    80001416:	f022                	sd	s0,32(sp)
    80001418:	ec26                	sd	s1,24(sp)
    8000141a:	e84a                	sd	s2,16(sp)
    8000141c:	e44e                	sd	s3,8(sp)
    8000141e:	e052                	sd	s4,0(sp)
    80001420:	1800                	addi	s0,sp,48
    80001422:	892a                	mv	s2,a0
  for (pp = proc; pp < &proc[NPROC]; pp++)
    80001424:	00009497          	auipc	s1,0x9
    80001428:	41c48493          	addi	s1,s1,1052 # 8000a840 <proc>
          pp->parent = initproc;
    8000142c:	00009a17          	auipc	s4,0x9
    80001430:	fa4a0a13          	addi	s4,s4,-92 # 8000a3d0 <initproc>
  for (pp = proc; pp < &proc[NPROC]; pp++)
    80001434:	0000f997          	auipc	s3,0xf
    80001438:	e0c98993          	addi	s3,s3,-500 # 80010240 <tickslock>
    8000143c:	a029                	j	80001446 <reparent+0x34>
    8000143e:	16848493          	addi	s1,s1,360
    80001442:	01348b63          	beq	s1,s3,80001458 <reparent+0x46>
      if (pp->parent == p)
    80001446:	7c9c                	ld	a5,56(s1)
    80001448:	ff279be3          	bne	a5,s2,8000143e <reparent+0x2c>
          pp->parent = initproc;
    8000144c:	000a3503          	ld	a0,0(s4)
    80001450:	fc88                	sd	a0,56(s1)
          wakeup (initproc);
    80001452:	f57ff0ef          	jal	800013a8 <wakeup>
    80001456:	b7e5                	j	8000143e <reparent+0x2c>
}
    80001458:	70a2                	ld	ra,40(sp)
    8000145a:	7402                	ld	s0,32(sp)
    8000145c:	64e2                	ld	s1,24(sp)
    8000145e:	6942                	ld	s2,16(sp)
    80001460:	69a2                	ld	s3,8(sp)
    80001462:	6a02                	ld	s4,0(sp)
    80001464:	6145                	addi	sp,sp,48
    80001466:	8082                	ret

0000000080001468 <exit>:
{
    80001468:	7179                	addi	sp,sp,-48
    8000146a:	f406                	sd	ra,40(sp)
    8000146c:	f022                	sd	s0,32(sp)
    8000146e:	ec26                	sd	s1,24(sp)
    80001470:	e84a                	sd	s2,16(sp)
    80001472:	e44e                	sd	s3,8(sp)
    80001474:	e052                	sd	s4,0(sp)
    80001476:	1800                	addi	s0,sp,48
    80001478:	8a2a                	mv	s4,a0
  struct proc *p = myproc ();
    8000147a:	909ff0ef          	jal	80000d82 <myproc>
    8000147e:	89aa                	mv	s3,a0
  if (p == initproc)
    80001480:	00009797          	auipc	a5,0x9
    80001484:	f507b783          	ld	a5,-176(a5) # 8000a3d0 <initproc>
    80001488:	0d050493          	addi	s1,a0,208
    8000148c:	15050913          	addi	s2,a0,336
    80001490:	00a79b63          	bne	a5,a0,800014a6 <exit+0x3e>
    panic ("init exiting");
    80001494:	00006517          	auipc	a0,0x6
    80001498:	d7c50513          	addi	a0,a0,-644 # 80007210 <etext+0x210>
    8000149c:	042040ef          	jal	800054de <panic>
  for (int fd = 0; fd < NOFILE; fd++)
    800014a0:	04a1                	addi	s1,s1,8
    800014a2:	01248963          	beq	s1,s2,800014b4 <exit+0x4c>
      if (p->ofile[fd])
    800014a6:	6088                	ld	a0,0(s1)
    800014a8:	dd65                	beqz	a0,800014a0 <exit+0x38>
          fileclose (f);
    800014aa:	6d7010ef          	jal	80003380 <fileclose>
          p->ofile[fd] = 0;
    800014ae:	0004b023          	sd	zero,0(s1)
    800014b2:	b7fd                	j	800014a0 <exit+0x38>
  begin_op ();
    800014b4:	29b010ef          	jal	80002f4e <begin_op>
  iput (p->cwd);
    800014b8:	1509b503          	ld	a0,336(s3)
    800014bc:	35c010ef          	jal	80002818 <iput>
  end_op ();
    800014c0:	2ff010ef          	jal	80002fbe <end_op>
  p->cwd = 0;
    800014c4:	1409b823          	sd	zero,336(s3)
  acquire (&wait_lock);
    800014c8:	00009517          	auipc	a0,0x9
    800014cc:	f6050513          	addi	a0,a0,-160 # 8000a428 <wait_lock>
    800014d0:	34c040ef          	jal	8000581c <acquire>
  reparent (p);
    800014d4:	854e                	mv	a0,s3
    800014d6:	f3dff0ef          	jal	80001412 <reparent>
  wakeup (p->parent);
    800014da:	0389b503          	ld	a0,56(s3)
    800014de:	ecbff0ef          	jal	800013a8 <wakeup>
  acquire (&p->lock);
    800014e2:	854e                	mv	a0,s3
    800014e4:	338040ef          	jal	8000581c <acquire>
  p->xstate = status;
    800014e8:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800014ec:	4795                	li	a5,5
    800014ee:	00f9ac23          	sw	a5,24(s3)
  release (&wait_lock);
    800014f2:	00009517          	auipc	a0,0x9
    800014f6:	f3650513          	addi	a0,a0,-202 # 8000a428 <wait_lock>
    800014fa:	3b6040ef          	jal	800058b0 <release>
  sched ();
    800014fe:	d77ff0ef          	jal	80001274 <sched>
  panic ("zombie exit");
    80001502:	00006517          	auipc	a0,0x6
    80001506:	d1e50513          	addi	a0,a0,-738 # 80007220 <etext+0x220>
    8000150a:	7d5030ef          	jal	800054de <panic>

000000008000150e <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill (int pid)
{
    8000150e:	7179                	addi	sp,sp,-48
    80001510:	f406                	sd	ra,40(sp)
    80001512:	f022                	sd	s0,32(sp)
    80001514:	ec26                	sd	s1,24(sp)
    80001516:	e84a                	sd	s2,16(sp)
    80001518:	e44e                	sd	s3,8(sp)
    8000151a:	1800                	addi	s0,sp,48
    8000151c:	892a                	mv	s2,a0
  struct proc *p;

  for (p = proc; p < &proc[NPROC]; p++)
    8000151e:	00009497          	auipc	s1,0x9
    80001522:	32248493          	addi	s1,s1,802 # 8000a840 <proc>
    80001526:	0000f997          	auipc	s3,0xf
    8000152a:	d1a98993          	addi	s3,s3,-742 # 80010240 <tickslock>
    {
      acquire (&p->lock);
    8000152e:	8526                	mv	a0,s1
    80001530:	2ec040ef          	jal	8000581c <acquire>
      if (p->pid == pid)
    80001534:	589c                	lw	a5,48(s1)
    80001536:	01278b63          	beq	a5,s2,8000154c <kill+0x3e>
              p->state = RUNNABLE;
            }
          release (&p->lock);
          return 0;
        }
      release (&p->lock);
    8000153a:	8526                	mv	a0,s1
    8000153c:	374040ef          	jal	800058b0 <release>
  for (p = proc; p < &proc[NPROC]; p++)
    80001540:	16848493          	addi	s1,s1,360
    80001544:	ff3495e3          	bne	s1,s3,8000152e <kill+0x20>
    }
  return -1;
    80001548:	557d                	li	a0,-1
    8000154a:	a819                	j	80001560 <kill+0x52>
          p->killed = 1;
    8000154c:	4785                	li	a5,1
    8000154e:	d49c                	sw	a5,40(s1)
          if (p->state == SLEEPING)
    80001550:	4c98                	lw	a4,24(s1)
    80001552:	4789                	li	a5,2
    80001554:	00f70d63          	beq	a4,a5,8000156e <kill+0x60>
          release (&p->lock);
    80001558:	8526                	mv	a0,s1
    8000155a:	356040ef          	jal	800058b0 <release>
          return 0;
    8000155e:	4501                	li	a0,0
}
    80001560:	70a2                	ld	ra,40(sp)
    80001562:	7402                	ld	s0,32(sp)
    80001564:	64e2                	ld	s1,24(sp)
    80001566:	6942                	ld	s2,16(sp)
    80001568:	69a2                	ld	s3,8(sp)
    8000156a:	6145                	addi	sp,sp,48
    8000156c:	8082                	ret
              p->state = RUNNABLE;
    8000156e:	478d                	li	a5,3
    80001570:	cc9c                	sw	a5,24(s1)
    80001572:	b7dd                	j	80001558 <kill+0x4a>

0000000080001574 <setkilled>:

void
setkilled (struct proc *p)
{
    80001574:	1101                	addi	sp,sp,-32
    80001576:	ec06                	sd	ra,24(sp)
    80001578:	e822                	sd	s0,16(sp)
    8000157a:	e426                	sd	s1,8(sp)
    8000157c:	1000                	addi	s0,sp,32
    8000157e:	84aa                	mv	s1,a0
  acquire (&p->lock);
    80001580:	29c040ef          	jal	8000581c <acquire>
  p->killed = 1;
    80001584:	4785                	li	a5,1
    80001586:	d49c                	sw	a5,40(s1)
  release (&p->lock);
    80001588:	8526                	mv	a0,s1
    8000158a:	326040ef          	jal	800058b0 <release>
}
    8000158e:	60e2                	ld	ra,24(sp)
    80001590:	6442                	ld	s0,16(sp)
    80001592:	64a2                	ld	s1,8(sp)
    80001594:	6105                	addi	sp,sp,32
    80001596:	8082                	ret

0000000080001598 <killed>:

int
killed (struct proc *p)
{
    80001598:	1101                	addi	sp,sp,-32
    8000159a:	ec06                	sd	ra,24(sp)
    8000159c:	e822                	sd	s0,16(sp)
    8000159e:	e426                	sd	s1,8(sp)
    800015a0:	e04a                	sd	s2,0(sp)
    800015a2:	1000                	addi	s0,sp,32
    800015a4:	84aa                	mv	s1,a0
  int k;

  acquire (&p->lock);
    800015a6:	276040ef          	jal	8000581c <acquire>
  k = p->killed;
    800015aa:	549c                	lw	a5,40(s1)
    800015ac:	893e                	mv	s2,a5
  release (&p->lock);
    800015ae:	8526                	mv	a0,s1
    800015b0:	300040ef          	jal	800058b0 <release>
  return k;
}
    800015b4:	854a                	mv	a0,s2
    800015b6:	60e2                	ld	ra,24(sp)
    800015b8:	6442                	ld	s0,16(sp)
    800015ba:	64a2                	ld	s1,8(sp)
    800015bc:	6902                	ld	s2,0(sp)
    800015be:	6105                	addi	sp,sp,32
    800015c0:	8082                	ret

00000000800015c2 <wait>:
{
    800015c2:	715d                	addi	sp,sp,-80
    800015c4:	e486                	sd	ra,72(sp)
    800015c6:	e0a2                	sd	s0,64(sp)
    800015c8:	fc26                	sd	s1,56(sp)
    800015ca:	f84a                	sd	s2,48(sp)
    800015cc:	f44e                	sd	s3,40(sp)
    800015ce:	f052                	sd	s4,32(sp)
    800015d0:	ec56                	sd	s5,24(sp)
    800015d2:	e85a                	sd	s6,16(sp)
    800015d4:	e45e                	sd	s7,8(sp)
    800015d6:	0880                	addi	s0,sp,80
    800015d8:	8baa                	mv	s7,a0
  struct proc *p = myproc ();
    800015da:	fa8ff0ef          	jal	80000d82 <myproc>
    800015de:	892a                	mv	s2,a0
  acquire (&wait_lock);
    800015e0:	00009517          	auipc	a0,0x9
    800015e4:	e4850513          	addi	a0,a0,-440 # 8000a428 <wait_lock>
    800015e8:	234040ef          	jal	8000581c <acquire>
              if (pp->state == ZOMBIE)
    800015ec:	4a15                	li	s4,5
              havekids = 1;
    800015ee:	4a85                	li	s5,1
      for (pp = proc; pp < &proc[NPROC]; pp++)
    800015f0:	0000f997          	auipc	s3,0xf
    800015f4:	c5098993          	addi	s3,s3,-944 # 80010240 <tickslock>
      sleep (p, &wait_lock); // DOC: wait-sleep
    800015f8:	00009b17          	auipc	s6,0x9
    800015fc:	e30b0b13          	addi	s6,s6,-464 # 8000a428 <wait_lock>
    80001600:	a869                	j	8000169a <wait+0xd8>
                  pid = pp->pid;
    80001602:	0304a983          	lw	s3,48(s1)
                  if (addr != 0
    80001606:	000b8c63          	beqz	s7,8000161e <wait+0x5c>
                      && copyout (p->pagetable, addr, (char *)&pp->xstate,
    8000160a:	4691                	li	a3,4
    8000160c:	02c48613          	addi	a2,s1,44
    80001610:	85de                	mv	a1,s7
    80001612:	05093503          	ld	a0,80(s2)
    80001616:	becff0ef          	jal	80000a02 <copyout>
    8000161a:	02054a63          	bltz	a0,8000164e <wait+0x8c>
                  freeproc (pp);
    8000161e:	8526                	mv	a0,s1
    80001620:	8d7ff0ef          	jal	80000ef6 <freeproc>
                  release (&pp->lock);
    80001624:	8526                	mv	a0,s1
    80001626:	28a040ef          	jal	800058b0 <release>
                  release (&wait_lock);
    8000162a:	00009517          	auipc	a0,0x9
    8000162e:	dfe50513          	addi	a0,a0,-514 # 8000a428 <wait_lock>
    80001632:	27e040ef          	jal	800058b0 <release>
}
    80001636:	854e                	mv	a0,s3
    80001638:	60a6                	ld	ra,72(sp)
    8000163a:	6406                	ld	s0,64(sp)
    8000163c:	74e2                	ld	s1,56(sp)
    8000163e:	7942                	ld	s2,48(sp)
    80001640:	79a2                	ld	s3,40(sp)
    80001642:	7a02                	ld	s4,32(sp)
    80001644:	6ae2                	ld	s5,24(sp)
    80001646:	6b42                	ld	s6,16(sp)
    80001648:	6ba2                	ld	s7,8(sp)
    8000164a:	6161                	addi	sp,sp,80
    8000164c:	8082                	ret
                      release (&pp->lock);
    8000164e:	8526                	mv	a0,s1
    80001650:	260040ef          	jal	800058b0 <release>
                      release (&wait_lock);
    80001654:	00009517          	auipc	a0,0x9
    80001658:	dd450513          	addi	a0,a0,-556 # 8000a428 <wait_lock>
    8000165c:	254040ef          	jal	800058b0 <release>
                      return -1;
    80001660:	59fd                	li	s3,-1
    80001662:	bfd1                	j	80001636 <wait+0x74>
      for (pp = proc; pp < &proc[NPROC]; pp++)
    80001664:	16848493          	addi	s1,s1,360
    80001668:	03348063          	beq	s1,s3,80001688 <wait+0xc6>
          if (pp->parent == p)
    8000166c:	7c9c                	ld	a5,56(s1)
    8000166e:	ff279be3          	bne	a5,s2,80001664 <wait+0xa2>
              acquire (&pp->lock);
    80001672:	8526                	mv	a0,s1
    80001674:	1a8040ef          	jal	8000581c <acquire>
              if (pp->state == ZOMBIE)
    80001678:	4c9c                	lw	a5,24(s1)
    8000167a:	f94784e3          	beq	a5,s4,80001602 <wait+0x40>
              release (&pp->lock);
    8000167e:	8526                	mv	a0,s1
    80001680:	230040ef          	jal	800058b0 <release>
              havekids = 1;
    80001684:	8756                	mv	a4,s5
    80001686:	bff9                	j	80001664 <wait+0xa2>
      if (!havekids || killed (p))
    80001688:	cf19                	beqz	a4,800016a6 <wait+0xe4>
    8000168a:	854a                	mv	a0,s2
    8000168c:	f0dff0ef          	jal	80001598 <killed>
    80001690:	e919                	bnez	a0,800016a6 <wait+0xe4>
      sleep (p, &wait_lock); // DOC: wait-sleep
    80001692:	85da                	mv	a1,s6
    80001694:	854a                	mv	a0,s2
    80001696:	cc7ff0ef          	jal	8000135c <sleep>
      havekids = 0;
    8000169a:	4701                	li	a4,0
      for (pp = proc; pp < &proc[NPROC]; pp++)
    8000169c:	00009497          	auipc	s1,0x9
    800016a0:	1a448493          	addi	s1,s1,420 # 8000a840 <proc>
    800016a4:	b7e1                	j	8000166c <wait+0xaa>
          release (&wait_lock);
    800016a6:	00009517          	auipc	a0,0x9
    800016aa:	d8250513          	addi	a0,a0,-638 # 8000a428 <wait_lock>
    800016ae:	202040ef          	jal	800058b0 <release>
          return -1;
    800016b2:	59fd                	li	s3,-1
    800016b4:	b749                	j	80001636 <wait+0x74>

00000000800016b6 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout (int user_dst, uint64 dst, void *src, uint64 len)
{
    800016b6:	7179                	addi	sp,sp,-48
    800016b8:	f406                	sd	ra,40(sp)
    800016ba:	f022                	sd	s0,32(sp)
    800016bc:	ec26                	sd	s1,24(sp)
    800016be:	e84a                	sd	s2,16(sp)
    800016c0:	e44e                	sd	s3,8(sp)
    800016c2:	e052                	sd	s4,0(sp)
    800016c4:	1800                	addi	s0,sp,48
    800016c6:	84aa                	mv	s1,a0
    800016c8:	8a2e                	mv	s4,a1
    800016ca:	89b2                	mv	s3,a2
    800016cc:	8936                	mv	s2,a3
  struct proc *p = myproc ();
    800016ce:	eb4ff0ef          	jal	80000d82 <myproc>
  if (user_dst)
    800016d2:	cc99                	beqz	s1,800016f0 <either_copyout+0x3a>
    {
      return copyout (p->pagetable, dst, src, len);
    800016d4:	86ca                	mv	a3,s2
    800016d6:	864e                	mv	a2,s3
    800016d8:	85d2                	mv	a1,s4
    800016da:	6928                	ld	a0,80(a0)
    800016dc:	b26ff0ef          	jal	80000a02 <copyout>
  else
    {
      memmove ((char *)dst, src, len);
      return 0;
    }
}
    800016e0:	70a2                	ld	ra,40(sp)
    800016e2:	7402                	ld	s0,32(sp)
    800016e4:	64e2                	ld	s1,24(sp)
    800016e6:	6942                	ld	s2,16(sp)
    800016e8:	69a2                	ld	s3,8(sp)
    800016ea:	6a02                	ld	s4,0(sp)
    800016ec:	6145                	addi	sp,sp,48
    800016ee:	8082                	ret
      memmove ((char *)dst, src, len);
    800016f0:	0009061b          	sext.w	a2,s2
    800016f4:	85ce                	mv	a1,s3
    800016f6:	8552                	mv	a0,s4
    800016f8:	ac7fe0ef          	jal	800001be <memmove>
      return 0;
    800016fc:	8526                	mv	a0,s1
    800016fe:	b7cd                	j	800016e0 <either_copyout+0x2a>

0000000080001700 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin (void *dst, int user_src, uint64 src, uint64 len)
{
    80001700:	7179                	addi	sp,sp,-48
    80001702:	f406                	sd	ra,40(sp)
    80001704:	f022                	sd	s0,32(sp)
    80001706:	ec26                	sd	s1,24(sp)
    80001708:	e84a                	sd	s2,16(sp)
    8000170a:	e44e                	sd	s3,8(sp)
    8000170c:	e052                	sd	s4,0(sp)
    8000170e:	1800                	addi	s0,sp,48
    80001710:	8a2a                	mv	s4,a0
    80001712:	84ae                	mv	s1,a1
    80001714:	89b2                	mv	s3,a2
    80001716:	8936                	mv	s2,a3
  struct proc *p = myproc ();
    80001718:	e6aff0ef          	jal	80000d82 <myproc>
  if (user_src)
    8000171c:	cc99                	beqz	s1,8000173a <either_copyin+0x3a>
    {
      return copyin (p->pagetable, dst, src, len);
    8000171e:	86ca                	mv	a3,s2
    80001720:	864e                	mv	a2,s3
    80001722:	85d2                	mv	a1,s4
    80001724:	6928                	ld	a0,80(a0)
    80001726:	b8cff0ef          	jal	80000ab2 <copyin>
  else
    {
      memmove (dst, (char *)src, len);
      return 0;
    }
}
    8000172a:	70a2                	ld	ra,40(sp)
    8000172c:	7402                	ld	s0,32(sp)
    8000172e:	64e2                	ld	s1,24(sp)
    80001730:	6942                	ld	s2,16(sp)
    80001732:	69a2                	ld	s3,8(sp)
    80001734:	6a02                	ld	s4,0(sp)
    80001736:	6145                	addi	sp,sp,48
    80001738:	8082                	ret
      memmove (dst, (char *)src, len);
    8000173a:	0009061b          	sext.w	a2,s2
    8000173e:	85ce                	mv	a1,s3
    80001740:	8552                	mv	a0,s4
    80001742:	a7dfe0ef          	jal	800001be <memmove>
      return 0;
    80001746:	8526                	mv	a0,s1
    80001748:	b7cd                	j	8000172a <either_copyin+0x2a>

000000008000174a <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump (void)
{
    8000174a:	715d                	addi	sp,sp,-80
    8000174c:	e486                	sd	ra,72(sp)
    8000174e:	e0a2                	sd	s0,64(sp)
    80001750:	fc26                	sd	s1,56(sp)
    80001752:	f84a                	sd	s2,48(sp)
    80001754:	f44e                	sd	s3,40(sp)
    80001756:	f052                	sd	s4,32(sp)
    80001758:	ec56                	sd	s5,24(sp)
    8000175a:	e85a                	sd	s6,16(sp)
    8000175c:	e45e                	sd	s7,8(sp)
    8000175e:	0880                	addi	s0,sp,80
      = { [UNUSED] "unused",   [USED] "used",      [SLEEPING] "sleep ",
          [RUNNABLE] "runble", [RUNNING] "run   ", [ZOMBIE] "zombie" };
  struct proc *p;
  char *state;

  printf ("\n");
    80001760:	00006517          	auipc	a0,0x6
    80001764:	8d850513          	addi	a0,a0,-1832 # 80007038 <etext+0x38>
    80001768:	267030ef          	jal	800051ce <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    8000176c:	00009497          	auipc	s1,0x9
    80001770:	22c48493          	addi	s1,s1,556 # 8000a998 <proc+0x158>
    80001774:	0000f917          	auipc	s2,0xf
    80001778:	c2490913          	addi	s2,s2,-988 # 80010398 <bcache+0x140>
    {
      if (p->state == UNUSED)
        continue;
      if (p->state >= 0 && p->state < NELEM (states) && states[p->state])
    8000177c:	4b15                	li	s6,5
        state = states[p->state];
      else
        state = "???";
    8000177e:	00006997          	auipc	s3,0x6
    80001782:	ab298993          	addi	s3,s3,-1358 # 80007230 <etext+0x230>
      printf ("%d %s %s", p->pid, state, p->name);
    80001786:	00006a97          	auipc	s5,0x6
    8000178a:	ab2a8a93          	addi	s5,s5,-1358 # 80007238 <etext+0x238>
      printf ("\n");
    8000178e:	00006a17          	auipc	s4,0x6
    80001792:	8aaa0a13          	addi	s4,s4,-1878 # 80007038 <etext+0x38>
      if (p->state >= 0 && p->state < NELEM (states) && states[p->state])
    80001796:	00006b97          	auipc	s7,0x6
    8000179a:	082b8b93          	addi	s7,s7,130 # 80007818 <states.0>
    8000179e:	a829                	j	800017b8 <procdump+0x6e>
      printf ("%d %s %s", p->pid, state, p->name);
    800017a0:	ed86a583          	lw	a1,-296(a3)
    800017a4:	8556                	mv	a0,s5
    800017a6:	229030ef          	jal	800051ce <printf>
      printf ("\n");
    800017aa:	8552                	mv	a0,s4
    800017ac:	223030ef          	jal	800051ce <printf>
  for (p = proc; p < &proc[NPROC]; p++)
    800017b0:	16848493          	addi	s1,s1,360
    800017b4:	03248263          	beq	s1,s2,800017d8 <procdump+0x8e>
      if (p->state == UNUSED)
    800017b8:	86a6                	mv	a3,s1
    800017ba:	ec04a783          	lw	a5,-320(s1)
    800017be:	dbed                	beqz	a5,800017b0 <procdump+0x66>
        state = "???";
    800017c0:	864e                	mv	a2,s3
      if (p->state >= 0 && p->state < NELEM (states) && states[p->state])
    800017c2:	fcfb6fe3          	bltu	s6,a5,800017a0 <procdump+0x56>
    800017c6:	02079713          	slli	a4,a5,0x20
    800017ca:	01d75793          	srli	a5,a4,0x1d
    800017ce:	97de                	add	a5,a5,s7
    800017d0:	6390                	ld	a2,0(a5)
    800017d2:	f679                	bnez	a2,800017a0 <procdump+0x56>
        state = "???";
    800017d4:	864e                	mv	a2,s3
    800017d6:	b7e9                	j	800017a0 <procdump+0x56>
    }
}
    800017d8:	60a6                	ld	ra,72(sp)
    800017da:	6406                	ld	s0,64(sp)
    800017dc:	74e2                	ld	s1,56(sp)
    800017de:	7942                	ld	s2,48(sp)
    800017e0:	79a2                	ld	s3,40(sp)
    800017e2:	7a02                	ld	s4,32(sp)
    800017e4:	6ae2                	ld	s5,24(sp)
    800017e6:	6b42                	ld	s6,16(sp)
    800017e8:	6ba2                	ld	s7,8(sp)
    800017ea:	6161                	addi	sp,sp,80
    800017ec:	8082                	ret

00000000800017ee <swtch>:
    800017ee:	00153023          	sd	ra,0(a0)
    800017f2:	00253423          	sd	sp,8(a0)
    800017f6:	e900                	sd	s0,16(a0)
    800017f8:	ed04                	sd	s1,24(a0)
    800017fa:	03253023          	sd	s2,32(a0)
    800017fe:	03353423          	sd	s3,40(a0)
    80001802:	03453823          	sd	s4,48(a0)
    80001806:	03553c23          	sd	s5,56(a0)
    8000180a:	05653023          	sd	s6,64(a0)
    8000180e:	05753423          	sd	s7,72(a0)
    80001812:	05853823          	sd	s8,80(a0)
    80001816:	05953c23          	sd	s9,88(a0)
    8000181a:	07a53023          	sd	s10,96(a0)
    8000181e:	07b53423          	sd	s11,104(a0)
    80001822:	0005b083          	ld	ra,0(a1)
    80001826:	0085b103          	ld	sp,8(a1)
    8000182a:	6980                	ld	s0,16(a1)
    8000182c:	6d84                	ld	s1,24(a1)
    8000182e:	0205b903          	ld	s2,32(a1)
    80001832:	0285b983          	ld	s3,40(a1)
    80001836:	0305ba03          	ld	s4,48(a1)
    8000183a:	0385ba83          	ld	s5,56(a1)
    8000183e:	0405bb03          	ld	s6,64(a1)
    80001842:	0485bb83          	ld	s7,72(a1)
    80001846:	0505bc03          	ld	s8,80(a1)
    8000184a:	0585bc83          	ld	s9,88(a1)
    8000184e:	0605bd03          	ld	s10,96(a1)
    80001852:	0685bd83          	ld	s11,104(a1)
    80001856:	8082                	ret

0000000080001858 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001858:	1141                	addi	sp,sp,-16
    8000185a:	e406                	sd	ra,8(sp)
    8000185c:	e022                	sd	s0,0(sp)
    8000185e:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001860:	00006597          	auipc	a1,0x6
    80001864:	a1858593          	addi	a1,a1,-1512 # 80007278 <etext+0x278>
    80001868:	0000f517          	auipc	a0,0xf
    8000186c:	9d850513          	addi	a0,a0,-1576 # 80010240 <tickslock>
    80001870:	723030ef          	jal	80005792 <initlock>
}
    80001874:	60a2                	ld	ra,8(sp)
    80001876:	6402                	ld	s0,0(sp)
    80001878:	0141                	addi	sp,sp,16
    8000187a:	8082                	ret

000000008000187c <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8000187c:	1141                	addi	sp,sp,-16
    8000187e:	e406                	sd	ra,8(sp)
    80001880:	e022                	sd	s0,0(sp)
    80001882:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001884:	00003797          	auipc	a5,0x3
    80001888:	eac78793          	addi	a5,a5,-340 # 80004730 <kernelvec>
    8000188c:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001890:	60a2                	ld	ra,8(sp)
    80001892:	6402                	ld	s0,0(sp)
    80001894:	0141                	addi	sp,sp,16
    80001896:	8082                	ret

0000000080001898 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001898:	1141                	addi	sp,sp,-16
    8000189a:	e406                	sd	ra,8(sp)
    8000189c:	e022                	sd	s0,0(sp)
    8000189e:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800018a0:	ce2ff0ef          	jal	80000d82 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018a4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800018a8:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018aa:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    800018ae:	00004697          	auipc	a3,0x4
    800018b2:	75268693          	addi	a3,a3,1874 # 80006000 <_trampoline>
    800018b6:	00004717          	auipc	a4,0x4
    800018ba:	74a70713          	addi	a4,a4,1866 # 80006000 <_trampoline>
    800018be:	8f15                	sub	a4,a4,a3
    800018c0:	040007b7          	lui	a5,0x4000
    800018c4:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    800018c6:	07b2                	slli	a5,a5,0xc
    800018c8:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    800018ca:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800018ce:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800018d0:	18002673          	csrr	a2,satp
    800018d4:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800018d6:	6d30                	ld	a2,88(a0)
    800018d8:	6138                	ld	a4,64(a0)
    800018da:	6585                	lui	a1,0x1
    800018dc:	972e                	add	a4,a4,a1
    800018de:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800018e0:	6d38                	ld	a4,88(a0)
    800018e2:	00000617          	auipc	a2,0x0
    800018e6:	11460613          	addi	a2,a2,276 # 800019f6 <usertrap>
    800018ea:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800018ec:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800018ee:	8612                	mv	a2,tp
    800018f0:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018f2:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800018f6:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    800018fa:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018fe:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001902:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001904:	6f18                	ld	a4,24(a4)
    80001906:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    8000190a:	6928                	ld	a0,80(a0)
    8000190c:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    8000190e:	00004717          	auipc	a4,0x4
    80001912:	78e70713          	addi	a4,a4,1934 # 8000609c <userret>
    80001916:	8f15                	sub	a4,a4,a3
    80001918:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    8000191a:	577d                	li	a4,-1
    8000191c:	177e                	slli	a4,a4,0x3f
    8000191e:	8d59                	or	a0,a0,a4
    80001920:	9782                	jalr	a5
}
    80001922:	60a2                	ld	ra,8(sp)
    80001924:	6402                	ld	s0,0(sp)
    80001926:	0141                	addi	sp,sp,16
    80001928:	8082                	ret

000000008000192a <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    8000192a:	1141                	addi	sp,sp,-16
    8000192c:	e406                	sd	ra,8(sp)
    8000192e:	e022                	sd	s0,0(sp)
    80001930:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80001932:	c1cff0ef          	jal	80000d4e <cpuid>
    80001936:	cd11                	beqz	a0,80001952 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    80001938:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    8000193c:	000f4737          	lui	a4,0xf4
    80001940:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80001944:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80001946:	14d79073          	csrw	stimecmp,a5
}
    8000194a:	60a2                	ld	ra,8(sp)
    8000194c:	6402                	ld	s0,0(sp)
    8000194e:	0141                	addi	sp,sp,16
    80001950:	8082                	ret
    acquire(&tickslock);
    80001952:	0000f517          	auipc	a0,0xf
    80001956:	8ee50513          	addi	a0,a0,-1810 # 80010240 <tickslock>
    8000195a:	6c3030ef          	jal	8000581c <acquire>
    ticks++;
    8000195e:	00009717          	auipc	a4,0x9
    80001962:	a7a70713          	addi	a4,a4,-1414 # 8000a3d8 <ticks>
    80001966:	431c                	lw	a5,0(a4)
    80001968:	2785                	addiw	a5,a5,1
    8000196a:	c31c                	sw	a5,0(a4)
    wakeup(&ticks);
    8000196c:	853a                	mv	a0,a4
    8000196e:	a3bff0ef          	jal	800013a8 <wakeup>
    release(&tickslock);
    80001972:	0000f517          	auipc	a0,0xf
    80001976:	8ce50513          	addi	a0,a0,-1842 # 80010240 <tickslock>
    8000197a:	737030ef          	jal	800058b0 <release>
    8000197e:	bf6d                	j	80001938 <clockintr+0xe>

0000000080001980 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001980:	1101                	addi	sp,sp,-32
    80001982:	ec06                	sd	ra,24(sp)
    80001984:	e822                	sd	s0,16(sp)
    80001986:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001988:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    8000198c:	57fd                	li	a5,-1
    8000198e:	17fe                	slli	a5,a5,0x3f
    80001990:	07a5                	addi	a5,a5,9
    80001992:	00f70c63          	beq	a4,a5,800019aa <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001996:	57fd                	li	a5,-1
    80001998:	17fe                	slli	a5,a5,0x3f
    8000199a:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    8000199c:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    8000199e:	04f70863          	beq	a4,a5,800019ee <devintr+0x6e>
  }
}
    800019a2:	60e2                	ld	ra,24(sp)
    800019a4:	6442                	ld	s0,16(sp)
    800019a6:	6105                	addi	sp,sp,32
    800019a8:	8082                	ret
    800019aa:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    800019ac:	631020ef          	jal	800047dc <plic_claim>
    800019b0:	872a                	mv	a4,a0
    800019b2:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800019b4:	47a9                	li	a5,10
    800019b6:	00f50963          	beq	a0,a5,800019c8 <devintr+0x48>
    } else if(irq == VIRTIO0_IRQ){
    800019ba:	4785                	li	a5,1
    800019bc:	00f50963          	beq	a0,a5,800019ce <devintr+0x4e>
    return 1;
    800019c0:	4505                	li	a0,1
    } else if(irq){
    800019c2:	eb09                	bnez	a4,800019d4 <devintr+0x54>
    800019c4:	64a2                	ld	s1,8(sp)
    800019c6:	bff1                	j	800019a2 <devintr+0x22>
      uartintr();
    800019c8:	58b030ef          	jal	80005752 <uartintr>
    if(irq)
    800019cc:	a819                	j	800019e2 <devintr+0x62>
      virtio_disk_intr();
    800019ce:	2a4030ef          	jal	80004c72 <virtio_disk_intr>
    if(irq)
    800019d2:	a801                	j	800019e2 <devintr+0x62>
      printf("unexpected interrupt irq=%d\n", irq);
    800019d4:	85ba                	mv	a1,a4
    800019d6:	00006517          	auipc	a0,0x6
    800019da:	8aa50513          	addi	a0,a0,-1878 # 80007280 <etext+0x280>
    800019de:	7f0030ef          	jal	800051ce <printf>
      plic_complete(irq);
    800019e2:	8526                	mv	a0,s1
    800019e4:	619020ef          	jal	800047fc <plic_complete>
    return 1;
    800019e8:	4505                	li	a0,1
    800019ea:	64a2                	ld	s1,8(sp)
    800019ec:	bf5d                	j	800019a2 <devintr+0x22>
    clockintr();
    800019ee:	f3dff0ef          	jal	8000192a <clockintr>
    return 2;
    800019f2:	4509                	li	a0,2
    800019f4:	b77d                	j	800019a2 <devintr+0x22>

00000000800019f6 <usertrap>:
{
    800019f6:	1101                	addi	sp,sp,-32
    800019f8:	ec06                	sd	ra,24(sp)
    800019fa:	e822                	sd	s0,16(sp)
    800019fc:	e426                	sd	s1,8(sp)
    800019fe:	e04a                	sd	s2,0(sp)
    80001a00:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001a02:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001a06:	1007f793          	andi	a5,a5,256
    80001a0a:	ef85                	bnez	a5,80001a42 <usertrap+0x4c>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001a0c:	00003797          	auipc	a5,0x3
    80001a10:	d2478793          	addi	a5,a5,-732 # 80004730 <kernelvec>
    80001a14:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001a18:	b6aff0ef          	jal	80000d82 <myproc>
    80001a1c:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001a1e:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a20:	14102773          	csrr	a4,sepc
    80001a24:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a26:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001a2a:	47a1                	li	a5,8
    80001a2c:	02f70163          	beq	a4,a5,80001a4e <usertrap+0x58>
  } else if((which_dev = devintr()) != 0){
    80001a30:	f51ff0ef          	jal	80001980 <devintr>
    80001a34:	892a                	mv	s2,a0
    80001a36:	c135                	beqz	a0,80001a9a <usertrap+0xa4>
  if(killed(p))
    80001a38:	8526                	mv	a0,s1
    80001a3a:	b5fff0ef          	jal	80001598 <killed>
    80001a3e:	cd1d                	beqz	a0,80001a7c <usertrap+0x86>
    80001a40:	a81d                	j	80001a76 <usertrap+0x80>
    panic("usertrap: not from user mode");
    80001a42:	00006517          	auipc	a0,0x6
    80001a46:	85e50513          	addi	a0,a0,-1954 # 800072a0 <etext+0x2a0>
    80001a4a:	295030ef          	jal	800054de <panic>
    if(killed(p))
    80001a4e:	b4bff0ef          	jal	80001598 <killed>
    80001a52:	e121                	bnez	a0,80001a92 <usertrap+0x9c>
    p->trapframe->epc += 4;
    80001a54:	6cb8                	ld	a4,88(s1)
    80001a56:	6f1c                	ld	a5,24(a4)
    80001a58:	0791                	addi	a5,a5,4
    80001a5a:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001a5c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001a60:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001a64:	10079073          	csrw	sstatus,a5
    syscall();
    80001a68:	242000ef          	jal	80001caa <syscall>
  if(killed(p))
    80001a6c:	8526                	mv	a0,s1
    80001a6e:	b2bff0ef          	jal	80001598 <killed>
    80001a72:	c901                	beqz	a0,80001a82 <usertrap+0x8c>
    80001a74:	4901                	li	s2,0
    exit(-1);
    80001a76:	557d                	li	a0,-1
    80001a78:	9f1ff0ef          	jal	80001468 <exit>
  if(which_dev == 2)
    80001a7c:	4789                	li	a5,2
    80001a7e:	04f90563          	beq	s2,a5,80001ac8 <usertrap+0xd2>
  usertrapret();
    80001a82:	e17ff0ef          	jal	80001898 <usertrapret>
}
    80001a86:	60e2                	ld	ra,24(sp)
    80001a88:	6442                	ld	s0,16(sp)
    80001a8a:	64a2                	ld	s1,8(sp)
    80001a8c:	6902                	ld	s2,0(sp)
    80001a8e:	6105                	addi	sp,sp,32
    80001a90:	8082                	ret
      exit(-1);
    80001a92:	557d                	li	a0,-1
    80001a94:	9d5ff0ef          	jal	80001468 <exit>
    80001a98:	bf75                	j	80001a54 <usertrap+0x5e>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a9a:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001a9e:	5890                	lw	a2,48(s1)
    80001aa0:	00006517          	auipc	a0,0x6
    80001aa4:	82050513          	addi	a0,a0,-2016 # 800072c0 <etext+0x2c0>
    80001aa8:	726030ef          	jal	800051ce <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001aac:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001ab0:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001ab4:	00006517          	auipc	a0,0x6
    80001ab8:	83c50513          	addi	a0,a0,-1988 # 800072f0 <etext+0x2f0>
    80001abc:	712030ef          	jal	800051ce <printf>
    setkilled(p);
    80001ac0:	8526                	mv	a0,s1
    80001ac2:	ab3ff0ef          	jal	80001574 <setkilled>
    80001ac6:	b75d                	j	80001a6c <usertrap+0x76>
    yield();
    80001ac8:	869ff0ef          	jal	80001330 <yield>
    80001acc:	bf5d                	j	80001a82 <usertrap+0x8c>

0000000080001ace <kerneltrap>:
{
    80001ace:	7179                	addi	sp,sp,-48
    80001ad0:	f406                	sd	ra,40(sp)
    80001ad2:	f022                	sd	s0,32(sp)
    80001ad4:	ec26                	sd	s1,24(sp)
    80001ad6:	e84a                	sd	s2,16(sp)
    80001ad8:	e44e                	sd	s3,8(sp)
    80001ada:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001adc:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ae0:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ae4:	142027f3          	csrr	a5,scause
    80001ae8:	89be                	mv	s3,a5
  if((sstatus & SSTATUS_SPP) == 0)
    80001aea:	1004f793          	andi	a5,s1,256
    80001aee:	c795                	beqz	a5,80001b1a <kerneltrap+0x4c>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001af0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001af4:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001af6:	eb85                	bnez	a5,80001b26 <kerneltrap+0x58>
  if((which_dev = devintr()) == 0){
    80001af8:	e89ff0ef          	jal	80001980 <devintr>
    80001afc:	c91d                	beqz	a0,80001b32 <kerneltrap+0x64>
  if(which_dev == 2 && myproc() != 0)
    80001afe:	4789                	li	a5,2
    80001b00:	04f50a63          	beq	a0,a5,80001b54 <kerneltrap+0x86>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b04:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b08:	10049073          	csrw	sstatus,s1
}
    80001b0c:	70a2                	ld	ra,40(sp)
    80001b0e:	7402                	ld	s0,32(sp)
    80001b10:	64e2                	ld	s1,24(sp)
    80001b12:	6942                	ld	s2,16(sp)
    80001b14:	69a2                	ld	s3,8(sp)
    80001b16:	6145                	addi	sp,sp,48
    80001b18:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001b1a:	00005517          	auipc	a0,0x5
    80001b1e:	7fe50513          	addi	a0,a0,2046 # 80007318 <etext+0x318>
    80001b22:	1bd030ef          	jal	800054de <panic>
    panic("kerneltrap: interrupts enabled");
    80001b26:	00006517          	auipc	a0,0x6
    80001b2a:	81a50513          	addi	a0,a0,-2022 # 80007340 <etext+0x340>
    80001b2e:	1b1030ef          	jal	800054de <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b32:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b36:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001b3a:	85ce                	mv	a1,s3
    80001b3c:	00006517          	auipc	a0,0x6
    80001b40:	82450513          	addi	a0,a0,-2012 # 80007360 <etext+0x360>
    80001b44:	68a030ef          	jal	800051ce <printf>
    panic("kerneltrap");
    80001b48:	00006517          	auipc	a0,0x6
    80001b4c:	84050513          	addi	a0,a0,-1984 # 80007388 <etext+0x388>
    80001b50:	18f030ef          	jal	800054de <panic>
  if(which_dev == 2 && myproc() != 0)
    80001b54:	a2eff0ef          	jal	80000d82 <myproc>
    80001b58:	d555                	beqz	a0,80001b04 <kerneltrap+0x36>
    yield();
    80001b5a:	fd6ff0ef          	jal	80001330 <yield>
    80001b5e:	b75d                	j	80001b04 <kerneltrap+0x36>

0000000080001b60 <argraw>:
  return strlen (buf);
}

static uint64
argraw (int n)
{
    80001b60:	1101                	addi	sp,sp,-32
    80001b62:	ec06                	sd	ra,24(sp)
    80001b64:	e822                	sd	s0,16(sp)
    80001b66:	e426                	sd	s1,8(sp)
    80001b68:	1000                	addi	s0,sp,32
    80001b6a:	84aa                	mv	s1,a0
  struct proc *p = myproc ();
    80001b6c:	a16ff0ef          	jal	80000d82 <myproc>
  switch (n)
    80001b70:	4795                	li	a5,5
    80001b72:	0497e163          	bltu	a5,s1,80001bb4 <argraw+0x54>
    80001b76:	048a                	slli	s1,s1,0x2
    80001b78:	00006717          	auipc	a4,0x6
    80001b7c:	cd070713          	addi	a4,a4,-816 # 80007848 <states.0+0x30>
    80001b80:	94ba                	add	s1,s1,a4
    80001b82:	409c                	lw	a5,0(s1)
    80001b84:	97ba                	add	a5,a5,a4
    80001b86:	8782                	jr	a5
    {
    case 0:
      return p->trapframe->a0;
    80001b88:	6d3c                	ld	a5,88(a0)
    80001b8a:	7ba8                	ld	a0,112(a5)
    case 5:
      return p->trapframe->a5;
    }
  panic ("argraw");
  return -1;
}
    80001b8c:	60e2                	ld	ra,24(sp)
    80001b8e:	6442                	ld	s0,16(sp)
    80001b90:	64a2                	ld	s1,8(sp)
    80001b92:	6105                	addi	sp,sp,32
    80001b94:	8082                	ret
      return p->trapframe->a1;
    80001b96:	6d3c                	ld	a5,88(a0)
    80001b98:	7fa8                	ld	a0,120(a5)
    80001b9a:	bfcd                	j	80001b8c <argraw+0x2c>
      return p->trapframe->a2;
    80001b9c:	6d3c                	ld	a5,88(a0)
    80001b9e:	63c8                	ld	a0,128(a5)
    80001ba0:	b7f5                	j	80001b8c <argraw+0x2c>
      return p->trapframe->a3;
    80001ba2:	6d3c                	ld	a5,88(a0)
    80001ba4:	67c8                	ld	a0,136(a5)
    80001ba6:	b7dd                	j	80001b8c <argraw+0x2c>
      return p->trapframe->a4;
    80001ba8:	6d3c                	ld	a5,88(a0)
    80001baa:	6bc8                	ld	a0,144(a5)
    80001bac:	b7c5                	j	80001b8c <argraw+0x2c>
      return p->trapframe->a5;
    80001bae:	6d3c                	ld	a5,88(a0)
    80001bb0:	6fc8                	ld	a0,152(a5)
    80001bb2:	bfe9                	j	80001b8c <argraw+0x2c>
  panic ("argraw");
    80001bb4:	00005517          	auipc	a0,0x5
    80001bb8:	7e450513          	addi	a0,a0,2020 # 80007398 <etext+0x398>
    80001bbc:	123030ef          	jal	800054de <panic>

0000000080001bc0 <fetchaddr>:
{
    80001bc0:	1101                	addi	sp,sp,-32
    80001bc2:	ec06                	sd	ra,24(sp)
    80001bc4:	e822                	sd	s0,16(sp)
    80001bc6:	e426                	sd	s1,8(sp)
    80001bc8:	e04a                	sd	s2,0(sp)
    80001bca:	1000                	addi	s0,sp,32
    80001bcc:	84aa                	mv	s1,a0
    80001bce:	892e                	mv	s2,a1
  struct proc *p = myproc ();
    80001bd0:	9b2ff0ef          	jal	80000d82 <myproc>
  if (addr >= p->sz
    80001bd4:	653c                	ld	a5,72(a0)
    80001bd6:	02f4f663          	bgeu	s1,a5,80001c02 <fetchaddr+0x42>
      || addr + sizeof (uint64)
    80001bda:	00848713          	addi	a4,s1,8
    80001bde:	02e7e463          	bltu	a5,a4,80001c06 <fetchaddr+0x46>
  if (copyin (p->pagetable, (char *)ip, addr, sizeof (*ip)) != 0)
    80001be2:	46a1                	li	a3,8
    80001be4:	8626                	mv	a2,s1
    80001be6:	85ca                	mv	a1,s2
    80001be8:	6928                	ld	a0,80(a0)
    80001bea:	ec9fe0ef          	jal	80000ab2 <copyin>
    80001bee:	00a03533          	snez	a0,a0
    80001bf2:	40a0053b          	negw	a0,a0
}
    80001bf6:	60e2                	ld	ra,24(sp)
    80001bf8:	6442                	ld	s0,16(sp)
    80001bfa:	64a2                	ld	s1,8(sp)
    80001bfc:	6902                	ld	s2,0(sp)
    80001bfe:	6105                	addi	sp,sp,32
    80001c00:	8082                	ret
    return -1;
    80001c02:	557d                	li	a0,-1
    80001c04:	bfcd                	j	80001bf6 <fetchaddr+0x36>
    80001c06:	557d                	li	a0,-1
    80001c08:	b7fd                	j	80001bf6 <fetchaddr+0x36>

0000000080001c0a <fetchstr>:
{
    80001c0a:	7179                	addi	sp,sp,-48
    80001c0c:	f406                	sd	ra,40(sp)
    80001c0e:	f022                	sd	s0,32(sp)
    80001c10:	ec26                	sd	s1,24(sp)
    80001c12:	e84a                	sd	s2,16(sp)
    80001c14:	e44e                	sd	s3,8(sp)
    80001c16:	1800                	addi	s0,sp,48
    80001c18:	89aa                	mv	s3,a0
    80001c1a:	84ae                	mv	s1,a1
    80001c1c:	8932                	mv	s2,a2
  struct proc *p = myproc ();
    80001c1e:	964ff0ef          	jal	80000d82 <myproc>
  if (copyinstr (p->pagetable, buf, addr, max) < 0)
    80001c22:	86ca                	mv	a3,s2
    80001c24:	864e                	mv	a2,s3
    80001c26:	85a6                	mv	a1,s1
    80001c28:	6928                	ld	a0,80(a0)
    80001c2a:	f0ffe0ef          	jal	80000b38 <copyinstr>
    80001c2e:	00054c63          	bltz	a0,80001c46 <fetchstr+0x3c>
  return strlen (buf);
    80001c32:	8526                	mv	a0,s1
    80001c34:	eb4fe0ef          	jal	800002e8 <strlen>
}
    80001c38:	70a2                	ld	ra,40(sp)
    80001c3a:	7402                	ld	s0,32(sp)
    80001c3c:	64e2                	ld	s1,24(sp)
    80001c3e:	6942                	ld	s2,16(sp)
    80001c40:	69a2                	ld	s3,8(sp)
    80001c42:	6145                	addi	sp,sp,48
    80001c44:	8082                	ret
    return -1;
    80001c46:	557d                	li	a0,-1
    80001c48:	bfc5                	j	80001c38 <fetchstr+0x2e>

0000000080001c4a <argint>:

// Fetch the nth 32-bit system call argument.
void
argint (int n, int *ip)
{
    80001c4a:	1101                	addi	sp,sp,-32
    80001c4c:	ec06                	sd	ra,24(sp)
    80001c4e:	e822                	sd	s0,16(sp)
    80001c50:	e426                	sd	s1,8(sp)
    80001c52:	1000                	addi	s0,sp,32
    80001c54:	84ae                	mv	s1,a1
  *ip = argraw (n);
    80001c56:	f0bff0ef          	jal	80001b60 <argraw>
    80001c5a:	c088                	sw	a0,0(s1)
}
    80001c5c:	60e2                	ld	ra,24(sp)
    80001c5e:	6442                	ld	s0,16(sp)
    80001c60:	64a2                	ld	s1,8(sp)
    80001c62:	6105                	addi	sp,sp,32
    80001c64:	8082                	ret

0000000080001c66 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr (int n, uint64 *ip)
{
    80001c66:	1101                	addi	sp,sp,-32
    80001c68:	ec06                	sd	ra,24(sp)
    80001c6a:	e822                	sd	s0,16(sp)
    80001c6c:	e426                	sd	s1,8(sp)
    80001c6e:	1000                	addi	s0,sp,32
    80001c70:	84ae                	mv	s1,a1
  *ip = argraw (n);
    80001c72:	eefff0ef          	jal	80001b60 <argraw>
    80001c76:	e088                	sd	a0,0(s1)
}
    80001c78:	60e2                	ld	ra,24(sp)
    80001c7a:	6442                	ld	s0,16(sp)
    80001c7c:	64a2                	ld	s1,8(sp)
    80001c7e:	6105                	addi	sp,sp,32
    80001c80:	8082                	ret

0000000080001c82 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr (int n, char *buf, int max)
{
    80001c82:	1101                	addi	sp,sp,-32
    80001c84:	ec06                	sd	ra,24(sp)
    80001c86:	e822                	sd	s0,16(sp)
    80001c88:	e426                	sd	s1,8(sp)
    80001c8a:	e04a                	sd	s2,0(sp)
    80001c8c:	1000                	addi	s0,sp,32
    80001c8e:	892e                	mv	s2,a1
    80001c90:	84b2                	mv	s1,a2
  *ip = argraw (n);
    80001c92:	ecfff0ef          	jal	80001b60 <argraw>
  uint64 addr;
  argaddr (n, &addr);
  return fetchstr (addr, buf, max);
    80001c96:	8626                	mv	a2,s1
    80001c98:	85ca                	mv	a1,s2
    80001c9a:	f71ff0ef          	jal	80001c0a <fetchstr>
}
    80001c9e:	60e2                	ld	ra,24(sp)
    80001ca0:	6442                	ld	s0,16(sp)
    80001ca2:	64a2                	ld	s1,8(sp)
    80001ca4:	6902                	ld	s2,0(sp)
    80001ca6:	6105                	addi	sp,sp,32
    80001ca8:	8082                	ret

0000000080001caa <syscall>:
        "sbrk",   "sleep", "uptime", "open",  "write", "mknod",
        "unlink", "link",  "mkdir",  "close", "trace" };

void
syscall (void)
{
    80001caa:	7179                	addi	sp,sp,-48
    80001cac:	f406                	sd	ra,40(sp)
    80001cae:	f022                	sd	s0,32(sp)
    80001cb0:	ec26                	sd	s1,24(sp)
    80001cb2:	e84a                	sd	s2,16(sp)
    80001cb4:	e44e                	sd	s3,8(sp)
    80001cb6:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc ();
    80001cb8:	8caff0ef          	jal	80000d82 <myproc>
    80001cbc:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001cbe:	05853903          	ld	s2,88(a0)
    80001cc2:	0a893783          	ld	a5,168(s2)
    80001cc6:	0007899b          	sext.w	s3,a5
  if (num > 0 && num < NELEM (syscalls) && syscalls[num])
    80001cca:	37fd                	addiw	a5,a5,-1
    80001ccc:	4755                	li	a4,21
    80001cce:	04f76463          	bltu	a4,a5,80001d16 <syscall+0x6c>
    80001cd2:	00399713          	slli	a4,s3,0x3
    80001cd6:	00006797          	auipc	a5,0x6
    80001cda:	b8a78793          	addi	a5,a5,-1142 # 80007860 <syscalls>
    80001cde:	97ba                	add	a5,a5,a4
    80001ce0:	639c                	ld	a5,0(a5)
    80001ce2:	cb95                	beqz	a5,80001d16 <syscall+0x6c>
    {
      p->trapframe->a0 = syscalls[num]();
    80001ce4:	9782                	jalr	a5
    80001ce6:	06a93823          	sd	a0,112(s2)
      if (p->mask & (1 << num))
    80001cea:	58dc                	lw	a5,52(s1)
    80001cec:	4137d7bb          	sraw	a5,a5,s3
    80001cf0:	8b85                	andi	a5,a5,1
    80001cf2:	cf9d                	beqz	a5,80001d30 <syscall+0x86>
        printf ("%d: syscall %s -> %ld\n", p->pid, syscall_list[num],
    80001cf4:	6cb8                	ld	a4,88(s1)
    80001cf6:	098e                	slli	s3,s3,0x3
    80001cf8:	00006797          	auipc	a5,0x6
    80001cfc:	b6878793          	addi	a5,a5,-1176 # 80007860 <syscalls>
    80001d00:	97ce                	add	a5,a5,s3
    80001d02:	7b34                	ld	a3,112(a4)
    80001d04:	7fd0                	ld	a2,184(a5)
    80001d06:	588c                	lw	a1,48(s1)
    80001d08:	00005517          	auipc	a0,0x5
    80001d0c:	69850513          	addi	a0,a0,1688 # 800073a0 <etext+0x3a0>
    80001d10:	4be030ef          	jal	800051ce <printf>
    80001d14:	a831                	j	80001d30 <syscall+0x86>
                p->trapframe->a0);
    }
  else
    {
      printf ("%d %s: unknown sys call %d\n", p->pid, p->name, num);
    80001d16:	86ce                	mv	a3,s3
    80001d18:	15848613          	addi	a2,s1,344
    80001d1c:	588c                	lw	a1,48(s1)
    80001d1e:	00005517          	auipc	a0,0x5
    80001d22:	69a50513          	addi	a0,a0,1690 # 800073b8 <etext+0x3b8>
    80001d26:	4a8030ef          	jal	800051ce <printf>
      p->trapframe->a0 = -1;
    80001d2a:	6cbc                	ld	a5,88(s1)
    80001d2c:	577d                	li	a4,-1
    80001d2e:	fbb8                	sd	a4,112(a5)
    }
}
    80001d30:	70a2                	ld	ra,40(sp)
    80001d32:	7402                	ld	s0,32(sp)
    80001d34:	64e2                	ld	s1,24(sp)
    80001d36:	6942                	ld	s2,16(sp)
    80001d38:	69a2                	ld	s3,8(sp)
    80001d3a:	6145                	addi	sp,sp,48
    80001d3c:	8082                	ret

0000000080001d3e <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80001d3e:	1101                	addi	sp,sp,-32
    80001d40:	ec06                	sd	ra,24(sp)
    80001d42:	e822                	sd	s0,16(sp)
    80001d44:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001d46:	fec40593          	addi	a1,s0,-20
    80001d4a:	4501                	li	a0,0
    80001d4c:	effff0ef          	jal	80001c4a <argint>
  exit(n);
    80001d50:	fec42503          	lw	a0,-20(s0)
    80001d54:	f14ff0ef          	jal	80001468 <exit>
  return 0;  // not reached
}
    80001d58:	4501                	li	a0,0
    80001d5a:	60e2                	ld	ra,24(sp)
    80001d5c:	6442                	ld	s0,16(sp)
    80001d5e:	6105                	addi	sp,sp,32
    80001d60:	8082                	ret

0000000080001d62 <sys_getpid>:

uint64
sys_getpid(void)
{
    80001d62:	1141                	addi	sp,sp,-16
    80001d64:	e406                	sd	ra,8(sp)
    80001d66:	e022                	sd	s0,0(sp)
    80001d68:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001d6a:	818ff0ef          	jal	80000d82 <myproc>
}
    80001d6e:	5908                	lw	a0,48(a0)
    80001d70:	60a2                	ld	ra,8(sp)
    80001d72:	6402                	ld	s0,0(sp)
    80001d74:	0141                	addi	sp,sp,16
    80001d76:	8082                	ret

0000000080001d78 <sys_fork>:

uint64
sys_fork(void)
{
    80001d78:	1141                	addi	sp,sp,-16
    80001d7a:	e406                	sd	ra,8(sp)
    80001d7c:	e022                	sd	s0,0(sp)
    80001d7e:	0800                	addi	s0,sp,16
  return fork();
    80001d80:	b2aff0ef          	jal	800010aa <fork>
}
    80001d84:	60a2                	ld	ra,8(sp)
    80001d86:	6402                	ld	s0,0(sp)
    80001d88:	0141                	addi	sp,sp,16
    80001d8a:	8082                	ret

0000000080001d8c <sys_wait>:

uint64
sys_wait(void)
{
    80001d8c:	1101                	addi	sp,sp,-32
    80001d8e:	ec06                	sd	ra,24(sp)
    80001d90:	e822                	sd	s0,16(sp)
    80001d92:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001d94:	fe840593          	addi	a1,s0,-24
    80001d98:	4501                	li	a0,0
    80001d9a:	ecdff0ef          	jal	80001c66 <argaddr>
  return wait(p);
    80001d9e:	fe843503          	ld	a0,-24(s0)
    80001da2:	821ff0ef          	jal	800015c2 <wait>
}
    80001da6:	60e2                	ld	ra,24(sp)
    80001da8:	6442                	ld	s0,16(sp)
    80001daa:	6105                	addi	sp,sp,32
    80001dac:	8082                	ret

0000000080001dae <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001dae:	7179                	addi	sp,sp,-48
    80001db0:	f406                	sd	ra,40(sp)
    80001db2:	f022                	sd	s0,32(sp)
    80001db4:	ec26                	sd	s1,24(sp)
    80001db6:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80001db8:	fdc40593          	addi	a1,s0,-36
    80001dbc:	4501                	li	a0,0
    80001dbe:	e8dff0ef          	jal	80001c4a <argint>
  addr = myproc()->sz;
    80001dc2:	fc1fe0ef          	jal	80000d82 <myproc>
    80001dc6:	653c                	ld	a5,72(a0)
    80001dc8:	84be                	mv	s1,a5
  if(growproc(n) < 0)
    80001dca:	fdc42503          	lw	a0,-36(s0)
    80001dce:	a8cff0ef          	jal	8000105a <growproc>
    80001dd2:	00054863          	bltz	a0,80001de2 <sys_sbrk+0x34>
    return -1;
  return addr;
}
    80001dd6:	8526                	mv	a0,s1
    80001dd8:	70a2                	ld	ra,40(sp)
    80001dda:	7402                	ld	s0,32(sp)
    80001ddc:	64e2                	ld	s1,24(sp)
    80001dde:	6145                	addi	sp,sp,48
    80001de0:	8082                	ret
    return -1;
    80001de2:	57fd                	li	a5,-1
    80001de4:	84be                	mv	s1,a5
    80001de6:	bfc5                	j	80001dd6 <sys_sbrk+0x28>

0000000080001de8 <sys_sleep>:

uint64
sys_sleep(void)
{
    80001de8:	7139                	addi	sp,sp,-64
    80001dea:	fc06                	sd	ra,56(sp)
    80001dec:	f822                	sd	s0,48(sp)
    80001dee:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80001df0:	fcc40593          	addi	a1,s0,-52
    80001df4:	4501                	li	a0,0
    80001df6:	e55ff0ef          	jal	80001c4a <argint>
  if(n < 0)
    80001dfa:	fcc42783          	lw	a5,-52(s0)
    80001dfe:	0607c863          	bltz	a5,80001e6e <sys_sleep+0x86>
    n = 0;
  acquire(&tickslock);
    80001e02:	0000e517          	auipc	a0,0xe
    80001e06:	43e50513          	addi	a0,a0,1086 # 80010240 <tickslock>
    80001e0a:	213030ef          	jal	8000581c <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    80001e0e:	fcc42783          	lw	a5,-52(s0)
    80001e12:	c3b9                	beqz	a5,80001e58 <sys_sleep+0x70>
    80001e14:	f426                	sd	s1,40(sp)
    80001e16:	f04a                	sd	s2,32(sp)
    80001e18:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    80001e1a:	00008997          	auipc	s3,0x8
    80001e1e:	5be9a983          	lw	s3,1470(s3) # 8000a3d8 <ticks>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001e22:	0000e917          	auipc	s2,0xe
    80001e26:	41e90913          	addi	s2,s2,1054 # 80010240 <tickslock>
    80001e2a:	00008497          	auipc	s1,0x8
    80001e2e:	5ae48493          	addi	s1,s1,1454 # 8000a3d8 <ticks>
    if(killed(myproc())){
    80001e32:	f51fe0ef          	jal	80000d82 <myproc>
    80001e36:	f62ff0ef          	jal	80001598 <killed>
    80001e3a:	ed0d                	bnez	a0,80001e74 <sys_sleep+0x8c>
    sleep(&ticks, &tickslock);
    80001e3c:	85ca                	mv	a1,s2
    80001e3e:	8526                	mv	a0,s1
    80001e40:	d1cff0ef          	jal	8000135c <sleep>
  while(ticks - ticks0 < n){
    80001e44:	409c                	lw	a5,0(s1)
    80001e46:	413787bb          	subw	a5,a5,s3
    80001e4a:	fcc42703          	lw	a4,-52(s0)
    80001e4e:	fee7e2e3          	bltu	a5,a4,80001e32 <sys_sleep+0x4a>
    80001e52:	74a2                	ld	s1,40(sp)
    80001e54:	7902                	ld	s2,32(sp)
    80001e56:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001e58:	0000e517          	auipc	a0,0xe
    80001e5c:	3e850513          	addi	a0,a0,1000 # 80010240 <tickslock>
    80001e60:	251030ef          	jal	800058b0 <release>
  return 0;
    80001e64:	4501                	li	a0,0
}
    80001e66:	70e2                	ld	ra,56(sp)
    80001e68:	7442                	ld	s0,48(sp)
    80001e6a:	6121                	addi	sp,sp,64
    80001e6c:	8082                	ret
    n = 0;
    80001e6e:	fc042623          	sw	zero,-52(s0)
    80001e72:	bf41                	j	80001e02 <sys_sleep+0x1a>
      release(&tickslock);
    80001e74:	0000e517          	auipc	a0,0xe
    80001e78:	3cc50513          	addi	a0,a0,972 # 80010240 <tickslock>
    80001e7c:	235030ef          	jal	800058b0 <release>
      return -1;
    80001e80:	557d                	li	a0,-1
    80001e82:	74a2                	ld	s1,40(sp)
    80001e84:	7902                	ld	s2,32(sp)
    80001e86:	69e2                	ld	s3,24(sp)
    80001e88:	bff9                	j	80001e66 <sys_sleep+0x7e>

0000000080001e8a <sys_kill>:

uint64
sys_kill(void)
{
    80001e8a:	1101                	addi	sp,sp,-32
    80001e8c:	ec06                	sd	ra,24(sp)
    80001e8e:	e822                	sd	s0,16(sp)
    80001e90:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001e92:	fec40593          	addi	a1,s0,-20
    80001e96:	4501                	li	a0,0
    80001e98:	db3ff0ef          	jal	80001c4a <argint>
  return kill(pid);
    80001e9c:	fec42503          	lw	a0,-20(s0)
    80001ea0:	e6eff0ef          	jal	8000150e <kill>
}
    80001ea4:	60e2                	ld	ra,24(sp)
    80001ea6:	6442                	ld	s0,16(sp)
    80001ea8:	6105                	addi	sp,sp,32
    80001eaa:	8082                	ret

0000000080001eac <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001eac:	1101                	addi	sp,sp,-32
    80001eae:	ec06                	sd	ra,24(sp)
    80001eb0:	e822                	sd	s0,16(sp)
    80001eb2:	e426                	sd	s1,8(sp)
    80001eb4:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001eb6:	0000e517          	auipc	a0,0xe
    80001eba:	38a50513          	addi	a0,a0,906 # 80010240 <tickslock>
    80001ebe:	15f030ef          	jal	8000581c <acquire>
  xticks = ticks;
    80001ec2:	00008797          	auipc	a5,0x8
    80001ec6:	5167a783          	lw	a5,1302(a5) # 8000a3d8 <ticks>
    80001eca:	84be                	mv	s1,a5
  release(&tickslock);
    80001ecc:	0000e517          	auipc	a0,0xe
    80001ed0:	37450513          	addi	a0,a0,884 # 80010240 <tickslock>
    80001ed4:	1dd030ef          	jal	800058b0 <release>
  return xticks;
}
    80001ed8:	02049513          	slli	a0,s1,0x20
    80001edc:	9101                	srli	a0,a0,0x20
    80001ede:	60e2                	ld	ra,24(sp)
    80001ee0:	6442                	ld	s0,16(sp)
    80001ee2:	64a2                	ld	s1,8(sp)
    80001ee4:	6105                	addi	sp,sp,32
    80001ee6:	8082                	ret

0000000080001ee8 <sys_trace>:
uint64
sys_trace(void){
    80001ee8:	1101                	addi	sp,sp,-32
    80001eea:	ec06                	sd	ra,24(sp)
    80001eec:	e822                	sd	s0,16(sp)
    80001eee:	1000                	addi	s0,sp,32
  int mask;

  argint(0, &mask);
    80001ef0:	fec40593          	addi	a1,s0,-20
    80001ef4:	4501                	li	a0,0
    80001ef6:	d55ff0ef          	jal	80001c4a <argint>
  myproc()->mask = mask;
    80001efa:	e89fe0ef          	jal	80000d82 <myproc>
    80001efe:	fec42783          	lw	a5,-20(s0)
    80001f02:	d95c                	sw	a5,52(a0)
  return 0;
}
    80001f04:	4501                	li	a0,0
    80001f06:	60e2                	ld	ra,24(sp)
    80001f08:	6442                	ld	s0,16(sp)
    80001f0a:	6105                	addi	sp,sp,32
    80001f0c:	8082                	ret

0000000080001f0e <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80001f0e:	7179                	addi	sp,sp,-48
    80001f10:	f406                	sd	ra,40(sp)
    80001f12:	f022                	sd	s0,32(sp)
    80001f14:	ec26                	sd	s1,24(sp)
    80001f16:	e84a                	sd	s2,16(sp)
    80001f18:	e44e                	sd	s3,8(sp)
    80001f1a:	e052                	sd	s4,0(sp)
    80001f1c:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80001f1e:	00005597          	auipc	a1,0x5
    80001f22:	56258593          	addi	a1,a1,1378 # 80007480 <etext+0x480>
    80001f26:	0000e517          	auipc	a0,0xe
    80001f2a:	33250513          	addi	a0,a0,818 # 80010258 <bcache>
    80001f2e:	065030ef          	jal	80005792 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80001f32:	00016797          	auipc	a5,0x16
    80001f36:	32678793          	addi	a5,a5,806 # 80018258 <bcache+0x8000>
    80001f3a:	00016717          	auipc	a4,0x16
    80001f3e:	58670713          	addi	a4,a4,1414 # 800184c0 <bcache+0x8268>
    80001f42:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80001f46:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001f4a:	0000e497          	auipc	s1,0xe
    80001f4e:	32648493          	addi	s1,s1,806 # 80010270 <bcache+0x18>
    b->next = bcache.head.next;
    80001f52:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80001f54:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80001f56:	00005a17          	auipc	s4,0x5
    80001f5a:	532a0a13          	addi	s4,s4,1330 # 80007488 <etext+0x488>
    b->next = bcache.head.next;
    80001f5e:	2b893783          	ld	a5,696(s2)
    80001f62:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80001f64:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80001f68:	85d2                	mv	a1,s4
    80001f6a:	01048513          	addi	a0,s1,16
    80001f6e:	24c010ef          	jal	800031ba <initsleeplock>
    bcache.head.next->prev = b;
    80001f72:	2b893783          	ld	a5,696(s2)
    80001f76:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80001f78:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001f7c:	45848493          	addi	s1,s1,1112
    80001f80:	fd349fe3          	bne	s1,s3,80001f5e <binit+0x50>
  }
}
    80001f84:	70a2                	ld	ra,40(sp)
    80001f86:	7402                	ld	s0,32(sp)
    80001f88:	64e2                	ld	s1,24(sp)
    80001f8a:	6942                	ld	s2,16(sp)
    80001f8c:	69a2                	ld	s3,8(sp)
    80001f8e:	6a02                	ld	s4,0(sp)
    80001f90:	6145                	addi	sp,sp,48
    80001f92:	8082                	ret

0000000080001f94 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80001f94:	7179                	addi	sp,sp,-48
    80001f96:	f406                	sd	ra,40(sp)
    80001f98:	f022                	sd	s0,32(sp)
    80001f9a:	ec26                	sd	s1,24(sp)
    80001f9c:	e84a                	sd	s2,16(sp)
    80001f9e:	e44e                	sd	s3,8(sp)
    80001fa0:	1800                	addi	s0,sp,48
    80001fa2:	892a                	mv	s2,a0
    80001fa4:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80001fa6:	0000e517          	auipc	a0,0xe
    80001faa:	2b250513          	addi	a0,a0,690 # 80010258 <bcache>
    80001fae:	06f030ef          	jal	8000581c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80001fb2:	00016497          	auipc	s1,0x16
    80001fb6:	55e4b483          	ld	s1,1374(s1) # 80018510 <bcache+0x82b8>
    80001fba:	00016797          	auipc	a5,0x16
    80001fbe:	50678793          	addi	a5,a5,1286 # 800184c0 <bcache+0x8268>
    80001fc2:	02f48b63          	beq	s1,a5,80001ff8 <bread+0x64>
    80001fc6:	873e                	mv	a4,a5
    80001fc8:	a021                	j	80001fd0 <bread+0x3c>
    80001fca:	68a4                	ld	s1,80(s1)
    80001fcc:	02e48663          	beq	s1,a4,80001ff8 <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    80001fd0:	449c                	lw	a5,8(s1)
    80001fd2:	ff279ce3          	bne	a5,s2,80001fca <bread+0x36>
    80001fd6:	44dc                	lw	a5,12(s1)
    80001fd8:	ff3799e3          	bne	a5,s3,80001fca <bread+0x36>
      b->refcnt++;
    80001fdc:	40bc                	lw	a5,64(s1)
    80001fde:	2785                	addiw	a5,a5,1
    80001fe0:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80001fe2:	0000e517          	auipc	a0,0xe
    80001fe6:	27650513          	addi	a0,a0,630 # 80010258 <bcache>
    80001fea:	0c7030ef          	jal	800058b0 <release>
      acquiresleep(&b->lock);
    80001fee:	01048513          	addi	a0,s1,16
    80001ff2:	1fe010ef          	jal	800031f0 <acquiresleep>
      return b;
    80001ff6:	a889                	j	80002048 <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80001ff8:	00016497          	auipc	s1,0x16
    80001ffc:	5104b483          	ld	s1,1296(s1) # 80018508 <bcache+0x82b0>
    80002000:	00016797          	auipc	a5,0x16
    80002004:	4c078793          	addi	a5,a5,1216 # 800184c0 <bcache+0x8268>
    80002008:	00f48863          	beq	s1,a5,80002018 <bread+0x84>
    8000200c:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000200e:	40bc                	lw	a5,64(s1)
    80002010:	cb91                	beqz	a5,80002024 <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002012:	64a4                	ld	s1,72(s1)
    80002014:	fee49de3          	bne	s1,a4,8000200e <bread+0x7a>
  panic("bget: no buffers");
    80002018:	00005517          	auipc	a0,0x5
    8000201c:	47850513          	addi	a0,a0,1144 # 80007490 <etext+0x490>
    80002020:	4be030ef          	jal	800054de <panic>
      b->dev = dev;
    80002024:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002028:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    8000202c:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002030:	4785                	li	a5,1
    80002032:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002034:	0000e517          	auipc	a0,0xe
    80002038:	22450513          	addi	a0,a0,548 # 80010258 <bcache>
    8000203c:	075030ef          	jal	800058b0 <release>
      acquiresleep(&b->lock);
    80002040:	01048513          	addi	a0,s1,16
    80002044:	1ac010ef          	jal	800031f0 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002048:	409c                	lw	a5,0(s1)
    8000204a:	cb89                	beqz	a5,8000205c <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000204c:	8526                	mv	a0,s1
    8000204e:	70a2                	ld	ra,40(sp)
    80002050:	7402                	ld	s0,32(sp)
    80002052:	64e2                	ld	s1,24(sp)
    80002054:	6942                	ld	s2,16(sp)
    80002056:	69a2                	ld	s3,8(sp)
    80002058:	6145                	addi	sp,sp,48
    8000205a:	8082                	ret
    virtio_disk_rw(b, 0);
    8000205c:	4581                	li	a1,0
    8000205e:	8526                	mv	a0,s1
    80002060:	201020ef          	jal	80004a60 <virtio_disk_rw>
    b->valid = 1;
    80002064:	4785                	li	a5,1
    80002066:	c09c                	sw	a5,0(s1)
  return b;
    80002068:	b7d5                	j	8000204c <bread+0xb8>

000000008000206a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000206a:	1101                	addi	sp,sp,-32
    8000206c:	ec06                	sd	ra,24(sp)
    8000206e:	e822                	sd	s0,16(sp)
    80002070:	e426                	sd	s1,8(sp)
    80002072:	1000                	addi	s0,sp,32
    80002074:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002076:	0541                	addi	a0,a0,16
    80002078:	1f6010ef          	jal	8000326e <holdingsleep>
    8000207c:	c911                	beqz	a0,80002090 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    8000207e:	4585                	li	a1,1
    80002080:	8526                	mv	a0,s1
    80002082:	1df020ef          	jal	80004a60 <virtio_disk_rw>
}
    80002086:	60e2                	ld	ra,24(sp)
    80002088:	6442                	ld	s0,16(sp)
    8000208a:	64a2                	ld	s1,8(sp)
    8000208c:	6105                	addi	sp,sp,32
    8000208e:	8082                	ret
    panic("bwrite");
    80002090:	00005517          	auipc	a0,0x5
    80002094:	41850513          	addi	a0,a0,1048 # 800074a8 <etext+0x4a8>
    80002098:	446030ef          	jal	800054de <panic>

000000008000209c <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000209c:	1101                	addi	sp,sp,-32
    8000209e:	ec06                	sd	ra,24(sp)
    800020a0:	e822                	sd	s0,16(sp)
    800020a2:	e426                	sd	s1,8(sp)
    800020a4:	e04a                	sd	s2,0(sp)
    800020a6:	1000                	addi	s0,sp,32
    800020a8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800020aa:	01050913          	addi	s2,a0,16
    800020ae:	854a                	mv	a0,s2
    800020b0:	1be010ef          	jal	8000326e <holdingsleep>
    800020b4:	c125                	beqz	a0,80002114 <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    800020b6:	854a                	mv	a0,s2
    800020b8:	17e010ef          	jal	80003236 <releasesleep>

  acquire(&bcache.lock);
    800020bc:	0000e517          	auipc	a0,0xe
    800020c0:	19c50513          	addi	a0,a0,412 # 80010258 <bcache>
    800020c4:	758030ef          	jal	8000581c <acquire>
  b->refcnt--;
    800020c8:	40bc                	lw	a5,64(s1)
    800020ca:	37fd                	addiw	a5,a5,-1
    800020cc:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800020ce:	e79d                	bnez	a5,800020fc <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800020d0:	68b8                	ld	a4,80(s1)
    800020d2:	64bc                	ld	a5,72(s1)
    800020d4:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800020d6:	68b8                	ld	a4,80(s1)
    800020d8:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800020da:	00016797          	auipc	a5,0x16
    800020de:	17e78793          	addi	a5,a5,382 # 80018258 <bcache+0x8000>
    800020e2:	2b87b703          	ld	a4,696(a5)
    800020e6:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800020e8:	00016717          	auipc	a4,0x16
    800020ec:	3d870713          	addi	a4,a4,984 # 800184c0 <bcache+0x8268>
    800020f0:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800020f2:	2b87b703          	ld	a4,696(a5)
    800020f6:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800020f8:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800020fc:	0000e517          	auipc	a0,0xe
    80002100:	15c50513          	addi	a0,a0,348 # 80010258 <bcache>
    80002104:	7ac030ef          	jal	800058b0 <release>
}
    80002108:	60e2                	ld	ra,24(sp)
    8000210a:	6442                	ld	s0,16(sp)
    8000210c:	64a2                	ld	s1,8(sp)
    8000210e:	6902                	ld	s2,0(sp)
    80002110:	6105                	addi	sp,sp,32
    80002112:	8082                	ret
    panic("brelse");
    80002114:	00005517          	auipc	a0,0x5
    80002118:	39c50513          	addi	a0,a0,924 # 800074b0 <etext+0x4b0>
    8000211c:	3c2030ef          	jal	800054de <panic>

0000000080002120 <bpin>:

void
bpin(struct buf *b) {
    80002120:	1101                	addi	sp,sp,-32
    80002122:	ec06                	sd	ra,24(sp)
    80002124:	e822                	sd	s0,16(sp)
    80002126:	e426                	sd	s1,8(sp)
    80002128:	1000                	addi	s0,sp,32
    8000212a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000212c:	0000e517          	auipc	a0,0xe
    80002130:	12c50513          	addi	a0,a0,300 # 80010258 <bcache>
    80002134:	6e8030ef          	jal	8000581c <acquire>
  b->refcnt++;
    80002138:	40bc                	lw	a5,64(s1)
    8000213a:	2785                	addiw	a5,a5,1
    8000213c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000213e:	0000e517          	auipc	a0,0xe
    80002142:	11a50513          	addi	a0,a0,282 # 80010258 <bcache>
    80002146:	76a030ef          	jal	800058b0 <release>
}
    8000214a:	60e2                	ld	ra,24(sp)
    8000214c:	6442                	ld	s0,16(sp)
    8000214e:	64a2                	ld	s1,8(sp)
    80002150:	6105                	addi	sp,sp,32
    80002152:	8082                	ret

0000000080002154 <bunpin>:

void
bunpin(struct buf *b) {
    80002154:	1101                	addi	sp,sp,-32
    80002156:	ec06                	sd	ra,24(sp)
    80002158:	e822                	sd	s0,16(sp)
    8000215a:	e426                	sd	s1,8(sp)
    8000215c:	1000                	addi	s0,sp,32
    8000215e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002160:	0000e517          	auipc	a0,0xe
    80002164:	0f850513          	addi	a0,a0,248 # 80010258 <bcache>
    80002168:	6b4030ef          	jal	8000581c <acquire>
  b->refcnt--;
    8000216c:	40bc                	lw	a5,64(s1)
    8000216e:	37fd                	addiw	a5,a5,-1
    80002170:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002172:	0000e517          	auipc	a0,0xe
    80002176:	0e650513          	addi	a0,a0,230 # 80010258 <bcache>
    8000217a:	736030ef          	jal	800058b0 <release>
}
    8000217e:	60e2                	ld	ra,24(sp)
    80002180:	6442                	ld	s0,16(sp)
    80002182:	64a2                	ld	s1,8(sp)
    80002184:	6105                	addi	sp,sp,32
    80002186:	8082                	ret

0000000080002188 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002188:	1101                	addi	sp,sp,-32
    8000218a:	ec06                	sd	ra,24(sp)
    8000218c:	e822                	sd	s0,16(sp)
    8000218e:	e426                	sd	s1,8(sp)
    80002190:	e04a                	sd	s2,0(sp)
    80002192:	1000                	addi	s0,sp,32
    80002194:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002196:	00d5d79b          	srliw	a5,a1,0xd
    8000219a:	00016597          	auipc	a1,0x16
    8000219e:	79a5a583          	lw	a1,1946(a1) # 80018934 <sb+0x1c>
    800021a2:	9dbd                	addw	a1,a1,a5
    800021a4:	df1ff0ef          	jal	80001f94 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800021a8:	0074f713          	andi	a4,s1,7
    800021ac:	4785                	li	a5,1
    800021ae:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    800021b2:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    800021b4:	90d9                	srli	s1,s1,0x36
    800021b6:	00950733          	add	a4,a0,s1
    800021ba:	05874703          	lbu	a4,88(a4)
    800021be:	00e7f6b3          	and	a3,a5,a4
    800021c2:	c29d                	beqz	a3,800021e8 <bfree+0x60>
    800021c4:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800021c6:	94aa                	add	s1,s1,a0
    800021c8:	fff7c793          	not	a5,a5
    800021cc:	8f7d                	and	a4,a4,a5
    800021ce:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800021d2:	717000ef          	jal	800030e8 <log_write>
  brelse(bp);
    800021d6:	854a                	mv	a0,s2
    800021d8:	ec5ff0ef          	jal	8000209c <brelse>
}
    800021dc:	60e2                	ld	ra,24(sp)
    800021de:	6442                	ld	s0,16(sp)
    800021e0:	64a2                	ld	s1,8(sp)
    800021e2:	6902                	ld	s2,0(sp)
    800021e4:	6105                	addi	sp,sp,32
    800021e6:	8082                	ret
    panic("freeing free block");
    800021e8:	00005517          	auipc	a0,0x5
    800021ec:	2d050513          	addi	a0,a0,720 # 800074b8 <etext+0x4b8>
    800021f0:	2ee030ef          	jal	800054de <panic>

00000000800021f4 <balloc>:
{
    800021f4:	715d                	addi	sp,sp,-80
    800021f6:	e486                	sd	ra,72(sp)
    800021f8:	e0a2                	sd	s0,64(sp)
    800021fa:	fc26                	sd	s1,56(sp)
    800021fc:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    800021fe:	00016797          	auipc	a5,0x16
    80002202:	71e7a783          	lw	a5,1822(a5) # 8001891c <sb+0x4>
    80002206:	0e078263          	beqz	a5,800022ea <balloc+0xf6>
    8000220a:	f84a                	sd	s2,48(sp)
    8000220c:	f44e                	sd	s3,40(sp)
    8000220e:	f052                	sd	s4,32(sp)
    80002210:	ec56                	sd	s5,24(sp)
    80002212:	e85a                	sd	s6,16(sp)
    80002214:	e45e                	sd	s7,8(sp)
    80002216:	e062                	sd	s8,0(sp)
    80002218:	8baa                	mv	s7,a0
    8000221a:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    8000221c:	00016b17          	auipc	s6,0x16
    80002220:	6fcb0b13          	addi	s6,s6,1788 # 80018918 <sb>
      m = 1 << (bi % 8);
    80002224:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002226:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002228:	6c09                	lui	s8,0x2
    8000222a:	a09d                	j	80002290 <balloc+0x9c>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000222c:	97ca                	add	a5,a5,s2
    8000222e:	8e55                	or	a2,a2,a3
    80002230:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002234:	854a                	mv	a0,s2
    80002236:	6b3000ef          	jal	800030e8 <log_write>
        brelse(bp);
    8000223a:	854a                	mv	a0,s2
    8000223c:	e61ff0ef          	jal	8000209c <brelse>
  bp = bread(dev, bno);
    80002240:	85a6                	mv	a1,s1
    80002242:	855e                	mv	a0,s7
    80002244:	d51ff0ef          	jal	80001f94 <bread>
    80002248:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000224a:	40000613          	li	a2,1024
    8000224e:	4581                	li	a1,0
    80002250:	05850513          	addi	a0,a0,88
    80002254:	f0bfd0ef          	jal	8000015e <memset>
  log_write(bp);
    80002258:	854a                	mv	a0,s2
    8000225a:	68f000ef          	jal	800030e8 <log_write>
  brelse(bp);
    8000225e:	854a                	mv	a0,s2
    80002260:	e3dff0ef          	jal	8000209c <brelse>
}
    80002264:	7942                	ld	s2,48(sp)
    80002266:	79a2                	ld	s3,40(sp)
    80002268:	7a02                	ld	s4,32(sp)
    8000226a:	6ae2                	ld	s5,24(sp)
    8000226c:	6b42                	ld	s6,16(sp)
    8000226e:	6ba2                	ld	s7,8(sp)
    80002270:	6c02                	ld	s8,0(sp)
}
    80002272:	8526                	mv	a0,s1
    80002274:	60a6                	ld	ra,72(sp)
    80002276:	6406                	ld	s0,64(sp)
    80002278:	74e2                	ld	s1,56(sp)
    8000227a:	6161                	addi	sp,sp,80
    8000227c:	8082                	ret
    brelse(bp);
    8000227e:	854a                	mv	a0,s2
    80002280:	e1dff0ef          	jal	8000209c <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002284:	015c0abb          	addw	s5,s8,s5
    80002288:	004b2783          	lw	a5,4(s6)
    8000228c:	04faf863          	bgeu	s5,a5,800022dc <balloc+0xe8>
    bp = bread(dev, BBLOCK(b, sb));
    80002290:	40dad59b          	sraiw	a1,s5,0xd
    80002294:	01cb2783          	lw	a5,28(s6)
    80002298:	9dbd                	addw	a1,a1,a5
    8000229a:	855e                	mv	a0,s7
    8000229c:	cf9ff0ef          	jal	80001f94 <bread>
    800022a0:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022a2:	004b2503          	lw	a0,4(s6)
    800022a6:	84d6                	mv	s1,s5
    800022a8:	4701                	li	a4,0
    800022aa:	fca4fae3          	bgeu	s1,a0,8000227e <balloc+0x8a>
      m = 1 << (bi % 8);
    800022ae:	00777693          	andi	a3,a4,7
    800022b2:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800022b6:	41f7579b          	sraiw	a5,a4,0x1f
    800022ba:	01d7d79b          	srliw	a5,a5,0x1d
    800022be:	9fb9                	addw	a5,a5,a4
    800022c0:	4037d79b          	sraiw	a5,a5,0x3
    800022c4:	00f90633          	add	a2,s2,a5
    800022c8:	05864603          	lbu	a2,88(a2)
    800022cc:	00c6f5b3          	and	a1,a3,a2
    800022d0:	ddb1                	beqz	a1,8000222c <balloc+0x38>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022d2:	2705                	addiw	a4,a4,1
    800022d4:	2485                	addiw	s1,s1,1
    800022d6:	fd471ae3          	bne	a4,s4,800022aa <balloc+0xb6>
    800022da:	b755                	j	8000227e <balloc+0x8a>
    800022dc:	7942                	ld	s2,48(sp)
    800022de:	79a2                	ld	s3,40(sp)
    800022e0:	7a02                	ld	s4,32(sp)
    800022e2:	6ae2                	ld	s5,24(sp)
    800022e4:	6b42                	ld	s6,16(sp)
    800022e6:	6ba2                	ld	s7,8(sp)
    800022e8:	6c02                	ld	s8,0(sp)
  printf("balloc: out of blocks\n");
    800022ea:	00005517          	auipc	a0,0x5
    800022ee:	1e650513          	addi	a0,a0,486 # 800074d0 <etext+0x4d0>
    800022f2:	6dd020ef          	jal	800051ce <printf>
  return 0;
    800022f6:	4481                	li	s1,0
    800022f8:	bfad                	j	80002272 <balloc+0x7e>

00000000800022fa <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800022fa:	7179                	addi	sp,sp,-48
    800022fc:	f406                	sd	ra,40(sp)
    800022fe:	f022                	sd	s0,32(sp)
    80002300:	ec26                	sd	s1,24(sp)
    80002302:	e84a                	sd	s2,16(sp)
    80002304:	e44e                	sd	s3,8(sp)
    80002306:	1800                	addi	s0,sp,48
    80002308:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000230a:	47ad                	li	a5,11
    8000230c:	02b7e363          	bltu	a5,a1,80002332 <bmap+0x38>
    if((addr = ip->addrs[bn]) == 0){
    80002310:	02059793          	slli	a5,a1,0x20
    80002314:	01e7d593          	srli	a1,a5,0x1e
    80002318:	00b509b3          	add	s3,a0,a1
    8000231c:	0509a483          	lw	s1,80(s3)
    80002320:	e0b5                	bnez	s1,80002384 <bmap+0x8a>
      addr = balloc(ip->dev);
    80002322:	4108                	lw	a0,0(a0)
    80002324:	ed1ff0ef          	jal	800021f4 <balloc>
    80002328:	84aa                	mv	s1,a0
      if(addr == 0)
    8000232a:	cd29                	beqz	a0,80002384 <bmap+0x8a>
        return 0;
      ip->addrs[bn] = addr;
    8000232c:	04a9a823          	sw	a0,80(s3)
    80002330:	a891                	j	80002384 <bmap+0x8a>
    }
    return addr;
  }
  bn -= NDIRECT;
    80002332:	ff45879b          	addiw	a5,a1,-12
    80002336:	873e                	mv	a4,a5
    80002338:	89be                	mv	s3,a5

  if(bn < NINDIRECT){
    8000233a:	0ff00793          	li	a5,255
    8000233e:	06e7e763          	bltu	a5,a4,800023ac <bmap+0xb2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002342:	08052483          	lw	s1,128(a0)
    80002346:	e891                	bnez	s1,8000235a <bmap+0x60>
      addr = balloc(ip->dev);
    80002348:	4108                	lw	a0,0(a0)
    8000234a:	eabff0ef          	jal	800021f4 <balloc>
    8000234e:	84aa                	mv	s1,a0
      if(addr == 0)
    80002350:	c915                	beqz	a0,80002384 <bmap+0x8a>
    80002352:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002354:	08a92023          	sw	a0,128(s2)
    80002358:	a011                	j	8000235c <bmap+0x62>
    8000235a:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    8000235c:	85a6                	mv	a1,s1
    8000235e:	00092503          	lw	a0,0(s2)
    80002362:	c33ff0ef          	jal	80001f94 <bread>
    80002366:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002368:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000236c:	02099713          	slli	a4,s3,0x20
    80002370:	01e75593          	srli	a1,a4,0x1e
    80002374:	97ae                	add	a5,a5,a1
    80002376:	89be                	mv	s3,a5
    80002378:	4384                	lw	s1,0(a5)
    8000237a:	cc89                	beqz	s1,80002394 <bmap+0x9a>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    8000237c:	8552                	mv	a0,s4
    8000237e:	d1fff0ef          	jal	8000209c <brelse>
    return addr;
    80002382:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002384:	8526                	mv	a0,s1
    80002386:	70a2                	ld	ra,40(sp)
    80002388:	7402                	ld	s0,32(sp)
    8000238a:	64e2                	ld	s1,24(sp)
    8000238c:	6942                	ld	s2,16(sp)
    8000238e:	69a2                	ld	s3,8(sp)
    80002390:	6145                	addi	sp,sp,48
    80002392:	8082                	ret
      addr = balloc(ip->dev);
    80002394:	00092503          	lw	a0,0(s2)
    80002398:	e5dff0ef          	jal	800021f4 <balloc>
    8000239c:	84aa                	mv	s1,a0
      if(addr){
    8000239e:	dd79                	beqz	a0,8000237c <bmap+0x82>
        a[bn] = addr;
    800023a0:	00a9a023          	sw	a0,0(s3)
        log_write(bp);
    800023a4:	8552                	mv	a0,s4
    800023a6:	543000ef          	jal	800030e8 <log_write>
    800023aa:	bfc9                	j	8000237c <bmap+0x82>
    800023ac:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    800023ae:	00005517          	auipc	a0,0x5
    800023b2:	13a50513          	addi	a0,a0,314 # 800074e8 <etext+0x4e8>
    800023b6:	128030ef          	jal	800054de <panic>

00000000800023ba <iget>:
{
    800023ba:	7179                	addi	sp,sp,-48
    800023bc:	f406                	sd	ra,40(sp)
    800023be:	f022                	sd	s0,32(sp)
    800023c0:	ec26                	sd	s1,24(sp)
    800023c2:	e84a                	sd	s2,16(sp)
    800023c4:	e44e                	sd	s3,8(sp)
    800023c6:	e052                	sd	s4,0(sp)
    800023c8:	1800                	addi	s0,sp,48
    800023ca:	892a                	mv	s2,a0
    800023cc:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800023ce:	00016517          	auipc	a0,0x16
    800023d2:	56a50513          	addi	a0,a0,1386 # 80018938 <itable>
    800023d6:	446030ef          	jal	8000581c <acquire>
  empty = 0;
    800023da:	4981                	li	s3,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800023dc:	00016497          	auipc	s1,0x16
    800023e0:	57448493          	addi	s1,s1,1396 # 80018950 <itable+0x18>
    800023e4:	00018697          	auipc	a3,0x18
    800023e8:	ffc68693          	addi	a3,a3,-4 # 8001a3e0 <log>
    800023ec:	a809                	j	800023fe <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800023ee:	e781                	bnez	a5,800023f6 <iget+0x3c>
    800023f0:	00099363          	bnez	s3,800023f6 <iget+0x3c>
      empty = ip;
    800023f4:	89a6                	mv	s3,s1
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800023f6:	08848493          	addi	s1,s1,136
    800023fa:	02d48563          	beq	s1,a3,80002424 <iget+0x6a>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800023fe:	449c                	lw	a5,8(s1)
    80002400:	fef057e3          	blez	a5,800023ee <iget+0x34>
    80002404:	4098                	lw	a4,0(s1)
    80002406:	ff2718e3          	bne	a4,s2,800023f6 <iget+0x3c>
    8000240a:	40d8                	lw	a4,4(s1)
    8000240c:	ff4715e3          	bne	a4,s4,800023f6 <iget+0x3c>
      ip->ref++;
    80002410:	2785                	addiw	a5,a5,1
    80002412:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002414:	00016517          	auipc	a0,0x16
    80002418:	52450513          	addi	a0,a0,1316 # 80018938 <itable>
    8000241c:	494030ef          	jal	800058b0 <release>
      return ip;
    80002420:	89a6                	mv	s3,s1
    80002422:	a015                	j	80002446 <iget+0x8c>
  if(empty == 0)
    80002424:	02098a63          	beqz	s3,80002458 <iget+0x9e>
  ip->dev = dev;
    80002428:	0129a023          	sw	s2,0(s3)
  ip->inum = inum;
    8000242c:	0149a223          	sw	s4,4(s3)
  ip->ref = 1;
    80002430:	4785                	li	a5,1
    80002432:	00f9a423          	sw	a5,8(s3)
  ip->valid = 0;
    80002436:	0409a023          	sw	zero,64(s3)
  release(&itable.lock);
    8000243a:	00016517          	auipc	a0,0x16
    8000243e:	4fe50513          	addi	a0,a0,1278 # 80018938 <itable>
    80002442:	46e030ef          	jal	800058b0 <release>
}
    80002446:	854e                	mv	a0,s3
    80002448:	70a2                	ld	ra,40(sp)
    8000244a:	7402                	ld	s0,32(sp)
    8000244c:	64e2                	ld	s1,24(sp)
    8000244e:	6942                	ld	s2,16(sp)
    80002450:	69a2                	ld	s3,8(sp)
    80002452:	6a02                	ld	s4,0(sp)
    80002454:	6145                	addi	sp,sp,48
    80002456:	8082                	ret
    panic("iget: no inodes");
    80002458:	00005517          	auipc	a0,0x5
    8000245c:	0a850513          	addi	a0,a0,168 # 80007500 <etext+0x500>
    80002460:	07e030ef          	jal	800054de <panic>

0000000080002464 <fsinit>:
fsinit(int dev) {
    80002464:	1101                	addi	sp,sp,-32
    80002466:	ec06                	sd	ra,24(sp)
    80002468:	e822                	sd	s0,16(sp)
    8000246a:	e426                	sd	s1,8(sp)
    8000246c:	e04a                	sd	s2,0(sp)
    8000246e:	1000                	addi	s0,sp,32
    80002470:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002472:	4585                	li	a1,1
    80002474:	b21ff0ef          	jal	80001f94 <bread>
    80002478:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    8000247a:	02000613          	li	a2,32
    8000247e:	05850593          	addi	a1,a0,88
    80002482:	00016517          	auipc	a0,0x16
    80002486:	49650513          	addi	a0,a0,1174 # 80018918 <sb>
    8000248a:	d35fd0ef          	jal	800001be <memmove>
  brelse(bp);
    8000248e:	8526                	mv	a0,s1
    80002490:	c0dff0ef          	jal	8000209c <brelse>
  if(sb.magic != FSMAGIC)
    80002494:	00016717          	auipc	a4,0x16
    80002498:	48472703          	lw	a4,1156(a4) # 80018918 <sb>
    8000249c:	102037b7          	lui	a5,0x10203
    800024a0:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800024a4:	00f71f63          	bne	a4,a5,800024c2 <fsinit+0x5e>
  initlog(dev, &sb);
    800024a8:	00016597          	auipc	a1,0x16
    800024ac:	47058593          	addi	a1,a1,1136 # 80018918 <sb>
    800024b0:	854a                	mv	a0,s2
    800024b2:	219000ef          	jal	80002eca <initlog>
}
    800024b6:	60e2                	ld	ra,24(sp)
    800024b8:	6442                	ld	s0,16(sp)
    800024ba:	64a2                	ld	s1,8(sp)
    800024bc:	6902                	ld	s2,0(sp)
    800024be:	6105                	addi	sp,sp,32
    800024c0:	8082                	ret
    panic("invalid file system");
    800024c2:	00005517          	auipc	a0,0x5
    800024c6:	04e50513          	addi	a0,a0,78 # 80007510 <etext+0x510>
    800024ca:	014030ef          	jal	800054de <panic>

00000000800024ce <iinit>:
{
    800024ce:	7179                	addi	sp,sp,-48
    800024d0:	f406                	sd	ra,40(sp)
    800024d2:	f022                	sd	s0,32(sp)
    800024d4:	ec26                	sd	s1,24(sp)
    800024d6:	e84a                	sd	s2,16(sp)
    800024d8:	e44e                	sd	s3,8(sp)
    800024da:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800024dc:	00005597          	auipc	a1,0x5
    800024e0:	04c58593          	addi	a1,a1,76 # 80007528 <etext+0x528>
    800024e4:	00016517          	auipc	a0,0x16
    800024e8:	45450513          	addi	a0,a0,1108 # 80018938 <itable>
    800024ec:	2a6030ef          	jal	80005792 <initlock>
  for(i = 0; i < NINODE; i++) {
    800024f0:	00016497          	auipc	s1,0x16
    800024f4:	47048493          	addi	s1,s1,1136 # 80018960 <itable+0x28>
    800024f8:	00018997          	auipc	s3,0x18
    800024fc:	ef898993          	addi	s3,s3,-264 # 8001a3f0 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002500:	00005917          	auipc	s2,0x5
    80002504:	03090913          	addi	s2,s2,48 # 80007530 <etext+0x530>
    80002508:	85ca                	mv	a1,s2
    8000250a:	8526                	mv	a0,s1
    8000250c:	4af000ef          	jal	800031ba <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002510:	08848493          	addi	s1,s1,136
    80002514:	ff349ae3          	bne	s1,s3,80002508 <iinit+0x3a>
}
    80002518:	70a2                	ld	ra,40(sp)
    8000251a:	7402                	ld	s0,32(sp)
    8000251c:	64e2                	ld	s1,24(sp)
    8000251e:	6942                	ld	s2,16(sp)
    80002520:	69a2                	ld	s3,8(sp)
    80002522:	6145                	addi	sp,sp,48
    80002524:	8082                	ret

0000000080002526 <ialloc>:
{
    80002526:	7139                	addi	sp,sp,-64
    80002528:	fc06                	sd	ra,56(sp)
    8000252a:	f822                	sd	s0,48(sp)
    8000252c:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    8000252e:	00016717          	auipc	a4,0x16
    80002532:	3f672703          	lw	a4,1014(a4) # 80018924 <sb+0xc>
    80002536:	4785                	li	a5,1
    80002538:	06e7f063          	bgeu	a5,a4,80002598 <ialloc+0x72>
    8000253c:	f426                	sd	s1,40(sp)
    8000253e:	f04a                	sd	s2,32(sp)
    80002540:	ec4e                	sd	s3,24(sp)
    80002542:	e852                	sd	s4,16(sp)
    80002544:	e456                	sd	s5,8(sp)
    80002546:	e05a                	sd	s6,0(sp)
    80002548:	8aaa                	mv	s5,a0
    8000254a:	8b2e                	mv	s6,a1
    8000254c:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    8000254e:	00016a17          	auipc	s4,0x16
    80002552:	3caa0a13          	addi	s4,s4,970 # 80018918 <sb>
    80002556:	00495593          	srli	a1,s2,0x4
    8000255a:	018a2783          	lw	a5,24(s4)
    8000255e:	9dbd                	addw	a1,a1,a5
    80002560:	8556                	mv	a0,s5
    80002562:	a33ff0ef          	jal	80001f94 <bread>
    80002566:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002568:	05850993          	addi	s3,a0,88
    8000256c:	00f97793          	andi	a5,s2,15
    80002570:	079a                	slli	a5,a5,0x6
    80002572:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002574:	00099783          	lh	a5,0(s3)
    80002578:	cb9d                	beqz	a5,800025ae <ialloc+0x88>
    brelse(bp);
    8000257a:	b23ff0ef          	jal	8000209c <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000257e:	0905                	addi	s2,s2,1
    80002580:	00ca2703          	lw	a4,12(s4)
    80002584:	0009079b          	sext.w	a5,s2
    80002588:	fce7e7e3          	bltu	a5,a4,80002556 <ialloc+0x30>
    8000258c:	74a2                	ld	s1,40(sp)
    8000258e:	7902                	ld	s2,32(sp)
    80002590:	69e2                	ld	s3,24(sp)
    80002592:	6a42                	ld	s4,16(sp)
    80002594:	6aa2                	ld	s5,8(sp)
    80002596:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    80002598:	00005517          	auipc	a0,0x5
    8000259c:	fa050513          	addi	a0,a0,-96 # 80007538 <etext+0x538>
    800025a0:	42f020ef          	jal	800051ce <printf>
  return 0;
    800025a4:	4501                	li	a0,0
}
    800025a6:	70e2                	ld	ra,56(sp)
    800025a8:	7442                	ld	s0,48(sp)
    800025aa:	6121                	addi	sp,sp,64
    800025ac:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    800025ae:	04000613          	li	a2,64
    800025b2:	4581                	li	a1,0
    800025b4:	854e                	mv	a0,s3
    800025b6:	ba9fd0ef          	jal	8000015e <memset>
      dip->type = type;
    800025ba:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800025be:	8526                	mv	a0,s1
    800025c0:	329000ef          	jal	800030e8 <log_write>
      brelse(bp);
    800025c4:	8526                	mv	a0,s1
    800025c6:	ad7ff0ef          	jal	8000209c <brelse>
      return iget(dev, inum);
    800025ca:	0009059b          	sext.w	a1,s2
    800025ce:	8556                	mv	a0,s5
    800025d0:	debff0ef          	jal	800023ba <iget>
    800025d4:	74a2                	ld	s1,40(sp)
    800025d6:	7902                	ld	s2,32(sp)
    800025d8:	69e2                	ld	s3,24(sp)
    800025da:	6a42                	ld	s4,16(sp)
    800025dc:	6aa2                	ld	s5,8(sp)
    800025de:	6b02                	ld	s6,0(sp)
    800025e0:	b7d9                	j	800025a6 <ialloc+0x80>

00000000800025e2 <iupdate>:
{
    800025e2:	1101                	addi	sp,sp,-32
    800025e4:	ec06                	sd	ra,24(sp)
    800025e6:	e822                	sd	s0,16(sp)
    800025e8:	e426                	sd	s1,8(sp)
    800025ea:	e04a                	sd	s2,0(sp)
    800025ec:	1000                	addi	s0,sp,32
    800025ee:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800025f0:	415c                	lw	a5,4(a0)
    800025f2:	0047d79b          	srliw	a5,a5,0x4
    800025f6:	00016597          	auipc	a1,0x16
    800025fa:	33a5a583          	lw	a1,826(a1) # 80018930 <sb+0x18>
    800025fe:	9dbd                	addw	a1,a1,a5
    80002600:	4108                	lw	a0,0(a0)
    80002602:	993ff0ef          	jal	80001f94 <bread>
    80002606:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002608:	05850793          	addi	a5,a0,88
    8000260c:	40d8                	lw	a4,4(s1)
    8000260e:	8b3d                	andi	a4,a4,15
    80002610:	071a                	slli	a4,a4,0x6
    80002612:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002614:	04449703          	lh	a4,68(s1)
    80002618:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    8000261c:	04649703          	lh	a4,70(s1)
    80002620:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002624:	04849703          	lh	a4,72(s1)
    80002628:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000262c:	04a49703          	lh	a4,74(s1)
    80002630:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002634:	44f8                	lw	a4,76(s1)
    80002636:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002638:	03400613          	li	a2,52
    8000263c:	05048593          	addi	a1,s1,80
    80002640:	00c78513          	addi	a0,a5,12
    80002644:	b7bfd0ef          	jal	800001be <memmove>
  log_write(bp);
    80002648:	854a                	mv	a0,s2
    8000264a:	29f000ef          	jal	800030e8 <log_write>
  brelse(bp);
    8000264e:	854a                	mv	a0,s2
    80002650:	a4dff0ef          	jal	8000209c <brelse>
}
    80002654:	60e2                	ld	ra,24(sp)
    80002656:	6442                	ld	s0,16(sp)
    80002658:	64a2                	ld	s1,8(sp)
    8000265a:	6902                	ld	s2,0(sp)
    8000265c:	6105                	addi	sp,sp,32
    8000265e:	8082                	ret

0000000080002660 <idup>:
{
    80002660:	1101                	addi	sp,sp,-32
    80002662:	ec06                	sd	ra,24(sp)
    80002664:	e822                	sd	s0,16(sp)
    80002666:	e426                	sd	s1,8(sp)
    80002668:	1000                	addi	s0,sp,32
    8000266a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    8000266c:	00016517          	auipc	a0,0x16
    80002670:	2cc50513          	addi	a0,a0,716 # 80018938 <itable>
    80002674:	1a8030ef          	jal	8000581c <acquire>
  ip->ref++;
    80002678:	449c                	lw	a5,8(s1)
    8000267a:	2785                	addiw	a5,a5,1
    8000267c:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000267e:	00016517          	auipc	a0,0x16
    80002682:	2ba50513          	addi	a0,a0,698 # 80018938 <itable>
    80002686:	22a030ef          	jal	800058b0 <release>
}
    8000268a:	8526                	mv	a0,s1
    8000268c:	60e2                	ld	ra,24(sp)
    8000268e:	6442                	ld	s0,16(sp)
    80002690:	64a2                	ld	s1,8(sp)
    80002692:	6105                	addi	sp,sp,32
    80002694:	8082                	ret

0000000080002696 <ilock>:
{
    80002696:	1101                	addi	sp,sp,-32
    80002698:	ec06                	sd	ra,24(sp)
    8000269a:	e822                	sd	s0,16(sp)
    8000269c:	e426                	sd	s1,8(sp)
    8000269e:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    800026a0:	cd19                	beqz	a0,800026be <ilock+0x28>
    800026a2:	84aa                	mv	s1,a0
    800026a4:	451c                	lw	a5,8(a0)
    800026a6:	00f05c63          	blez	a5,800026be <ilock+0x28>
  acquiresleep(&ip->lock);
    800026aa:	0541                	addi	a0,a0,16
    800026ac:	345000ef          	jal	800031f0 <acquiresleep>
  if(ip->valid == 0){
    800026b0:	40bc                	lw	a5,64(s1)
    800026b2:	cf89                	beqz	a5,800026cc <ilock+0x36>
}
    800026b4:	60e2                	ld	ra,24(sp)
    800026b6:	6442                	ld	s0,16(sp)
    800026b8:	64a2                	ld	s1,8(sp)
    800026ba:	6105                	addi	sp,sp,32
    800026bc:	8082                	ret
    800026be:	e04a                	sd	s2,0(sp)
    panic("ilock");
    800026c0:	00005517          	auipc	a0,0x5
    800026c4:	e9050513          	addi	a0,a0,-368 # 80007550 <etext+0x550>
    800026c8:	617020ef          	jal	800054de <panic>
    800026cc:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800026ce:	40dc                	lw	a5,4(s1)
    800026d0:	0047d79b          	srliw	a5,a5,0x4
    800026d4:	00016597          	auipc	a1,0x16
    800026d8:	25c5a583          	lw	a1,604(a1) # 80018930 <sb+0x18>
    800026dc:	9dbd                	addw	a1,a1,a5
    800026de:	4088                	lw	a0,0(s1)
    800026e0:	8b5ff0ef          	jal	80001f94 <bread>
    800026e4:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800026e6:	05850593          	addi	a1,a0,88
    800026ea:	40dc                	lw	a5,4(s1)
    800026ec:	8bbd                	andi	a5,a5,15
    800026ee:	079a                	slli	a5,a5,0x6
    800026f0:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800026f2:	00059783          	lh	a5,0(a1)
    800026f6:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    800026fa:	00259783          	lh	a5,2(a1)
    800026fe:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002702:	00459783          	lh	a5,4(a1)
    80002706:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    8000270a:	00659783          	lh	a5,6(a1)
    8000270e:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002712:	459c                	lw	a5,8(a1)
    80002714:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002716:	03400613          	li	a2,52
    8000271a:	05b1                	addi	a1,a1,12
    8000271c:	05048513          	addi	a0,s1,80
    80002720:	a9ffd0ef          	jal	800001be <memmove>
    brelse(bp);
    80002724:	854a                	mv	a0,s2
    80002726:	977ff0ef          	jal	8000209c <brelse>
    ip->valid = 1;
    8000272a:	4785                	li	a5,1
    8000272c:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    8000272e:	04449783          	lh	a5,68(s1)
    80002732:	c399                	beqz	a5,80002738 <ilock+0xa2>
    80002734:	6902                	ld	s2,0(sp)
    80002736:	bfbd                	j	800026b4 <ilock+0x1e>
      panic("ilock: no type");
    80002738:	00005517          	auipc	a0,0x5
    8000273c:	e2050513          	addi	a0,a0,-480 # 80007558 <etext+0x558>
    80002740:	59f020ef          	jal	800054de <panic>

0000000080002744 <iunlock>:
{
    80002744:	1101                	addi	sp,sp,-32
    80002746:	ec06                	sd	ra,24(sp)
    80002748:	e822                	sd	s0,16(sp)
    8000274a:	e426                	sd	s1,8(sp)
    8000274c:	e04a                	sd	s2,0(sp)
    8000274e:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002750:	c505                	beqz	a0,80002778 <iunlock+0x34>
    80002752:	84aa                	mv	s1,a0
    80002754:	01050913          	addi	s2,a0,16
    80002758:	854a                	mv	a0,s2
    8000275a:	315000ef          	jal	8000326e <holdingsleep>
    8000275e:	cd09                	beqz	a0,80002778 <iunlock+0x34>
    80002760:	449c                	lw	a5,8(s1)
    80002762:	00f05b63          	blez	a5,80002778 <iunlock+0x34>
  releasesleep(&ip->lock);
    80002766:	854a                	mv	a0,s2
    80002768:	2cf000ef          	jal	80003236 <releasesleep>
}
    8000276c:	60e2                	ld	ra,24(sp)
    8000276e:	6442                	ld	s0,16(sp)
    80002770:	64a2                	ld	s1,8(sp)
    80002772:	6902                	ld	s2,0(sp)
    80002774:	6105                	addi	sp,sp,32
    80002776:	8082                	ret
    panic("iunlock");
    80002778:	00005517          	auipc	a0,0x5
    8000277c:	df050513          	addi	a0,a0,-528 # 80007568 <etext+0x568>
    80002780:	55f020ef          	jal	800054de <panic>

0000000080002784 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002784:	7179                	addi	sp,sp,-48
    80002786:	f406                	sd	ra,40(sp)
    80002788:	f022                	sd	s0,32(sp)
    8000278a:	ec26                	sd	s1,24(sp)
    8000278c:	e84a                	sd	s2,16(sp)
    8000278e:	e44e                	sd	s3,8(sp)
    80002790:	1800                	addi	s0,sp,48
    80002792:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002794:	05050493          	addi	s1,a0,80
    80002798:	08050913          	addi	s2,a0,128
    8000279c:	a021                	j	800027a4 <itrunc+0x20>
    8000279e:	0491                	addi	s1,s1,4
    800027a0:	01248b63          	beq	s1,s2,800027b6 <itrunc+0x32>
    if(ip->addrs[i]){
    800027a4:	408c                	lw	a1,0(s1)
    800027a6:	dde5                	beqz	a1,8000279e <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    800027a8:	0009a503          	lw	a0,0(s3)
    800027ac:	9ddff0ef          	jal	80002188 <bfree>
      ip->addrs[i] = 0;
    800027b0:	0004a023          	sw	zero,0(s1)
    800027b4:	b7ed                	j	8000279e <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    800027b6:	0809a583          	lw	a1,128(s3)
    800027ba:	ed89                	bnez	a1,800027d4 <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800027bc:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800027c0:	854e                	mv	a0,s3
    800027c2:	e21ff0ef          	jal	800025e2 <iupdate>
}
    800027c6:	70a2                	ld	ra,40(sp)
    800027c8:	7402                	ld	s0,32(sp)
    800027ca:	64e2                	ld	s1,24(sp)
    800027cc:	6942                	ld	s2,16(sp)
    800027ce:	69a2                	ld	s3,8(sp)
    800027d0:	6145                	addi	sp,sp,48
    800027d2:	8082                	ret
    800027d4:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800027d6:	0009a503          	lw	a0,0(s3)
    800027da:	fbaff0ef          	jal	80001f94 <bread>
    800027de:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    800027e0:	05850493          	addi	s1,a0,88
    800027e4:	45850913          	addi	s2,a0,1112
    800027e8:	a021                	j	800027f0 <itrunc+0x6c>
    800027ea:	0491                	addi	s1,s1,4
    800027ec:	01248963          	beq	s1,s2,800027fe <itrunc+0x7a>
      if(a[j])
    800027f0:	408c                	lw	a1,0(s1)
    800027f2:	dde5                	beqz	a1,800027ea <itrunc+0x66>
        bfree(ip->dev, a[j]);
    800027f4:	0009a503          	lw	a0,0(s3)
    800027f8:	991ff0ef          	jal	80002188 <bfree>
    800027fc:	b7fd                	j	800027ea <itrunc+0x66>
    brelse(bp);
    800027fe:	8552                	mv	a0,s4
    80002800:	89dff0ef          	jal	8000209c <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002804:	0809a583          	lw	a1,128(s3)
    80002808:	0009a503          	lw	a0,0(s3)
    8000280c:	97dff0ef          	jal	80002188 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002810:	0809a023          	sw	zero,128(s3)
    80002814:	6a02                	ld	s4,0(sp)
    80002816:	b75d                	j	800027bc <itrunc+0x38>

0000000080002818 <iput>:
{
    80002818:	1101                	addi	sp,sp,-32
    8000281a:	ec06                	sd	ra,24(sp)
    8000281c:	e822                	sd	s0,16(sp)
    8000281e:	e426                	sd	s1,8(sp)
    80002820:	1000                	addi	s0,sp,32
    80002822:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002824:	00016517          	auipc	a0,0x16
    80002828:	11450513          	addi	a0,a0,276 # 80018938 <itable>
    8000282c:	7f1020ef          	jal	8000581c <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002830:	4498                	lw	a4,8(s1)
    80002832:	4785                	li	a5,1
    80002834:	02f70063          	beq	a4,a5,80002854 <iput+0x3c>
  ip->ref--;
    80002838:	449c                	lw	a5,8(s1)
    8000283a:	37fd                	addiw	a5,a5,-1
    8000283c:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000283e:	00016517          	auipc	a0,0x16
    80002842:	0fa50513          	addi	a0,a0,250 # 80018938 <itable>
    80002846:	06a030ef          	jal	800058b0 <release>
}
    8000284a:	60e2                	ld	ra,24(sp)
    8000284c:	6442                	ld	s0,16(sp)
    8000284e:	64a2                	ld	s1,8(sp)
    80002850:	6105                	addi	sp,sp,32
    80002852:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002854:	40bc                	lw	a5,64(s1)
    80002856:	d3ed                	beqz	a5,80002838 <iput+0x20>
    80002858:	04a49783          	lh	a5,74(s1)
    8000285c:	fff1                	bnez	a5,80002838 <iput+0x20>
    8000285e:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002860:	01048793          	addi	a5,s1,16
    80002864:	893e                	mv	s2,a5
    80002866:	853e                	mv	a0,a5
    80002868:	189000ef          	jal	800031f0 <acquiresleep>
    release(&itable.lock);
    8000286c:	00016517          	auipc	a0,0x16
    80002870:	0cc50513          	addi	a0,a0,204 # 80018938 <itable>
    80002874:	03c030ef          	jal	800058b0 <release>
    itrunc(ip);
    80002878:	8526                	mv	a0,s1
    8000287a:	f0bff0ef          	jal	80002784 <itrunc>
    ip->type = 0;
    8000287e:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002882:	8526                	mv	a0,s1
    80002884:	d5fff0ef          	jal	800025e2 <iupdate>
    ip->valid = 0;
    80002888:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    8000288c:	854a                	mv	a0,s2
    8000288e:	1a9000ef          	jal	80003236 <releasesleep>
    acquire(&itable.lock);
    80002892:	00016517          	auipc	a0,0x16
    80002896:	0a650513          	addi	a0,a0,166 # 80018938 <itable>
    8000289a:	783020ef          	jal	8000581c <acquire>
    8000289e:	6902                	ld	s2,0(sp)
    800028a0:	bf61                	j	80002838 <iput+0x20>

00000000800028a2 <iunlockput>:
{
    800028a2:	1101                	addi	sp,sp,-32
    800028a4:	ec06                	sd	ra,24(sp)
    800028a6:	e822                	sd	s0,16(sp)
    800028a8:	e426                	sd	s1,8(sp)
    800028aa:	1000                	addi	s0,sp,32
    800028ac:	84aa                	mv	s1,a0
  iunlock(ip);
    800028ae:	e97ff0ef          	jal	80002744 <iunlock>
  iput(ip);
    800028b2:	8526                	mv	a0,s1
    800028b4:	f65ff0ef          	jal	80002818 <iput>
}
    800028b8:	60e2                	ld	ra,24(sp)
    800028ba:	6442                	ld	s0,16(sp)
    800028bc:	64a2                	ld	s1,8(sp)
    800028be:	6105                	addi	sp,sp,32
    800028c0:	8082                	ret

00000000800028c2 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    800028c2:	1141                	addi	sp,sp,-16
    800028c4:	e406                	sd	ra,8(sp)
    800028c6:	e022                	sd	s0,0(sp)
    800028c8:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    800028ca:	411c                	lw	a5,0(a0)
    800028cc:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800028ce:	415c                	lw	a5,4(a0)
    800028d0:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800028d2:	04451783          	lh	a5,68(a0)
    800028d6:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800028da:	04a51783          	lh	a5,74(a0)
    800028de:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800028e2:	04c56783          	lwu	a5,76(a0)
    800028e6:	e99c                	sd	a5,16(a1)
}
    800028e8:	60a2                	ld	ra,8(sp)
    800028ea:	6402                	ld	s0,0(sp)
    800028ec:	0141                	addi	sp,sp,16
    800028ee:	8082                	ret

00000000800028f0 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800028f0:	457c                	lw	a5,76(a0)
    800028f2:	0ed7e663          	bltu	a5,a3,800029de <readi+0xee>
{
    800028f6:	7159                	addi	sp,sp,-112
    800028f8:	f486                	sd	ra,104(sp)
    800028fa:	f0a2                	sd	s0,96(sp)
    800028fc:	eca6                	sd	s1,88(sp)
    800028fe:	e0d2                	sd	s4,64(sp)
    80002900:	fc56                	sd	s5,56(sp)
    80002902:	f85a                	sd	s6,48(sp)
    80002904:	f45e                	sd	s7,40(sp)
    80002906:	1880                	addi	s0,sp,112
    80002908:	8b2a                	mv	s6,a0
    8000290a:	8bae                	mv	s7,a1
    8000290c:	8a32                	mv	s4,a2
    8000290e:	84b6                	mv	s1,a3
    80002910:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002912:	9f35                	addw	a4,a4,a3
    return 0;
    80002914:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002916:	0ad76b63          	bltu	a4,a3,800029cc <readi+0xdc>
    8000291a:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    8000291c:	00e7f463          	bgeu	a5,a4,80002924 <readi+0x34>
    n = ip->size - off;
    80002920:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002924:	080a8b63          	beqz	s5,800029ba <readi+0xca>
    80002928:	e8ca                	sd	s2,80(sp)
    8000292a:	f062                	sd	s8,32(sp)
    8000292c:	ec66                	sd	s9,24(sp)
    8000292e:	e86a                	sd	s10,16(sp)
    80002930:	e46e                	sd	s11,8(sp)
    80002932:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002934:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002938:	5c7d                	li	s8,-1
    8000293a:	a80d                	j	8000296c <readi+0x7c>
    8000293c:	020d1d93          	slli	s11,s10,0x20
    80002940:	020ddd93          	srli	s11,s11,0x20
    80002944:	05890613          	addi	a2,s2,88
    80002948:	86ee                	mv	a3,s11
    8000294a:	963e                	add	a2,a2,a5
    8000294c:	85d2                	mv	a1,s4
    8000294e:	855e                	mv	a0,s7
    80002950:	d67fe0ef          	jal	800016b6 <either_copyout>
    80002954:	05850363          	beq	a0,s8,8000299a <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002958:	854a                	mv	a0,s2
    8000295a:	f42ff0ef          	jal	8000209c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000295e:	013d09bb          	addw	s3,s10,s3
    80002962:	009d04bb          	addw	s1,s10,s1
    80002966:	9a6e                	add	s4,s4,s11
    80002968:	0559f363          	bgeu	s3,s5,800029ae <readi+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    8000296c:	00a4d59b          	srliw	a1,s1,0xa
    80002970:	855a                	mv	a0,s6
    80002972:	989ff0ef          	jal	800022fa <bmap>
    80002976:	85aa                	mv	a1,a0
    if(addr == 0)
    80002978:	c139                	beqz	a0,800029be <readi+0xce>
    bp = bread(ip->dev, addr);
    8000297a:	000b2503          	lw	a0,0(s6)
    8000297e:	e16ff0ef          	jal	80001f94 <bread>
    80002982:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002984:	3ff4f793          	andi	a5,s1,1023
    80002988:	40fc873b          	subw	a4,s9,a5
    8000298c:	413a86bb          	subw	a3,s5,s3
    80002990:	8d3a                	mv	s10,a4
    80002992:	fae6f5e3          	bgeu	a3,a4,8000293c <readi+0x4c>
    80002996:	8d36                	mv	s10,a3
    80002998:	b755                	j	8000293c <readi+0x4c>
      brelse(bp);
    8000299a:	854a                	mv	a0,s2
    8000299c:	f00ff0ef          	jal	8000209c <brelse>
      tot = -1;
    800029a0:	59fd                	li	s3,-1
      break;
    800029a2:	6946                	ld	s2,80(sp)
    800029a4:	7c02                	ld	s8,32(sp)
    800029a6:	6ce2                	ld	s9,24(sp)
    800029a8:	6d42                	ld	s10,16(sp)
    800029aa:	6da2                	ld	s11,8(sp)
    800029ac:	a831                	j	800029c8 <readi+0xd8>
    800029ae:	6946                	ld	s2,80(sp)
    800029b0:	7c02                	ld	s8,32(sp)
    800029b2:	6ce2                	ld	s9,24(sp)
    800029b4:	6d42                	ld	s10,16(sp)
    800029b6:	6da2                	ld	s11,8(sp)
    800029b8:	a801                	j	800029c8 <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800029ba:	89d6                	mv	s3,s5
    800029bc:	a031                	j	800029c8 <readi+0xd8>
    800029be:	6946                	ld	s2,80(sp)
    800029c0:	7c02                	ld	s8,32(sp)
    800029c2:	6ce2                	ld	s9,24(sp)
    800029c4:	6d42                	ld	s10,16(sp)
    800029c6:	6da2                	ld	s11,8(sp)
  }
  return tot;
    800029c8:	854e                	mv	a0,s3
    800029ca:	69a6                	ld	s3,72(sp)
}
    800029cc:	70a6                	ld	ra,104(sp)
    800029ce:	7406                	ld	s0,96(sp)
    800029d0:	64e6                	ld	s1,88(sp)
    800029d2:	6a06                	ld	s4,64(sp)
    800029d4:	7ae2                	ld	s5,56(sp)
    800029d6:	7b42                	ld	s6,48(sp)
    800029d8:	7ba2                	ld	s7,40(sp)
    800029da:	6165                	addi	sp,sp,112
    800029dc:	8082                	ret
    return 0;
    800029de:	4501                	li	a0,0
}
    800029e0:	8082                	ret

00000000800029e2 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800029e2:	457c                	lw	a5,76(a0)
    800029e4:	0ed7eb63          	bltu	a5,a3,80002ada <writei+0xf8>
{
    800029e8:	7159                	addi	sp,sp,-112
    800029ea:	f486                	sd	ra,104(sp)
    800029ec:	f0a2                	sd	s0,96(sp)
    800029ee:	e8ca                	sd	s2,80(sp)
    800029f0:	e0d2                	sd	s4,64(sp)
    800029f2:	fc56                	sd	s5,56(sp)
    800029f4:	f85a                	sd	s6,48(sp)
    800029f6:	f45e                	sd	s7,40(sp)
    800029f8:	1880                	addi	s0,sp,112
    800029fa:	8aaa                	mv	s5,a0
    800029fc:	8bae                	mv	s7,a1
    800029fe:	8a32                	mv	s4,a2
    80002a00:	8936                	mv	s2,a3
    80002a02:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002a04:	00e687bb          	addw	a5,a3,a4
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002a08:	00043737          	lui	a4,0x43
    80002a0c:	0cf76963          	bltu	a4,a5,80002ade <writei+0xfc>
    80002a10:	0cd7e763          	bltu	a5,a3,80002ade <writei+0xfc>
    80002a14:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002a16:	0a0b0a63          	beqz	s6,80002aca <writei+0xe8>
    80002a1a:	eca6                	sd	s1,88(sp)
    80002a1c:	f062                	sd	s8,32(sp)
    80002a1e:	ec66                	sd	s9,24(sp)
    80002a20:	e86a                	sd	s10,16(sp)
    80002a22:	e46e                	sd	s11,8(sp)
    80002a24:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a26:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002a2a:	5c7d                	li	s8,-1
    80002a2c:	a825                	j	80002a64 <writei+0x82>
    80002a2e:	020d1d93          	slli	s11,s10,0x20
    80002a32:	020ddd93          	srli	s11,s11,0x20
    80002a36:	05848513          	addi	a0,s1,88
    80002a3a:	86ee                	mv	a3,s11
    80002a3c:	8652                	mv	a2,s4
    80002a3e:	85de                	mv	a1,s7
    80002a40:	953e                	add	a0,a0,a5
    80002a42:	cbffe0ef          	jal	80001700 <either_copyin>
    80002a46:	05850663          	beq	a0,s8,80002a92 <writei+0xb0>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002a4a:	8526                	mv	a0,s1
    80002a4c:	69c000ef          	jal	800030e8 <log_write>
    brelse(bp);
    80002a50:	8526                	mv	a0,s1
    80002a52:	e4aff0ef          	jal	8000209c <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002a56:	013d09bb          	addw	s3,s10,s3
    80002a5a:	012d093b          	addw	s2,s10,s2
    80002a5e:	9a6e                	add	s4,s4,s11
    80002a60:	0369fc63          	bgeu	s3,s6,80002a98 <writei+0xb6>
    uint addr = bmap(ip, off/BSIZE);
    80002a64:	00a9559b          	srliw	a1,s2,0xa
    80002a68:	8556                	mv	a0,s5
    80002a6a:	891ff0ef          	jal	800022fa <bmap>
    80002a6e:	85aa                	mv	a1,a0
    if(addr == 0)
    80002a70:	c505                	beqz	a0,80002a98 <writei+0xb6>
    bp = bread(ip->dev, addr);
    80002a72:	000aa503          	lw	a0,0(s5)
    80002a76:	d1eff0ef          	jal	80001f94 <bread>
    80002a7a:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a7c:	3ff97793          	andi	a5,s2,1023
    80002a80:	40fc873b          	subw	a4,s9,a5
    80002a84:	413b06bb          	subw	a3,s6,s3
    80002a88:	8d3a                	mv	s10,a4
    80002a8a:	fae6f2e3          	bgeu	a3,a4,80002a2e <writei+0x4c>
    80002a8e:	8d36                	mv	s10,a3
    80002a90:	bf79                	j	80002a2e <writei+0x4c>
      brelse(bp);
    80002a92:	8526                	mv	a0,s1
    80002a94:	e08ff0ef          	jal	8000209c <brelse>
  }

  if(off > ip->size)
    80002a98:	04caa783          	lw	a5,76(s5)
    80002a9c:	0327f963          	bgeu	a5,s2,80002ace <writei+0xec>
    ip->size = off;
    80002aa0:	052aa623          	sw	s2,76(s5)
    80002aa4:	64e6                	ld	s1,88(sp)
    80002aa6:	7c02                	ld	s8,32(sp)
    80002aa8:	6ce2                	ld	s9,24(sp)
    80002aaa:	6d42                	ld	s10,16(sp)
    80002aac:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002aae:	8556                	mv	a0,s5
    80002ab0:	b33ff0ef          	jal	800025e2 <iupdate>

  return tot;
    80002ab4:	854e                	mv	a0,s3
    80002ab6:	69a6                	ld	s3,72(sp)
}
    80002ab8:	70a6                	ld	ra,104(sp)
    80002aba:	7406                	ld	s0,96(sp)
    80002abc:	6946                	ld	s2,80(sp)
    80002abe:	6a06                	ld	s4,64(sp)
    80002ac0:	7ae2                	ld	s5,56(sp)
    80002ac2:	7b42                	ld	s6,48(sp)
    80002ac4:	7ba2                	ld	s7,40(sp)
    80002ac6:	6165                	addi	sp,sp,112
    80002ac8:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002aca:	89da                	mv	s3,s6
    80002acc:	b7cd                	j	80002aae <writei+0xcc>
    80002ace:	64e6                	ld	s1,88(sp)
    80002ad0:	7c02                	ld	s8,32(sp)
    80002ad2:	6ce2                	ld	s9,24(sp)
    80002ad4:	6d42                	ld	s10,16(sp)
    80002ad6:	6da2                	ld	s11,8(sp)
    80002ad8:	bfd9                	j	80002aae <writei+0xcc>
    return -1;
    80002ada:	557d                	li	a0,-1
}
    80002adc:	8082                	ret
    return -1;
    80002ade:	557d                	li	a0,-1
    80002ae0:	bfe1                	j	80002ab8 <writei+0xd6>

0000000080002ae2 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002ae2:	1141                	addi	sp,sp,-16
    80002ae4:	e406                	sd	ra,8(sp)
    80002ae6:	e022                	sd	s0,0(sp)
    80002ae8:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002aea:	4639                	li	a2,14
    80002aec:	f46fd0ef          	jal	80000232 <strncmp>
}
    80002af0:	60a2                	ld	ra,8(sp)
    80002af2:	6402                	ld	s0,0(sp)
    80002af4:	0141                	addi	sp,sp,16
    80002af6:	8082                	ret

0000000080002af8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002af8:	711d                	addi	sp,sp,-96
    80002afa:	ec86                	sd	ra,88(sp)
    80002afc:	e8a2                	sd	s0,80(sp)
    80002afe:	e4a6                	sd	s1,72(sp)
    80002b00:	e0ca                	sd	s2,64(sp)
    80002b02:	fc4e                	sd	s3,56(sp)
    80002b04:	f852                	sd	s4,48(sp)
    80002b06:	f456                	sd	s5,40(sp)
    80002b08:	f05a                	sd	s6,32(sp)
    80002b0a:	ec5e                	sd	s7,24(sp)
    80002b0c:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002b0e:	04451703          	lh	a4,68(a0)
    80002b12:	4785                	li	a5,1
    80002b14:	00f71f63          	bne	a4,a5,80002b32 <dirlookup+0x3a>
    80002b18:	892a                	mv	s2,a0
    80002b1a:	8aae                	mv	s5,a1
    80002b1c:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002b1e:	457c                	lw	a5,76(a0)
    80002b20:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002b22:	fa040a13          	addi	s4,s0,-96
    80002b26:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80002b28:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002b2c:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002b2e:	e39d                	bnez	a5,80002b54 <dirlookup+0x5c>
    80002b30:	a8b9                	j	80002b8e <dirlookup+0x96>
    panic("dirlookup not DIR");
    80002b32:	00005517          	auipc	a0,0x5
    80002b36:	a3e50513          	addi	a0,a0,-1474 # 80007570 <etext+0x570>
    80002b3a:	1a5020ef          	jal	800054de <panic>
      panic("dirlookup read");
    80002b3e:	00005517          	auipc	a0,0x5
    80002b42:	a4a50513          	addi	a0,a0,-1462 # 80007588 <etext+0x588>
    80002b46:	199020ef          	jal	800054de <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002b4a:	24c1                	addiw	s1,s1,16
    80002b4c:	04c92783          	lw	a5,76(s2)
    80002b50:	02f4fe63          	bgeu	s1,a5,80002b8c <dirlookup+0x94>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002b54:	874e                	mv	a4,s3
    80002b56:	86a6                	mv	a3,s1
    80002b58:	8652                	mv	a2,s4
    80002b5a:	4581                	li	a1,0
    80002b5c:	854a                	mv	a0,s2
    80002b5e:	d93ff0ef          	jal	800028f0 <readi>
    80002b62:	fd351ee3          	bne	a0,s3,80002b3e <dirlookup+0x46>
    if(de.inum == 0)
    80002b66:	fa045783          	lhu	a5,-96(s0)
    80002b6a:	d3e5                	beqz	a5,80002b4a <dirlookup+0x52>
    if(namecmp(name, de.name) == 0){
    80002b6c:	85da                	mv	a1,s6
    80002b6e:	8556                	mv	a0,s5
    80002b70:	f73ff0ef          	jal	80002ae2 <namecmp>
    80002b74:	f979                	bnez	a0,80002b4a <dirlookup+0x52>
      if(poff)
    80002b76:	000b8463          	beqz	s7,80002b7e <dirlookup+0x86>
        *poff = off;
    80002b7a:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80002b7e:	fa045583          	lhu	a1,-96(s0)
    80002b82:	00092503          	lw	a0,0(s2)
    80002b86:	835ff0ef          	jal	800023ba <iget>
    80002b8a:	a011                	j	80002b8e <dirlookup+0x96>
  return 0;
    80002b8c:	4501                	li	a0,0
}
    80002b8e:	60e6                	ld	ra,88(sp)
    80002b90:	6446                	ld	s0,80(sp)
    80002b92:	64a6                	ld	s1,72(sp)
    80002b94:	6906                	ld	s2,64(sp)
    80002b96:	79e2                	ld	s3,56(sp)
    80002b98:	7a42                	ld	s4,48(sp)
    80002b9a:	7aa2                	ld	s5,40(sp)
    80002b9c:	7b02                	ld	s6,32(sp)
    80002b9e:	6be2                	ld	s7,24(sp)
    80002ba0:	6125                	addi	sp,sp,96
    80002ba2:	8082                	ret

0000000080002ba4 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002ba4:	711d                	addi	sp,sp,-96
    80002ba6:	ec86                	sd	ra,88(sp)
    80002ba8:	e8a2                	sd	s0,80(sp)
    80002baa:	e4a6                	sd	s1,72(sp)
    80002bac:	e0ca                	sd	s2,64(sp)
    80002bae:	fc4e                	sd	s3,56(sp)
    80002bb0:	f852                	sd	s4,48(sp)
    80002bb2:	f456                	sd	s5,40(sp)
    80002bb4:	f05a                	sd	s6,32(sp)
    80002bb6:	ec5e                	sd	s7,24(sp)
    80002bb8:	e862                	sd	s8,16(sp)
    80002bba:	e466                	sd	s9,8(sp)
    80002bbc:	e06a                	sd	s10,0(sp)
    80002bbe:	1080                	addi	s0,sp,96
    80002bc0:	84aa                	mv	s1,a0
    80002bc2:	8b2e                	mv	s6,a1
    80002bc4:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002bc6:	00054703          	lbu	a4,0(a0)
    80002bca:	02f00793          	li	a5,47
    80002bce:	00f70f63          	beq	a4,a5,80002bec <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002bd2:	9b0fe0ef          	jal	80000d82 <myproc>
    80002bd6:	15053503          	ld	a0,336(a0)
    80002bda:	a87ff0ef          	jal	80002660 <idup>
    80002bde:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002be0:	02f00993          	li	s3,47
  if(len >= DIRSIZ)
    80002be4:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80002be6:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002be8:	4b85                	li	s7,1
    80002bea:	a879                	j	80002c88 <namex+0xe4>
    ip = iget(ROOTDEV, ROOTINO);
    80002bec:	4585                	li	a1,1
    80002bee:	852e                	mv	a0,a1
    80002bf0:	fcaff0ef          	jal	800023ba <iget>
    80002bf4:	8a2a                	mv	s4,a0
    80002bf6:	b7ed                	j	80002be0 <namex+0x3c>
      iunlockput(ip);
    80002bf8:	8552                	mv	a0,s4
    80002bfa:	ca9ff0ef          	jal	800028a2 <iunlockput>
      return 0;
    80002bfe:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002c00:	8552                	mv	a0,s4
    80002c02:	60e6                	ld	ra,88(sp)
    80002c04:	6446                	ld	s0,80(sp)
    80002c06:	64a6                	ld	s1,72(sp)
    80002c08:	6906                	ld	s2,64(sp)
    80002c0a:	79e2                	ld	s3,56(sp)
    80002c0c:	7a42                	ld	s4,48(sp)
    80002c0e:	7aa2                	ld	s5,40(sp)
    80002c10:	7b02                	ld	s6,32(sp)
    80002c12:	6be2                	ld	s7,24(sp)
    80002c14:	6c42                	ld	s8,16(sp)
    80002c16:	6ca2                	ld	s9,8(sp)
    80002c18:	6d02                	ld	s10,0(sp)
    80002c1a:	6125                	addi	sp,sp,96
    80002c1c:	8082                	ret
      iunlock(ip);
    80002c1e:	8552                	mv	a0,s4
    80002c20:	b25ff0ef          	jal	80002744 <iunlock>
      return ip;
    80002c24:	bff1                	j	80002c00 <namex+0x5c>
      iunlockput(ip);
    80002c26:	8552                	mv	a0,s4
    80002c28:	c7bff0ef          	jal	800028a2 <iunlockput>
      return 0;
    80002c2c:	8a4a                	mv	s4,s2
    80002c2e:	bfc9                	j	80002c00 <namex+0x5c>
  len = path - s;
    80002c30:	40990633          	sub	a2,s2,s1
    80002c34:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80002c38:	09ac5463          	bge	s8,s10,80002cc0 <namex+0x11c>
    memmove(name, s, DIRSIZ);
    80002c3c:	8666                	mv	a2,s9
    80002c3e:	85a6                	mv	a1,s1
    80002c40:	8556                	mv	a0,s5
    80002c42:	d7cfd0ef          	jal	800001be <memmove>
    80002c46:	84ca                	mv	s1,s2
  while(*path == '/')
    80002c48:	0004c783          	lbu	a5,0(s1)
    80002c4c:	01379763          	bne	a5,s3,80002c5a <namex+0xb6>
    path++;
    80002c50:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002c52:	0004c783          	lbu	a5,0(s1)
    80002c56:	ff378de3          	beq	a5,s3,80002c50 <namex+0xac>
    ilock(ip);
    80002c5a:	8552                	mv	a0,s4
    80002c5c:	a3bff0ef          	jal	80002696 <ilock>
    if(ip->type != T_DIR){
    80002c60:	044a1783          	lh	a5,68(s4)
    80002c64:	f9779ae3          	bne	a5,s7,80002bf8 <namex+0x54>
    if(nameiparent && *path == '\0'){
    80002c68:	000b0563          	beqz	s6,80002c72 <namex+0xce>
    80002c6c:	0004c783          	lbu	a5,0(s1)
    80002c70:	d7dd                	beqz	a5,80002c1e <namex+0x7a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002c72:	4601                	li	a2,0
    80002c74:	85d6                	mv	a1,s5
    80002c76:	8552                	mv	a0,s4
    80002c78:	e81ff0ef          	jal	80002af8 <dirlookup>
    80002c7c:	892a                	mv	s2,a0
    80002c7e:	d545                	beqz	a0,80002c26 <namex+0x82>
    iunlockput(ip);
    80002c80:	8552                	mv	a0,s4
    80002c82:	c21ff0ef          	jal	800028a2 <iunlockput>
    ip = next;
    80002c86:	8a4a                	mv	s4,s2
  while(*path == '/')
    80002c88:	0004c783          	lbu	a5,0(s1)
    80002c8c:	01379763          	bne	a5,s3,80002c9a <namex+0xf6>
    path++;
    80002c90:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002c92:	0004c783          	lbu	a5,0(s1)
    80002c96:	ff378de3          	beq	a5,s3,80002c90 <namex+0xec>
  if(*path == 0)
    80002c9a:	cf8d                	beqz	a5,80002cd4 <namex+0x130>
  while(*path != '/' && *path != 0)
    80002c9c:	0004c783          	lbu	a5,0(s1)
    80002ca0:	fd178713          	addi	a4,a5,-47
    80002ca4:	cb19                	beqz	a4,80002cba <namex+0x116>
    80002ca6:	cb91                	beqz	a5,80002cba <namex+0x116>
    80002ca8:	8926                	mv	s2,s1
    path++;
    80002caa:	0905                	addi	s2,s2,1
  while(*path != '/' && *path != 0)
    80002cac:	00094783          	lbu	a5,0(s2)
    80002cb0:	fd178713          	addi	a4,a5,-47
    80002cb4:	df35                	beqz	a4,80002c30 <namex+0x8c>
    80002cb6:	fbf5                	bnez	a5,80002caa <namex+0x106>
    80002cb8:	bfa5                	j	80002c30 <namex+0x8c>
    80002cba:	8926                	mv	s2,s1
  len = path - s;
    80002cbc:	4d01                	li	s10,0
    80002cbe:	4601                	li	a2,0
    memmove(name, s, len);
    80002cc0:	2601                	sext.w	a2,a2
    80002cc2:	85a6                	mv	a1,s1
    80002cc4:	8556                	mv	a0,s5
    80002cc6:	cf8fd0ef          	jal	800001be <memmove>
    name[len] = 0;
    80002cca:	9d56                	add	s10,s10,s5
    80002ccc:	000d0023          	sb	zero,0(s10)
    80002cd0:	84ca                	mv	s1,s2
    80002cd2:	bf9d                	j	80002c48 <namex+0xa4>
  if(nameiparent){
    80002cd4:	f20b06e3          	beqz	s6,80002c00 <namex+0x5c>
    iput(ip);
    80002cd8:	8552                	mv	a0,s4
    80002cda:	b3fff0ef          	jal	80002818 <iput>
    return 0;
    80002cde:	4a01                	li	s4,0
    80002ce0:	b705                	j	80002c00 <namex+0x5c>

0000000080002ce2 <dirlink>:
{
    80002ce2:	715d                	addi	sp,sp,-80
    80002ce4:	e486                	sd	ra,72(sp)
    80002ce6:	e0a2                	sd	s0,64(sp)
    80002ce8:	f84a                	sd	s2,48(sp)
    80002cea:	ec56                	sd	s5,24(sp)
    80002cec:	e85a                	sd	s6,16(sp)
    80002cee:	0880                	addi	s0,sp,80
    80002cf0:	892a                	mv	s2,a0
    80002cf2:	8aae                	mv	s5,a1
    80002cf4:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002cf6:	4601                	li	a2,0
    80002cf8:	e01ff0ef          	jal	80002af8 <dirlookup>
    80002cfc:	ed1d                	bnez	a0,80002d3a <dirlink+0x58>
    80002cfe:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002d00:	04c92483          	lw	s1,76(s2)
    80002d04:	c4b9                	beqz	s1,80002d52 <dirlink+0x70>
    80002d06:	f44e                	sd	s3,40(sp)
    80002d08:	f052                	sd	s4,32(sp)
    80002d0a:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002d0c:	fb040a13          	addi	s4,s0,-80
    80002d10:	49c1                	li	s3,16
    80002d12:	874e                	mv	a4,s3
    80002d14:	86a6                	mv	a3,s1
    80002d16:	8652                	mv	a2,s4
    80002d18:	4581                	li	a1,0
    80002d1a:	854a                	mv	a0,s2
    80002d1c:	bd5ff0ef          	jal	800028f0 <readi>
    80002d20:	03351163          	bne	a0,s3,80002d42 <dirlink+0x60>
    if(de.inum == 0)
    80002d24:	fb045783          	lhu	a5,-80(s0)
    80002d28:	c39d                	beqz	a5,80002d4e <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002d2a:	24c1                	addiw	s1,s1,16
    80002d2c:	04c92783          	lw	a5,76(s2)
    80002d30:	fef4e1e3          	bltu	s1,a5,80002d12 <dirlink+0x30>
    80002d34:	79a2                	ld	s3,40(sp)
    80002d36:	7a02                	ld	s4,32(sp)
    80002d38:	a829                	j	80002d52 <dirlink+0x70>
    iput(ip);
    80002d3a:	adfff0ef          	jal	80002818 <iput>
    return -1;
    80002d3e:	557d                	li	a0,-1
    80002d40:	a83d                	j	80002d7e <dirlink+0x9c>
      panic("dirlink read");
    80002d42:	00005517          	auipc	a0,0x5
    80002d46:	85650513          	addi	a0,a0,-1962 # 80007598 <etext+0x598>
    80002d4a:	794020ef          	jal	800054de <panic>
    80002d4e:	79a2                	ld	s3,40(sp)
    80002d50:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80002d52:	4639                	li	a2,14
    80002d54:	85d6                	mv	a1,s5
    80002d56:	fb240513          	addi	a0,s0,-78
    80002d5a:	d12fd0ef          	jal	8000026c <strncpy>
  de.inum = inum;
    80002d5e:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002d62:	4741                	li	a4,16
    80002d64:	86a6                	mv	a3,s1
    80002d66:	fb040613          	addi	a2,s0,-80
    80002d6a:	4581                	li	a1,0
    80002d6c:	854a                	mv	a0,s2
    80002d6e:	c75ff0ef          	jal	800029e2 <writei>
    80002d72:	1541                	addi	a0,a0,-16
    80002d74:	00a03533          	snez	a0,a0
    80002d78:	40a0053b          	negw	a0,a0
    80002d7c:	74e2                	ld	s1,56(sp)
}
    80002d7e:	60a6                	ld	ra,72(sp)
    80002d80:	6406                	ld	s0,64(sp)
    80002d82:	7942                	ld	s2,48(sp)
    80002d84:	6ae2                	ld	s5,24(sp)
    80002d86:	6b42                	ld	s6,16(sp)
    80002d88:	6161                	addi	sp,sp,80
    80002d8a:	8082                	ret

0000000080002d8c <namei>:

struct inode*
namei(char *path)
{
    80002d8c:	1101                	addi	sp,sp,-32
    80002d8e:	ec06                	sd	ra,24(sp)
    80002d90:	e822                	sd	s0,16(sp)
    80002d92:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002d94:	fe040613          	addi	a2,s0,-32
    80002d98:	4581                	li	a1,0
    80002d9a:	e0bff0ef          	jal	80002ba4 <namex>
}
    80002d9e:	60e2                	ld	ra,24(sp)
    80002da0:	6442                	ld	s0,16(sp)
    80002da2:	6105                	addi	sp,sp,32
    80002da4:	8082                	ret

0000000080002da6 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002da6:	1141                	addi	sp,sp,-16
    80002da8:	e406                	sd	ra,8(sp)
    80002daa:	e022                	sd	s0,0(sp)
    80002dac:	0800                	addi	s0,sp,16
    80002dae:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002db0:	4585                	li	a1,1
    80002db2:	df3ff0ef          	jal	80002ba4 <namex>
}
    80002db6:	60a2                	ld	ra,8(sp)
    80002db8:	6402                	ld	s0,0(sp)
    80002dba:	0141                	addi	sp,sp,16
    80002dbc:	8082                	ret

0000000080002dbe <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002dbe:	1101                	addi	sp,sp,-32
    80002dc0:	ec06                	sd	ra,24(sp)
    80002dc2:	e822                	sd	s0,16(sp)
    80002dc4:	e426                	sd	s1,8(sp)
    80002dc6:	e04a                	sd	s2,0(sp)
    80002dc8:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80002dca:	00017917          	auipc	s2,0x17
    80002dce:	61690913          	addi	s2,s2,1558 # 8001a3e0 <log>
    80002dd2:	01892583          	lw	a1,24(s2)
    80002dd6:	02892503          	lw	a0,40(s2)
    80002dda:	9baff0ef          	jal	80001f94 <bread>
    80002dde:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80002de0:	02c92603          	lw	a2,44(s2)
    80002de4:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80002de6:	00c05f63          	blez	a2,80002e04 <write_head+0x46>
    80002dea:	00017717          	auipc	a4,0x17
    80002dee:	62670713          	addi	a4,a4,1574 # 8001a410 <log+0x30>
    80002df2:	87aa                	mv	a5,a0
    80002df4:	060a                	slli	a2,a2,0x2
    80002df6:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80002df8:	4314                	lw	a3,0(a4)
    80002dfa:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80002dfc:	0711                	addi	a4,a4,4
    80002dfe:	0791                	addi	a5,a5,4
    80002e00:	fec79ce3          	bne	a5,a2,80002df8 <write_head+0x3a>
  }
  bwrite(buf);
    80002e04:	8526                	mv	a0,s1
    80002e06:	a64ff0ef          	jal	8000206a <bwrite>
  brelse(buf);
    80002e0a:	8526                	mv	a0,s1
    80002e0c:	a90ff0ef          	jal	8000209c <brelse>
}
    80002e10:	60e2                	ld	ra,24(sp)
    80002e12:	6442                	ld	s0,16(sp)
    80002e14:	64a2                	ld	s1,8(sp)
    80002e16:	6902                	ld	s2,0(sp)
    80002e18:	6105                	addi	sp,sp,32
    80002e1a:	8082                	ret

0000000080002e1c <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80002e1c:	00017797          	auipc	a5,0x17
    80002e20:	5f07a783          	lw	a5,1520(a5) # 8001a40c <log+0x2c>
    80002e24:	0af05263          	blez	a5,80002ec8 <install_trans+0xac>
{
    80002e28:	715d                	addi	sp,sp,-80
    80002e2a:	e486                	sd	ra,72(sp)
    80002e2c:	e0a2                	sd	s0,64(sp)
    80002e2e:	fc26                	sd	s1,56(sp)
    80002e30:	f84a                	sd	s2,48(sp)
    80002e32:	f44e                	sd	s3,40(sp)
    80002e34:	f052                	sd	s4,32(sp)
    80002e36:	ec56                	sd	s5,24(sp)
    80002e38:	e85a                	sd	s6,16(sp)
    80002e3a:	e45e                	sd	s7,8(sp)
    80002e3c:	0880                	addi	s0,sp,80
    80002e3e:	8b2a                	mv	s6,a0
    80002e40:	00017a97          	auipc	s5,0x17
    80002e44:	5d0a8a93          	addi	s5,s5,1488 # 8001a410 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002e48:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002e4a:	00017997          	auipc	s3,0x17
    80002e4e:	59698993          	addi	s3,s3,1430 # 8001a3e0 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002e52:	40000b93          	li	s7,1024
    80002e56:	a829                	j	80002e70 <install_trans+0x54>
    brelse(lbuf);
    80002e58:	854a                	mv	a0,s2
    80002e5a:	a42ff0ef          	jal	8000209c <brelse>
    brelse(dbuf);
    80002e5e:	8526                	mv	a0,s1
    80002e60:	a3cff0ef          	jal	8000209c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002e64:	2a05                	addiw	s4,s4,1
    80002e66:	0a91                	addi	s5,s5,4
    80002e68:	02c9a783          	lw	a5,44(s3)
    80002e6c:	04fa5363          	bge	s4,a5,80002eb2 <install_trans+0x96>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002e70:	0189a583          	lw	a1,24(s3)
    80002e74:	014585bb          	addw	a1,a1,s4
    80002e78:	2585                	addiw	a1,a1,1
    80002e7a:	0289a503          	lw	a0,40(s3)
    80002e7e:	916ff0ef          	jal	80001f94 <bread>
    80002e82:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80002e84:	000aa583          	lw	a1,0(s5)
    80002e88:	0289a503          	lw	a0,40(s3)
    80002e8c:	908ff0ef          	jal	80001f94 <bread>
    80002e90:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002e92:	865e                	mv	a2,s7
    80002e94:	05890593          	addi	a1,s2,88
    80002e98:	05850513          	addi	a0,a0,88
    80002e9c:	b22fd0ef          	jal	800001be <memmove>
    bwrite(dbuf);  // write dst to disk
    80002ea0:	8526                	mv	a0,s1
    80002ea2:	9c8ff0ef          	jal	8000206a <bwrite>
    if(recovering == 0)
    80002ea6:	fa0b19e3          	bnez	s6,80002e58 <install_trans+0x3c>
      bunpin(dbuf);
    80002eaa:	8526                	mv	a0,s1
    80002eac:	aa8ff0ef          	jal	80002154 <bunpin>
    80002eb0:	b765                	j	80002e58 <install_trans+0x3c>
}
    80002eb2:	60a6                	ld	ra,72(sp)
    80002eb4:	6406                	ld	s0,64(sp)
    80002eb6:	74e2                	ld	s1,56(sp)
    80002eb8:	7942                	ld	s2,48(sp)
    80002eba:	79a2                	ld	s3,40(sp)
    80002ebc:	7a02                	ld	s4,32(sp)
    80002ebe:	6ae2                	ld	s5,24(sp)
    80002ec0:	6b42                	ld	s6,16(sp)
    80002ec2:	6ba2                	ld	s7,8(sp)
    80002ec4:	6161                	addi	sp,sp,80
    80002ec6:	8082                	ret
    80002ec8:	8082                	ret

0000000080002eca <initlog>:
{
    80002eca:	7179                	addi	sp,sp,-48
    80002ecc:	f406                	sd	ra,40(sp)
    80002ece:	f022                	sd	s0,32(sp)
    80002ed0:	ec26                	sd	s1,24(sp)
    80002ed2:	e84a                	sd	s2,16(sp)
    80002ed4:	e44e                	sd	s3,8(sp)
    80002ed6:	1800                	addi	s0,sp,48
    80002ed8:	892a                	mv	s2,a0
    80002eda:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80002edc:	00017497          	auipc	s1,0x17
    80002ee0:	50448493          	addi	s1,s1,1284 # 8001a3e0 <log>
    80002ee4:	00004597          	auipc	a1,0x4
    80002ee8:	6c458593          	addi	a1,a1,1732 # 800075a8 <etext+0x5a8>
    80002eec:	8526                	mv	a0,s1
    80002eee:	0a5020ef          	jal	80005792 <initlock>
  log.start = sb->logstart;
    80002ef2:	0149a583          	lw	a1,20(s3)
    80002ef6:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80002ef8:	0109a783          	lw	a5,16(s3)
    80002efc:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80002efe:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80002f02:	854a                	mv	a0,s2
    80002f04:	890ff0ef          	jal	80001f94 <bread>
  log.lh.n = lh->n;
    80002f08:	4d30                	lw	a2,88(a0)
    80002f0a:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80002f0c:	00c05f63          	blez	a2,80002f2a <initlog+0x60>
    80002f10:	87aa                	mv	a5,a0
    80002f12:	00017717          	auipc	a4,0x17
    80002f16:	4fe70713          	addi	a4,a4,1278 # 8001a410 <log+0x30>
    80002f1a:	060a                	slli	a2,a2,0x2
    80002f1c:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80002f1e:	4ff4                	lw	a3,92(a5)
    80002f20:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80002f22:	0791                	addi	a5,a5,4
    80002f24:	0711                	addi	a4,a4,4
    80002f26:	fec79ce3          	bne	a5,a2,80002f1e <initlog+0x54>
  brelse(buf);
    80002f2a:	972ff0ef          	jal	8000209c <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80002f2e:	4505                	li	a0,1
    80002f30:	eedff0ef          	jal	80002e1c <install_trans>
  log.lh.n = 0;
    80002f34:	00017797          	auipc	a5,0x17
    80002f38:	4c07ac23          	sw	zero,1240(a5) # 8001a40c <log+0x2c>
  write_head(); // clear the log
    80002f3c:	e83ff0ef          	jal	80002dbe <write_head>
}
    80002f40:	70a2                	ld	ra,40(sp)
    80002f42:	7402                	ld	s0,32(sp)
    80002f44:	64e2                	ld	s1,24(sp)
    80002f46:	6942                	ld	s2,16(sp)
    80002f48:	69a2                	ld	s3,8(sp)
    80002f4a:	6145                	addi	sp,sp,48
    80002f4c:	8082                	ret

0000000080002f4e <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80002f4e:	1101                	addi	sp,sp,-32
    80002f50:	ec06                	sd	ra,24(sp)
    80002f52:	e822                	sd	s0,16(sp)
    80002f54:	e426                	sd	s1,8(sp)
    80002f56:	e04a                	sd	s2,0(sp)
    80002f58:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80002f5a:	00017517          	auipc	a0,0x17
    80002f5e:	48650513          	addi	a0,a0,1158 # 8001a3e0 <log>
    80002f62:	0bb020ef          	jal	8000581c <acquire>
  while(1){
    if(log.committing){
    80002f66:	00017497          	auipc	s1,0x17
    80002f6a:	47a48493          	addi	s1,s1,1146 # 8001a3e0 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80002f6e:	4979                	li	s2,30
    80002f70:	a029                	j	80002f7a <begin_op+0x2c>
      sleep(&log, &log.lock);
    80002f72:	85a6                	mv	a1,s1
    80002f74:	8526                	mv	a0,s1
    80002f76:	be6fe0ef          	jal	8000135c <sleep>
    if(log.committing){
    80002f7a:	50dc                	lw	a5,36(s1)
    80002f7c:	fbfd                	bnez	a5,80002f72 <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80002f7e:	5098                	lw	a4,32(s1)
    80002f80:	2705                	addiw	a4,a4,1
    80002f82:	0027179b          	slliw	a5,a4,0x2
    80002f86:	9fb9                	addw	a5,a5,a4
    80002f88:	0017979b          	slliw	a5,a5,0x1
    80002f8c:	54d4                	lw	a3,44(s1)
    80002f8e:	9fb5                	addw	a5,a5,a3
    80002f90:	00f95763          	bge	s2,a5,80002f9e <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80002f94:	85a6                	mv	a1,s1
    80002f96:	8526                	mv	a0,s1
    80002f98:	bc4fe0ef          	jal	8000135c <sleep>
    80002f9c:	bff9                	j	80002f7a <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    80002f9e:	00017797          	auipc	a5,0x17
    80002fa2:	46e7a123          	sw	a4,1122(a5) # 8001a400 <log+0x20>
      release(&log.lock);
    80002fa6:	00017517          	auipc	a0,0x17
    80002faa:	43a50513          	addi	a0,a0,1082 # 8001a3e0 <log>
    80002fae:	103020ef          	jal	800058b0 <release>
      break;
    }
  }
}
    80002fb2:	60e2                	ld	ra,24(sp)
    80002fb4:	6442                	ld	s0,16(sp)
    80002fb6:	64a2                	ld	s1,8(sp)
    80002fb8:	6902                	ld	s2,0(sp)
    80002fba:	6105                	addi	sp,sp,32
    80002fbc:	8082                	ret

0000000080002fbe <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80002fbe:	7139                	addi	sp,sp,-64
    80002fc0:	fc06                	sd	ra,56(sp)
    80002fc2:	f822                	sd	s0,48(sp)
    80002fc4:	f426                	sd	s1,40(sp)
    80002fc6:	f04a                	sd	s2,32(sp)
    80002fc8:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80002fca:	00017497          	auipc	s1,0x17
    80002fce:	41648493          	addi	s1,s1,1046 # 8001a3e0 <log>
    80002fd2:	8526                	mv	a0,s1
    80002fd4:	049020ef          	jal	8000581c <acquire>
  log.outstanding -= 1;
    80002fd8:	509c                	lw	a5,32(s1)
    80002fda:	37fd                	addiw	a5,a5,-1
    80002fdc:	893e                	mv	s2,a5
    80002fde:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80002fe0:	50dc                	lw	a5,36(s1)
    80002fe2:	e7b1                	bnez	a5,8000302e <end_op+0x70>
    panic("log.committing");
  if(log.outstanding == 0){
    80002fe4:	04091e63          	bnez	s2,80003040 <end_op+0x82>
    do_commit = 1;
    log.committing = 1;
    80002fe8:	00017497          	auipc	s1,0x17
    80002fec:	3f848493          	addi	s1,s1,1016 # 8001a3e0 <log>
    80002ff0:	4785                	li	a5,1
    80002ff2:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80002ff4:	8526                	mv	a0,s1
    80002ff6:	0bb020ef          	jal	800058b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80002ffa:	54dc                	lw	a5,44(s1)
    80002ffc:	06f04463          	bgtz	a5,80003064 <end_op+0xa6>
    acquire(&log.lock);
    80003000:	00017517          	auipc	a0,0x17
    80003004:	3e050513          	addi	a0,a0,992 # 8001a3e0 <log>
    80003008:	015020ef          	jal	8000581c <acquire>
    log.committing = 0;
    8000300c:	00017797          	auipc	a5,0x17
    80003010:	3e07ac23          	sw	zero,1016(a5) # 8001a404 <log+0x24>
    wakeup(&log);
    80003014:	00017517          	auipc	a0,0x17
    80003018:	3cc50513          	addi	a0,a0,972 # 8001a3e0 <log>
    8000301c:	b8cfe0ef          	jal	800013a8 <wakeup>
    release(&log.lock);
    80003020:	00017517          	auipc	a0,0x17
    80003024:	3c050513          	addi	a0,a0,960 # 8001a3e0 <log>
    80003028:	089020ef          	jal	800058b0 <release>
}
    8000302c:	a035                	j	80003058 <end_op+0x9a>
    8000302e:	ec4e                	sd	s3,24(sp)
    80003030:	e852                	sd	s4,16(sp)
    80003032:	e456                	sd	s5,8(sp)
    panic("log.committing");
    80003034:	00004517          	auipc	a0,0x4
    80003038:	57c50513          	addi	a0,a0,1404 # 800075b0 <etext+0x5b0>
    8000303c:	4a2020ef          	jal	800054de <panic>
    wakeup(&log);
    80003040:	00017517          	auipc	a0,0x17
    80003044:	3a050513          	addi	a0,a0,928 # 8001a3e0 <log>
    80003048:	b60fe0ef          	jal	800013a8 <wakeup>
  release(&log.lock);
    8000304c:	00017517          	auipc	a0,0x17
    80003050:	39450513          	addi	a0,a0,916 # 8001a3e0 <log>
    80003054:	05d020ef          	jal	800058b0 <release>
}
    80003058:	70e2                	ld	ra,56(sp)
    8000305a:	7442                	ld	s0,48(sp)
    8000305c:	74a2                	ld	s1,40(sp)
    8000305e:	7902                	ld	s2,32(sp)
    80003060:	6121                	addi	sp,sp,64
    80003062:	8082                	ret
    80003064:	ec4e                	sd	s3,24(sp)
    80003066:	e852                	sd	s4,16(sp)
    80003068:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    8000306a:	00017a97          	auipc	s5,0x17
    8000306e:	3a6a8a93          	addi	s5,s5,934 # 8001a410 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003072:	00017a17          	auipc	s4,0x17
    80003076:	36ea0a13          	addi	s4,s4,878 # 8001a3e0 <log>
    8000307a:	018a2583          	lw	a1,24(s4)
    8000307e:	012585bb          	addw	a1,a1,s2
    80003082:	2585                	addiw	a1,a1,1
    80003084:	028a2503          	lw	a0,40(s4)
    80003088:	f0dfe0ef          	jal	80001f94 <bread>
    8000308c:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000308e:	000aa583          	lw	a1,0(s5)
    80003092:	028a2503          	lw	a0,40(s4)
    80003096:	efffe0ef          	jal	80001f94 <bread>
    8000309a:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000309c:	40000613          	li	a2,1024
    800030a0:	05850593          	addi	a1,a0,88
    800030a4:	05848513          	addi	a0,s1,88
    800030a8:	916fd0ef          	jal	800001be <memmove>
    bwrite(to);  // write the log
    800030ac:	8526                	mv	a0,s1
    800030ae:	fbdfe0ef          	jal	8000206a <bwrite>
    brelse(from);
    800030b2:	854e                	mv	a0,s3
    800030b4:	fe9fe0ef          	jal	8000209c <brelse>
    brelse(to);
    800030b8:	8526                	mv	a0,s1
    800030ba:	fe3fe0ef          	jal	8000209c <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800030be:	2905                	addiw	s2,s2,1
    800030c0:	0a91                	addi	s5,s5,4
    800030c2:	02ca2783          	lw	a5,44(s4)
    800030c6:	faf94ae3          	blt	s2,a5,8000307a <end_op+0xbc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800030ca:	cf5ff0ef          	jal	80002dbe <write_head>
    install_trans(0); // Now install writes to home locations
    800030ce:	4501                	li	a0,0
    800030d0:	d4dff0ef          	jal	80002e1c <install_trans>
    log.lh.n = 0;
    800030d4:	00017797          	auipc	a5,0x17
    800030d8:	3207ac23          	sw	zero,824(a5) # 8001a40c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800030dc:	ce3ff0ef          	jal	80002dbe <write_head>
    800030e0:	69e2                	ld	s3,24(sp)
    800030e2:	6a42                	ld	s4,16(sp)
    800030e4:	6aa2                	ld	s5,8(sp)
    800030e6:	bf29                	j	80003000 <end_op+0x42>

00000000800030e8 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800030e8:	1101                	addi	sp,sp,-32
    800030ea:	ec06                	sd	ra,24(sp)
    800030ec:	e822                	sd	s0,16(sp)
    800030ee:	e426                	sd	s1,8(sp)
    800030f0:	1000                	addi	s0,sp,32
    800030f2:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800030f4:	00017517          	auipc	a0,0x17
    800030f8:	2ec50513          	addi	a0,a0,748 # 8001a3e0 <log>
    800030fc:	720020ef          	jal	8000581c <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003100:	00017617          	auipc	a2,0x17
    80003104:	30c62603          	lw	a2,780(a2) # 8001a40c <log+0x2c>
    80003108:	47f5                	li	a5,29
    8000310a:	06c7c463          	blt	a5,a2,80003172 <log_write+0x8a>
    8000310e:	00017797          	auipc	a5,0x17
    80003112:	2ee7a783          	lw	a5,750(a5) # 8001a3fc <log+0x1c>
    80003116:	37fd                	addiw	a5,a5,-1
    80003118:	04f65d63          	bge	a2,a5,80003172 <log_write+0x8a>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000311c:	00017797          	auipc	a5,0x17
    80003120:	2e47a783          	lw	a5,740(a5) # 8001a400 <log+0x20>
    80003124:	04f05d63          	blez	a5,8000317e <log_write+0x96>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003128:	4781                	li	a5,0
    8000312a:	06c05063          	blez	a2,8000318a <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000312e:	44cc                	lw	a1,12(s1)
    80003130:	00017717          	auipc	a4,0x17
    80003134:	2e070713          	addi	a4,a4,736 # 8001a410 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003138:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000313a:	4314                	lw	a3,0(a4)
    8000313c:	04b68763          	beq	a3,a1,8000318a <log_write+0xa2>
  for (i = 0; i < log.lh.n; i++) {
    80003140:	2785                	addiw	a5,a5,1
    80003142:	0711                	addi	a4,a4,4
    80003144:	fef61be3          	bne	a2,a5,8000313a <log_write+0x52>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003148:	060a                	slli	a2,a2,0x2
    8000314a:	02060613          	addi	a2,a2,32
    8000314e:	00017797          	auipc	a5,0x17
    80003152:	29278793          	addi	a5,a5,658 # 8001a3e0 <log>
    80003156:	97b2                	add	a5,a5,a2
    80003158:	44d8                	lw	a4,12(s1)
    8000315a:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000315c:	8526                	mv	a0,s1
    8000315e:	fc3fe0ef          	jal	80002120 <bpin>
    log.lh.n++;
    80003162:	00017717          	auipc	a4,0x17
    80003166:	27e70713          	addi	a4,a4,638 # 8001a3e0 <log>
    8000316a:	575c                	lw	a5,44(a4)
    8000316c:	2785                	addiw	a5,a5,1
    8000316e:	d75c                	sw	a5,44(a4)
    80003170:	a815                	j	800031a4 <log_write+0xbc>
    panic("too big a transaction");
    80003172:	00004517          	auipc	a0,0x4
    80003176:	44e50513          	addi	a0,a0,1102 # 800075c0 <etext+0x5c0>
    8000317a:	364020ef          	jal	800054de <panic>
    panic("log_write outside of trans");
    8000317e:	00004517          	auipc	a0,0x4
    80003182:	45a50513          	addi	a0,a0,1114 # 800075d8 <etext+0x5d8>
    80003186:	358020ef          	jal	800054de <panic>
  log.lh.block[i] = b->blockno;
    8000318a:	00279693          	slli	a3,a5,0x2
    8000318e:	02068693          	addi	a3,a3,32
    80003192:	00017717          	auipc	a4,0x17
    80003196:	24e70713          	addi	a4,a4,590 # 8001a3e0 <log>
    8000319a:	9736                	add	a4,a4,a3
    8000319c:	44d4                	lw	a3,12(s1)
    8000319e:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800031a0:	faf60ee3          	beq	a2,a5,8000315c <log_write+0x74>
  }
  release(&log.lock);
    800031a4:	00017517          	auipc	a0,0x17
    800031a8:	23c50513          	addi	a0,a0,572 # 8001a3e0 <log>
    800031ac:	704020ef          	jal	800058b0 <release>
}
    800031b0:	60e2                	ld	ra,24(sp)
    800031b2:	6442                	ld	s0,16(sp)
    800031b4:	64a2                	ld	s1,8(sp)
    800031b6:	6105                	addi	sp,sp,32
    800031b8:	8082                	ret

00000000800031ba <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800031ba:	1101                	addi	sp,sp,-32
    800031bc:	ec06                	sd	ra,24(sp)
    800031be:	e822                	sd	s0,16(sp)
    800031c0:	e426                	sd	s1,8(sp)
    800031c2:	e04a                	sd	s2,0(sp)
    800031c4:	1000                	addi	s0,sp,32
    800031c6:	84aa                	mv	s1,a0
    800031c8:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800031ca:	00004597          	auipc	a1,0x4
    800031ce:	42e58593          	addi	a1,a1,1070 # 800075f8 <etext+0x5f8>
    800031d2:	0521                	addi	a0,a0,8
    800031d4:	5be020ef          	jal	80005792 <initlock>
  lk->name = name;
    800031d8:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800031dc:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800031e0:	0204a423          	sw	zero,40(s1)
}
    800031e4:	60e2                	ld	ra,24(sp)
    800031e6:	6442                	ld	s0,16(sp)
    800031e8:	64a2                	ld	s1,8(sp)
    800031ea:	6902                	ld	s2,0(sp)
    800031ec:	6105                	addi	sp,sp,32
    800031ee:	8082                	ret

00000000800031f0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800031f0:	1101                	addi	sp,sp,-32
    800031f2:	ec06                	sd	ra,24(sp)
    800031f4:	e822                	sd	s0,16(sp)
    800031f6:	e426                	sd	s1,8(sp)
    800031f8:	e04a                	sd	s2,0(sp)
    800031fa:	1000                	addi	s0,sp,32
    800031fc:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800031fe:	00850913          	addi	s2,a0,8
    80003202:	854a                	mv	a0,s2
    80003204:	618020ef          	jal	8000581c <acquire>
  while (lk->locked) {
    80003208:	409c                	lw	a5,0(s1)
    8000320a:	c799                	beqz	a5,80003218 <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    8000320c:	85ca                	mv	a1,s2
    8000320e:	8526                	mv	a0,s1
    80003210:	94cfe0ef          	jal	8000135c <sleep>
  while (lk->locked) {
    80003214:	409c                	lw	a5,0(s1)
    80003216:	fbfd                	bnez	a5,8000320c <acquiresleep+0x1c>
  }
  lk->locked = 1;
    80003218:	4785                	li	a5,1
    8000321a:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000321c:	b67fd0ef          	jal	80000d82 <myproc>
    80003220:	591c                	lw	a5,48(a0)
    80003222:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003224:	854a                	mv	a0,s2
    80003226:	68a020ef          	jal	800058b0 <release>
}
    8000322a:	60e2                	ld	ra,24(sp)
    8000322c:	6442                	ld	s0,16(sp)
    8000322e:	64a2                	ld	s1,8(sp)
    80003230:	6902                	ld	s2,0(sp)
    80003232:	6105                	addi	sp,sp,32
    80003234:	8082                	ret

0000000080003236 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003236:	1101                	addi	sp,sp,-32
    80003238:	ec06                	sd	ra,24(sp)
    8000323a:	e822                	sd	s0,16(sp)
    8000323c:	e426                	sd	s1,8(sp)
    8000323e:	e04a                	sd	s2,0(sp)
    80003240:	1000                	addi	s0,sp,32
    80003242:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003244:	00850913          	addi	s2,a0,8
    80003248:	854a                	mv	a0,s2
    8000324a:	5d2020ef          	jal	8000581c <acquire>
  lk->locked = 0;
    8000324e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003252:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003256:	8526                	mv	a0,s1
    80003258:	950fe0ef          	jal	800013a8 <wakeup>
  release(&lk->lk);
    8000325c:	854a                	mv	a0,s2
    8000325e:	652020ef          	jal	800058b0 <release>
}
    80003262:	60e2                	ld	ra,24(sp)
    80003264:	6442                	ld	s0,16(sp)
    80003266:	64a2                	ld	s1,8(sp)
    80003268:	6902                	ld	s2,0(sp)
    8000326a:	6105                	addi	sp,sp,32
    8000326c:	8082                	ret

000000008000326e <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    8000326e:	7179                	addi	sp,sp,-48
    80003270:	f406                	sd	ra,40(sp)
    80003272:	f022                	sd	s0,32(sp)
    80003274:	ec26                	sd	s1,24(sp)
    80003276:	e84a                	sd	s2,16(sp)
    80003278:	1800                	addi	s0,sp,48
    8000327a:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    8000327c:	00850913          	addi	s2,a0,8
    80003280:	854a                	mv	a0,s2
    80003282:	59a020ef          	jal	8000581c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003286:	409c                	lw	a5,0(s1)
    80003288:	ef81                	bnez	a5,800032a0 <holdingsleep+0x32>
    8000328a:	4481                	li	s1,0
  release(&lk->lk);
    8000328c:	854a                	mv	a0,s2
    8000328e:	622020ef          	jal	800058b0 <release>
  return r;
}
    80003292:	8526                	mv	a0,s1
    80003294:	70a2                	ld	ra,40(sp)
    80003296:	7402                	ld	s0,32(sp)
    80003298:	64e2                	ld	s1,24(sp)
    8000329a:	6942                	ld	s2,16(sp)
    8000329c:	6145                	addi	sp,sp,48
    8000329e:	8082                	ret
    800032a0:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    800032a2:	0284a983          	lw	s3,40(s1)
    800032a6:	addfd0ef          	jal	80000d82 <myproc>
    800032aa:	5904                	lw	s1,48(a0)
    800032ac:	413484b3          	sub	s1,s1,s3
    800032b0:	0014b493          	seqz	s1,s1
    800032b4:	69a2                	ld	s3,8(sp)
    800032b6:	bfd9                	j	8000328c <holdingsleep+0x1e>

00000000800032b8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800032b8:	1141                	addi	sp,sp,-16
    800032ba:	e406                	sd	ra,8(sp)
    800032bc:	e022                	sd	s0,0(sp)
    800032be:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800032c0:	00004597          	auipc	a1,0x4
    800032c4:	34858593          	addi	a1,a1,840 # 80007608 <etext+0x608>
    800032c8:	00017517          	auipc	a0,0x17
    800032cc:	26050513          	addi	a0,a0,608 # 8001a528 <ftable>
    800032d0:	4c2020ef          	jal	80005792 <initlock>
}
    800032d4:	60a2                	ld	ra,8(sp)
    800032d6:	6402                	ld	s0,0(sp)
    800032d8:	0141                	addi	sp,sp,16
    800032da:	8082                	ret

00000000800032dc <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800032dc:	1101                	addi	sp,sp,-32
    800032de:	ec06                	sd	ra,24(sp)
    800032e0:	e822                	sd	s0,16(sp)
    800032e2:	e426                	sd	s1,8(sp)
    800032e4:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800032e6:	00017517          	auipc	a0,0x17
    800032ea:	24250513          	addi	a0,a0,578 # 8001a528 <ftable>
    800032ee:	52e020ef          	jal	8000581c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800032f2:	00017497          	auipc	s1,0x17
    800032f6:	24e48493          	addi	s1,s1,590 # 8001a540 <ftable+0x18>
    800032fa:	00018717          	auipc	a4,0x18
    800032fe:	1e670713          	addi	a4,a4,486 # 8001b4e0 <disk>
    if(f->ref == 0){
    80003302:	40dc                	lw	a5,4(s1)
    80003304:	cf89                	beqz	a5,8000331e <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003306:	02848493          	addi	s1,s1,40
    8000330a:	fee49ce3          	bne	s1,a4,80003302 <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000330e:	00017517          	auipc	a0,0x17
    80003312:	21a50513          	addi	a0,a0,538 # 8001a528 <ftable>
    80003316:	59a020ef          	jal	800058b0 <release>
  return 0;
    8000331a:	4481                	li	s1,0
    8000331c:	a809                	j	8000332e <filealloc+0x52>
      f->ref = 1;
    8000331e:	4785                	li	a5,1
    80003320:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003322:	00017517          	auipc	a0,0x17
    80003326:	20650513          	addi	a0,a0,518 # 8001a528 <ftable>
    8000332a:	586020ef          	jal	800058b0 <release>
}
    8000332e:	8526                	mv	a0,s1
    80003330:	60e2                	ld	ra,24(sp)
    80003332:	6442                	ld	s0,16(sp)
    80003334:	64a2                	ld	s1,8(sp)
    80003336:	6105                	addi	sp,sp,32
    80003338:	8082                	ret

000000008000333a <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000333a:	1101                	addi	sp,sp,-32
    8000333c:	ec06                	sd	ra,24(sp)
    8000333e:	e822                	sd	s0,16(sp)
    80003340:	e426                	sd	s1,8(sp)
    80003342:	1000                	addi	s0,sp,32
    80003344:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003346:	00017517          	auipc	a0,0x17
    8000334a:	1e250513          	addi	a0,a0,482 # 8001a528 <ftable>
    8000334e:	4ce020ef          	jal	8000581c <acquire>
  if(f->ref < 1)
    80003352:	40dc                	lw	a5,4(s1)
    80003354:	02f05063          	blez	a5,80003374 <filedup+0x3a>
    panic("filedup");
  f->ref++;
    80003358:	2785                	addiw	a5,a5,1
    8000335a:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    8000335c:	00017517          	auipc	a0,0x17
    80003360:	1cc50513          	addi	a0,a0,460 # 8001a528 <ftable>
    80003364:	54c020ef          	jal	800058b0 <release>
  return f;
}
    80003368:	8526                	mv	a0,s1
    8000336a:	60e2                	ld	ra,24(sp)
    8000336c:	6442                	ld	s0,16(sp)
    8000336e:	64a2                	ld	s1,8(sp)
    80003370:	6105                	addi	sp,sp,32
    80003372:	8082                	ret
    panic("filedup");
    80003374:	00004517          	auipc	a0,0x4
    80003378:	29c50513          	addi	a0,a0,668 # 80007610 <etext+0x610>
    8000337c:	162020ef          	jal	800054de <panic>

0000000080003380 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003380:	7139                	addi	sp,sp,-64
    80003382:	fc06                	sd	ra,56(sp)
    80003384:	f822                	sd	s0,48(sp)
    80003386:	f426                	sd	s1,40(sp)
    80003388:	0080                	addi	s0,sp,64
    8000338a:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    8000338c:	00017517          	auipc	a0,0x17
    80003390:	19c50513          	addi	a0,a0,412 # 8001a528 <ftable>
    80003394:	488020ef          	jal	8000581c <acquire>
  if(f->ref < 1)
    80003398:	40dc                	lw	a5,4(s1)
    8000339a:	04f05a63          	blez	a5,800033ee <fileclose+0x6e>
    panic("fileclose");
  if(--f->ref > 0){
    8000339e:	37fd                	addiw	a5,a5,-1
    800033a0:	c0dc                	sw	a5,4(s1)
    800033a2:	06f04063          	bgtz	a5,80003402 <fileclose+0x82>
    800033a6:	f04a                	sd	s2,32(sp)
    800033a8:	ec4e                	sd	s3,24(sp)
    800033aa:	e852                	sd	s4,16(sp)
    800033ac:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800033ae:	0004a903          	lw	s2,0(s1)
    800033b2:	0094c783          	lbu	a5,9(s1)
    800033b6:	89be                	mv	s3,a5
    800033b8:	689c                	ld	a5,16(s1)
    800033ba:	8a3e                	mv	s4,a5
    800033bc:	6c9c                	ld	a5,24(s1)
    800033be:	8abe                	mv	s5,a5
  f->ref = 0;
    800033c0:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800033c4:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800033c8:	00017517          	auipc	a0,0x17
    800033cc:	16050513          	addi	a0,a0,352 # 8001a528 <ftable>
    800033d0:	4e0020ef          	jal	800058b0 <release>

  if(ff.type == FD_PIPE){
    800033d4:	4785                	li	a5,1
    800033d6:	04f90163          	beq	s2,a5,80003418 <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800033da:	ffe9079b          	addiw	a5,s2,-2
    800033de:	4705                	li	a4,1
    800033e0:	04f77563          	bgeu	a4,a5,8000342a <fileclose+0xaa>
    800033e4:	7902                	ld	s2,32(sp)
    800033e6:	69e2                	ld	s3,24(sp)
    800033e8:	6a42                	ld	s4,16(sp)
    800033ea:	6aa2                	ld	s5,8(sp)
    800033ec:	a00d                	j	8000340e <fileclose+0x8e>
    800033ee:	f04a                	sd	s2,32(sp)
    800033f0:	ec4e                	sd	s3,24(sp)
    800033f2:	e852                	sd	s4,16(sp)
    800033f4:	e456                	sd	s5,8(sp)
    panic("fileclose");
    800033f6:	00004517          	auipc	a0,0x4
    800033fa:	22250513          	addi	a0,a0,546 # 80007618 <etext+0x618>
    800033fe:	0e0020ef          	jal	800054de <panic>
    release(&ftable.lock);
    80003402:	00017517          	auipc	a0,0x17
    80003406:	12650513          	addi	a0,a0,294 # 8001a528 <ftable>
    8000340a:	4a6020ef          	jal	800058b0 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    8000340e:	70e2                	ld	ra,56(sp)
    80003410:	7442                	ld	s0,48(sp)
    80003412:	74a2                	ld	s1,40(sp)
    80003414:	6121                	addi	sp,sp,64
    80003416:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003418:	85ce                	mv	a1,s3
    8000341a:	8552                	mv	a0,s4
    8000341c:	348000ef          	jal	80003764 <pipeclose>
    80003420:	7902                	ld	s2,32(sp)
    80003422:	69e2                	ld	s3,24(sp)
    80003424:	6a42                	ld	s4,16(sp)
    80003426:	6aa2                	ld	s5,8(sp)
    80003428:	b7dd                	j	8000340e <fileclose+0x8e>
    begin_op();
    8000342a:	b25ff0ef          	jal	80002f4e <begin_op>
    iput(ff.ip);
    8000342e:	8556                	mv	a0,s5
    80003430:	be8ff0ef          	jal	80002818 <iput>
    end_op();
    80003434:	b8bff0ef          	jal	80002fbe <end_op>
    80003438:	7902                	ld	s2,32(sp)
    8000343a:	69e2                	ld	s3,24(sp)
    8000343c:	6a42                	ld	s4,16(sp)
    8000343e:	6aa2                	ld	s5,8(sp)
    80003440:	b7f9                	j	8000340e <fileclose+0x8e>

0000000080003442 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003442:	715d                	addi	sp,sp,-80
    80003444:	e486                	sd	ra,72(sp)
    80003446:	e0a2                	sd	s0,64(sp)
    80003448:	fc26                	sd	s1,56(sp)
    8000344a:	f052                	sd	s4,32(sp)
    8000344c:	0880                	addi	s0,sp,80
    8000344e:	84aa                	mv	s1,a0
    80003450:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    80003452:	931fd0ef          	jal	80000d82 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003456:	409c                	lw	a5,0(s1)
    80003458:	37f9                	addiw	a5,a5,-2
    8000345a:	4705                	li	a4,1
    8000345c:	04f76263          	bltu	a4,a5,800034a0 <filestat+0x5e>
    80003460:	f84a                	sd	s2,48(sp)
    80003462:	f44e                	sd	s3,40(sp)
    80003464:	89aa                	mv	s3,a0
    ilock(f->ip);
    80003466:	6c88                	ld	a0,24(s1)
    80003468:	a2eff0ef          	jal	80002696 <ilock>
    stati(f->ip, &st);
    8000346c:	fb840913          	addi	s2,s0,-72
    80003470:	85ca                	mv	a1,s2
    80003472:	6c88                	ld	a0,24(s1)
    80003474:	c4eff0ef          	jal	800028c2 <stati>
    iunlock(f->ip);
    80003478:	6c88                	ld	a0,24(s1)
    8000347a:	acaff0ef          	jal	80002744 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8000347e:	46e1                	li	a3,24
    80003480:	864a                	mv	a2,s2
    80003482:	85d2                	mv	a1,s4
    80003484:	0509b503          	ld	a0,80(s3)
    80003488:	d7afd0ef          	jal	80000a02 <copyout>
    8000348c:	41f5551b          	sraiw	a0,a0,0x1f
    80003490:	7942                	ld	s2,48(sp)
    80003492:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003494:	60a6                	ld	ra,72(sp)
    80003496:	6406                	ld	s0,64(sp)
    80003498:	74e2                	ld	s1,56(sp)
    8000349a:	7a02                	ld	s4,32(sp)
    8000349c:	6161                	addi	sp,sp,80
    8000349e:	8082                	ret
  return -1;
    800034a0:	557d                	li	a0,-1
    800034a2:	bfcd                	j	80003494 <filestat+0x52>

00000000800034a4 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    800034a4:	7179                	addi	sp,sp,-48
    800034a6:	f406                	sd	ra,40(sp)
    800034a8:	f022                	sd	s0,32(sp)
    800034aa:	e84a                	sd	s2,16(sp)
    800034ac:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    800034ae:	00854783          	lbu	a5,8(a0)
    800034b2:	cfd1                	beqz	a5,8000354e <fileread+0xaa>
    800034b4:	ec26                	sd	s1,24(sp)
    800034b6:	e44e                	sd	s3,8(sp)
    800034b8:	84aa                	mv	s1,a0
    800034ba:	892e                	mv	s2,a1
    800034bc:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    800034be:	411c                	lw	a5,0(a0)
    800034c0:	4705                	li	a4,1
    800034c2:	04e78363          	beq	a5,a4,80003508 <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800034c6:	470d                	li	a4,3
    800034c8:	04e78763          	beq	a5,a4,80003516 <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    800034cc:	4709                	li	a4,2
    800034ce:	06e79a63          	bne	a5,a4,80003542 <fileread+0x9e>
    ilock(f->ip);
    800034d2:	6d08                	ld	a0,24(a0)
    800034d4:	9c2ff0ef          	jal	80002696 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    800034d8:	874e                	mv	a4,s3
    800034da:	5094                	lw	a3,32(s1)
    800034dc:	864a                	mv	a2,s2
    800034de:	4585                	li	a1,1
    800034e0:	6c88                	ld	a0,24(s1)
    800034e2:	c0eff0ef          	jal	800028f0 <readi>
    800034e6:	892a                	mv	s2,a0
    800034e8:	00a05563          	blez	a0,800034f2 <fileread+0x4e>
      f->off += r;
    800034ec:	509c                	lw	a5,32(s1)
    800034ee:	9fa9                	addw	a5,a5,a0
    800034f0:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800034f2:	6c88                	ld	a0,24(s1)
    800034f4:	a50ff0ef          	jal	80002744 <iunlock>
    800034f8:	64e2                	ld	s1,24(sp)
    800034fa:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    800034fc:	854a                	mv	a0,s2
    800034fe:	70a2                	ld	ra,40(sp)
    80003500:	7402                	ld	s0,32(sp)
    80003502:	6942                	ld	s2,16(sp)
    80003504:	6145                	addi	sp,sp,48
    80003506:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003508:	6908                	ld	a0,16(a0)
    8000350a:	3b0000ef          	jal	800038ba <piperead>
    8000350e:	892a                	mv	s2,a0
    80003510:	64e2                	ld	s1,24(sp)
    80003512:	69a2                	ld	s3,8(sp)
    80003514:	b7e5                	j	800034fc <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003516:	02451783          	lh	a5,36(a0)
    8000351a:	03079693          	slli	a3,a5,0x30
    8000351e:	92c1                	srli	a3,a3,0x30
    80003520:	4725                	li	a4,9
    80003522:	02d76963          	bltu	a4,a3,80003554 <fileread+0xb0>
    80003526:	0792                	slli	a5,a5,0x4
    80003528:	00017717          	auipc	a4,0x17
    8000352c:	f6070713          	addi	a4,a4,-160 # 8001a488 <devsw>
    80003530:	97ba                	add	a5,a5,a4
    80003532:	639c                	ld	a5,0(a5)
    80003534:	c78d                	beqz	a5,8000355e <fileread+0xba>
    r = devsw[f->major].read(1, addr, n);
    80003536:	4505                	li	a0,1
    80003538:	9782                	jalr	a5
    8000353a:	892a                	mv	s2,a0
    8000353c:	64e2                	ld	s1,24(sp)
    8000353e:	69a2                	ld	s3,8(sp)
    80003540:	bf75                	j	800034fc <fileread+0x58>
    panic("fileread");
    80003542:	00004517          	auipc	a0,0x4
    80003546:	0e650513          	addi	a0,a0,230 # 80007628 <etext+0x628>
    8000354a:	795010ef          	jal	800054de <panic>
    return -1;
    8000354e:	57fd                	li	a5,-1
    80003550:	893e                	mv	s2,a5
    80003552:	b76d                	j	800034fc <fileread+0x58>
      return -1;
    80003554:	57fd                	li	a5,-1
    80003556:	893e                	mv	s2,a5
    80003558:	64e2                	ld	s1,24(sp)
    8000355a:	69a2                	ld	s3,8(sp)
    8000355c:	b745                	j	800034fc <fileread+0x58>
    8000355e:	57fd                	li	a5,-1
    80003560:	893e                	mv	s2,a5
    80003562:	64e2                	ld	s1,24(sp)
    80003564:	69a2                	ld	s3,8(sp)
    80003566:	bf59                	j	800034fc <fileread+0x58>

0000000080003568 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003568:	00954783          	lbu	a5,9(a0)
    8000356c:	10078f63          	beqz	a5,8000368a <filewrite+0x122>
{
    80003570:	711d                	addi	sp,sp,-96
    80003572:	ec86                	sd	ra,88(sp)
    80003574:	e8a2                	sd	s0,80(sp)
    80003576:	e0ca                	sd	s2,64(sp)
    80003578:	f456                	sd	s5,40(sp)
    8000357a:	f05a                	sd	s6,32(sp)
    8000357c:	1080                	addi	s0,sp,96
    8000357e:	892a                	mv	s2,a0
    80003580:	8b2e                	mv	s6,a1
    80003582:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003584:	411c                	lw	a5,0(a0)
    80003586:	4705                	li	a4,1
    80003588:	02e78a63          	beq	a5,a4,800035bc <filewrite+0x54>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000358c:	470d                	li	a4,3
    8000358e:	02e78b63          	beq	a5,a4,800035c4 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003592:	4709                	li	a4,2
    80003594:	0ce79f63          	bne	a5,a4,80003672 <filewrite+0x10a>
    80003598:	f852                	sd	s4,48(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    8000359a:	0ac05a63          	blez	a2,8000364e <filewrite+0xe6>
    8000359e:	e4a6                	sd	s1,72(sp)
    800035a0:	fc4e                	sd	s3,56(sp)
    800035a2:	ec5e                	sd	s7,24(sp)
    800035a4:	e862                	sd	s8,16(sp)
    800035a6:	e466                	sd	s9,8(sp)
    int i = 0;
    800035a8:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    800035aa:	6b85                	lui	s7,0x1
    800035ac:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    800035b0:	6785                	lui	a5,0x1
    800035b2:	c007879b          	addiw	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    800035b6:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800035b8:	4c05                	li	s8,1
    800035ba:	a8ad                	j	80003634 <filewrite+0xcc>
    ret = pipewrite(f->pipe, addr, n);
    800035bc:	6908                	ld	a0,16(a0)
    800035be:	204000ef          	jal	800037c2 <pipewrite>
    800035c2:	a04d                	j	80003664 <filewrite+0xfc>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800035c4:	02451783          	lh	a5,36(a0)
    800035c8:	03079693          	slli	a3,a5,0x30
    800035cc:	92c1                	srli	a3,a3,0x30
    800035ce:	4725                	li	a4,9
    800035d0:	0ad76f63          	bltu	a4,a3,8000368e <filewrite+0x126>
    800035d4:	0792                	slli	a5,a5,0x4
    800035d6:	00017717          	auipc	a4,0x17
    800035da:	eb270713          	addi	a4,a4,-334 # 8001a488 <devsw>
    800035de:	97ba                	add	a5,a5,a4
    800035e0:	679c                	ld	a5,8(a5)
    800035e2:	cbc5                	beqz	a5,80003692 <filewrite+0x12a>
    ret = devsw[f->major].write(1, addr, n);
    800035e4:	4505                	li	a0,1
    800035e6:	9782                	jalr	a5
    800035e8:	a8b5                	j	80003664 <filewrite+0xfc>
      if(n1 > max)
    800035ea:	2981                	sext.w	s3,s3
      begin_op();
    800035ec:	963ff0ef          	jal	80002f4e <begin_op>
      ilock(f->ip);
    800035f0:	01893503          	ld	a0,24(s2)
    800035f4:	8a2ff0ef          	jal	80002696 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800035f8:	874e                	mv	a4,s3
    800035fa:	02092683          	lw	a3,32(s2)
    800035fe:	016a0633          	add	a2,s4,s6
    80003602:	85e2                	mv	a1,s8
    80003604:	01893503          	ld	a0,24(s2)
    80003608:	bdaff0ef          	jal	800029e2 <writei>
    8000360c:	84aa                	mv	s1,a0
    8000360e:	00a05763          	blez	a0,8000361c <filewrite+0xb4>
        f->off += r;
    80003612:	02092783          	lw	a5,32(s2)
    80003616:	9fa9                	addw	a5,a5,a0
    80003618:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    8000361c:	01893503          	ld	a0,24(s2)
    80003620:	924ff0ef          	jal	80002744 <iunlock>
      end_op();
    80003624:	99bff0ef          	jal	80002fbe <end_op>

      if(r != n1){
    80003628:	02999563          	bne	s3,s1,80003652 <filewrite+0xea>
        // error from writei
        break;
      }
      i += r;
    8000362c:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    80003630:	015a5963          	bge	s4,s5,80003642 <filewrite+0xda>
      int n1 = n - i;
    80003634:	414a87bb          	subw	a5,s5,s4
    80003638:	89be                	mv	s3,a5
      if(n1 > max)
    8000363a:	fafbd8e3          	bge	s7,a5,800035ea <filewrite+0x82>
    8000363e:	89e6                	mv	s3,s9
    80003640:	b76d                	j	800035ea <filewrite+0x82>
    80003642:	64a6                	ld	s1,72(sp)
    80003644:	79e2                	ld	s3,56(sp)
    80003646:	6be2                	ld	s7,24(sp)
    80003648:	6c42                	ld	s8,16(sp)
    8000364a:	6ca2                	ld	s9,8(sp)
    8000364c:	a801                	j	8000365c <filewrite+0xf4>
    int i = 0;
    8000364e:	4a01                	li	s4,0
    80003650:	a031                	j	8000365c <filewrite+0xf4>
    80003652:	64a6                	ld	s1,72(sp)
    80003654:	79e2                	ld	s3,56(sp)
    80003656:	6be2                	ld	s7,24(sp)
    80003658:	6c42                	ld	s8,16(sp)
    8000365a:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    8000365c:	034a9d63          	bne	s5,s4,80003696 <filewrite+0x12e>
    80003660:	8556                	mv	a0,s5
    80003662:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003664:	60e6                	ld	ra,88(sp)
    80003666:	6446                	ld	s0,80(sp)
    80003668:	6906                	ld	s2,64(sp)
    8000366a:	7aa2                	ld	s5,40(sp)
    8000366c:	7b02                	ld	s6,32(sp)
    8000366e:	6125                	addi	sp,sp,96
    80003670:	8082                	ret
    80003672:	e4a6                	sd	s1,72(sp)
    80003674:	fc4e                	sd	s3,56(sp)
    80003676:	f852                	sd	s4,48(sp)
    80003678:	ec5e                	sd	s7,24(sp)
    8000367a:	e862                	sd	s8,16(sp)
    8000367c:	e466                	sd	s9,8(sp)
    panic("filewrite");
    8000367e:	00004517          	auipc	a0,0x4
    80003682:	fba50513          	addi	a0,a0,-70 # 80007638 <etext+0x638>
    80003686:	659010ef          	jal	800054de <panic>
    return -1;
    8000368a:	557d                	li	a0,-1
}
    8000368c:	8082                	ret
      return -1;
    8000368e:	557d                	li	a0,-1
    80003690:	bfd1                	j	80003664 <filewrite+0xfc>
    80003692:	557d                	li	a0,-1
    80003694:	bfc1                	j	80003664 <filewrite+0xfc>
    ret = (i == n ? n : -1);
    80003696:	557d                	li	a0,-1
    80003698:	7a42                	ld	s4,48(sp)
    8000369a:	b7e9                	j	80003664 <filewrite+0xfc>

000000008000369c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000369c:	7179                	addi	sp,sp,-48
    8000369e:	f406                	sd	ra,40(sp)
    800036a0:	f022                	sd	s0,32(sp)
    800036a2:	ec26                	sd	s1,24(sp)
    800036a4:	e052                	sd	s4,0(sp)
    800036a6:	1800                	addi	s0,sp,48
    800036a8:	84aa                	mv	s1,a0
    800036aa:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800036ac:	0005b023          	sd	zero,0(a1)
    800036b0:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800036b4:	c29ff0ef          	jal	800032dc <filealloc>
    800036b8:	e088                	sd	a0,0(s1)
    800036ba:	c549                	beqz	a0,80003744 <pipealloc+0xa8>
    800036bc:	c21ff0ef          	jal	800032dc <filealloc>
    800036c0:	00aa3023          	sd	a0,0(s4)
    800036c4:	cd25                	beqz	a0,8000373c <pipealloc+0xa0>
    800036c6:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800036c8:	a3dfc0ef          	jal	80000104 <kalloc>
    800036cc:	892a                	mv	s2,a0
    800036ce:	c12d                	beqz	a0,80003730 <pipealloc+0x94>
    800036d0:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    800036d2:	4985                	li	s3,1
    800036d4:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    800036d8:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    800036dc:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    800036e0:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800036e4:	00004597          	auipc	a1,0x4
    800036e8:	d0c58593          	addi	a1,a1,-756 # 800073f0 <etext+0x3f0>
    800036ec:	0a6020ef          	jal	80005792 <initlock>
  (*f0)->type = FD_PIPE;
    800036f0:	609c                	ld	a5,0(s1)
    800036f2:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800036f6:	609c                	ld	a5,0(s1)
    800036f8:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800036fc:	609c                	ld	a5,0(s1)
    800036fe:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003702:	609c                	ld	a5,0(s1)
    80003704:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003708:	000a3783          	ld	a5,0(s4)
    8000370c:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003710:	000a3783          	ld	a5,0(s4)
    80003714:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003718:	000a3783          	ld	a5,0(s4)
    8000371c:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003720:	000a3783          	ld	a5,0(s4)
    80003724:	0127b823          	sd	s2,16(a5)
  return 0;
    80003728:	4501                	li	a0,0
    8000372a:	6942                	ld	s2,16(sp)
    8000372c:	69a2                	ld	s3,8(sp)
    8000372e:	a01d                	j	80003754 <pipealloc+0xb8>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003730:	6088                	ld	a0,0(s1)
    80003732:	c119                	beqz	a0,80003738 <pipealloc+0x9c>
    80003734:	6942                	ld	s2,16(sp)
    80003736:	a029                	j	80003740 <pipealloc+0xa4>
    80003738:	6942                	ld	s2,16(sp)
    8000373a:	a029                	j	80003744 <pipealloc+0xa8>
    8000373c:	6088                	ld	a0,0(s1)
    8000373e:	c10d                	beqz	a0,80003760 <pipealloc+0xc4>
    fileclose(*f0);
    80003740:	c41ff0ef          	jal	80003380 <fileclose>
  if(*f1)
    80003744:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003748:	557d                	li	a0,-1
  if(*f1)
    8000374a:	c789                	beqz	a5,80003754 <pipealloc+0xb8>
    fileclose(*f1);
    8000374c:	853e                	mv	a0,a5
    8000374e:	c33ff0ef          	jal	80003380 <fileclose>
  return -1;
    80003752:	557d                	li	a0,-1
}
    80003754:	70a2                	ld	ra,40(sp)
    80003756:	7402                	ld	s0,32(sp)
    80003758:	64e2                	ld	s1,24(sp)
    8000375a:	6a02                	ld	s4,0(sp)
    8000375c:	6145                	addi	sp,sp,48
    8000375e:	8082                	ret
  return -1;
    80003760:	557d                	li	a0,-1
    80003762:	bfcd                	j	80003754 <pipealloc+0xb8>

0000000080003764 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003764:	1101                	addi	sp,sp,-32
    80003766:	ec06                	sd	ra,24(sp)
    80003768:	e822                	sd	s0,16(sp)
    8000376a:	e426                	sd	s1,8(sp)
    8000376c:	e04a                	sd	s2,0(sp)
    8000376e:	1000                	addi	s0,sp,32
    80003770:	84aa                	mv	s1,a0
    80003772:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003774:	0a8020ef          	jal	8000581c <acquire>
  if(writable){
    80003778:	02090763          	beqz	s2,800037a6 <pipeclose+0x42>
    pi->writeopen = 0;
    8000377c:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003780:	21848513          	addi	a0,s1,536
    80003784:	c25fd0ef          	jal	800013a8 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003788:	2204a783          	lw	a5,544(s1)
    8000378c:	e781                	bnez	a5,80003794 <pipeclose+0x30>
    8000378e:	2244a783          	lw	a5,548(s1)
    80003792:	c38d                	beqz	a5,800037b4 <pipeclose+0x50>
    release(&pi->lock);
    kfree((char*)pi);
  } else
    release(&pi->lock);
    80003794:	8526                	mv	a0,s1
    80003796:	11a020ef          	jal	800058b0 <release>
}
    8000379a:	60e2                	ld	ra,24(sp)
    8000379c:	6442                	ld	s0,16(sp)
    8000379e:	64a2                	ld	s1,8(sp)
    800037a0:	6902                	ld	s2,0(sp)
    800037a2:	6105                	addi	sp,sp,32
    800037a4:	8082                	ret
    pi->readopen = 0;
    800037a6:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800037aa:	21c48513          	addi	a0,s1,540
    800037ae:	bfbfd0ef          	jal	800013a8 <wakeup>
    800037b2:	bfd9                	j	80003788 <pipeclose+0x24>
    release(&pi->lock);
    800037b4:	8526                	mv	a0,s1
    800037b6:	0fa020ef          	jal	800058b0 <release>
    kfree((char*)pi);
    800037ba:	8526                	mv	a0,s1
    800037bc:	861fc0ef          	jal	8000001c <kfree>
    800037c0:	bfe9                	j	8000379a <pipeclose+0x36>

00000000800037c2 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800037c2:	7159                	addi	sp,sp,-112
    800037c4:	f486                	sd	ra,104(sp)
    800037c6:	f0a2                	sd	s0,96(sp)
    800037c8:	eca6                	sd	s1,88(sp)
    800037ca:	e8ca                	sd	s2,80(sp)
    800037cc:	e4ce                	sd	s3,72(sp)
    800037ce:	e0d2                	sd	s4,64(sp)
    800037d0:	fc56                	sd	s5,56(sp)
    800037d2:	1880                	addi	s0,sp,112
    800037d4:	84aa                	mv	s1,a0
    800037d6:	8aae                	mv	s5,a1
    800037d8:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800037da:	da8fd0ef          	jal	80000d82 <myproc>
    800037de:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800037e0:	8526                	mv	a0,s1
    800037e2:	03a020ef          	jal	8000581c <acquire>
  while(i < n){
    800037e6:	0d405263          	blez	s4,800038aa <pipewrite+0xe8>
    800037ea:	f85a                	sd	s6,48(sp)
    800037ec:	f45e                	sd	s7,40(sp)
    800037ee:	f062                	sd	s8,32(sp)
    800037f0:	ec66                	sd	s9,24(sp)
    800037f2:	e86a                	sd	s10,16(sp)
  int i = 0;
    800037f4:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800037f6:	f9f40c13          	addi	s8,s0,-97
    800037fa:	4b85                	li	s7,1
    800037fc:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800037fe:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003802:	21c48c93          	addi	s9,s1,540
    80003806:	a82d                	j	80003840 <pipewrite+0x7e>
      release(&pi->lock);
    80003808:	8526                	mv	a0,s1
    8000380a:	0a6020ef          	jal	800058b0 <release>
      return -1;
    8000380e:	597d                	li	s2,-1
    80003810:	7b42                	ld	s6,48(sp)
    80003812:	7ba2                	ld	s7,40(sp)
    80003814:	7c02                	ld	s8,32(sp)
    80003816:	6ce2                	ld	s9,24(sp)
    80003818:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    8000381a:	854a                	mv	a0,s2
    8000381c:	70a6                	ld	ra,104(sp)
    8000381e:	7406                	ld	s0,96(sp)
    80003820:	64e6                	ld	s1,88(sp)
    80003822:	6946                	ld	s2,80(sp)
    80003824:	69a6                	ld	s3,72(sp)
    80003826:	6a06                	ld	s4,64(sp)
    80003828:	7ae2                	ld	s5,56(sp)
    8000382a:	6165                	addi	sp,sp,112
    8000382c:	8082                	ret
      wakeup(&pi->nread);
    8000382e:	856a                	mv	a0,s10
    80003830:	b79fd0ef          	jal	800013a8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003834:	85a6                	mv	a1,s1
    80003836:	8566                	mv	a0,s9
    80003838:	b25fd0ef          	jal	8000135c <sleep>
  while(i < n){
    8000383c:	05495a63          	bge	s2,s4,80003890 <pipewrite+0xce>
    if(pi->readopen == 0 || killed(pr)){
    80003840:	2204a783          	lw	a5,544(s1)
    80003844:	d3f1                	beqz	a5,80003808 <pipewrite+0x46>
    80003846:	854e                	mv	a0,s3
    80003848:	d51fd0ef          	jal	80001598 <killed>
    8000384c:	fd55                	bnez	a0,80003808 <pipewrite+0x46>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    8000384e:	2184a783          	lw	a5,536(s1)
    80003852:	21c4a703          	lw	a4,540(s1)
    80003856:	2007879b          	addiw	a5,a5,512
    8000385a:	fcf70ae3          	beq	a4,a5,8000382e <pipewrite+0x6c>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000385e:	86de                	mv	a3,s7
    80003860:	01590633          	add	a2,s2,s5
    80003864:	85e2                	mv	a1,s8
    80003866:	0509b503          	ld	a0,80(s3)
    8000386a:	a48fd0ef          	jal	80000ab2 <copyin>
    8000386e:	05650063          	beq	a0,s6,800038ae <pipewrite+0xec>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003872:	21c4a783          	lw	a5,540(s1)
    80003876:	0017871b          	addiw	a4,a5,1
    8000387a:	20e4ae23          	sw	a4,540(s1)
    8000387e:	1ff7f793          	andi	a5,a5,511
    80003882:	97a6                	add	a5,a5,s1
    80003884:	f9f44703          	lbu	a4,-97(s0)
    80003888:	00e78c23          	sb	a4,24(a5)
      i++;
    8000388c:	2905                	addiw	s2,s2,1
    8000388e:	b77d                	j	8000383c <pipewrite+0x7a>
    80003890:	7b42                	ld	s6,48(sp)
    80003892:	7ba2                	ld	s7,40(sp)
    80003894:	7c02                	ld	s8,32(sp)
    80003896:	6ce2                	ld	s9,24(sp)
    80003898:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    8000389a:	21848513          	addi	a0,s1,536
    8000389e:	b0bfd0ef          	jal	800013a8 <wakeup>
  release(&pi->lock);
    800038a2:	8526                	mv	a0,s1
    800038a4:	00c020ef          	jal	800058b0 <release>
  return i;
    800038a8:	bf8d                	j	8000381a <pipewrite+0x58>
  int i = 0;
    800038aa:	4901                	li	s2,0
    800038ac:	b7fd                	j	8000389a <pipewrite+0xd8>
    800038ae:	7b42                	ld	s6,48(sp)
    800038b0:	7ba2                	ld	s7,40(sp)
    800038b2:	7c02                	ld	s8,32(sp)
    800038b4:	6ce2                	ld	s9,24(sp)
    800038b6:	6d42                	ld	s10,16(sp)
    800038b8:	b7cd                	j	8000389a <pipewrite+0xd8>

00000000800038ba <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800038ba:	711d                	addi	sp,sp,-96
    800038bc:	ec86                	sd	ra,88(sp)
    800038be:	e8a2                	sd	s0,80(sp)
    800038c0:	e4a6                	sd	s1,72(sp)
    800038c2:	e0ca                	sd	s2,64(sp)
    800038c4:	fc4e                	sd	s3,56(sp)
    800038c6:	f852                	sd	s4,48(sp)
    800038c8:	f456                	sd	s5,40(sp)
    800038ca:	1080                	addi	s0,sp,96
    800038cc:	84aa                	mv	s1,a0
    800038ce:	892e                	mv	s2,a1
    800038d0:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800038d2:	cb0fd0ef          	jal	80000d82 <myproc>
    800038d6:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800038d8:	8526                	mv	a0,s1
    800038da:	743010ef          	jal	8000581c <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800038de:	2184a703          	lw	a4,536(s1)
    800038e2:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800038e6:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800038ea:	02f71763          	bne	a4,a5,80003918 <piperead+0x5e>
    800038ee:	2244a783          	lw	a5,548(s1)
    800038f2:	cf85                	beqz	a5,8000392a <piperead+0x70>
    if(killed(pr)){
    800038f4:	8552                	mv	a0,s4
    800038f6:	ca3fd0ef          	jal	80001598 <killed>
    800038fa:	e11d                	bnez	a0,80003920 <piperead+0x66>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800038fc:	85a6                	mv	a1,s1
    800038fe:	854e                	mv	a0,s3
    80003900:	a5dfd0ef          	jal	8000135c <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003904:	2184a703          	lw	a4,536(s1)
    80003908:	21c4a783          	lw	a5,540(s1)
    8000390c:	fef701e3          	beq	a4,a5,800038ee <piperead+0x34>
    80003910:	f05a                	sd	s6,32(sp)
    80003912:	ec5e                	sd	s7,24(sp)
    80003914:	e862                	sd	s8,16(sp)
    80003916:	a829                	j	80003930 <piperead+0x76>
    80003918:	f05a                	sd	s6,32(sp)
    8000391a:	ec5e                	sd	s7,24(sp)
    8000391c:	e862                	sd	s8,16(sp)
    8000391e:	a809                	j	80003930 <piperead+0x76>
      release(&pi->lock);
    80003920:	8526                	mv	a0,s1
    80003922:	78f010ef          	jal	800058b0 <release>
      return -1;
    80003926:	59fd                	li	s3,-1
    80003928:	a09d                	j	8000398e <piperead+0xd4>
    8000392a:	f05a                	sd	s6,32(sp)
    8000392c:	ec5e                	sd	s7,24(sp)
    8000392e:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003930:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003932:	faf40c13          	addi	s8,s0,-81
    80003936:	4b85                	li	s7,1
    80003938:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000393a:	05505063          	blez	s5,8000397a <piperead+0xc0>
    if(pi->nread == pi->nwrite)
    8000393e:	2184a783          	lw	a5,536(s1)
    80003942:	21c4a703          	lw	a4,540(s1)
    80003946:	02f70a63          	beq	a4,a5,8000397a <piperead+0xc0>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000394a:	0017871b          	addiw	a4,a5,1
    8000394e:	20e4ac23          	sw	a4,536(s1)
    80003952:	1ff7f793          	andi	a5,a5,511
    80003956:	97a6                	add	a5,a5,s1
    80003958:	0187c783          	lbu	a5,24(a5)
    8000395c:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003960:	86de                	mv	a3,s7
    80003962:	8662                	mv	a2,s8
    80003964:	85ca                	mv	a1,s2
    80003966:	050a3503          	ld	a0,80(s4)
    8000396a:	898fd0ef          	jal	80000a02 <copyout>
    8000396e:	01650663          	beq	a0,s6,8000397a <piperead+0xc0>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003972:	2985                	addiw	s3,s3,1
    80003974:	0905                	addi	s2,s2,1
    80003976:	fd3a94e3          	bne	s5,s3,8000393e <piperead+0x84>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000397a:	21c48513          	addi	a0,s1,540
    8000397e:	a2bfd0ef          	jal	800013a8 <wakeup>
  release(&pi->lock);
    80003982:	8526                	mv	a0,s1
    80003984:	72d010ef          	jal	800058b0 <release>
    80003988:	7b02                	ld	s6,32(sp)
    8000398a:	6be2                	ld	s7,24(sp)
    8000398c:	6c42                	ld	s8,16(sp)
  return i;
}
    8000398e:	854e                	mv	a0,s3
    80003990:	60e6                	ld	ra,88(sp)
    80003992:	6446                	ld	s0,80(sp)
    80003994:	64a6                	ld	s1,72(sp)
    80003996:	6906                	ld	s2,64(sp)
    80003998:	79e2                	ld	s3,56(sp)
    8000399a:	7a42                	ld	s4,48(sp)
    8000399c:	7aa2                	ld	s5,40(sp)
    8000399e:	6125                	addi	sp,sp,96
    800039a0:	8082                	ret

00000000800039a2 <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    800039a2:	1141                	addi	sp,sp,-16
    800039a4:	e406                	sd	ra,8(sp)
    800039a6:	e022                	sd	s0,0(sp)
    800039a8:	0800                	addi	s0,sp,16
    800039aa:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800039ac:	0035151b          	slliw	a0,a0,0x3
    800039b0:	8921                	andi	a0,a0,8
      perm = PTE_X;
    if(flags & 0x2)
    800039b2:	8b89                	andi	a5,a5,2
    800039b4:	c399                	beqz	a5,800039ba <flags2perm+0x18>
      perm |= PTE_W;
    800039b6:	00456513          	ori	a0,a0,4
    return perm;
}
    800039ba:	60a2                	ld	ra,8(sp)
    800039bc:	6402                	ld	s0,0(sp)
    800039be:	0141                	addi	sp,sp,16
    800039c0:	8082                	ret

00000000800039c2 <exec>:

int
exec(char *path, char **argv)
{
    800039c2:	de010113          	addi	sp,sp,-544
    800039c6:	20113c23          	sd	ra,536(sp)
    800039ca:	20813823          	sd	s0,528(sp)
    800039ce:	20913423          	sd	s1,520(sp)
    800039d2:	21213023          	sd	s2,512(sp)
    800039d6:	1400                	addi	s0,sp,544
    800039d8:	892a                	mv	s2,a0
    800039da:	dea43823          	sd	a0,-528(s0)
    800039de:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800039e2:	ba0fd0ef          	jal	80000d82 <myproc>
    800039e6:	84aa                	mv	s1,a0

  begin_op();
    800039e8:	d66ff0ef          	jal	80002f4e <begin_op>

  if((ip = namei(path)) == 0){
    800039ec:	854a                	mv	a0,s2
    800039ee:	b9eff0ef          	jal	80002d8c <namei>
    800039f2:	cd21                	beqz	a0,80003a4a <exec+0x88>
    800039f4:	fbd2                	sd	s4,496(sp)
    800039f6:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800039f8:	c9ffe0ef          	jal	80002696 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800039fc:	04000713          	li	a4,64
    80003a00:	4681                	li	a3,0
    80003a02:	e5040613          	addi	a2,s0,-432
    80003a06:	4581                	li	a1,0
    80003a08:	8552                	mv	a0,s4
    80003a0a:	ee7fe0ef          	jal	800028f0 <readi>
    80003a0e:	04000793          	li	a5,64
    80003a12:	00f51a63          	bne	a0,a5,80003a26 <exec+0x64>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80003a16:	e5042703          	lw	a4,-432(s0)
    80003a1a:	464c47b7          	lui	a5,0x464c4
    80003a1e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003a22:	02f70863          	beq	a4,a5,80003a52 <exec+0x90>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003a26:	8552                	mv	a0,s4
    80003a28:	e7bfe0ef          	jal	800028a2 <iunlockput>
    end_op();
    80003a2c:	d92ff0ef          	jal	80002fbe <end_op>
  }
  return -1;
    80003a30:	557d                	li	a0,-1
    80003a32:	7a5e                	ld	s4,496(sp)
}
    80003a34:	21813083          	ld	ra,536(sp)
    80003a38:	21013403          	ld	s0,528(sp)
    80003a3c:	20813483          	ld	s1,520(sp)
    80003a40:	20013903          	ld	s2,512(sp)
    80003a44:	22010113          	addi	sp,sp,544
    80003a48:	8082                	ret
    end_op();
    80003a4a:	d74ff0ef          	jal	80002fbe <end_op>
    return -1;
    80003a4e:	557d                	li	a0,-1
    80003a50:	b7d5                	j	80003a34 <exec+0x72>
    80003a52:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003a54:	8526                	mv	a0,s1
    80003a56:	bd6fd0ef          	jal	80000e2c <proc_pagetable>
    80003a5a:	8b2a                	mv	s6,a0
    80003a5c:	26050d63          	beqz	a0,80003cd6 <exec+0x314>
    80003a60:	ffce                	sd	s3,504(sp)
    80003a62:	f7d6                	sd	s5,488(sp)
    80003a64:	efde                	sd	s7,472(sp)
    80003a66:	ebe2                	sd	s8,464(sp)
    80003a68:	e7e6                	sd	s9,456(sp)
    80003a6a:	e3ea                	sd	s10,448(sp)
    80003a6c:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003a6e:	e8845783          	lhu	a5,-376(s0)
    80003a72:	0e078963          	beqz	a5,80003b64 <exec+0x1a2>
    80003a76:	e7042683          	lw	a3,-400(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003a7a:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003a7c:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003a7e:	03800d93          	li	s11,56
    if(ph.vaddr % PGSIZE != 0)
    80003a82:	6c85                	lui	s9,0x1
    80003a84:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80003a88:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003a8c:	6a85                	lui	s5,0x1
    80003a8e:	a085                	j	80003aee <exec+0x12c>
      panic("loadseg: address should exist");
    80003a90:	00004517          	auipc	a0,0x4
    80003a94:	bb850513          	addi	a0,a0,-1096 # 80007648 <etext+0x648>
    80003a98:	247010ef          	jal	800054de <panic>
    if(sz - i < PGSIZE)
    80003a9c:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003a9e:	874a                	mv	a4,s2
    80003aa0:	009b86bb          	addw	a3,s7,s1
    80003aa4:	4581                	li	a1,0
    80003aa6:	8552                	mv	a0,s4
    80003aa8:	e49fe0ef          	jal	800028f0 <readi>
    80003aac:	22a91963          	bne	s2,a0,80003cde <exec+0x31c>
  for(i = 0; i < sz; i += PGSIZE){
    80003ab0:	009a84bb          	addw	s1,s5,s1
    80003ab4:	0334f263          	bgeu	s1,s3,80003ad8 <exec+0x116>
    pa = walkaddr(pagetable, va + i);
    80003ab8:	02049593          	slli	a1,s1,0x20
    80003abc:	9181                	srli	a1,a1,0x20
    80003abe:	95e2                	add	a1,a1,s8
    80003ac0:	855a                	mv	a0,s6
    80003ac2:	9cbfc0ef          	jal	8000048c <walkaddr>
    80003ac6:	862a                	mv	a2,a0
    if(pa == 0)
    80003ac8:	d561                	beqz	a0,80003a90 <exec+0xce>
    if(sz - i < PGSIZE)
    80003aca:	409987bb          	subw	a5,s3,s1
    80003ace:	893e                	mv	s2,a5
    80003ad0:	fcfcf6e3          	bgeu	s9,a5,80003a9c <exec+0xda>
    80003ad4:	8956                	mv	s2,s5
    80003ad6:	b7d9                	j	80003a9c <exec+0xda>
    sz = sz1;
    80003ad8:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003adc:	2d05                	addiw	s10,s10,1
    80003ade:	e0843783          	ld	a5,-504(s0)
    80003ae2:	0387869b          	addiw	a3,a5,56
    80003ae6:	e8845783          	lhu	a5,-376(s0)
    80003aea:	06fd5e63          	bge	s10,a5,80003b66 <exec+0x1a4>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003aee:	e0d43423          	sd	a3,-504(s0)
    80003af2:	876e                	mv	a4,s11
    80003af4:	e1840613          	addi	a2,s0,-488
    80003af8:	4581                	li	a1,0
    80003afa:	8552                	mv	a0,s4
    80003afc:	df5fe0ef          	jal	800028f0 <readi>
    80003b00:	1db51d63          	bne	a0,s11,80003cda <exec+0x318>
    if(ph.type != ELF_PROG_LOAD)
    80003b04:	e1842783          	lw	a5,-488(s0)
    80003b08:	4705                	li	a4,1
    80003b0a:	fce799e3          	bne	a5,a4,80003adc <exec+0x11a>
    if(ph.memsz < ph.filesz)
    80003b0e:	e4043483          	ld	s1,-448(s0)
    80003b12:	e3843783          	ld	a5,-456(s0)
    80003b16:	1ef4e263          	bltu	s1,a5,80003cfa <exec+0x338>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003b1a:	e2843783          	ld	a5,-472(s0)
    80003b1e:	94be                	add	s1,s1,a5
    80003b20:	1ef4e063          	bltu	s1,a5,80003d00 <exec+0x33e>
    if(ph.vaddr % PGSIZE != 0)
    80003b24:	de843703          	ld	a4,-536(s0)
    80003b28:	8ff9                	and	a5,a5,a4
    80003b2a:	1c079e63          	bnez	a5,80003d06 <exec+0x344>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003b2e:	e1c42503          	lw	a0,-484(s0)
    80003b32:	e71ff0ef          	jal	800039a2 <flags2perm>
    80003b36:	86aa                	mv	a3,a0
    80003b38:	8626                	mv	a2,s1
    80003b3a:	85ca                	mv	a1,s2
    80003b3c:	855a                	mv	a0,s6
    80003b3e:	cb5fc0ef          	jal	800007f2 <uvmalloc>
    80003b42:	dea43c23          	sd	a0,-520(s0)
    80003b46:	1c050363          	beqz	a0,80003d0c <exec+0x34a>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003b4a:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003b4e:	00098863          	beqz	s3,80003b5e <exec+0x19c>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003b52:	e2843c03          	ld	s8,-472(s0)
    80003b56:	e2042b83          	lw	s7,-480(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003b5a:	4481                	li	s1,0
    80003b5c:	bfb1                	j	80003ab8 <exec+0xf6>
    sz = sz1;
    80003b5e:	df843903          	ld	s2,-520(s0)
    80003b62:	bfad                	j	80003adc <exec+0x11a>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003b64:	4901                	li	s2,0
  iunlockput(ip);
    80003b66:	8552                	mv	a0,s4
    80003b68:	d3bfe0ef          	jal	800028a2 <iunlockput>
  end_op();
    80003b6c:	c52ff0ef          	jal	80002fbe <end_op>
  p = myproc();
    80003b70:	a12fd0ef          	jal	80000d82 <myproc>
    80003b74:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80003b76:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80003b7a:	6985                	lui	s3,0x1
    80003b7c:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    80003b7e:	99ca                	add	s3,s3,s2
    80003b80:	77fd                	lui	a5,0xfffff
    80003b82:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003b86:	4691                	li	a3,4
    80003b88:	660d                	lui	a2,0x3
    80003b8a:	964e                	add	a2,a2,s3
    80003b8c:	85ce                	mv	a1,s3
    80003b8e:	855a                	mv	a0,s6
    80003b90:	c63fc0ef          	jal	800007f2 <uvmalloc>
    80003b94:	8a2a                	mv	s4,a0
    80003b96:	e105                	bnez	a0,80003bb6 <exec+0x1f4>
    proc_freepagetable(pagetable, sz);
    80003b98:	85ce                	mv	a1,s3
    80003b9a:	855a                	mv	a0,s6
    80003b9c:	b14fd0ef          	jal	80000eb0 <proc_freepagetable>
  return -1;
    80003ba0:	557d                	li	a0,-1
    80003ba2:	79fe                	ld	s3,504(sp)
    80003ba4:	7a5e                	ld	s4,496(sp)
    80003ba6:	7abe                	ld	s5,488(sp)
    80003ba8:	7b1e                	ld	s6,480(sp)
    80003baa:	6bfe                	ld	s7,472(sp)
    80003bac:	6c5e                	ld	s8,464(sp)
    80003bae:	6cbe                	ld	s9,456(sp)
    80003bb0:	6d1e                	ld	s10,448(sp)
    80003bb2:	7dfa                	ld	s11,440(sp)
    80003bb4:	b541                	j	80003a34 <exec+0x72>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003bb6:	75f5                	lui	a1,0xffffd
    80003bb8:	95aa                	add	a1,a1,a0
    80003bba:	855a                	mv	a0,s6
    80003bbc:	e1dfc0ef          	jal	800009d8 <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003bc0:	7bf9                	lui	s7,0xffffe
    80003bc2:	9bd2                	add	s7,s7,s4
  for(argc = 0; argv[argc]; argc++) {
    80003bc4:	e0043783          	ld	a5,-512(s0)
    80003bc8:	6388                	ld	a0,0(a5)
  sp = sz;
    80003bca:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    80003bcc:	4481                	li	s1,0
    ustack[argc] = sp;
    80003bce:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80003bd2:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    80003bd6:	cd21                	beqz	a0,80003c2e <exec+0x26c>
    sp -= strlen(argv[argc]) + 1;
    80003bd8:	f10fc0ef          	jal	800002e8 <strlen>
    80003bdc:	0015079b          	addiw	a5,a0,1
    80003be0:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003be4:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003be8:	13796563          	bltu	s2,s7,80003d12 <exec+0x350>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003bec:	e0043d83          	ld	s11,-512(s0)
    80003bf0:	000db983          	ld	s3,0(s11)
    80003bf4:	854e                	mv	a0,s3
    80003bf6:	ef2fc0ef          	jal	800002e8 <strlen>
    80003bfa:	0015069b          	addiw	a3,a0,1
    80003bfe:	864e                	mv	a2,s3
    80003c00:	85ca                	mv	a1,s2
    80003c02:	855a                	mv	a0,s6
    80003c04:	dfffc0ef          	jal	80000a02 <copyout>
    80003c08:	10054763          	bltz	a0,80003d16 <exec+0x354>
    ustack[argc] = sp;
    80003c0c:	00349793          	slli	a5,s1,0x3
    80003c10:	97e6                	add	a5,a5,s9
    80003c12:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffdb8e0>
  for(argc = 0; argv[argc]; argc++) {
    80003c16:	0485                	addi	s1,s1,1
    80003c18:	008d8793          	addi	a5,s11,8
    80003c1c:	e0f43023          	sd	a5,-512(s0)
    80003c20:	008db503          	ld	a0,8(s11)
    80003c24:	c509                	beqz	a0,80003c2e <exec+0x26c>
    if(argc >= MAXARG)
    80003c26:	fb8499e3          	bne	s1,s8,80003bd8 <exec+0x216>
  sz = sz1;
    80003c2a:	89d2                	mv	s3,s4
    80003c2c:	b7b5                	j	80003b98 <exec+0x1d6>
  ustack[argc] = 0;
    80003c2e:	00349793          	slli	a5,s1,0x3
    80003c32:	f9078793          	addi	a5,a5,-112
    80003c36:	97a2                	add	a5,a5,s0
    80003c38:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003c3c:	00349693          	slli	a3,s1,0x3
    80003c40:	06a1                	addi	a3,a3,8
    80003c42:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003c46:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80003c4a:	89d2                	mv	s3,s4
  if(sp < stackbase)
    80003c4c:	f57966e3          	bltu	s2,s7,80003b98 <exec+0x1d6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003c50:	e9040613          	addi	a2,s0,-368
    80003c54:	85ca                	mv	a1,s2
    80003c56:	855a                	mv	a0,s6
    80003c58:	dabfc0ef          	jal	80000a02 <copyout>
    80003c5c:	f2054ee3          	bltz	a0,80003b98 <exec+0x1d6>
  p->trapframe->a1 = sp;
    80003c60:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80003c64:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003c68:	df043783          	ld	a5,-528(s0)
    80003c6c:	0007c703          	lbu	a4,0(a5)
    80003c70:	cf11                	beqz	a4,80003c8c <exec+0x2ca>
    80003c72:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003c74:	02f00693          	li	a3,47
    80003c78:	a029                	j	80003c82 <exec+0x2c0>
  for(last=s=path; *s; s++)
    80003c7a:	0785                	addi	a5,a5,1
    80003c7c:	fff7c703          	lbu	a4,-1(a5)
    80003c80:	c711                	beqz	a4,80003c8c <exec+0x2ca>
    if(*s == '/')
    80003c82:	fed71ce3          	bne	a4,a3,80003c7a <exec+0x2b8>
      last = s+1;
    80003c86:	def43823          	sd	a5,-528(s0)
    80003c8a:	bfc5                	j	80003c7a <exec+0x2b8>
  safestrcpy(p->name, last, sizeof(p->name));
    80003c8c:	4641                	li	a2,16
    80003c8e:	df043583          	ld	a1,-528(s0)
    80003c92:	158a8513          	addi	a0,s5,344
    80003c96:	e1cfc0ef          	jal	800002b2 <safestrcpy>
  oldpagetable = p->pagetable;
    80003c9a:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80003c9e:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    80003ca2:	054ab423          	sd	s4,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80003ca6:	058ab783          	ld	a5,88(s5)
    80003caa:	e6843703          	ld	a4,-408(s0)
    80003cae:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003cb0:	058ab783          	ld	a5,88(s5)
    80003cb4:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003cb8:	85ea                	mv	a1,s10
    80003cba:	9f6fd0ef          	jal	80000eb0 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003cbe:	0004851b          	sext.w	a0,s1
    80003cc2:	79fe                	ld	s3,504(sp)
    80003cc4:	7a5e                	ld	s4,496(sp)
    80003cc6:	7abe                	ld	s5,488(sp)
    80003cc8:	7b1e                	ld	s6,480(sp)
    80003cca:	6bfe                	ld	s7,472(sp)
    80003ccc:	6c5e                	ld	s8,464(sp)
    80003cce:	6cbe                	ld	s9,456(sp)
    80003cd0:	6d1e                	ld	s10,448(sp)
    80003cd2:	7dfa                	ld	s11,440(sp)
    80003cd4:	b385                	j	80003a34 <exec+0x72>
    80003cd6:	7b1e                	ld	s6,480(sp)
    80003cd8:	b3b9                	j	80003a26 <exec+0x64>
    80003cda:	df243c23          	sd	s2,-520(s0)
    proc_freepagetable(pagetable, sz);
    80003cde:	df843583          	ld	a1,-520(s0)
    80003ce2:	855a                	mv	a0,s6
    80003ce4:	9ccfd0ef          	jal	80000eb0 <proc_freepagetable>
  if(ip){
    80003ce8:	79fe                	ld	s3,504(sp)
    80003cea:	7abe                	ld	s5,488(sp)
    80003cec:	7b1e                	ld	s6,480(sp)
    80003cee:	6bfe                	ld	s7,472(sp)
    80003cf0:	6c5e                	ld	s8,464(sp)
    80003cf2:	6cbe                	ld	s9,456(sp)
    80003cf4:	6d1e                	ld	s10,448(sp)
    80003cf6:	7dfa                	ld	s11,440(sp)
    80003cf8:	b33d                	j	80003a26 <exec+0x64>
    80003cfa:	df243c23          	sd	s2,-520(s0)
    80003cfe:	b7c5                	j	80003cde <exec+0x31c>
    80003d00:	df243c23          	sd	s2,-520(s0)
    80003d04:	bfe9                	j	80003cde <exec+0x31c>
    80003d06:	df243c23          	sd	s2,-520(s0)
    80003d0a:	bfd1                	j	80003cde <exec+0x31c>
    80003d0c:	df243c23          	sd	s2,-520(s0)
    80003d10:	b7f9                	j	80003cde <exec+0x31c>
  sz = sz1;
    80003d12:	89d2                	mv	s3,s4
    80003d14:	b551                	j	80003b98 <exec+0x1d6>
    80003d16:	89d2                	mv	s3,s4
    80003d18:	b541                	j	80003b98 <exec+0x1d6>

0000000080003d1a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003d1a:	7179                	addi	sp,sp,-48
    80003d1c:	f406                	sd	ra,40(sp)
    80003d1e:	f022                	sd	s0,32(sp)
    80003d20:	ec26                	sd	s1,24(sp)
    80003d22:	e84a                	sd	s2,16(sp)
    80003d24:	1800                	addi	s0,sp,48
    80003d26:	892e                	mv	s2,a1
    80003d28:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003d2a:	fdc40593          	addi	a1,s0,-36
    80003d2e:	f1dfd0ef          	jal	80001c4a <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003d32:	fdc42703          	lw	a4,-36(s0)
    80003d36:	47bd                	li	a5,15
    80003d38:	02e7ea63          	bltu	a5,a4,80003d6c <argfd+0x52>
    80003d3c:	846fd0ef          	jal	80000d82 <myproc>
    80003d40:	fdc42703          	lw	a4,-36(s0)
    80003d44:	00371793          	slli	a5,a4,0x3
    80003d48:	0d078793          	addi	a5,a5,208
    80003d4c:	953e                	add	a0,a0,a5
    80003d4e:	611c                	ld	a5,0(a0)
    80003d50:	c385                	beqz	a5,80003d70 <argfd+0x56>
    return -1;
  if(pfd)
    80003d52:	00090463          	beqz	s2,80003d5a <argfd+0x40>
    *pfd = fd;
    80003d56:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80003d5a:	4501                	li	a0,0
  if(pf)
    80003d5c:	c091                	beqz	s1,80003d60 <argfd+0x46>
    *pf = f;
    80003d5e:	e09c                	sd	a5,0(s1)
}
    80003d60:	70a2                	ld	ra,40(sp)
    80003d62:	7402                	ld	s0,32(sp)
    80003d64:	64e2                	ld	s1,24(sp)
    80003d66:	6942                	ld	s2,16(sp)
    80003d68:	6145                	addi	sp,sp,48
    80003d6a:	8082                	ret
    return -1;
    80003d6c:	557d                	li	a0,-1
    80003d6e:	bfcd                	j	80003d60 <argfd+0x46>
    80003d70:	557d                	li	a0,-1
    80003d72:	b7fd                	j	80003d60 <argfd+0x46>

0000000080003d74 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003d74:	1101                	addi	sp,sp,-32
    80003d76:	ec06                	sd	ra,24(sp)
    80003d78:	e822                	sd	s0,16(sp)
    80003d7a:	e426                	sd	s1,8(sp)
    80003d7c:	1000                	addi	s0,sp,32
    80003d7e:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003d80:	802fd0ef          	jal	80000d82 <myproc>
    80003d84:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003d86:	0d050793          	addi	a5,a0,208
    80003d8a:	4501                	li	a0,0
    80003d8c:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003d8e:	6398                	ld	a4,0(a5)
    80003d90:	cb19                	beqz	a4,80003da6 <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003d92:	2505                	addiw	a0,a0,1
    80003d94:	07a1                	addi	a5,a5,8
    80003d96:	fed51ce3          	bne	a0,a3,80003d8e <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003d9a:	557d                	li	a0,-1
}
    80003d9c:	60e2                	ld	ra,24(sp)
    80003d9e:	6442                	ld	s0,16(sp)
    80003da0:	64a2                	ld	s1,8(sp)
    80003da2:	6105                	addi	sp,sp,32
    80003da4:	8082                	ret
      p->ofile[fd] = f;
    80003da6:	00351793          	slli	a5,a0,0x3
    80003daa:	0d078793          	addi	a5,a5,208
    80003dae:	963e                	add	a2,a2,a5
    80003db0:	e204                	sd	s1,0(a2)
      return fd;
    80003db2:	b7ed                	j	80003d9c <fdalloc+0x28>

0000000080003db4 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003db4:	715d                	addi	sp,sp,-80
    80003db6:	e486                	sd	ra,72(sp)
    80003db8:	e0a2                	sd	s0,64(sp)
    80003dba:	fc26                	sd	s1,56(sp)
    80003dbc:	f84a                	sd	s2,48(sp)
    80003dbe:	f44e                	sd	s3,40(sp)
    80003dc0:	f052                	sd	s4,32(sp)
    80003dc2:	ec56                	sd	s5,24(sp)
    80003dc4:	e85a                	sd	s6,16(sp)
    80003dc6:	0880                	addi	s0,sp,80
    80003dc8:	892e                	mv	s2,a1
    80003dca:	8a2e                	mv	s4,a1
    80003dcc:	8ab2                	mv	s5,a2
    80003dce:	8b36                	mv	s6,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003dd0:	fb040593          	addi	a1,s0,-80
    80003dd4:	fd3fe0ef          	jal	80002da6 <nameiparent>
    80003dd8:	84aa                	mv	s1,a0
    80003dda:	10050763          	beqz	a0,80003ee8 <create+0x134>
    return 0;

  ilock(dp);
    80003dde:	8b9fe0ef          	jal	80002696 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003de2:	4601                	li	a2,0
    80003de4:	fb040593          	addi	a1,s0,-80
    80003de8:	8526                	mv	a0,s1
    80003dea:	d0ffe0ef          	jal	80002af8 <dirlookup>
    80003dee:	89aa                	mv	s3,a0
    80003df0:	c131                	beqz	a0,80003e34 <create+0x80>
    iunlockput(dp);
    80003df2:	8526                	mv	a0,s1
    80003df4:	aaffe0ef          	jal	800028a2 <iunlockput>
    ilock(ip);
    80003df8:	854e                	mv	a0,s3
    80003dfa:	89dfe0ef          	jal	80002696 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003dfe:	4789                	li	a5,2
    80003e00:	02f91563          	bne	s2,a5,80003e2a <create+0x76>
    80003e04:	0449d783          	lhu	a5,68(s3)
    80003e08:	37f9                	addiw	a5,a5,-2
    80003e0a:	17c2                	slli	a5,a5,0x30
    80003e0c:	93c1                	srli	a5,a5,0x30
    80003e0e:	4705                	li	a4,1
    80003e10:	00f76d63          	bltu	a4,a5,80003e2a <create+0x76>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003e14:	854e                	mv	a0,s3
    80003e16:	60a6                	ld	ra,72(sp)
    80003e18:	6406                	ld	s0,64(sp)
    80003e1a:	74e2                	ld	s1,56(sp)
    80003e1c:	7942                	ld	s2,48(sp)
    80003e1e:	79a2                	ld	s3,40(sp)
    80003e20:	7a02                	ld	s4,32(sp)
    80003e22:	6ae2                	ld	s5,24(sp)
    80003e24:	6b42                	ld	s6,16(sp)
    80003e26:	6161                	addi	sp,sp,80
    80003e28:	8082                	ret
    iunlockput(ip);
    80003e2a:	854e                	mv	a0,s3
    80003e2c:	a77fe0ef          	jal	800028a2 <iunlockput>
    return 0;
    80003e30:	4981                	li	s3,0
    80003e32:	b7cd                	j	80003e14 <create+0x60>
  if((ip = ialloc(dp->dev, type)) == 0){
    80003e34:	85ca                	mv	a1,s2
    80003e36:	4088                	lw	a0,0(s1)
    80003e38:	eeefe0ef          	jal	80002526 <ialloc>
    80003e3c:	892a                	mv	s2,a0
    80003e3e:	cd15                	beqz	a0,80003e7a <create+0xc6>
  ilock(ip);
    80003e40:	857fe0ef          	jal	80002696 <ilock>
  ip->major = major;
    80003e44:	05591323          	sh	s5,70(s2)
  ip->minor = minor;
    80003e48:	05691423          	sh	s6,72(s2)
  ip->nlink = 1;
    80003e4c:	4785                	li	a5,1
    80003e4e:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80003e52:	854a                	mv	a0,s2
    80003e54:	f8efe0ef          	jal	800025e2 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80003e58:	4705                	li	a4,1
    80003e5a:	02ea0463          	beq	s4,a4,80003e82 <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80003e5e:	00492603          	lw	a2,4(s2)
    80003e62:	fb040593          	addi	a1,s0,-80
    80003e66:	8526                	mv	a0,s1
    80003e68:	e7bfe0ef          	jal	80002ce2 <dirlink>
    80003e6c:	06054263          	bltz	a0,80003ed0 <create+0x11c>
  iunlockput(dp);
    80003e70:	8526                	mv	a0,s1
    80003e72:	a31fe0ef          	jal	800028a2 <iunlockput>
  return ip;
    80003e76:	89ca                	mv	s3,s2
    80003e78:	bf71                	j	80003e14 <create+0x60>
    iunlockput(dp);
    80003e7a:	8526                	mv	a0,s1
    80003e7c:	a27fe0ef          	jal	800028a2 <iunlockput>
    return 0;
    80003e80:	bf51                	j	80003e14 <create+0x60>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80003e82:	00492603          	lw	a2,4(s2)
    80003e86:	00003597          	auipc	a1,0x3
    80003e8a:	7e258593          	addi	a1,a1,2018 # 80007668 <etext+0x668>
    80003e8e:	854a                	mv	a0,s2
    80003e90:	e53fe0ef          	jal	80002ce2 <dirlink>
    80003e94:	02054e63          	bltz	a0,80003ed0 <create+0x11c>
    80003e98:	40d0                	lw	a2,4(s1)
    80003e9a:	00003597          	auipc	a1,0x3
    80003e9e:	7d658593          	addi	a1,a1,2006 # 80007670 <etext+0x670>
    80003ea2:	854a                	mv	a0,s2
    80003ea4:	e3ffe0ef          	jal	80002ce2 <dirlink>
    80003ea8:	02054463          	bltz	a0,80003ed0 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80003eac:	00492603          	lw	a2,4(s2)
    80003eb0:	fb040593          	addi	a1,s0,-80
    80003eb4:	8526                	mv	a0,s1
    80003eb6:	e2dfe0ef          	jal	80002ce2 <dirlink>
    80003eba:	00054b63          	bltz	a0,80003ed0 <create+0x11c>
    dp->nlink++;  // for ".."
    80003ebe:	04a4d783          	lhu	a5,74(s1)
    80003ec2:	2785                	addiw	a5,a5,1
    80003ec4:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80003ec8:	8526                	mv	a0,s1
    80003eca:	f18fe0ef          	jal	800025e2 <iupdate>
    80003ece:	b74d                	j	80003e70 <create+0xbc>
  ip->nlink = 0;
    80003ed0:	04091523          	sh	zero,74(s2)
  iupdate(ip);
    80003ed4:	854a                	mv	a0,s2
    80003ed6:	f0cfe0ef          	jal	800025e2 <iupdate>
  iunlockput(ip);
    80003eda:	854a                	mv	a0,s2
    80003edc:	9c7fe0ef          	jal	800028a2 <iunlockput>
  iunlockput(dp);
    80003ee0:	8526                	mv	a0,s1
    80003ee2:	9c1fe0ef          	jal	800028a2 <iunlockput>
  return 0;
    80003ee6:	b73d                	j	80003e14 <create+0x60>
    return 0;
    80003ee8:	89aa                	mv	s3,a0
    80003eea:	b72d                	j	80003e14 <create+0x60>

0000000080003eec <sys_dup>:
{
    80003eec:	7179                	addi	sp,sp,-48
    80003eee:	f406                	sd	ra,40(sp)
    80003ef0:	f022                	sd	s0,32(sp)
    80003ef2:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80003ef4:	fd840613          	addi	a2,s0,-40
    80003ef8:	4581                	li	a1,0
    80003efa:	4501                	li	a0,0
    80003efc:	e1fff0ef          	jal	80003d1a <argfd>
    return -1;
    80003f00:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80003f02:	02054363          	bltz	a0,80003f28 <sys_dup+0x3c>
    80003f06:	ec26                	sd	s1,24(sp)
    80003f08:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80003f0a:	fd843483          	ld	s1,-40(s0)
    80003f0e:	8526                	mv	a0,s1
    80003f10:	e65ff0ef          	jal	80003d74 <fdalloc>
    80003f14:	892a                	mv	s2,a0
    return -1;
    80003f16:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80003f18:	00054d63          	bltz	a0,80003f32 <sys_dup+0x46>
  filedup(f);
    80003f1c:	8526                	mv	a0,s1
    80003f1e:	c1cff0ef          	jal	8000333a <filedup>
  return fd;
    80003f22:	87ca                	mv	a5,s2
    80003f24:	64e2                	ld	s1,24(sp)
    80003f26:	6942                	ld	s2,16(sp)
}
    80003f28:	853e                	mv	a0,a5
    80003f2a:	70a2                	ld	ra,40(sp)
    80003f2c:	7402                	ld	s0,32(sp)
    80003f2e:	6145                	addi	sp,sp,48
    80003f30:	8082                	ret
    80003f32:	64e2                	ld	s1,24(sp)
    80003f34:	6942                	ld	s2,16(sp)
    80003f36:	bfcd                	j	80003f28 <sys_dup+0x3c>

0000000080003f38 <sys_read>:
{
    80003f38:	7179                	addi	sp,sp,-48
    80003f3a:	f406                	sd	ra,40(sp)
    80003f3c:	f022                	sd	s0,32(sp)
    80003f3e:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80003f40:	fd840593          	addi	a1,s0,-40
    80003f44:	4505                	li	a0,1
    80003f46:	d21fd0ef          	jal	80001c66 <argaddr>
  argint(2, &n);
    80003f4a:	fe440593          	addi	a1,s0,-28
    80003f4e:	4509                	li	a0,2
    80003f50:	cfbfd0ef          	jal	80001c4a <argint>
  if(argfd(0, 0, &f) < 0)
    80003f54:	fe840613          	addi	a2,s0,-24
    80003f58:	4581                	li	a1,0
    80003f5a:	4501                	li	a0,0
    80003f5c:	dbfff0ef          	jal	80003d1a <argfd>
    80003f60:	87aa                	mv	a5,a0
    return -1;
    80003f62:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80003f64:	0007ca63          	bltz	a5,80003f78 <sys_read+0x40>
  return fileread(f, p, n);
    80003f68:	fe442603          	lw	a2,-28(s0)
    80003f6c:	fd843583          	ld	a1,-40(s0)
    80003f70:	fe843503          	ld	a0,-24(s0)
    80003f74:	d30ff0ef          	jal	800034a4 <fileread>
}
    80003f78:	70a2                	ld	ra,40(sp)
    80003f7a:	7402                	ld	s0,32(sp)
    80003f7c:	6145                	addi	sp,sp,48
    80003f7e:	8082                	ret

0000000080003f80 <sys_write>:
{
    80003f80:	7179                	addi	sp,sp,-48
    80003f82:	f406                	sd	ra,40(sp)
    80003f84:	f022                	sd	s0,32(sp)
    80003f86:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80003f88:	fd840593          	addi	a1,s0,-40
    80003f8c:	4505                	li	a0,1
    80003f8e:	cd9fd0ef          	jal	80001c66 <argaddr>
  argint(2, &n);
    80003f92:	fe440593          	addi	a1,s0,-28
    80003f96:	4509                	li	a0,2
    80003f98:	cb3fd0ef          	jal	80001c4a <argint>
  if(argfd(0, 0, &f) < 0)
    80003f9c:	fe840613          	addi	a2,s0,-24
    80003fa0:	4581                	li	a1,0
    80003fa2:	4501                	li	a0,0
    80003fa4:	d77ff0ef          	jal	80003d1a <argfd>
    80003fa8:	87aa                	mv	a5,a0
    return -1;
    80003faa:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80003fac:	0007ca63          	bltz	a5,80003fc0 <sys_write+0x40>
  return filewrite(f, p, n);
    80003fb0:	fe442603          	lw	a2,-28(s0)
    80003fb4:	fd843583          	ld	a1,-40(s0)
    80003fb8:	fe843503          	ld	a0,-24(s0)
    80003fbc:	dacff0ef          	jal	80003568 <filewrite>
}
    80003fc0:	70a2                	ld	ra,40(sp)
    80003fc2:	7402                	ld	s0,32(sp)
    80003fc4:	6145                	addi	sp,sp,48
    80003fc6:	8082                	ret

0000000080003fc8 <sys_close>:
{
    80003fc8:	1101                	addi	sp,sp,-32
    80003fca:	ec06                	sd	ra,24(sp)
    80003fcc:	e822                	sd	s0,16(sp)
    80003fce:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80003fd0:	fe040613          	addi	a2,s0,-32
    80003fd4:	fec40593          	addi	a1,s0,-20
    80003fd8:	4501                	li	a0,0
    80003fda:	d41ff0ef          	jal	80003d1a <argfd>
    return -1;
    80003fde:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80003fe0:	02054163          	bltz	a0,80004002 <sys_close+0x3a>
  myproc()->ofile[fd] = 0;
    80003fe4:	d9ffc0ef          	jal	80000d82 <myproc>
    80003fe8:	fec42783          	lw	a5,-20(s0)
    80003fec:	078e                	slli	a5,a5,0x3
    80003fee:	0d078793          	addi	a5,a5,208
    80003ff2:	953e                	add	a0,a0,a5
    80003ff4:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80003ff8:	fe043503          	ld	a0,-32(s0)
    80003ffc:	b84ff0ef          	jal	80003380 <fileclose>
  return 0;
    80004000:	4781                	li	a5,0
}
    80004002:	853e                	mv	a0,a5
    80004004:	60e2                	ld	ra,24(sp)
    80004006:	6442                	ld	s0,16(sp)
    80004008:	6105                	addi	sp,sp,32
    8000400a:	8082                	ret

000000008000400c <sys_fstat>:
{
    8000400c:	1101                	addi	sp,sp,-32
    8000400e:	ec06                	sd	ra,24(sp)
    80004010:	e822                	sd	s0,16(sp)
    80004012:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80004014:	fe040593          	addi	a1,s0,-32
    80004018:	4505                	li	a0,1
    8000401a:	c4dfd0ef          	jal	80001c66 <argaddr>
  if(argfd(0, 0, &f) < 0)
    8000401e:	fe840613          	addi	a2,s0,-24
    80004022:	4581                	li	a1,0
    80004024:	4501                	li	a0,0
    80004026:	cf5ff0ef          	jal	80003d1a <argfd>
    8000402a:	87aa                	mv	a5,a0
    return -1;
    8000402c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000402e:	0007c863          	bltz	a5,8000403e <sys_fstat+0x32>
  return filestat(f, st);
    80004032:	fe043583          	ld	a1,-32(s0)
    80004036:	fe843503          	ld	a0,-24(s0)
    8000403a:	c08ff0ef          	jal	80003442 <filestat>
}
    8000403e:	60e2                	ld	ra,24(sp)
    80004040:	6442                	ld	s0,16(sp)
    80004042:	6105                	addi	sp,sp,32
    80004044:	8082                	ret

0000000080004046 <sys_link>:
{
    80004046:	7169                	addi	sp,sp,-304
    80004048:	f606                	sd	ra,296(sp)
    8000404a:	f222                	sd	s0,288(sp)
    8000404c:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000404e:	08000613          	li	a2,128
    80004052:	ed040593          	addi	a1,s0,-304
    80004056:	4501                	li	a0,0
    80004058:	c2bfd0ef          	jal	80001c82 <argstr>
    return -1;
    8000405c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000405e:	0c054e63          	bltz	a0,8000413a <sys_link+0xf4>
    80004062:	08000613          	li	a2,128
    80004066:	f5040593          	addi	a1,s0,-176
    8000406a:	4505                	li	a0,1
    8000406c:	c17fd0ef          	jal	80001c82 <argstr>
    return -1;
    80004070:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004072:	0c054463          	bltz	a0,8000413a <sys_link+0xf4>
    80004076:	ee26                	sd	s1,280(sp)
  begin_op();
    80004078:	ed7fe0ef          	jal	80002f4e <begin_op>
  if((ip = namei(old)) == 0){
    8000407c:	ed040513          	addi	a0,s0,-304
    80004080:	d0dfe0ef          	jal	80002d8c <namei>
    80004084:	84aa                	mv	s1,a0
    80004086:	c53d                	beqz	a0,800040f4 <sys_link+0xae>
  ilock(ip);
    80004088:	e0efe0ef          	jal	80002696 <ilock>
  if(ip->type == T_DIR){
    8000408c:	04449703          	lh	a4,68(s1)
    80004090:	4785                	li	a5,1
    80004092:	06f70663          	beq	a4,a5,800040fe <sys_link+0xb8>
    80004096:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80004098:	04a4d783          	lhu	a5,74(s1)
    8000409c:	2785                	addiw	a5,a5,1
    8000409e:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800040a2:	8526                	mv	a0,s1
    800040a4:	d3efe0ef          	jal	800025e2 <iupdate>
  iunlock(ip);
    800040a8:	8526                	mv	a0,s1
    800040aa:	e9afe0ef          	jal	80002744 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800040ae:	fd040593          	addi	a1,s0,-48
    800040b2:	f5040513          	addi	a0,s0,-176
    800040b6:	cf1fe0ef          	jal	80002da6 <nameiparent>
    800040ba:	892a                	mv	s2,a0
    800040bc:	cd21                	beqz	a0,80004114 <sys_link+0xce>
  ilock(dp);
    800040be:	dd8fe0ef          	jal	80002696 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800040c2:	854a                	mv	a0,s2
    800040c4:	00092703          	lw	a4,0(s2)
    800040c8:	409c                	lw	a5,0(s1)
    800040ca:	04f71263          	bne	a4,a5,8000410e <sys_link+0xc8>
    800040ce:	40d0                	lw	a2,4(s1)
    800040d0:	fd040593          	addi	a1,s0,-48
    800040d4:	c0ffe0ef          	jal	80002ce2 <dirlink>
    800040d8:	02054b63          	bltz	a0,8000410e <sys_link+0xc8>
  iunlockput(dp);
    800040dc:	854a                	mv	a0,s2
    800040de:	fc4fe0ef          	jal	800028a2 <iunlockput>
  iput(ip);
    800040e2:	8526                	mv	a0,s1
    800040e4:	f34fe0ef          	jal	80002818 <iput>
  end_op();
    800040e8:	ed7fe0ef          	jal	80002fbe <end_op>
  return 0;
    800040ec:	4781                	li	a5,0
    800040ee:	64f2                	ld	s1,280(sp)
    800040f0:	6952                	ld	s2,272(sp)
    800040f2:	a0a1                	j	8000413a <sys_link+0xf4>
    end_op();
    800040f4:	ecbfe0ef          	jal	80002fbe <end_op>
    return -1;
    800040f8:	57fd                	li	a5,-1
    800040fa:	64f2                	ld	s1,280(sp)
    800040fc:	a83d                	j	8000413a <sys_link+0xf4>
    iunlockput(ip);
    800040fe:	8526                	mv	a0,s1
    80004100:	fa2fe0ef          	jal	800028a2 <iunlockput>
    end_op();
    80004104:	ebbfe0ef          	jal	80002fbe <end_op>
    return -1;
    80004108:	57fd                	li	a5,-1
    8000410a:	64f2                	ld	s1,280(sp)
    8000410c:	a03d                	j	8000413a <sys_link+0xf4>
    iunlockput(dp);
    8000410e:	854a                	mv	a0,s2
    80004110:	f92fe0ef          	jal	800028a2 <iunlockput>
  ilock(ip);
    80004114:	8526                	mv	a0,s1
    80004116:	d80fe0ef          	jal	80002696 <ilock>
  ip->nlink--;
    8000411a:	04a4d783          	lhu	a5,74(s1)
    8000411e:	37fd                	addiw	a5,a5,-1
    80004120:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004124:	8526                	mv	a0,s1
    80004126:	cbcfe0ef          	jal	800025e2 <iupdate>
  iunlockput(ip);
    8000412a:	8526                	mv	a0,s1
    8000412c:	f76fe0ef          	jal	800028a2 <iunlockput>
  end_op();
    80004130:	e8ffe0ef          	jal	80002fbe <end_op>
  return -1;
    80004134:	57fd                	li	a5,-1
    80004136:	64f2                	ld	s1,280(sp)
    80004138:	6952                	ld	s2,272(sp)
}
    8000413a:	853e                	mv	a0,a5
    8000413c:	70b2                	ld	ra,296(sp)
    8000413e:	7412                	ld	s0,288(sp)
    80004140:	6155                	addi	sp,sp,304
    80004142:	8082                	ret

0000000080004144 <sys_unlink>:
{
    80004144:	7151                	addi	sp,sp,-240
    80004146:	f586                	sd	ra,232(sp)
    80004148:	f1a2                	sd	s0,224(sp)
    8000414a:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    8000414c:	08000613          	li	a2,128
    80004150:	f3040593          	addi	a1,s0,-208
    80004154:	4501                	li	a0,0
    80004156:	b2dfd0ef          	jal	80001c82 <argstr>
    8000415a:	14054d63          	bltz	a0,800042b4 <sys_unlink+0x170>
    8000415e:	eda6                	sd	s1,216(sp)
  begin_op();
    80004160:	deffe0ef          	jal	80002f4e <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004164:	fb040593          	addi	a1,s0,-80
    80004168:	f3040513          	addi	a0,s0,-208
    8000416c:	c3bfe0ef          	jal	80002da6 <nameiparent>
    80004170:	84aa                	mv	s1,a0
    80004172:	c955                	beqz	a0,80004226 <sys_unlink+0xe2>
  ilock(dp);
    80004174:	d22fe0ef          	jal	80002696 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004178:	00003597          	auipc	a1,0x3
    8000417c:	4f058593          	addi	a1,a1,1264 # 80007668 <etext+0x668>
    80004180:	fb040513          	addi	a0,s0,-80
    80004184:	95ffe0ef          	jal	80002ae2 <namecmp>
    80004188:	10050b63          	beqz	a0,8000429e <sys_unlink+0x15a>
    8000418c:	00003597          	auipc	a1,0x3
    80004190:	4e458593          	addi	a1,a1,1252 # 80007670 <etext+0x670>
    80004194:	fb040513          	addi	a0,s0,-80
    80004198:	94bfe0ef          	jal	80002ae2 <namecmp>
    8000419c:	10050163          	beqz	a0,8000429e <sys_unlink+0x15a>
    800041a0:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    800041a2:	f2c40613          	addi	a2,s0,-212
    800041a6:	fb040593          	addi	a1,s0,-80
    800041aa:	8526                	mv	a0,s1
    800041ac:	94dfe0ef          	jal	80002af8 <dirlookup>
    800041b0:	892a                	mv	s2,a0
    800041b2:	0e050563          	beqz	a0,8000429c <sys_unlink+0x158>
    800041b6:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    800041b8:	cdefe0ef          	jal	80002696 <ilock>
  if(ip->nlink < 1)
    800041bc:	04a91783          	lh	a5,74(s2)
    800041c0:	06f05863          	blez	a5,80004230 <sys_unlink+0xec>
  if(ip->type == T_DIR && !isdirempty(ip)){
    800041c4:	04491703          	lh	a4,68(s2)
    800041c8:	4785                	li	a5,1
    800041ca:	06f70963          	beq	a4,a5,8000423c <sys_unlink+0xf8>
  memset(&de, 0, sizeof(de));
    800041ce:	fc040993          	addi	s3,s0,-64
    800041d2:	4641                	li	a2,16
    800041d4:	4581                	li	a1,0
    800041d6:	854e                	mv	a0,s3
    800041d8:	f87fb0ef          	jal	8000015e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800041dc:	4741                	li	a4,16
    800041de:	f2c42683          	lw	a3,-212(s0)
    800041e2:	864e                	mv	a2,s3
    800041e4:	4581                	li	a1,0
    800041e6:	8526                	mv	a0,s1
    800041e8:	ffafe0ef          	jal	800029e2 <writei>
    800041ec:	47c1                	li	a5,16
    800041ee:	08f51863          	bne	a0,a5,8000427e <sys_unlink+0x13a>
  if(ip->type == T_DIR){
    800041f2:	04491703          	lh	a4,68(s2)
    800041f6:	4785                	li	a5,1
    800041f8:	08f70963          	beq	a4,a5,8000428a <sys_unlink+0x146>
  iunlockput(dp);
    800041fc:	8526                	mv	a0,s1
    800041fe:	ea4fe0ef          	jal	800028a2 <iunlockput>
  ip->nlink--;
    80004202:	04a95783          	lhu	a5,74(s2)
    80004206:	37fd                	addiw	a5,a5,-1
    80004208:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    8000420c:	854a                	mv	a0,s2
    8000420e:	bd4fe0ef          	jal	800025e2 <iupdate>
  iunlockput(ip);
    80004212:	854a                	mv	a0,s2
    80004214:	e8efe0ef          	jal	800028a2 <iunlockput>
  end_op();
    80004218:	da7fe0ef          	jal	80002fbe <end_op>
  return 0;
    8000421c:	4501                	li	a0,0
    8000421e:	64ee                	ld	s1,216(sp)
    80004220:	694e                	ld	s2,208(sp)
    80004222:	69ae                	ld	s3,200(sp)
    80004224:	a061                	j	800042ac <sys_unlink+0x168>
    end_op();
    80004226:	d99fe0ef          	jal	80002fbe <end_op>
    return -1;
    8000422a:	557d                	li	a0,-1
    8000422c:	64ee                	ld	s1,216(sp)
    8000422e:	a8bd                	j	800042ac <sys_unlink+0x168>
    panic("unlink: nlink < 1");
    80004230:	00003517          	auipc	a0,0x3
    80004234:	44850513          	addi	a0,a0,1096 # 80007678 <etext+0x678>
    80004238:	2a6010ef          	jal	800054de <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    8000423c:	04c92703          	lw	a4,76(s2)
    80004240:	02000793          	li	a5,32
    80004244:	f8e7f5e3          	bgeu	a5,a4,800041ce <sys_unlink+0x8a>
    80004248:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000424a:	4741                	li	a4,16
    8000424c:	86ce                	mv	a3,s3
    8000424e:	f1840613          	addi	a2,s0,-232
    80004252:	4581                	li	a1,0
    80004254:	854a                	mv	a0,s2
    80004256:	e9afe0ef          	jal	800028f0 <readi>
    8000425a:	47c1                	li	a5,16
    8000425c:	00f51b63          	bne	a0,a5,80004272 <sys_unlink+0x12e>
    if(de.inum != 0)
    80004260:	f1845783          	lhu	a5,-232(s0)
    80004264:	ebb1                	bnez	a5,800042b8 <sys_unlink+0x174>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004266:	29c1                	addiw	s3,s3,16
    80004268:	04c92783          	lw	a5,76(s2)
    8000426c:	fcf9efe3          	bltu	s3,a5,8000424a <sys_unlink+0x106>
    80004270:	bfb9                	j	800041ce <sys_unlink+0x8a>
      panic("isdirempty: readi");
    80004272:	00003517          	auipc	a0,0x3
    80004276:	41e50513          	addi	a0,a0,1054 # 80007690 <etext+0x690>
    8000427a:	264010ef          	jal	800054de <panic>
    panic("unlink: writei");
    8000427e:	00003517          	auipc	a0,0x3
    80004282:	42a50513          	addi	a0,a0,1066 # 800076a8 <etext+0x6a8>
    80004286:	258010ef          	jal	800054de <panic>
    dp->nlink--;
    8000428a:	04a4d783          	lhu	a5,74(s1)
    8000428e:	37fd                	addiw	a5,a5,-1
    80004290:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004294:	8526                	mv	a0,s1
    80004296:	b4cfe0ef          	jal	800025e2 <iupdate>
    8000429a:	b78d                	j	800041fc <sys_unlink+0xb8>
    8000429c:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    8000429e:	8526                	mv	a0,s1
    800042a0:	e02fe0ef          	jal	800028a2 <iunlockput>
  end_op();
    800042a4:	d1bfe0ef          	jal	80002fbe <end_op>
  return -1;
    800042a8:	557d                	li	a0,-1
    800042aa:	64ee                	ld	s1,216(sp)
}
    800042ac:	70ae                	ld	ra,232(sp)
    800042ae:	740e                	ld	s0,224(sp)
    800042b0:	616d                	addi	sp,sp,240
    800042b2:	8082                	ret
    return -1;
    800042b4:	557d                	li	a0,-1
    800042b6:	bfdd                	j	800042ac <sys_unlink+0x168>
    iunlockput(ip);
    800042b8:	854a                	mv	a0,s2
    800042ba:	de8fe0ef          	jal	800028a2 <iunlockput>
    goto bad;
    800042be:	694e                	ld	s2,208(sp)
    800042c0:	69ae                	ld	s3,200(sp)
    800042c2:	bff1                	j	8000429e <sys_unlink+0x15a>

00000000800042c4 <sys_open>:

uint64
sys_open(void)
{
    800042c4:	7131                	addi	sp,sp,-192
    800042c6:	fd06                	sd	ra,184(sp)
    800042c8:	f922                	sd	s0,176(sp)
    800042ca:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    800042cc:	f4c40593          	addi	a1,s0,-180
    800042d0:	4505                	li	a0,1
    800042d2:	979fd0ef          	jal	80001c4a <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800042d6:	08000613          	li	a2,128
    800042da:	f5040593          	addi	a1,s0,-176
    800042de:	4501                	li	a0,0
    800042e0:	9a3fd0ef          	jal	80001c82 <argstr>
    800042e4:	87aa                	mv	a5,a0
    return -1;
    800042e6:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    800042e8:	0a07c363          	bltz	a5,8000438e <sys_open+0xca>
    800042ec:	f526                	sd	s1,168(sp)

  begin_op();
    800042ee:	c61fe0ef          	jal	80002f4e <begin_op>

  if(omode & O_CREATE){
    800042f2:	f4c42783          	lw	a5,-180(s0)
    800042f6:	2007f793          	andi	a5,a5,512
    800042fa:	c3dd                	beqz	a5,800043a0 <sys_open+0xdc>
    ip = create(path, T_FILE, 0, 0);
    800042fc:	4681                	li	a3,0
    800042fe:	4601                	li	a2,0
    80004300:	4589                	li	a1,2
    80004302:	f5040513          	addi	a0,s0,-176
    80004306:	aafff0ef          	jal	80003db4 <create>
    8000430a:	84aa                	mv	s1,a0
    if(ip == 0){
    8000430c:	c549                	beqz	a0,80004396 <sys_open+0xd2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000430e:	04449703          	lh	a4,68(s1)
    80004312:	478d                	li	a5,3
    80004314:	00f71763          	bne	a4,a5,80004322 <sys_open+0x5e>
    80004318:	0464d703          	lhu	a4,70(s1)
    8000431c:	47a5                	li	a5,9
    8000431e:	0ae7ee63          	bltu	a5,a4,800043da <sys_open+0x116>
    80004322:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004324:	fb9fe0ef          	jal	800032dc <filealloc>
    80004328:	892a                	mv	s2,a0
    8000432a:	c561                	beqz	a0,800043f2 <sys_open+0x12e>
    8000432c:	ed4e                	sd	s3,152(sp)
    8000432e:	a47ff0ef          	jal	80003d74 <fdalloc>
    80004332:	89aa                	mv	s3,a0
    80004334:	0a054b63          	bltz	a0,800043ea <sys_open+0x126>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004338:	04449703          	lh	a4,68(s1)
    8000433c:	478d                	li	a5,3
    8000433e:	0cf70363          	beq	a4,a5,80004404 <sys_open+0x140>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004342:	4789                	li	a5,2
    80004344:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004348:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    8000434c:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004350:	f4c42783          	lw	a5,-180(s0)
    80004354:	0017f713          	andi	a4,a5,1
    80004358:	00174713          	xori	a4,a4,1
    8000435c:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004360:	0037f713          	andi	a4,a5,3
    80004364:	00e03733          	snez	a4,a4
    80004368:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    8000436c:	4007f793          	andi	a5,a5,1024
    80004370:	c791                	beqz	a5,8000437c <sys_open+0xb8>
    80004372:	04449703          	lh	a4,68(s1)
    80004376:	4789                	li	a5,2
    80004378:	08f70d63          	beq	a4,a5,80004412 <sys_open+0x14e>
    itrunc(ip);
  }

  iunlock(ip);
    8000437c:	8526                	mv	a0,s1
    8000437e:	bc6fe0ef          	jal	80002744 <iunlock>
  end_op();
    80004382:	c3dfe0ef          	jal	80002fbe <end_op>

  return fd;
    80004386:	854e                	mv	a0,s3
    80004388:	74aa                	ld	s1,168(sp)
    8000438a:	790a                	ld	s2,160(sp)
    8000438c:	69ea                	ld	s3,152(sp)
}
    8000438e:	70ea                	ld	ra,184(sp)
    80004390:	744a                	ld	s0,176(sp)
    80004392:	6129                	addi	sp,sp,192
    80004394:	8082                	ret
      end_op();
    80004396:	c29fe0ef          	jal	80002fbe <end_op>
      return -1;
    8000439a:	557d                	li	a0,-1
    8000439c:	74aa                	ld	s1,168(sp)
    8000439e:	bfc5                	j	8000438e <sys_open+0xca>
    if((ip = namei(path)) == 0){
    800043a0:	f5040513          	addi	a0,s0,-176
    800043a4:	9e9fe0ef          	jal	80002d8c <namei>
    800043a8:	84aa                	mv	s1,a0
    800043aa:	c11d                	beqz	a0,800043d0 <sys_open+0x10c>
    ilock(ip);
    800043ac:	aeafe0ef          	jal	80002696 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800043b0:	04449703          	lh	a4,68(s1)
    800043b4:	4785                	li	a5,1
    800043b6:	f4f71ce3          	bne	a4,a5,8000430e <sys_open+0x4a>
    800043ba:	f4c42783          	lw	a5,-180(s0)
    800043be:	d3b5                	beqz	a5,80004322 <sys_open+0x5e>
      iunlockput(ip);
    800043c0:	8526                	mv	a0,s1
    800043c2:	ce0fe0ef          	jal	800028a2 <iunlockput>
      end_op();
    800043c6:	bf9fe0ef          	jal	80002fbe <end_op>
      return -1;
    800043ca:	557d                	li	a0,-1
    800043cc:	74aa                	ld	s1,168(sp)
    800043ce:	b7c1                	j	8000438e <sys_open+0xca>
      end_op();
    800043d0:	beffe0ef          	jal	80002fbe <end_op>
      return -1;
    800043d4:	557d                	li	a0,-1
    800043d6:	74aa                	ld	s1,168(sp)
    800043d8:	bf5d                	j	8000438e <sys_open+0xca>
    iunlockput(ip);
    800043da:	8526                	mv	a0,s1
    800043dc:	cc6fe0ef          	jal	800028a2 <iunlockput>
    end_op();
    800043e0:	bdffe0ef          	jal	80002fbe <end_op>
    return -1;
    800043e4:	557d                	li	a0,-1
    800043e6:	74aa                	ld	s1,168(sp)
    800043e8:	b75d                	j	8000438e <sys_open+0xca>
      fileclose(f);
    800043ea:	854a                	mv	a0,s2
    800043ec:	f95fe0ef          	jal	80003380 <fileclose>
    800043f0:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    800043f2:	8526                	mv	a0,s1
    800043f4:	caefe0ef          	jal	800028a2 <iunlockput>
    end_op();
    800043f8:	bc7fe0ef          	jal	80002fbe <end_op>
    return -1;
    800043fc:	557d                	li	a0,-1
    800043fe:	74aa                	ld	s1,168(sp)
    80004400:	790a                	ld	s2,160(sp)
    80004402:	b771                	j	8000438e <sys_open+0xca>
    f->type = FD_DEVICE;
    80004404:	00e92023          	sw	a4,0(s2)
    f->major = ip->major;
    80004408:	04649783          	lh	a5,70(s1)
    8000440c:	02f91223          	sh	a5,36(s2)
    80004410:	bf35                	j	8000434c <sys_open+0x88>
    itrunc(ip);
    80004412:	8526                	mv	a0,s1
    80004414:	b70fe0ef          	jal	80002784 <itrunc>
    80004418:	b795                	j	8000437c <sys_open+0xb8>

000000008000441a <sys_mkdir>:

uint64
sys_mkdir(void)
{
    8000441a:	7175                	addi	sp,sp,-144
    8000441c:	e506                	sd	ra,136(sp)
    8000441e:	e122                	sd	s0,128(sp)
    80004420:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004422:	b2dfe0ef          	jal	80002f4e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004426:	08000613          	li	a2,128
    8000442a:	f7040593          	addi	a1,s0,-144
    8000442e:	4501                	li	a0,0
    80004430:	853fd0ef          	jal	80001c82 <argstr>
    80004434:	02054363          	bltz	a0,8000445a <sys_mkdir+0x40>
    80004438:	4681                	li	a3,0
    8000443a:	4601                	li	a2,0
    8000443c:	4585                	li	a1,1
    8000443e:	f7040513          	addi	a0,s0,-144
    80004442:	973ff0ef          	jal	80003db4 <create>
    80004446:	c911                	beqz	a0,8000445a <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004448:	c5afe0ef          	jal	800028a2 <iunlockput>
  end_op();
    8000444c:	b73fe0ef          	jal	80002fbe <end_op>
  return 0;
    80004450:	4501                	li	a0,0
}
    80004452:	60aa                	ld	ra,136(sp)
    80004454:	640a                	ld	s0,128(sp)
    80004456:	6149                	addi	sp,sp,144
    80004458:	8082                	ret
    end_op();
    8000445a:	b65fe0ef          	jal	80002fbe <end_op>
    return -1;
    8000445e:	557d                	li	a0,-1
    80004460:	bfcd                	j	80004452 <sys_mkdir+0x38>

0000000080004462 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004462:	7135                	addi	sp,sp,-160
    80004464:	ed06                	sd	ra,152(sp)
    80004466:	e922                	sd	s0,144(sp)
    80004468:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000446a:	ae5fe0ef          	jal	80002f4e <begin_op>
  argint(1, &major);
    8000446e:	f6c40593          	addi	a1,s0,-148
    80004472:	4505                	li	a0,1
    80004474:	fd6fd0ef          	jal	80001c4a <argint>
  argint(2, &minor);
    80004478:	f6840593          	addi	a1,s0,-152
    8000447c:	4509                	li	a0,2
    8000447e:	fccfd0ef          	jal	80001c4a <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004482:	08000613          	li	a2,128
    80004486:	f7040593          	addi	a1,s0,-144
    8000448a:	4501                	li	a0,0
    8000448c:	ff6fd0ef          	jal	80001c82 <argstr>
    80004490:	02054563          	bltz	a0,800044ba <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004494:	f6841683          	lh	a3,-152(s0)
    80004498:	f6c41603          	lh	a2,-148(s0)
    8000449c:	458d                	li	a1,3
    8000449e:	f7040513          	addi	a0,s0,-144
    800044a2:	913ff0ef          	jal	80003db4 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800044a6:	c911                	beqz	a0,800044ba <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800044a8:	bfafe0ef          	jal	800028a2 <iunlockput>
  end_op();
    800044ac:	b13fe0ef          	jal	80002fbe <end_op>
  return 0;
    800044b0:	4501                	li	a0,0
}
    800044b2:	60ea                	ld	ra,152(sp)
    800044b4:	644a                	ld	s0,144(sp)
    800044b6:	610d                	addi	sp,sp,160
    800044b8:	8082                	ret
    end_op();
    800044ba:	b05fe0ef          	jal	80002fbe <end_op>
    return -1;
    800044be:	557d                	li	a0,-1
    800044c0:	bfcd                	j	800044b2 <sys_mknod+0x50>

00000000800044c2 <sys_chdir>:

uint64
sys_chdir(void)
{
    800044c2:	7135                	addi	sp,sp,-160
    800044c4:	ed06                	sd	ra,152(sp)
    800044c6:	e922                	sd	s0,144(sp)
    800044c8:	e14a                	sd	s2,128(sp)
    800044ca:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    800044cc:	8b7fc0ef          	jal	80000d82 <myproc>
    800044d0:	892a                	mv	s2,a0
  
  begin_op();
    800044d2:	a7dfe0ef          	jal	80002f4e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800044d6:	08000613          	li	a2,128
    800044da:	f6040593          	addi	a1,s0,-160
    800044de:	4501                	li	a0,0
    800044e0:	fa2fd0ef          	jal	80001c82 <argstr>
    800044e4:	04054363          	bltz	a0,8000452a <sys_chdir+0x68>
    800044e8:	e526                	sd	s1,136(sp)
    800044ea:	f6040513          	addi	a0,s0,-160
    800044ee:	89ffe0ef          	jal	80002d8c <namei>
    800044f2:	84aa                	mv	s1,a0
    800044f4:	c915                	beqz	a0,80004528 <sys_chdir+0x66>
    end_op();
    return -1;
  }
  ilock(ip);
    800044f6:	9a0fe0ef          	jal	80002696 <ilock>
  if(ip->type != T_DIR){
    800044fa:	04449703          	lh	a4,68(s1)
    800044fe:	4785                	li	a5,1
    80004500:	02f71963          	bne	a4,a5,80004532 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004504:	8526                	mv	a0,s1
    80004506:	a3efe0ef          	jal	80002744 <iunlock>
  iput(p->cwd);
    8000450a:	15093503          	ld	a0,336(s2)
    8000450e:	b0afe0ef          	jal	80002818 <iput>
  end_op();
    80004512:	aadfe0ef          	jal	80002fbe <end_op>
  p->cwd = ip;
    80004516:	14993823          	sd	s1,336(s2)
  return 0;
    8000451a:	4501                	li	a0,0
    8000451c:	64aa                	ld	s1,136(sp)
}
    8000451e:	60ea                	ld	ra,152(sp)
    80004520:	644a                	ld	s0,144(sp)
    80004522:	690a                	ld	s2,128(sp)
    80004524:	610d                	addi	sp,sp,160
    80004526:	8082                	ret
    80004528:	64aa                	ld	s1,136(sp)
    end_op();
    8000452a:	a95fe0ef          	jal	80002fbe <end_op>
    return -1;
    8000452e:	557d                	li	a0,-1
    80004530:	b7fd                	j	8000451e <sys_chdir+0x5c>
    iunlockput(ip);
    80004532:	8526                	mv	a0,s1
    80004534:	b6efe0ef          	jal	800028a2 <iunlockput>
    end_op();
    80004538:	a87fe0ef          	jal	80002fbe <end_op>
    return -1;
    8000453c:	557d                	li	a0,-1
    8000453e:	64aa                	ld	s1,136(sp)
    80004540:	bff9                	j	8000451e <sys_chdir+0x5c>

0000000080004542 <sys_exec>:

uint64
sys_exec(void)
{
    80004542:	7105                	addi	sp,sp,-480
    80004544:	ef86                	sd	ra,472(sp)
    80004546:	eba2                	sd	s0,464(sp)
    80004548:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    8000454a:	e2840593          	addi	a1,s0,-472
    8000454e:	4505                	li	a0,1
    80004550:	f16fd0ef          	jal	80001c66 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004554:	08000613          	li	a2,128
    80004558:	f3040593          	addi	a1,s0,-208
    8000455c:	4501                	li	a0,0
    8000455e:	f24fd0ef          	jal	80001c82 <argstr>
    80004562:	87aa                	mv	a5,a0
    return -1;
    80004564:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80004566:	0e07c063          	bltz	a5,80004646 <sys_exec+0x104>
    8000456a:	e7a6                	sd	s1,456(sp)
    8000456c:	e3ca                	sd	s2,448(sp)
    8000456e:	ff4e                	sd	s3,440(sp)
    80004570:	fb52                	sd	s4,432(sp)
    80004572:	f756                	sd	s5,424(sp)
    80004574:	f35a                	sd	s6,416(sp)
    80004576:	ef5e                	sd	s7,408(sp)
  }
  memset(argv, 0, sizeof(argv));
    80004578:	e3040a13          	addi	s4,s0,-464
    8000457c:	10000613          	li	a2,256
    80004580:	4581                	li	a1,0
    80004582:	8552                	mv	a0,s4
    80004584:	bdbfb0ef          	jal	8000015e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004588:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    8000458a:	89d2                	mv	s3,s4
    8000458c:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000458e:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004592:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    80004594:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004598:	00391513          	slli	a0,s2,0x3
    8000459c:	85d6                	mv	a1,s5
    8000459e:	e2843783          	ld	a5,-472(s0)
    800045a2:	953e                	add	a0,a0,a5
    800045a4:	e1cfd0ef          	jal	80001bc0 <fetchaddr>
    800045a8:	02054663          	bltz	a0,800045d4 <sys_exec+0x92>
    if(uarg == 0){
    800045ac:	e2043783          	ld	a5,-480(s0)
    800045b0:	c7a1                	beqz	a5,800045f8 <sys_exec+0xb6>
    argv[i] = kalloc();
    800045b2:	b53fb0ef          	jal	80000104 <kalloc>
    800045b6:	85aa                	mv	a1,a0
    800045b8:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800045bc:	cd01                	beqz	a0,800045d4 <sys_exec+0x92>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800045be:	865a                	mv	a2,s6
    800045c0:	e2043503          	ld	a0,-480(s0)
    800045c4:	e46fd0ef          	jal	80001c0a <fetchstr>
    800045c8:	00054663          	bltz	a0,800045d4 <sys_exec+0x92>
    if(i >= NELEM(argv)){
    800045cc:	0905                	addi	s2,s2,1
    800045ce:	09a1                	addi	s3,s3,8
    800045d0:	fd7914e3          	bne	s2,s7,80004598 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800045d4:	100a0a13          	addi	s4,s4,256
    800045d8:	6088                	ld	a0,0(s1)
    800045da:	cd31                	beqz	a0,80004636 <sys_exec+0xf4>
    kfree(argv[i]);
    800045dc:	a41fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800045e0:	04a1                	addi	s1,s1,8
    800045e2:	ff449be3          	bne	s1,s4,800045d8 <sys_exec+0x96>
  return -1;
    800045e6:	557d                	li	a0,-1
    800045e8:	64be                	ld	s1,456(sp)
    800045ea:	691e                	ld	s2,448(sp)
    800045ec:	79fa                	ld	s3,440(sp)
    800045ee:	7a5a                	ld	s4,432(sp)
    800045f0:	7aba                	ld	s5,424(sp)
    800045f2:	7b1a                	ld	s6,416(sp)
    800045f4:	6bfa                	ld	s7,408(sp)
    800045f6:	a881                	j	80004646 <sys_exec+0x104>
      argv[i] = 0;
    800045f8:	0009079b          	sext.w	a5,s2
    800045fc:	e3040593          	addi	a1,s0,-464
    80004600:	078e                	slli	a5,a5,0x3
    80004602:	97ae                	add	a5,a5,a1
    80004604:	0007b023          	sd	zero,0(a5)
  int ret = exec(path, argv);
    80004608:	f3040513          	addi	a0,s0,-208
    8000460c:	bb6ff0ef          	jal	800039c2 <exec>
    80004610:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004612:	100a0a13          	addi	s4,s4,256
    80004616:	6088                	ld	a0,0(s1)
    80004618:	c511                	beqz	a0,80004624 <sys_exec+0xe2>
    kfree(argv[i]);
    8000461a:	a03fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000461e:	04a1                	addi	s1,s1,8
    80004620:	ff449be3          	bne	s1,s4,80004616 <sys_exec+0xd4>
  return ret;
    80004624:	854a                	mv	a0,s2
    80004626:	64be                	ld	s1,456(sp)
    80004628:	691e                	ld	s2,448(sp)
    8000462a:	79fa                	ld	s3,440(sp)
    8000462c:	7a5a                	ld	s4,432(sp)
    8000462e:	7aba                	ld	s5,424(sp)
    80004630:	7b1a                	ld	s6,416(sp)
    80004632:	6bfa                	ld	s7,408(sp)
    80004634:	a809                	j	80004646 <sys_exec+0x104>
  return -1;
    80004636:	557d                	li	a0,-1
    80004638:	64be                	ld	s1,456(sp)
    8000463a:	691e                	ld	s2,448(sp)
    8000463c:	79fa                	ld	s3,440(sp)
    8000463e:	7a5a                	ld	s4,432(sp)
    80004640:	7aba                	ld	s5,424(sp)
    80004642:	7b1a                	ld	s6,416(sp)
    80004644:	6bfa                	ld	s7,408(sp)
}
    80004646:	60fe                	ld	ra,472(sp)
    80004648:	645e                	ld	s0,464(sp)
    8000464a:	613d                	addi	sp,sp,480
    8000464c:	8082                	ret

000000008000464e <sys_pipe>:

uint64
sys_pipe(void)
{
    8000464e:	7139                	addi	sp,sp,-64
    80004650:	fc06                	sd	ra,56(sp)
    80004652:	f822                	sd	s0,48(sp)
    80004654:	f426                	sd	s1,40(sp)
    80004656:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004658:	f2afc0ef          	jal	80000d82 <myproc>
    8000465c:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    8000465e:	fd840593          	addi	a1,s0,-40
    80004662:	4501                	li	a0,0
    80004664:	e02fd0ef          	jal	80001c66 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80004668:	fc840593          	addi	a1,s0,-56
    8000466c:	fd040513          	addi	a0,s0,-48
    80004670:	82cff0ef          	jal	8000369c <pipealloc>
    return -1;
    80004674:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004676:	0a054763          	bltz	a0,80004724 <sys_pipe+0xd6>
  fd0 = -1;
    8000467a:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    8000467e:	fd043503          	ld	a0,-48(s0)
    80004682:	ef2ff0ef          	jal	80003d74 <fdalloc>
    80004686:	fca42223          	sw	a0,-60(s0)
    8000468a:	08054463          	bltz	a0,80004712 <sys_pipe+0xc4>
    8000468e:	fc843503          	ld	a0,-56(s0)
    80004692:	ee2ff0ef          	jal	80003d74 <fdalloc>
    80004696:	fca42023          	sw	a0,-64(s0)
    8000469a:	06054263          	bltz	a0,800046fe <sys_pipe+0xb0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000469e:	4691                	li	a3,4
    800046a0:	fc440613          	addi	a2,s0,-60
    800046a4:	fd843583          	ld	a1,-40(s0)
    800046a8:	68a8                	ld	a0,80(s1)
    800046aa:	b58fc0ef          	jal	80000a02 <copyout>
    800046ae:	00054e63          	bltz	a0,800046ca <sys_pipe+0x7c>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800046b2:	4691                	li	a3,4
    800046b4:	fc040613          	addi	a2,s0,-64
    800046b8:	fd843583          	ld	a1,-40(s0)
    800046bc:	95b6                	add	a1,a1,a3
    800046be:	68a8                	ld	a0,80(s1)
    800046c0:	b42fc0ef          	jal	80000a02 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800046c4:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800046c6:	04055f63          	bgez	a0,80004724 <sys_pipe+0xd6>
    p->ofile[fd0] = 0;
    800046ca:	fc442783          	lw	a5,-60(s0)
    800046ce:	078e                	slli	a5,a5,0x3
    800046d0:	0d078793          	addi	a5,a5,208
    800046d4:	97a6                	add	a5,a5,s1
    800046d6:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800046da:	fc042783          	lw	a5,-64(s0)
    800046de:	078e                	slli	a5,a5,0x3
    800046e0:	0d078793          	addi	a5,a5,208
    800046e4:	97a6                	add	a5,a5,s1
    800046e6:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800046ea:	fd043503          	ld	a0,-48(s0)
    800046ee:	c93fe0ef          	jal	80003380 <fileclose>
    fileclose(wf);
    800046f2:	fc843503          	ld	a0,-56(s0)
    800046f6:	c8bfe0ef          	jal	80003380 <fileclose>
    return -1;
    800046fa:	57fd                	li	a5,-1
    800046fc:	a025                	j	80004724 <sys_pipe+0xd6>
    if(fd0 >= 0)
    800046fe:	fc442783          	lw	a5,-60(s0)
    80004702:	0007c863          	bltz	a5,80004712 <sys_pipe+0xc4>
      p->ofile[fd0] = 0;
    80004706:	078e                	slli	a5,a5,0x3
    80004708:	0d078793          	addi	a5,a5,208
    8000470c:	97a6                	add	a5,a5,s1
    8000470e:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    80004712:	fd043503          	ld	a0,-48(s0)
    80004716:	c6bfe0ef          	jal	80003380 <fileclose>
    fileclose(wf);
    8000471a:	fc843503          	ld	a0,-56(s0)
    8000471e:	c63fe0ef          	jal	80003380 <fileclose>
    return -1;
    80004722:	57fd                	li	a5,-1
}
    80004724:	853e                	mv	a0,a5
    80004726:	70e2                	ld	ra,56(sp)
    80004728:	7442                	ld	s0,48(sp)
    8000472a:	74a2                	ld	s1,40(sp)
    8000472c:	6121                	addi	sp,sp,64
    8000472e:	8082                	ret

0000000080004730 <kernelvec>:
    80004730:	7111                	addi	sp,sp,-256
    80004732:	e006                	sd	ra,0(sp)
    80004734:	e40a                	sd	sp,8(sp)
    80004736:	e80e                	sd	gp,16(sp)
    80004738:	ec12                	sd	tp,24(sp)
    8000473a:	f016                	sd	t0,32(sp)
    8000473c:	f41a                	sd	t1,40(sp)
    8000473e:	f81e                	sd	t2,48(sp)
    80004740:	e4aa                	sd	a0,72(sp)
    80004742:	e8ae                	sd	a1,80(sp)
    80004744:	ecb2                	sd	a2,88(sp)
    80004746:	f0b6                	sd	a3,96(sp)
    80004748:	f4ba                	sd	a4,104(sp)
    8000474a:	f8be                	sd	a5,112(sp)
    8000474c:	fcc2                	sd	a6,120(sp)
    8000474e:	e146                	sd	a7,128(sp)
    80004750:	edf2                	sd	t3,216(sp)
    80004752:	f1f6                	sd	t4,224(sp)
    80004754:	f5fa                	sd	t5,232(sp)
    80004756:	f9fe                	sd	t6,240(sp)
    80004758:	b76fd0ef          	jal	80001ace <kerneltrap>
    8000475c:	6082                	ld	ra,0(sp)
    8000475e:	6122                	ld	sp,8(sp)
    80004760:	61c2                	ld	gp,16(sp)
    80004762:	7282                	ld	t0,32(sp)
    80004764:	7322                	ld	t1,40(sp)
    80004766:	73c2                	ld	t2,48(sp)
    80004768:	6526                	ld	a0,72(sp)
    8000476a:	65c6                	ld	a1,80(sp)
    8000476c:	6666                	ld	a2,88(sp)
    8000476e:	7686                	ld	a3,96(sp)
    80004770:	7726                	ld	a4,104(sp)
    80004772:	77c6                	ld	a5,112(sp)
    80004774:	7866                	ld	a6,120(sp)
    80004776:	688a                	ld	a7,128(sp)
    80004778:	6e6e                	ld	t3,216(sp)
    8000477a:	7e8e                	ld	t4,224(sp)
    8000477c:	7f2e                	ld	t5,232(sp)
    8000477e:	7fce                	ld	t6,240(sp)
    80004780:	6111                	addi	sp,sp,256
    80004782:	10200073          	sret
    80004786:	00000013          	nop
    8000478a:	00000013          	nop

000000008000478e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000478e:	1141                	addi	sp,sp,-16
    80004790:	e406                	sd	ra,8(sp)
    80004792:	e022                	sd	s0,0(sp)
    80004794:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80004796:	0c000737          	lui	a4,0xc000
    8000479a:	4785                	li	a5,1
    8000479c:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000479e:	c35c                	sw	a5,4(a4)
}
    800047a0:	60a2                	ld	ra,8(sp)
    800047a2:	6402                	ld	s0,0(sp)
    800047a4:	0141                	addi	sp,sp,16
    800047a6:	8082                	ret

00000000800047a8 <plicinithart>:

void
plicinithart(void)
{
    800047a8:	1141                	addi	sp,sp,-16
    800047aa:	e406                	sd	ra,8(sp)
    800047ac:	e022                	sd	s0,0(sp)
    800047ae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800047b0:	d9efc0ef          	jal	80000d4e <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800047b4:	0085171b          	slliw	a4,a0,0x8
    800047b8:	0c0027b7          	lui	a5,0xc002
    800047bc:	97ba                	add	a5,a5,a4
    800047be:	40200713          	li	a4,1026
    800047c2:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800047c6:	00d5151b          	slliw	a0,a0,0xd
    800047ca:	0c2017b7          	lui	a5,0xc201
    800047ce:	97aa                	add	a5,a5,a0
    800047d0:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800047d4:	60a2                	ld	ra,8(sp)
    800047d6:	6402                	ld	s0,0(sp)
    800047d8:	0141                	addi	sp,sp,16
    800047da:	8082                	ret

00000000800047dc <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800047dc:	1141                	addi	sp,sp,-16
    800047de:	e406                	sd	ra,8(sp)
    800047e0:	e022                	sd	s0,0(sp)
    800047e2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800047e4:	d6afc0ef          	jal	80000d4e <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800047e8:	00d5151b          	slliw	a0,a0,0xd
    800047ec:	0c2017b7          	lui	a5,0xc201
    800047f0:	97aa                	add	a5,a5,a0
  return irq;
}
    800047f2:	43c8                	lw	a0,4(a5)
    800047f4:	60a2                	ld	ra,8(sp)
    800047f6:	6402                	ld	s0,0(sp)
    800047f8:	0141                	addi	sp,sp,16
    800047fa:	8082                	ret

00000000800047fc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800047fc:	1101                	addi	sp,sp,-32
    800047fe:	ec06                	sd	ra,24(sp)
    80004800:	e822                	sd	s0,16(sp)
    80004802:	e426                	sd	s1,8(sp)
    80004804:	1000                	addi	s0,sp,32
    80004806:	84aa                	mv	s1,a0
  int hart = cpuid();
    80004808:	d46fc0ef          	jal	80000d4e <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000480c:	00d5179b          	slliw	a5,a0,0xd
    80004810:	0c201737          	lui	a4,0xc201
    80004814:	97ba                	add	a5,a5,a4
    80004816:	c3c4                	sw	s1,4(a5)
}
    80004818:	60e2                	ld	ra,24(sp)
    8000481a:	6442                	ld	s0,16(sp)
    8000481c:	64a2                	ld	s1,8(sp)
    8000481e:	6105                	addi	sp,sp,32
    80004820:	8082                	ret

0000000080004822 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80004822:	1141                	addi	sp,sp,-16
    80004824:	e406                	sd	ra,8(sp)
    80004826:	e022                	sd	s0,0(sp)
    80004828:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000482a:	479d                	li	a5,7
    8000482c:	04a7ca63          	blt	a5,a0,80004880 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80004830:	00017797          	auipc	a5,0x17
    80004834:	cb078793          	addi	a5,a5,-848 # 8001b4e0 <disk>
    80004838:	97aa                	add	a5,a5,a0
    8000483a:	0187c783          	lbu	a5,24(a5)
    8000483e:	e7b9                	bnez	a5,8000488c <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80004840:	00451693          	slli	a3,a0,0x4
    80004844:	00017797          	auipc	a5,0x17
    80004848:	c9c78793          	addi	a5,a5,-868 # 8001b4e0 <disk>
    8000484c:	6398                	ld	a4,0(a5)
    8000484e:	9736                	add	a4,a4,a3
    80004850:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80004854:	6398                	ld	a4,0(a5)
    80004856:	9736                	add	a4,a4,a3
    80004858:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    8000485c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80004860:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80004864:	97aa                	add	a5,a5,a0
    80004866:	4705                	li	a4,1
    80004868:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    8000486c:	00017517          	auipc	a0,0x17
    80004870:	c8c50513          	addi	a0,a0,-884 # 8001b4f8 <disk+0x18>
    80004874:	b35fc0ef          	jal	800013a8 <wakeup>
}
    80004878:	60a2                	ld	ra,8(sp)
    8000487a:	6402                	ld	s0,0(sp)
    8000487c:	0141                	addi	sp,sp,16
    8000487e:	8082                	ret
    panic("free_desc 1");
    80004880:	00003517          	auipc	a0,0x3
    80004884:	e3850513          	addi	a0,a0,-456 # 800076b8 <etext+0x6b8>
    80004888:	457000ef          	jal	800054de <panic>
    panic("free_desc 2");
    8000488c:	00003517          	auipc	a0,0x3
    80004890:	e3c50513          	addi	a0,a0,-452 # 800076c8 <etext+0x6c8>
    80004894:	44b000ef          	jal	800054de <panic>

0000000080004898 <virtio_disk_init>:
{
    80004898:	1101                	addi	sp,sp,-32
    8000489a:	ec06                	sd	ra,24(sp)
    8000489c:	e822                	sd	s0,16(sp)
    8000489e:	e426                	sd	s1,8(sp)
    800048a0:	e04a                	sd	s2,0(sp)
    800048a2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800048a4:	00003597          	auipc	a1,0x3
    800048a8:	e3458593          	addi	a1,a1,-460 # 800076d8 <etext+0x6d8>
    800048ac:	00017517          	auipc	a0,0x17
    800048b0:	d5c50513          	addi	a0,a0,-676 # 8001b608 <disk+0x128>
    800048b4:	6df000ef          	jal	80005792 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800048b8:	100017b7          	lui	a5,0x10001
    800048bc:	4398                	lw	a4,0(a5)
    800048be:	2701                	sext.w	a4,a4
    800048c0:	747277b7          	lui	a5,0x74727
    800048c4:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800048c8:	14f71863          	bne	a4,a5,80004a18 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800048cc:	100017b7          	lui	a5,0x10001
    800048d0:	43dc                	lw	a5,4(a5)
    800048d2:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800048d4:	4709                	li	a4,2
    800048d6:	14e79163          	bne	a5,a4,80004a18 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800048da:	100017b7          	lui	a5,0x10001
    800048de:	479c                	lw	a5,8(a5)
    800048e0:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800048e2:	12e79b63          	bne	a5,a4,80004a18 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800048e6:	100017b7          	lui	a5,0x10001
    800048ea:	47d8                	lw	a4,12(a5)
    800048ec:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800048ee:	554d47b7          	lui	a5,0x554d4
    800048f2:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800048f6:	12f71163          	bne	a4,a5,80004a18 <virtio_disk_init+0x180>
  *R(VIRTIO_MMIO_STATUS) = status;
    800048fa:	100017b7          	lui	a5,0x10001
    800048fe:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80004902:	4705                	li	a4,1
    80004904:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004906:	470d                	li	a4,3
    80004908:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000490a:	10001737          	lui	a4,0x10001
    8000490e:	4b18                	lw	a4,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80004910:	c7ffe6b7          	lui	a3,0xc7ffe
    80004914:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdb03f>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80004918:	8f75                	and	a4,a4,a3
    8000491a:	100016b7          	lui	a3,0x10001
    8000491e:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004920:	472d                	li	a4,11
    80004922:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80004924:	07078793          	addi	a5,a5,112
  status = *R(VIRTIO_MMIO_STATUS);
    80004928:	439c                	lw	a5,0(a5)
    8000492a:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    8000492e:	8ba1                	andi	a5,a5,8
    80004930:	0e078a63          	beqz	a5,80004a24 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80004934:	100017b7          	lui	a5,0x10001
    80004938:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    8000493c:	43fc                	lw	a5,68(a5)
    8000493e:	2781                	sext.w	a5,a5
    80004940:	0e079863          	bnez	a5,80004a30 <virtio_disk_init+0x198>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80004944:	100017b7          	lui	a5,0x10001
    80004948:	5bdc                	lw	a5,52(a5)
    8000494a:	2781                	sext.w	a5,a5
  if(max == 0)
    8000494c:	0e078863          	beqz	a5,80004a3c <virtio_disk_init+0x1a4>
  if(max < NUM)
    80004950:	471d                	li	a4,7
    80004952:	0ef77b63          	bgeu	a4,a5,80004a48 <virtio_disk_init+0x1b0>
  disk.desc = kalloc();
    80004956:	faefb0ef          	jal	80000104 <kalloc>
    8000495a:	00017497          	auipc	s1,0x17
    8000495e:	b8648493          	addi	s1,s1,-1146 # 8001b4e0 <disk>
    80004962:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80004964:	fa0fb0ef          	jal	80000104 <kalloc>
    80004968:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000496a:	f9afb0ef          	jal	80000104 <kalloc>
    8000496e:	87aa                	mv	a5,a0
    80004970:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80004972:	6088                	ld	a0,0(s1)
    80004974:	0e050063          	beqz	a0,80004a54 <virtio_disk_init+0x1bc>
    80004978:	00017717          	auipc	a4,0x17
    8000497c:	b7073703          	ld	a4,-1168(a4) # 8001b4e8 <disk+0x8>
    80004980:	cb71                	beqz	a4,80004a54 <virtio_disk_init+0x1bc>
    80004982:	cbe9                	beqz	a5,80004a54 <virtio_disk_init+0x1bc>
  memset(disk.desc, 0, PGSIZE);
    80004984:	6605                	lui	a2,0x1
    80004986:	4581                	li	a1,0
    80004988:	fd6fb0ef          	jal	8000015e <memset>
  memset(disk.avail, 0, PGSIZE);
    8000498c:	00017497          	auipc	s1,0x17
    80004990:	b5448493          	addi	s1,s1,-1196 # 8001b4e0 <disk>
    80004994:	6605                	lui	a2,0x1
    80004996:	4581                	li	a1,0
    80004998:	6488                	ld	a0,8(s1)
    8000499a:	fc4fb0ef          	jal	8000015e <memset>
  memset(disk.used, 0, PGSIZE);
    8000499e:	6605                	lui	a2,0x1
    800049a0:	4581                	li	a1,0
    800049a2:	6888                	ld	a0,16(s1)
    800049a4:	fbafb0ef          	jal	8000015e <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800049a8:	100017b7          	lui	a5,0x10001
    800049ac:	4721                	li	a4,8
    800049ae:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800049b0:	4098                	lw	a4,0(s1)
    800049b2:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800049b6:	40d8                	lw	a4,4(s1)
    800049b8:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800049bc:	649c                	ld	a5,8(s1)
    800049be:	0007869b          	sext.w	a3,a5
    800049c2:	10001737          	lui	a4,0x10001
    800049c6:	08d72823          	sw	a3,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800049ca:	9781                	srai	a5,a5,0x20
    800049cc:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800049d0:	689c                	ld	a5,16(s1)
    800049d2:	0007869b          	sext.w	a3,a5
    800049d6:	0ad72023          	sw	a3,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800049da:	9781                	srai	a5,a5,0x20
    800049dc:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800049e0:	4785                	li	a5,1
    800049e2:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    800049e4:	00f48c23          	sb	a5,24(s1)
    800049e8:	00f48ca3          	sb	a5,25(s1)
    800049ec:	00f48d23          	sb	a5,26(s1)
    800049f0:	00f48da3          	sb	a5,27(s1)
    800049f4:	00f48e23          	sb	a5,28(s1)
    800049f8:	00f48ea3          	sb	a5,29(s1)
    800049fc:	00f48f23          	sb	a5,30(s1)
    80004a00:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004a04:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004a08:	07272823          	sw	s2,112(a4)
}
    80004a0c:	60e2                	ld	ra,24(sp)
    80004a0e:	6442                	ld	s0,16(sp)
    80004a10:	64a2                	ld	s1,8(sp)
    80004a12:	6902                	ld	s2,0(sp)
    80004a14:	6105                	addi	sp,sp,32
    80004a16:	8082                	ret
    panic("could not find virtio disk");
    80004a18:	00003517          	auipc	a0,0x3
    80004a1c:	cd050513          	addi	a0,a0,-816 # 800076e8 <etext+0x6e8>
    80004a20:	2bf000ef          	jal	800054de <panic>
    panic("virtio disk FEATURES_OK unset");
    80004a24:	00003517          	auipc	a0,0x3
    80004a28:	ce450513          	addi	a0,a0,-796 # 80007708 <etext+0x708>
    80004a2c:	2b3000ef          	jal	800054de <panic>
    panic("virtio disk should not be ready");
    80004a30:	00003517          	auipc	a0,0x3
    80004a34:	cf850513          	addi	a0,a0,-776 # 80007728 <etext+0x728>
    80004a38:	2a7000ef          	jal	800054de <panic>
    panic("virtio disk has no queue 0");
    80004a3c:	00003517          	auipc	a0,0x3
    80004a40:	d0c50513          	addi	a0,a0,-756 # 80007748 <etext+0x748>
    80004a44:	29b000ef          	jal	800054de <panic>
    panic("virtio disk max queue too short");
    80004a48:	00003517          	auipc	a0,0x3
    80004a4c:	d2050513          	addi	a0,a0,-736 # 80007768 <etext+0x768>
    80004a50:	28f000ef          	jal	800054de <panic>
    panic("virtio disk kalloc");
    80004a54:	00003517          	auipc	a0,0x3
    80004a58:	d3450513          	addi	a0,a0,-716 # 80007788 <etext+0x788>
    80004a5c:	283000ef          	jal	800054de <panic>

0000000080004a60 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80004a60:	711d                	addi	sp,sp,-96
    80004a62:	ec86                	sd	ra,88(sp)
    80004a64:	e8a2                	sd	s0,80(sp)
    80004a66:	e4a6                	sd	s1,72(sp)
    80004a68:	e0ca                	sd	s2,64(sp)
    80004a6a:	fc4e                	sd	s3,56(sp)
    80004a6c:	f852                	sd	s4,48(sp)
    80004a6e:	f456                	sd	s5,40(sp)
    80004a70:	f05a                	sd	s6,32(sp)
    80004a72:	ec5e                	sd	s7,24(sp)
    80004a74:	e862                	sd	s8,16(sp)
    80004a76:	1080                	addi	s0,sp,96
    80004a78:	89aa                	mv	s3,a0
    80004a7a:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004a7c:	00c52b83          	lw	s7,12(a0)
    80004a80:	001b9b9b          	slliw	s7,s7,0x1
    80004a84:	1b82                	slli	s7,s7,0x20
    80004a86:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80004a8a:	00017517          	auipc	a0,0x17
    80004a8e:	b7e50513          	addi	a0,a0,-1154 # 8001b608 <disk+0x128>
    80004a92:	58b000ef          	jal	8000581c <acquire>
  for(int i = 0; i < NUM; i++){
    80004a96:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004a98:	00017a97          	auipc	s5,0x17
    80004a9c:	a48a8a93          	addi	s5,s5,-1464 # 8001b4e0 <disk>
  for(int i = 0; i < 3; i++){
    80004aa0:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    80004aa2:	5c7d                	li	s8,-1
    80004aa4:	a095                	j	80004b08 <virtio_disk_rw+0xa8>
      disk.free[i] = 0;
    80004aa6:	00fa8733          	add	a4,s5,a5
    80004aaa:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80004aae:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004ab0:	0207c563          	bltz	a5,80004ada <virtio_disk_rw+0x7a>
  for(int i = 0; i < 3; i++){
    80004ab4:	2905                	addiw	s2,s2,1
    80004ab6:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004ab8:	05490c63          	beq	s2,s4,80004b10 <virtio_disk_rw+0xb0>
    idx[i] = alloc_desc();
    80004abc:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004abe:	00017717          	auipc	a4,0x17
    80004ac2:	a2270713          	addi	a4,a4,-1502 # 8001b4e0 <disk>
    80004ac6:	4781                	li	a5,0
    if(disk.free[i]){
    80004ac8:	01874683          	lbu	a3,24(a4)
    80004acc:	fee9                	bnez	a3,80004aa6 <virtio_disk_rw+0x46>
  for(int i = 0; i < NUM; i++){
    80004ace:	2785                	addiw	a5,a5,1
    80004ad0:	0705                	addi	a4,a4,1
    80004ad2:	fe979be3          	bne	a5,s1,80004ac8 <virtio_disk_rw+0x68>
    idx[i] = alloc_desc();
    80004ad6:	0185a023          	sw	s8,0(a1)
      for(int j = 0; j < i; j++)
    80004ada:	01205d63          	blez	s2,80004af4 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004ade:	fa042503          	lw	a0,-96(s0)
    80004ae2:	d41ff0ef          	jal	80004822 <free_desc>
      for(int j = 0; j < i; j++)
    80004ae6:	4785                	li	a5,1
    80004ae8:	0127d663          	bge	a5,s2,80004af4 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004aec:	fa442503          	lw	a0,-92(s0)
    80004af0:	d33ff0ef          	jal	80004822 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004af4:	00017597          	auipc	a1,0x17
    80004af8:	b1458593          	addi	a1,a1,-1260 # 8001b608 <disk+0x128>
    80004afc:	00017517          	auipc	a0,0x17
    80004b00:	9fc50513          	addi	a0,a0,-1540 # 8001b4f8 <disk+0x18>
    80004b04:	859fc0ef          	jal	8000135c <sleep>
  for(int i = 0; i < 3; i++){
    80004b08:	fa040613          	addi	a2,s0,-96
    80004b0c:	4901                	li	s2,0
    80004b0e:	b77d                	j	80004abc <virtio_disk_rw+0x5c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004b10:	fa042503          	lw	a0,-96(s0)
    80004b14:	00451693          	slli	a3,a0,0x4

  if(write)
    80004b18:	00017797          	auipc	a5,0x17
    80004b1c:	9c878793          	addi	a5,a5,-1592 # 8001b4e0 <disk>
    80004b20:	00451713          	slli	a4,a0,0x4
    80004b24:	0a070713          	addi	a4,a4,160
    80004b28:	973e                	add	a4,a4,a5
    80004b2a:	01603633          	snez	a2,s6
    80004b2e:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004b30:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004b34:	01773823          	sd	s7,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004b38:	6398                	ld	a4,0(a5)
    80004b3a:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004b3c:	0a868613          	addi	a2,a3,168 # 100010a8 <_entry-0x6fffef58>
    80004b40:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004b42:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004b44:	6390                	ld	a2,0(a5)
    80004b46:	00d60833          	add	a6,a2,a3
    80004b4a:	4741                	li	a4,16
    80004b4c:	00e82423          	sw	a4,8(a6)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004b50:	4585                	li	a1,1
    80004b52:	00b81623          	sh	a1,12(a6)
  disk.desc[idx[0]].next = idx[1];
    80004b56:	fa442703          	lw	a4,-92(s0)
    80004b5a:	00e81723          	sh	a4,14(a6)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004b5e:	0712                	slli	a4,a4,0x4
    80004b60:	963a                	add	a2,a2,a4
    80004b62:	05898813          	addi	a6,s3,88
    80004b66:	01063023          	sd	a6,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80004b6a:	0007b883          	ld	a7,0(a5)
    80004b6e:	9746                	add	a4,a4,a7
    80004b70:	40000613          	li	a2,1024
    80004b74:	c710                	sw	a2,8(a4)
  if(write)
    80004b76:	001b3613          	seqz	a2,s6
    80004b7a:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004b7e:	8e4d                	or	a2,a2,a1
    80004b80:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004b84:	fa842603          	lw	a2,-88(s0)
    80004b88:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004b8c:	00451813          	slli	a6,a0,0x4
    80004b90:	02080813          	addi	a6,a6,32
    80004b94:	983e                	add	a6,a6,a5
    80004b96:	577d                	li	a4,-1
    80004b98:	00e80823          	sb	a4,16(a6)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004b9c:	0612                	slli	a2,a2,0x4
    80004b9e:	98b2                	add	a7,a7,a2
    80004ba0:	03068713          	addi	a4,a3,48
    80004ba4:	973e                	add	a4,a4,a5
    80004ba6:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004baa:	6398                	ld	a4,0(a5)
    80004bac:	9732                	add	a4,a4,a2
    80004bae:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004bb0:	4689                	li	a3,2
    80004bb2:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    80004bb6:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004bba:	00b9a223          	sw	a1,4(s3)
  disk.info[idx[0]].b = b;
    80004bbe:	01383423          	sd	s3,8(a6)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004bc2:	6794                	ld	a3,8(a5)
    80004bc4:	0026d703          	lhu	a4,2(a3)
    80004bc8:	8b1d                	andi	a4,a4,7
    80004bca:	0706                	slli	a4,a4,0x1
    80004bcc:	96ba                	add	a3,a3,a4
    80004bce:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004bd2:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004bd6:	6798                	ld	a4,8(a5)
    80004bd8:	00275783          	lhu	a5,2(a4)
    80004bdc:	2785                	addiw	a5,a5,1
    80004bde:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004be2:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004be6:	100017b7          	lui	a5,0x10001
    80004bea:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004bee:	0049a783          	lw	a5,4(s3)
    sleep(b, &disk.vdisk_lock);
    80004bf2:	00017917          	auipc	s2,0x17
    80004bf6:	a1690913          	addi	s2,s2,-1514 # 8001b608 <disk+0x128>
  while(b->disk == 1) {
    80004bfa:	84ae                	mv	s1,a1
    80004bfc:	00b79a63          	bne	a5,a1,80004c10 <virtio_disk_rw+0x1b0>
    sleep(b, &disk.vdisk_lock);
    80004c00:	85ca                	mv	a1,s2
    80004c02:	854e                	mv	a0,s3
    80004c04:	f58fc0ef          	jal	8000135c <sleep>
  while(b->disk == 1) {
    80004c08:	0049a783          	lw	a5,4(s3)
    80004c0c:	fe978ae3          	beq	a5,s1,80004c00 <virtio_disk_rw+0x1a0>
  }

  disk.info[idx[0]].b = 0;
    80004c10:	fa042903          	lw	s2,-96(s0)
    80004c14:	00491713          	slli	a4,s2,0x4
    80004c18:	02070713          	addi	a4,a4,32
    80004c1c:	00017797          	auipc	a5,0x17
    80004c20:	8c478793          	addi	a5,a5,-1852 # 8001b4e0 <disk>
    80004c24:	97ba                	add	a5,a5,a4
    80004c26:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004c2a:	00017997          	auipc	s3,0x17
    80004c2e:	8b698993          	addi	s3,s3,-1866 # 8001b4e0 <disk>
    80004c32:	00491713          	slli	a4,s2,0x4
    80004c36:	0009b783          	ld	a5,0(s3)
    80004c3a:	97ba                	add	a5,a5,a4
    80004c3c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004c40:	854a                	mv	a0,s2
    80004c42:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004c46:	bddff0ef          	jal	80004822 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004c4a:	8885                	andi	s1,s1,1
    80004c4c:	f0fd                	bnez	s1,80004c32 <virtio_disk_rw+0x1d2>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004c4e:	00017517          	auipc	a0,0x17
    80004c52:	9ba50513          	addi	a0,a0,-1606 # 8001b608 <disk+0x128>
    80004c56:	45b000ef          	jal	800058b0 <release>
}
    80004c5a:	60e6                	ld	ra,88(sp)
    80004c5c:	6446                	ld	s0,80(sp)
    80004c5e:	64a6                	ld	s1,72(sp)
    80004c60:	6906                	ld	s2,64(sp)
    80004c62:	79e2                	ld	s3,56(sp)
    80004c64:	7a42                	ld	s4,48(sp)
    80004c66:	7aa2                	ld	s5,40(sp)
    80004c68:	7b02                	ld	s6,32(sp)
    80004c6a:	6be2                	ld	s7,24(sp)
    80004c6c:	6c42                	ld	s8,16(sp)
    80004c6e:	6125                	addi	sp,sp,96
    80004c70:	8082                	ret

0000000080004c72 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004c72:	1101                	addi	sp,sp,-32
    80004c74:	ec06                	sd	ra,24(sp)
    80004c76:	e822                	sd	s0,16(sp)
    80004c78:	e426                	sd	s1,8(sp)
    80004c7a:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004c7c:	00017497          	auipc	s1,0x17
    80004c80:	86448493          	addi	s1,s1,-1948 # 8001b4e0 <disk>
    80004c84:	00017517          	auipc	a0,0x17
    80004c88:	98450513          	addi	a0,a0,-1660 # 8001b608 <disk+0x128>
    80004c8c:	391000ef          	jal	8000581c <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004c90:	100017b7          	lui	a5,0x10001
    80004c94:	53bc                	lw	a5,96(a5)
    80004c96:	8b8d                	andi	a5,a5,3
    80004c98:	10001737          	lui	a4,0x10001
    80004c9c:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80004c9e:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004ca2:	689c                	ld	a5,16(s1)
    80004ca4:	0204d703          	lhu	a4,32(s1)
    80004ca8:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004cac:	04f70863          	beq	a4,a5,80004cfc <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80004cb0:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004cb4:	6898                	ld	a4,16(s1)
    80004cb6:	0204d783          	lhu	a5,32(s1)
    80004cba:	8b9d                	andi	a5,a5,7
    80004cbc:	078e                	slli	a5,a5,0x3
    80004cbe:	97ba                	add	a5,a5,a4
    80004cc0:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004cc2:	00479713          	slli	a4,a5,0x4
    80004cc6:	02070713          	addi	a4,a4,32 # 10001020 <_entry-0x6fffefe0>
    80004cca:	9726                	add	a4,a4,s1
    80004ccc:	01074703          	lbu	a4,16(a4)
    80004cd0:	e329                	bnez	a4,80004d12 <virtio_disk_intr+0xa0>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004cd2:	0792                	slli	a5,a5,0x4
    80004cd4:	02078793          	addi	a5,a5,32
    80004cd8:	97a6                	add	a5,a5,s1
    80004cda:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004cdc:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004ce0:	ec8fc0ef          	jal	800013a8 <wakeup>

    disk.used_idx += 1;
    80004ce4:	0204d783          	lhu	a5,32(s1)
    80004ce8:	2785                	addiw	a5,a5,1
    80004cea:	17c2                	slli	a5,a5,0x30
    80004cec:	93c1                	srli	a5,a5,0x30
    80004cee:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004cf2:	6898                	ld	a4,16(s1)
    80004cf4:	00275703          	lhu	a4,2(a4)
    80004cf8:	faf71ce3          	bne	a4,a5,80004cb0 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004cfc:	00017517          	auipc	a0,0x17
    80004d00:	90c50513          	addi	a0,a0,-1780 # 8001b608 <disk+0x128>
    80004d04:	3ad000ef          	jal	800058b0 <release>
}
    80004d08:	60e2                	ld	ra,24(sp)
    80004d0a:	6442                	ld	s0,16(sp)
    80004d0c:	64a2                	ld	s1,8(sp)
    80004d0e:	6105                	addi	sp,sp,32
    80004d10:	8082                	ret
      panic("virtio_disk_intr status");
    80004d12:	00003517          	auipc	a0,0x3
    80004d16:	a8e50513          	addi	a0,a0,-1394 # 800077a0 <etext+0x7a0>
    80004d1a:	7c4000ef          	jal	800054de <panic>

0000000080004d1e <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80004d1e:	1141                	addi	sp,sp,-16
    80004d20:	e406                	sd	ra,8(sp)
    80004d22:	e022                	sd	s0,0(sp)
    80004d24:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    80004d26:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80004d2a:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80004d2e:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80004d32:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80004d36:	577d                	li	a4,-1
    80004d38:	177e                	slli	a4,a4,0x3f
    80004d3a:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80004d3c:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80004d40:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80004d44:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80004d48:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80004d4c:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80004d50:	000f4737          	lui	a4,0xf4
    80004d54:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80004d58:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80004d5a:	14d79073          	csrw	stimecmp,a5
}
    80004d5e:	60a2                	ld	ra,8(sp)
    80004d60:	6402                	ld	s0,0(sp)
    80004d62:	0141                	addi	sp,sp,16
    80004d64:	8082                	ret

0000000080004d66 <start>:
{
    80004d66:	1141                	addi	sp,sp,-16
    80004d68:	e406                	sd	ra,8(sp)
    80004d6a:	e022                	sd	s0,0(sp)
    80004d6c:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80004d6e:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80004d72:	7779                	lui	a4,0xffffe
    80004d74:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdb0df>
    80004d78:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80004d7a:	6705                	lui	a4,0x1
    80004d7c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004d80:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80004d82:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80004d86:	ffffb797          	auipc	a5,0xffffb
    80004d8a:	58e78793          	addi	a5,a5,1422 # 80000314 <main>
    80004d8e:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80004d92:	4781                	li	a5,0
    80004d94:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80004d98:	67c1                	lui	a5,0x10
    80004d9a:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004d9c:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80004da0:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80004da4:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80004da8:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80004dac:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80004db0:	57fd                	li	a5,-1
    80004db2:	83a9                	srli	a5,a5,0xa
    80004db4:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80004db8:	47bd                	li	a5,15
    80004dba:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80004dbe:	f61ff0ef          	jal	80004d1e <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80004dc2:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80004dc6:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80004dc8:	823e                	mv	tp,a5
  asm volatile("mret");
    80004dca:	30200073          	mret
}
    80004dce:	60a2                	ld	ra,8(sp)
    80004dd0:	6402                	ld	s0,0(sp)
    80004dd2:	0141                	addi	sp,sp,16
    80004dd4:	8082                	ret

0000000080004dd6 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80004dd6:	711d                	addi	sp,sp,-96
    80004dd8:	ec86                	sd	ra,88(sp)
    80004dda:	e8a2                	sd	s0,80(sp)
    80004ddc:	e0ca                	sd	s2,64(sp)
    80004dde:	1080                	addi	s0,sp,96
  int i;

  for(i = 0; i < n; i++){
    80004de0:	04c05763          	blez	a2,80004e2e <consolewrite+0x58>
    80004de4:	e4a6                	sd	s1,72(sp)
    80004de6:	fc4e                	sd	s3,56(sp)
    80004de8:	f852                	sd	s4,48(sp)
    80004dea:	f456                	sd	s5,40(sp)
    80004dec:	f05a                	sd	s6,32(sp)
    80004dee:	ec5e                	sd	s7,24(sp)
    80004df0:	8a2a                	mv	s4,a0
    80004df2:	84ae                	mv	s1,a1
    80004df4:	89b2                	mv	s3,a2
    80004df6:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80004df8:	faf40b93          	addi	s7,s0,-81
    80004dfc:	4b05                	li	s6,1
    80004dfe:	5afd                	li	s5,-1
    80004e00:	86da                	mv	a3,s6
    80004e02:	8626                	mv	a2,s1
    80004e04:	85d2                	mv	a1,s4
    80004e06:	855e                	mv	a0,s7
    80004e08:	8f9fc0ef          	jal	80001700 <either_copyin>
    80004e0c:	03550363          	beq	a0,s5,80004e32 <consolewrite+0x5c>
      break;
    uartputc(c);
    80004e10:	faf44503          	lbu	a0,-81(s0)
    80004e14:	06b000ef          	jal	8000567e <uartputc>
  for(i = 0; i < n; i++){
    80004e18:	2905                	addiw	s2,s2,1
    80004e1a:	0485                	addi	s1,s1,1
    80004e1c:	ff2992e3          	bne	s3,s2,80004e00 <consolewrite+0x2a>
    80004e20:	64a6                	ld	s1,72(sp)
    80004e22:	79e2                	ld	s3,56(sp)
    80004e24:	7a42                	ld	s4,48(sp)
    80004e26:	7aa2                	ld	s5,40(sp)
    80004e28:	7b02                	ld	s6,32(sp)
    80004e2a:	6be2                	ld	s7,24(sp)
    80004e2c:	a809                	j	80004e3e <consolewrite+0x68>
    80004e2e:	4901                	li	s2,0
    80004e30:	a039                	j	80004e3e <consolewrite+0x68>
    80004e32:	64a6                	ld	s1,72(sp)
    80004e34:	79e2                	ld	s3,56(sp)
    80004e36:	7a42                	ld	s4,48(sp)
    80004e38:	7aa2                	ld	s5,40(sp)
    80004e3a:	7b02                	ld	s6,32(sp)
    80004e3c:	6be2                	ld	s7,24(sp)
  }

  return i;
}
    80004e3e:	854a                	mv	a0,s2
    80004e40:	60e6                	ld	ra,88(sp)
    80004e42:	6446                	ld	s0,80(sp)
    80004e44:	6906                	ld	s2,64(sp)
    80004e46:	6125                	addi	sp,sp,96
    80004e48:	8082                	ret

0000000080004e4a <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80004e4a:	711d                	addi	sp,sp,-96
    80004e4c:	ec86                	sd	ra,88(sp)
    80004e4e:	e8a2                	sd	s0,80(sp)
    80004e50:	e4a6                	sd	s1,72(sp)
    80004e52:	e0ca                	sd	s2,64(sp)
    80004e54:	fc4e                	sd	s3,56(sp)
    80004e56:	f852                	sd	s4,48(sp)
    80004e58:	f05a                	sd	s6,32(sp)
    80004e5a:	ec5e                	sd	s7,24(sp)
    80004e5c:	1080                	addi	s0,sp,96
    80004e5e:	8b2a                	mv	s6,a0
    80004e60:	8a2e                	mv	s4,a1
    80004e62:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80004e64:	8bb2                	mv	s7,a2
  acquire(&cons.lock);
    80004e66:	0001e517          	auipc	a0,0x1e
    80004e6a:	7ba50513          	addi	a0,a0,1978 # 80023620 <cons>
    80004e6e:	1af000ef          	jal	8000581c <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80004e72:	0001e497          	auipc	s1,0x1e
    80004e76:	7ae48493          	addi	s1,s1,1966 # 80023620 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80004e7a:	0001f917          	auipc	s2,0x1f
    80004e7e:	83e90913          	addi	s2,s2,-1986 # 800236b8 <cons+0x98>
  while(n > 0){
    80004e82:	0b305b63          	blez	s3,80004f38 <consoleread+0xee>
    while(cons.r == cons.w){
    80004e86:	0984a783          	lw	a5,152(s1)
    80004e8a:	09c4a703          	lw	a4,156(s1)
    80004e8e:	0af71063          	bne	a4,a5,80004f2e <consoleread+0xe4>
      if(killed(myproc())){
    80004e92:	ef1fb0ef          	jal	80000d82 <myproc>
    80004e96:	f02fc0ef          	jal	80001598 <killed>
    80004e9a:	e12d                	bnez	a0,80004efc <consoleread+0xb2>
      sleep(&cons.r, &cons.lock);
    80004e9c:	85a6                	mv	a1,s1
    80004e9e:	854a                	mv	a0,s2
    80004ea0:	cbcfc0ef          	jal	8000135c <sleep>
    while(cons.r == cons.w){
    80004ea4:	0984a783          	lw	a5,152(s1)
    80004ea8:	09c4a703          	lw	a4,156(s1)
    80004eac:	fef703e3          	beq	a4,a5,80004e92 <consoleread+0x48>
    80004eb0:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80004eb2:	0001e717          	auipc	a4,0x1e
    80004eb6:	76e70713          	addi	a4,a4,1902 # 80023620 <cons>
    80004eba:	0017869b          	addiw	a3,a5,1
    80004ebe:	08d72c23          	sw	a3,152(a4)
    80004ec2:	07f7f693          	andi	a3,a5,127
    80004ec6:	9736                	add	a4,a4,a3
    80004ec8:	01874703          	lbu	a4,24(a4)
    80004ecc:	00070a9b          	sext.w	s5,a4

    if(c == C('D')){  // end-of-file
    80004ed0:	4691                	li	a3,4
    80004ed2:	04da8663          	beq	s5,a3,80004f1e <consoleread+0xd4>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80004ed6:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80004eda:	4685                	li	a3,1
    80004edc:	faf40613          	addi	a2,s0,-81
    80004ee0:	85d2                	mv	a1,s4
    80004ee2:	855a                	mv	a0,s6
    80004ee4:	fd2fc0ef          	jal	800016b6 <either_copyout>
    80004ee8:	57fd                	li	a5,-1
    80004eea:	04f50663          	beq	a0,a5,80004f36 <consoleread+0xec>
      break;

    dst++;
    80004eee:	0a05                	addi	s4,s4,1
    --n;
    80004ef0:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80004ef2:	47a9                	li	a5,10
    80004ef4:	04fa8b63          	beq	s5,a5,80004f4a <consoleread+0x100>
    80004ef8:	7aa2                	ld	s5,40(sp)
    80004efa:	b761                	j	80004e82 <consoleread+0x38>
        release(&cons.lock);
    80004efc:	0001e517          	auipc	a0,0x1e
    80004f00:	72450513          	addi	a0,a0,1828 # 80023620 <cons>
    80004f04:	1ad000ef          	jal	800058b0 <release>
        return -1;
    80004f08:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80004f0a:	60e6                	ld	ra,88(sp)
    80004f0c:	6446                	ld	s0,80(sp)
    80004f0e:	64a6                	ld	s1,72(sp)
    80004f10:	6906                	ld	s2,64(sp)
    80004f12:	79e2                	ld	s3,56(sp)
    80004f14:	7a42                	ld	s4,48(sp)
    80004f16:	7b02                	ld	s6,32(sp)
    80004f18:	6be2                	ld	s7,24(sp)
    80004f1a:	6125                	addi	sp,sp,96
    80004f1c:	8082                	ret
      if(n < target){
    80004f1e:	0179fa63          	bgeu	s3,s7,80004f32 <consoleread+0xe8>
        cons.r--;
    80004f22:	0001e717          	auipc	a4,0x1e
    80004f26:	78f72b23          	sw	a5,1942(a4) # 800236b8 <cons+0x98>
    80004f2a:	7aa2                	ld	s5,40(sp)
    80004f2c:	a031                	j	80004f38 <consoleread+0xee>
    80004f2e:	f456                	sd	s5,40(sp)
    80004f30:	b749                	j	80004eb2 <consoleread+0x68>
    80004f32:	7aa2                	ld	s5,40(sp)
    80004f34:	a011                	j	80004f38 <consoleread+0xee>
    80004f36:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    80004f38:	0001e517          	auipc	a0,0x1e
    80004f3c:	6e850513          	addi	a0,a0,1768 # 80023620 <cons>
    80004f40:	171000ef          	jal	800058b0 <release>
  return target - n;
    80004f44:	413b853b          	subw	a0,s7,s3
    80004f48:	b7c9                	j	80004f0a <consoleread+0xc0>
    80004f4a:	7aa2                	ld	s5,40(sp)
    80004f4c:	b7f5                	j	80004f38 <consoleread+0xee>

0000000080004f4e <consputc>:
{
    80004f4e:	1141                	addi	sp,sp,-16
    80004f50:	e406                	sd	ra,8(sp)
    80004f52:	e022                	sd	s0,0(sp)
    80004f54:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80004f56:	10000793          	li	a5,256
    80004f5a:	00f50863          	beq	a0,a5,80004f6a <consputc+0x1c>
    uartputc_sync(c);
    80004f5e:	63e000ef          	jal	8000559c <uartputc_sync>
}
    80004f62:	60a2                	ld	ra,8(sp)
    80004f64:	6402                	ld	s0,0(sp)
    80004f66:	0141                	addi	sp,sp,16
    80004f68:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80004f6a:	4521                	li	a0,8
    80004f6c:	630000ef          	jal	8000559c <uartputc_sync>
    80004f70:	02000513          	li	a0,32
    80004f74:	628000ef          	jal	8000559c <uartputc_sync>
    80004f78:	4521                	li	a0,8
    80004f7a:	622000ef          	jal	8000559c <uartputc_sync>
    80004f7e:	b7d5                	j	80004f62 <consputc+0x14>

0000000080004f80 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80004f80:	1101                	addi	sp,sp,-32
    80004f82:	ec06                	sd	ra,24(sp)
    80004f84:	e822                	sd	s0,16(sp)
    80004f86:	e426                	sd	s1,8(sp)
    80004f88:	1000                	addi	s0,sp,32
    80004f8a:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80004f8c:	0001e517          	auipc	a0,0x1e
    80004f90:	69450513          	addi	a0,a0,1684 # 80023620 <cons>
    80004f94:	089000ef          	jal	8000581c <acquire>

  switch(c){
    80004f98:	47d5                	li	a5,21
    80004f9a:	08f48d63          	beq	s1,a5,80005034 <consoleintr+0xb4>
    80004f9e:	0297c563          	blt	a5,s1,80004fc8 <consoleintr+0x48>
    80004fa2:	47a1                	li	a5,8
    80004fa4:	0ef48263          	beq	s1,a5,80005088 <consoleintr+0x108>
    80004fa8:	47c1                	li	a5,16
    80004faa:	10f49363          	bne	s1,a5,800050b0 <consoleintr+0x130>
  case C('P'):  // Print process list.
    procdump();
    80004fae:	f9cfc0ef          	jal	8000174a <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80004fb2:	0001e517          	auipc	a0,0x1e
    80004fb6:	66e50513          	addi	a0,a0,1646 # 80023620 <cons>
    80004fba:	0f7000ef          	jal	800058b0 <release>
}
    80004fbe:	60e2                	ld	ra,24(sp)
    80004fc0:	6442                	ld	s0,16(sp)
    80004fc2:	64a2                	ld	s1,8(sp)
    80004fc4:	6105                	addi	sp,sp,32
    80004fc6:	8082                	ret
  switch(c){
    80004fc8:	07f00793          	li	a5,127
    80004fcc:	0af48e63          	beq	s1,a5,80005088 <consoleintr+0x108>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80004fd0:	0001e717          	auipc	a4,0x1e
    80004fd4:	65070713          	addi	a4,a4,1616 # 80023620 <cons>
    80004fd8:	0a072783          	lw	a5,160(a4)
    80004fdc:	09872703          	lw	a4,152(a4)
    80004fe0:	9f99                	subw	a5,a5,a4
    80004fe2:	07f00713          	li	a4,127
    80004fe6:	fcf766e3          	bltu	a4,a5,80004fb2 <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    80004fea:	47b5                	li	a5,13
    80004fec:	0cf48563          	beq	s1,a5,800050b6 <consoleintr+0x136>
      consputc(c);
    80004ff0:	8526                	mv	a0,s1
    80004ff2:	f5dff0ef          	jal	80004f4e <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80004ff6:	0001e717          	auipc	a4,0x1e
    80004ffa:	62a70713          	addi	a4,a4,1578 # 80023620 <cons>
    80004ffe:	0a072683          	lw	a3,160(a4)
    80005002:	0016879b          	addiw	a5,a3,1
    80005006:	863e                	mv	a2,a5
    80005008:	0af72023          	sw	a5,160(a4)
    8000500c:	07f6f693          	andi	a3,a3,127
    80005010:	9736                	add	a4,a4,a3
    80005012:	00970c23          	sb	s1,24(a4)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005016:	ff648713          	addi	a4,s1,-10
    8000501a:	c371                	beqz	a4,800050de <consoleintr+0x15e>
    8000501c:	14f1                	addi	s1,s1,-4
    8000501e:	c0e1                	beqz	s1,800050de <consoleintr+0x15e>
    80005020:	0001e717          	auipc	a4,0x1e
    80005024:	69872703          	lw	a4,1688(a4) # 800236b8 <cons+0x98>
    80005028:	9f99                	subw	a5,a5,a4
    8000502a:	08000713          	li	a4,128
    8000502e:	f8e792e3          	bne	a5,a4,80004fb2 <consoleintr+0x32>
    80005032:	a075                	j	800050de <consoleintr+0x15e>
    80005034:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005036:	0001e717          	auipc	a4,0x1e
    8000503a:	5ea70713          	addi	a4,a4,1514 # 80023620 <cons>
    8000503e:	0a072783          	lw	a5,160(a4)
    80005042:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005046:	0001e497          	auipc	s1,0x1e
    8000504a:	5da48493          	addi	s1,s1,1498 # 80023620 <cons>
    while(cons.e != cons.w &&
    8000504e:	4929                	li	s2,10
    80005050:	02f70863          	beq	a4,a5,80005080 <consoleintr+0x100>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005054:	37fd                	addiw	a5,a5,-1
    80005056:	07f7f713          	andi	a4,a5,127
    8000505a:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    8000505c:	01874703          	lbu	a4,24(a4)
    80005060:	03270263          	beq	a4,s2,80005084 <consoleintr+0x104>
      cons.e--;
    80005064:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005068:	10000513          	li	a0,256
    8000506c:	ee3ff0ef          	jal	80004f4e <consputc>
    while(cons.e != cons.w &&
    80005070:	0a04a783          	lw	a5,160(s1)
    80005074:	09c4a703          	lw	a4,156(s1)
    80005078:	fcf71ee3          	bne	a4,a5,80005054 <consoleintr+0xd4>
    8000507c:	6902                	ld	s2,0(sp)
    8000507e:	bf15                	j	80004fb2 <consoleintr+0x32>
    80005080:	6902                	ld	s2,0(sp)
    80005082:	bf05                	j	80004fb2 <consoleintr+0x32>
    80005084:	6902                	ld	s2,0(sp)
    80005086:	b735                	j	80004fb2 <consoleintr+0x32>
    if(cons.e != cons.w){
    80005088:	0001e717          	auipc	a4,0x1e
    8000508c:	59870713          	addi	a4,a4,1432 # 80023620 <cons>
    80005090:	0a072783          	lw	a5,160(a4)
    80005094:	09c72703          	lw	a4,156(a4)
    80005098:	f0f70de3          	beq	a4,a5,80004fb2 <consoleintr+0x32>
      cons.e--;
    8000509c:	37fd                	addiw	a5,a5,-1
    8000509e:	0001e717          	auipc	a4,0x1e
    800050a2:	62f72123          	sw	a5,1570(a4) # 800236c0 <cons+0xa0>
      consputc(BACKSPACE);
    800050a6:	10000513          	li	a0,256
    800050aa:	ea5ff0ef          	jal	80004f4e <consputc>
    800050ae:	b711                	j	80004fb2 <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800050b0:	f00481e3          	beqz	s1,80004fb2 <consoleintr+0x32>
    800050b4:	bf31                	j	80004fd0 <consoleintr+0x50>
      consputc(c);
    800050b6:	4529                	li	a0,10
    800050b8:	e97ff0ef          	jal	80004f4e <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800050bc:	0001e797          	auipc	a5,0x1e
    800050c0:	56478793          	addi	a5,a5,1380 # 80023620 <cons>
    800050c4:	0a07a703          	lw	a4,160(a5)
    800050c8:	0017069b          	addiw	a3,a4,1
    800050cc:	8636                	mv	a2,a3
    800050ce:	0ad7a023          	sw	a3,160(a5)
    800050d2:	07f77713          	andi	a4,a4,127
    800050d6:	97ba                	add	a5,a5,a4
    800050d8:	4729                	li	a4,10
    800050da:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    800050de:	0001e797          	auipc	a5,0x1e
    800050e2:	5cc7af23          	sw	a2,1502(a5) # 800236bc <cons+0x9c>
        wakeup(&cons.r);
    800050e6:	0001e517          	auipc	a0,0x1e
    800050ea:	5d250513          	addi	a0,a0,1490 # 800236b8 <cons+0x98>
    800050ee:	abafc0ef          	jal	800013a8 <wakeup>
    800050f2:	b5c1                	j	80004fb2 <consoleintr+0x32>

00000000800050f4 <consoleinit>:

void
consoleinit(void)
{
    800050f4:	1141                	addi	sp,sp,-16
    800050f6:	e406                	sd	ra,8(sp)
    800050f8:	e022                	sd	s0,0(sp)
    800050fa:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    800050fc:	00002597          	auipc	a1,0x2
    80005100:	6bc58593          	addi	a1,a1,1724 # 800077b8 <etext+0x7b8>
    80005104:	0001e517          	auipc	a0,0x1e
    80005108:	51c50513          	addi	a0,a0,1308 # 80023620 <cons>
    8000510c:	686000ef          	jal	80005792 <initlock>

  uartinit();
    80005110:	436000ef          	jal	80005546 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005114:	00015797          	auipc	a5,0x15
    80005118:	37478793          	addi	a5,a5,884 # 8001a488 <devsw>
    8000511c:	00000717          	auipc	a4,0x0
    80005120:	d2e70713          	addi	a4,a4,-722 # 80004e4a <consoleread>
    80005124:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005126:	00000717          	auipc	a4,0x0
    8000512a:	cb070713          	addi	a4,a4,-848 # 80004dd6 <consolewrite>
    8000512e:	ef98                	sd	a4,24(a5)
}
    80005130:	60a2                	ld	ra,8(sp)
    80005132:	6402                	ld	s0,0(sp)
    80005134:	0141                	addi	sp,sp,16
    80005136:	8082                	ret

0000000080005138 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80005138:	7179                	addi	sp,sp,-48
    8000513a:	f406                	sd	ra,40(sp)
    8000513c:	f022                	sd	s0,32(sp)
    8000513e:	e84a                	sd	s2,16(sp)
    80005140:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    80005142:	c219                	beqz	a2,80005148 <printint+0x10>
    80005144:	08054163          	bltz	a0,800051c6 <printint+0x8e>
    x = -xx;
  else
    x = xx;
    80005148:	4301                	li	t1,0

  i = 0;
    8000514a:	fd040913          	addi	s2,s0,-48
    x = xx;
    8000514e:	86ca                	mv	a3,s2
  i = 0;
    80005150:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005152:	00003817          	auipc	a6,0x3
    80005156:	87e80813          	addi	a6,a6,-1922 # 800079d0 <digits>
    8000515a:	88ba                	mv	a7,a4
    8000515c:	0017061b          	addiw	a2,a4,1
    80005160:	8732                	mv	a4,a2
    80005162:	02b577b3          	remu	a5,a0,a1
    80005166:	97c2                	add	a5,a5,a6
    80005168:	0007c783          	lbu	a5,0(a5)
    8000516c:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005170:	87aa                	mv	a5,a0
    80005172:	02b55533          	divu	a0,a0,a1
    80005176:	0685                	addi	a3,a3,1
    80005178:	feb7f1e3          	bgeu	a5,a1,8000515a <printint+0x22>

  if(sign)
    8000517c:	00030c63          	beqz	t1,80005194 <printint+0x5c>
    buf[i++] = '-';
    80005180:	fe060793          	addi	a5,a2,-32
    80005184:	00878633          	add	a2,a5,s0
    80005188:	02d00793          	li	a5,45
    8000518c:	fef60823          	sb	a5,-16(a2)
    80005190:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    80005194:	02e05463          	blez	a4,800051bc <printint+0x84>
    80005198:	ec26                	sd	s1,24(sp)
    8000519a:	377d                	addiw	a4,a4,-1
    8000519c:	00e904b3          	add	s1,s2,a4
    800051a0:	197d                	addi	s2,s2,-1
    800051a2:	993a                	add	s2,s2,a4
    800051a4:	1702                	slli	a4,a4,0x20
    800051a6:	9301                	srli	a4,a4,0x20
    800051a8:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800051ac:	0004c503          	lbu	a0,0(s1)
    800051b0:	d9fff0ef          	jal	80004f4e <consputc>
  while(--i >= 0)
    800051b4:	14fd                	addi	s1,s1,-1
    800051b6:	ff249be3          	bne	s1,s2,800051ac <printint+0x74>
    800051ba:	64e2                	ld	s1,24(sp)
}
    800051bc:	70a2                	ld	ra,40(sp)
    800051be:	7402                	ld	s0,32(sp)
    800051c0:	6942                	ld	s2,16(sp)
    800051c2:	6145                	addi	sp,sp,48
    800051c4:	8082                	ret
    x = -xx;
    800051c6:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    800051ca:	4305                	li	t1,1
    x = -xx;
    800051cc:	bfbd                	j	8000514a <printint+0x12>

00000000800051ce <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    800051ce:	7131                	addi	sp,sp,-192
    800051d0:	fc86                	sd	ra,120(sp)
    800051d2:	f8a2                	sd	s0,112(sp)
    800051d4:	f0ca                	sd	s2,96(sp)
    800051d6:	ec6e                	sd	s11,24(sp)
    800051d8:	0100                	addi	s0,sp,128
    800051da:	892a                	mv	s2,a0
    800051dc:	e40c                	sd	a1,8(s0)
    800051de:	e810                	sd	a2,16(s0)
    800051e0:	ec14                	sd	a3,24(s0)
    800051e2:	f018                	sd	a4,32(s0)
    800051e4:	f41c                	sd	a5,40(s0)
    800051e6:	03043823          	sd	a6,48(s0)
    800051ea:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2, locking;
  char *s;

  locking = pr.locking;
    800051ee:	0001ed97          	auipc	s11,0x1e
    800051f2:	4f2dad83          	lw	s11,1266(s11) # 800236e0 <pr+0x18>
  if(locking)
    800051f6:	020d9d63          	bnez	s11,80005230 <printf+0x62>
    acquire(&pr.lock);

  va_start(ap, fmt);
    800051fa:	00840793          	addi	a5,s0,8
    800051fe:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005202:	00054503          	lbu	a0,0(a0)
    80005206:	20050f63          	beqz	a0,80005424 <printf+0x256>
    8000520a:	f4a6                	sd	s1,104(sp)
    8000520c:	ecce                	sd	s3,88(sp)
    8000520e:	e8d2                	sd	s4,80(sp)
    80005210:	e4d6                	sd	s5,72(sp)
    80005212:	e0da                	sd	s6,64(sp)
    80005214:	fc5e                	sd	s7,56(sp)
    80005216:	f862                	sd	s8,48(sp)
    80005218:	f06a                	sd	s10,32(sp)
    8000521a:	4a81                	li	s5,0
    if(cx != '%'){
    8000521c:	02500993          	li	s3,37
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    80005220:	07500c13          	li	s8,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    80005224:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 10, 0);
    80005228:	4b29                	li	s6,10
    if(c0 == 'd'){
    8000522a:	06400b93          	li	s7,100
    8000522e:	a80d                	j	80005260 <printf+0x92>
    acquire(&pr.lock);
    80005230:	0001e517          	auipc	a0,0x1e
    80005234:	49850513          	addi	a0,a0,1176 # 800236c8 <pr>
    80005238:	5e4000ef          	jal	8000581c <acquire>
  va_start(ap, fmt);
    8000523c:	00840793          	addi	a5,s0,8
    80005240:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005244:	00094503          	lbu	a0,0(s2)
    80005248:	f169                	bnez	a0,8000520a <printf+0x3c>
    8000524a:	aae5                	j	80005442 <printf+0x274>
      consputc(cx);
    8000524c:	d03ff0ef          	jal	80004f4e <consputc>
      continue;
    80005250:	84d6                	mv	s1,s5
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80005252:	2485                	addiw	s1,s1,1
    80005254:	8aa6                	mv	s5,s1
    80005256:	94ca                	add	s1,s1,s2
    80005258:	0004c503          	lbu	a0,0(s1)
    8000525c:	1a050a63          	beqz	a0,80005410 <printf+0x242>
    if(cx != '%'){
    80005260:	ff3516e3          	bne	a0,s3,8000524c <printf+0x7e>
    i++;
    80005264:	001a879b          	addiw	a5,s5,1
    80005268:	84be                	mv	s1,a5
    c0 = fmt[i+0] & 0xff;
    8000526a:	00f90733          	add	a4,s2,a5
    8000526e:	00074a03          	lbu	s4,0(a4)
    if(c0) c1 = fmt[i+1] & 0xff;
    80005272:	1e0a0863          	beqz	s4,80005462 <printf+0x294>
    80005276:	00174683          	lbu	a3,1(a4)
    if(c1) c2 = fmt[i+2] & 0xff;
    8000527a:	1c068b63          	beqz	a3,80005450 <printf+0x282>
    if(c0 == 'd'){
    8000527e:	037a0863          	beq	s4,s7,800052ae <printf+0xe0>
    } else if(c0 == 'l' && c1 == 'd'){
    80005282:	f94a0713          	addi	a4,s4,-108
    80005286:	00173713          	seqz	a4,a4
    8000528a:	f9c68613          	addi	a2,a3,-100
    8000528e:	ee05                	bnez	a2,800052c6 <printf+0xf8>
    80005290:	cb1d                	beqz	a4,800052c6 <printf+0xf8>
      printint(va_arg(ap, uint64), 10, 1);
    80005292:	f8843783          	ld	a5,-120(s0)
    80005296:	00878713          	addi	a4,a5,8
    8000529a:	f8e43423          	sd	a4,-120(s0)
    8000529e:	4605                	li	a2,1
    800052a0:	85da                	mv	a1,s6
    800052a2:	6388                	ld	a0,0(a5)
    800052a4:	e95ff0ef          	jal	80005138 <printint>
      i += 1;
    800052a8:	002a849b          	addiw	s1,s5,2
    800052ac:	b75d                	j	80005252 <printf+0x84>
      printint(va_arg(ap, int), 10, 1);
    800052ae:	f8843783          	ld	a5,-120(s0)
    800052b2:	00878713          	addi	a4,a5,8
    800052b6:	f8e43423          	sd	a4,-120(s0)
    800052ba:	4605                	li	a2,1
    800052bc:	85da                	mv	a1,s6
    800052be:	4388                	lw	a0,0(a5)
    800052c0:	e79ff0ef          	jal	80005138 <printint>
    800052c4:	b779                	j	80005252 <printf+0x84>
    if(c1) c2 = fmt[i+2] & 0xff;
    800052c6:	97ca                	add	a5,a5,s2
    800052c8:	8636                	mv	a2,a3
    800052ca:	0027c683          	lbu	a3,2(a5)
    800052ce:	a245                	j	8000546e <printf+0x2a0>
      printint(va_arg(ap, uint64), 10, 1);
    800052d0:	f8843783          	ld	a5,-120(s0)
    800052d4:	00878713          	addi	a4,a5,8
    800052d8:	f8e43423          	sd	a4,-120(s0)
    800052dc:	4605                	li	a2,1
    800052de:	45a9                	li	a1,10
    800052e0:	6388                	ld	a0,0(a5)
    800052e2:	e57ff0ef          	jal	80005138 <printint>
      i += 2;
    800052e6:	003a849b          	addiw	s1,s5,3
    800052ea:	b7a5                	j	80005252 <printf+0x84>
      printint(va_arg(ap, int), 10, 0);
    800052ec:	f8843783          	ld	a5,-120(s0)
    800052f0:	00878713          	addi	a4,a5,8
    800052f4:	f8e43423          	sd	a4,-120(s0)
    800052f8:	4601                	li	a2,0
    800052fa:	85da                	mv	a1,s6
    800052fc:	4388                	lw	a0,0(a5)
    800052fe:	e3bff0ef          	jal	80005138 <printint>
    80005302:	bf81                	j	80005252 <printf+0x84>
      printint(va_arg(ap, uint64), 10, 0);
    80005304:	f8843783          	ld	a5,-120(s0)
    80005308:	00878713          	addi	a4,a5,8
    8000530c:	f8e43423          	sd	a4,-120(s0)
    80005310:	4601                	li	a2,0
    80005312:	85da                	mv	a1,s6
    80005314:	6388                	ld	a0,0(a5)
    80005316:	e23ff0ef          	jal	80005138 <printint>
      i += 1;
    8000531a:	002a849b          	addiw	s1,s5,2
    8000531e:	bf15                	j	80005252 <printf+0x84>
      printint(va_arg(ap, uint64), 10, 0);
    80005320:	f8843783          	ld	a5,-120(s0)
    80005324:	00878713          	addi	a4,a5,8
    80005328:	f8e43423          	sd	a4,-120(s0)
    8000532c:	4601                	li	a2,0
    8000532e:	45a9                	li	a1,10
    80005330:	6388                	ld	a0,0(a5)
    80005332:	e07ff0ef          	jal	80005138 <printint>
      i += 2;
    80005336:	003a849b          	addiw	s1,s5,3
    8000533a:	bf21                	j	80005252 <printf+0x84>
      printint(va_arg(ap, int), 16, 0);
    8000533c:	f8843783          	ld	a5,-120(s0)
    80005340:	00878713          	addi	a4,a5,8
    80005344:	f8e43423          	sd	a4,-120(s0)
    80005348:	4601                	li	a2,0
    8000534a:	45c1                	li	a1,16
    8000534c:	4388                	lw	a0,0(a5)
    8000534e:	debff0ef          	jal	80005138 <printint>
    80005352:	b701                	j	80005252 <printf+0x84>
    } else if(c0 == 'l' && c1 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
    80005354:	f8843783          	ld	a5,-120(s0)
    80005358:	00878713          	addi	a4,a5,8
    8000535c:	f8e43423          	sd	a4,-120(s0)
    80005360:	45c1                	li	a1,16
    80005362:	6388                	ld	a0,0(a5)
    80005364:	dd5ff0ef          	jal	80005138 <printint>
      i += 1;
    80005368:	002a849b          	addiw	s1,s5,2
    8000536c:	b5dd                	j	80005252 <printf+0x84>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
    8000536e:	f8843783          	ld	a5,-120(s0)
    80005372:	00878713          	addi	a4,a5,8
    80005376:	f8e43423          	sd	a4,-120(s0)
    8000537a:	4601                	li	a2,0
    8000537c:	45c1                	li	a1,16
    8000537e:	6388                	ld	a0,0(a5)
    80005380:	db9ff0ef          	jal	80005138 <printint>
      i += 2;
    80005384:	003a849b          	addiw	s1,s5,3
    80005388:	b5e9                	j	80005252 <printf+0x84>
    8000538a:	f466                	sd	s9,40(sp)
    } else if(c0 == 'p'){
      printptr(va_arg(ap, uint64));
    8000538c:	f8843783          	ld	a5,-120(s0)
    80005390:	00878713          	addi	a4,a5,8
    80005394:	f8e43423          	sd	a4,-120(s0)
    80005398:	0007ba83          	ld	s5,0(a5)
  consputc('0');
    8000539c:	03000513          	li	a0,48
    800053a0:	bafff0ef          	jal	80004f4e <consputc>
  consputc('x');
    800053a4:	07800513          	li	a0,120
    800053a8:	ba7ff0ef          	jal	80004f4e <consputc>
    800053ac:	4a41                	li	s4,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800053ae:	00002c97          	auipc	s9,0x2
    800053b2:	622c8c93          	addi	s9,s9,1570 # 800079d0 <digits>
    800053b6:	03cad793          	srli	a5,s5,0x3c
    800053ba:	97e6                	add	a5,a5,s9
    800053bc:	0007c503          	lbu	a0,0(a5)
    800053c0:	b8fff0ef          	jal	80004f4e <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800053c4:	0a92                	slli	s5,s5,0x4
    800053c6:	3a7d                	addiw	s4,s4,-1
    800053c8:	fe0a17e3          	bnez	s4,800053b6 <printf+0x1e8>
    800053cc:	7ca2                	ld	s9,40(sp)
    800053ce:	b551                	j	80005252 <printf+0x84>
    } else if(c0 == 's'){
      if((s = va_arg(ap, char*)) == 0)
    800053d0:	f8843783          	ld	a5,-120(s0)
    800053d4:	00878713          	addi	a4,a5,8
    800053d8:	f8e43423          	sd	a4,-120(s0)
    800053dc:	0007ba03          	ld	s4,0(a5)
    800053e0:	000a0d63          	beqz	s4,800053fa <printf+0x22c>
        s = "(null)";
      for(; *s; s++)
    800053e4:	000a4503          	lbu	a0,0(s4)
    800053e8:	e60505e3          	beqz	a0,80005252 <printf+0x84>
        consputc(*s);
    800053ec:	b63ff0ef          	jal	80004f4e <consputc>
      for(; *s; s++)
    800053f0:	0a05                	addi	s4,s4,1
    800053f2:	000a4503          	lbu	a0,0(s4)
    800053f6:	f97d                	bnez	a0,800053ec <printf+0x21e>
    800053f8:	bda9                	j	80005252 <printf+0x84>
        s = "(null)";
    800053fa:	00002a17          	auipc	s4,0x2
    800053fe:	3c6a0a13          	addi	s4,s4,966 # 800077c0 <etext+0x7c0>
      for(; *s; s++)
    80005402:	02800513          	li	a0,40
    80005406:	b7dd                	j	800053ec <printf+0x21e>
    } else if(c0 == '%'){
      consputc('%');
    80005408:	8552                	mv	a0,s4
    8000540a:	b45ff0ef          	jal	80004f4e <consputc>
    8000540e:	b591                	j	80005252 <printf+0x84>
    }
#endif
  }
  va_end(ap);

  if(locking)
    80005410:	020d9163          	bnez	s11,80005432 <printf+0x264>
    80005414:	74a6                	ld	s1,104(sp)
    80005416:	69e6                	ld	s3,88(sp)
    80005418:	6a46                	ld	s4,80(sp)
    8000541a:	6aa6                	ld	s5,72(sp)
    8000541c:	6b06                	ld	s6,64(sp)
    8000541e:	7be2                	ld	s7,56(sp)
    80005420:	7c42                	ld	s8,48(sp)
    80005422:	7d02                	ld	s10,32(sp)
    release(&pr.lock);

  return 0;
}
    80005424:	4501                	li	a0,0
    80005426:	70e6                	ld	ra,120(sp)
    80005428:	7446                	ld	s0,112(sp)
    8000542a:	7906                	ld	s2,96(sp)
    8000542c:	6de2                	ld	s11,24(sp)
    8000542e:	6129                	addi	sp,sp,192
    80005430:	8082                	ret
    80005432:	74a6                	ld	s1,104(sp)
    80005434:	69e6                	ld	s3,88(sp)
    80005436:	6a46                	ld	s4,80(sp)
    80005438:	6aa6                	ld	s5,72(sp)
    8000543a:	6b06                	ld	s6,64(sp)
    8000543c:	7be2                	ld	s7,56(sp)
    8000543e:	7c42                	ld	s8,48(sp)
    80005440:	7d02                	ld	s10,32(sp)
    release(&pr.lock);
    80005442:	0001e517          	auipc	a0,0x1e
    80005446:	28650513          	addi	a0,a0,646 # 800236c8 <pr>
    8000544a:	466000ef          	jal	800058b0 <release>
    8000544e:	bfd9                	j	80005424 <printf+0x256>
    if(c0 == 'd'){
    80005450:	e57a0fe3          	beq	s4,s7,800052ae <printf+0xe0>
    } else if(c0 == 'l' && c1 == 'd'){
    80005454:	f94a0713          	addi	a4,s4,-108
    80005458:	00173713          	seqz	a4,a4
    8000545c:	8636                	mv	a2,a3
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000545e:	4781                	li	a5,0
    80005460:	a00d                	j	80005482 <printf+0x2b4>
    } else if(c0 == 'l' && c1 == 'd'){
    80005462:	f94a0713          	addi	a4,s4,-108
    80005466:	00173713          	seqz	a4,a4
    c1 = c2 = 0;
    8000546a:	8652                	mv	a2,s4
    8000546c:	86d2                	mv	a3,s4
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000546e:	f9460793          	addi	a5,a2,-108
    80005472:	0017b793          	seqz	a5,a5
    80005476:	8ff9                	and	a5,a5,a4
    80005478:	f9c68593          	addi	a1,a3,-100
    8000547c:	e199                	bnez	a1,80005482 <printf+0x2b4>
    8000547e:	e40799e3          	bnez	a5,800052d0 <printf+0x102>
    } else if(c0 == 'u'){
    80005482:	e78a05e3          	beq	s4,s8,800052ec <printf+0x11e>
    } else if(c0 == 'l' && c1 == 'u'){
    80005486:	f8b60593          	addi	a1,a2,-117
    8000548a:	e199                	bnez	a1,80005490 <printf+0x2c2>
    8000548c:	e6071ce3          	bnez	a4,80005304 <printf+0x136>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    80005490:	f8b68593          	addi	a1,a3,-117
    80005494:	e199                	bnez	a1,8000549a <printf+0x2cc>
    80005496:	e80795e3          	bnez	a5,80005320 <printf+0x152>
    } else if(c0 == 'x'){
    8000549a:	ebaa01e3          	beq	s4,s10,8000533c <printf+0x16e>
    } else if(c0 == 'l' && c1 == 'x'){
    8000549e:	f8860613          	addi	a2,a2,-120
    800054a2:	e219                	bnez	a2,800054a8 <printf+0x2da>
    800054a4:	ea0718e3          	bnez	a4,80005354 <printf+0x186>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    800054a8:	f8868693          	addi	a3,a3,-120
    800054ac:	e299                	bnez	a3,800054b2 <printf+0x2e4>
    800054ae:	ec0790e3          	bnez	a5,8000536e <printf+0x1a0>
    } else if(c0 == 'p'){
    800054b2:	07000793          	li	a5,112
    800054b6:	ecfa0ae3          	beq	s4,a5,8000538a <printf+0x1bc>
    } else if(c0 == 's'){
    800054ba:	07300793          	li	a5,115
    800054be:	f0fa09e3          	beq	s4,a5,800053d0 <printf+0x202>
    } else if(c0 == '%'){
    800054c2:	02500793          	li	a5,37
    800054c6:	f4fa01e3          	beq	s4,a5,80005408 <printf+0x23a>
    } else if(c0 == 0){
    800054ca:	f40a03e3          	beqz	s4,80005410 <printf+0x242>
      consputc('%');
    800054ce:	02500513          	li	a0,37
    800054d2:	a7dff0ef          	jal	80004f4e <consputc>
      consputc(c0);
    800054d6:	8552                	mv	a0,s4
    800054d8:	a77ff0ef          	jal	80004f4e <consputc>
    800054dc:	bb9d                	j	80005252 <printf+0x84>

00000000800054de <panic>:

void
panic(char *s)
{
    800054de:	1101                	addi	sp,sp,-32
    800054e0:	ec06                	sd	ra,24(sp)
    800054e2:	e822                	sd	s0,16(sp)
    800054e4:	e426                	sd	s1,8(sp)
    800054e6:	1000                	addi	s0,sp,32
    800054e8:	84aa                	mv	s1,a0
  pr.locking = 0;
    800054ea:	0001e797          	auipc	a5,0x1e
    800054ee:	1e07ab23          	sw	zero,502(a5) # 800236e0 <pr+0x18>
  printf("panic: ");
    800054f2:	00002517          	auipc	a0,0x2
    800054f6:	2d650513          	addi	a0,a0,726 # 800077c8 <etext+0x7c8>
    800054fa:	cd5ff0ef          	jal	800051ce <printf>
  printf("%s\n", s);
    800054fe:	85a6                	mv	a1,s1
    80005500:	00002517          	auipc	a0,0x2
    80005504:	2d050513          	addi	a0,a0,720 # 800077d0 <etext+0x7d0>
    80005508:	cc7ff0ef          	jal	800051ce <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000550c:	4785                	li	a5,1
    8000550e:	00005717          	auipc	a4,0x5
    80005512:	ecf72723          	sw	a5,-306(a4) # 8000a3dc <panicked>
  for(;;)
    80005516:	a001                	j	80005516 <panic+0x38>

0000000080005518 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005518:	1141                	addi	sp,sp,-16
    8000551a:	e406                	sd	ra,8(sp)
    8000551c:	e022                	sd	s0,0(sp)
    8000551e:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80005520:	00002597          	auipc	a1,0x2
    80005524:	2b858593          	addi	a1,a1,696 # 800077d8 <etext+0x7d8>
    80005528:	0001e517          	auipc	a0,0x1e
    8000552c:	1a050513          	addi	a0,a0,416 # 800236c8 <pr>
    80005530:	262000ef          	jal	80005792 <initlock>
  pr.locking = 1;
    80005534:	4785                	li	a5,1
    80005536:	0001e717          	auipc	a4,0x1e
    8000553a:	1af72523          	sw	a5,426(a4) # 800236e0 <pr+0x18>
}
    8000553e:	60a2                	ld	ra,8(sp)
    80005540:	6402                	ld	s0,0(sp)
    80005542:	0141                	addi	sp,sp,16
    80005544:	8082                	ret

0000000080005546 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005546:	1141                	addi	sp,sp,-16
    80005548:	e406                	sd	ra,8(sp)
    8000554a:	e022                	sd	s0,0(sp)
    8000554c:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000554e:	100007b7          	lui	a5,0x10000
    80005552:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005556:	10000737          	lui	a4,0x10000
    8000555a:	f8000693          	li	a3,-128
    8000555e:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005562:	468d                	li	a3,3
    80005564:	10000637          	lui	a2,0x10000
    80005568:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    8000556c:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005570:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005574:	8732                	mv	a4,a2
    80005576:	461d                	li	a2,7
    80005578:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000557c:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005580:	00002597          	auipc	a1,0x2
    80005584:	26058593          	addi	a1,a1,608 # 800077e0 <etext+0x7e0>
    80005588:	0001e517          	auipc	a0,0x1e
    8000558c:	16050513          	addi	a0,a0,352 # 800236e8 <uart_tx_lock>
    80005590:	202000ef          	jal	80005792 <initlock>
}
    80005594:	60a2                	ld	ra,8(sp)
    80005596:	6402                	ld	s0,0(sp)
    80005598:	0141                	addi	sp,sp,16
    8000559a:	8082                	ret

000000008000559c <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    8000559c:	1101                	addi	sp,sp,-32
    8000559e:	ec06                	sd	ra,24(sp)
    800055a0:	e822                	sd	s0,16(sp)
    800055a2:	e426                	sd	s1,8(sp)
    800055a4:	1000                	addi	s0,sp,32
    800055a6:	84aa                	mv	s1,a0
  push_off();
    800055a8:	230000ef          	jal	800057d8 <push_off>

  if(panicked){
    800055ac:	00005797          	auipc	a5,0x5
    800055b0:	e307a783          	lw	a5,-464(a5) # 8000a3dc <panicked>
    800055b4:	e795                	bnez	a5,800055e0 <uartputc_sync+0x44>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800055b6:	10000737          	lui	a4,0x10000
    800055ba:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    800055bc:	00074783          	lbu	a5,0(a4)
    800055c0:	0207f793          	andi	a5,a5,32
    800055c4:	dfe5                	beqz	a5,800055bc <uartputc_sync+0x20>
    ;
  WriteReg(THR, c);
    800055c6:	0ff4f513          	zext.b	a0,s1
    800055ca:	100007b7          	lui	a5,0x10000
    800055ce:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    800055d2:	28e000ef          	jal	80005860 <pop_off>
}
    800055d6:	60e2                	ld	ra,24(sp)
    800055d8:	6442                	ld	s0,16(sp)
    800055da:	64a2                	ld	s1,8(sp)
    800055dc:	6105                	addi	sp,sp,32
    800055de:	8082                	ret
    for(;;)
    800055e0:	a001                	j	800055e0 <uartputc_sync+0x44>

00000000800055e2 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800055e2:	00005797          	auipc	a5,0x5
    800055e6:	dfe7b783          	ld	a5,-514(a5) # 8000a3e0 <uart_tx_r>
    800055ea:	00005717          	auipc	a4,0x5
    800055ee:	dfe73703          	ld	a4,-514(a4) # 8000a3e8 <uart_tx_w>
    800055f2:	08f70163          	beq	a4,a5,80005674 <uartstart+0x92>
{
    800055f6:	7139                	addi	sp,sp,-64
    800055f8:	fc06                	sd	ra,56(sp)
    800055fa:	f822                	sd	s0,48(sp)
    800055fc:	f426                	sd	s1,40(sp)
    800055fe:	f04a                	sd	s2,32(sp)
    80005600:	ec4e                	sd	s3,24(sp)
    80005602:	e852                	sd	s4,16(sp)
    80005604:	e456                	sd	s5,8(sp)
    80005606:	e05a                	sd	s6,0(sp)
    80005608:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      ReadReg(ISR);
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000560a:	10000937          	lui	s2,0x10000
    8000560e:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005610:	0001ea97          	auipc	s5,0x1e
    80005614:	0d8a8a93          	addi	s5,s5,216 # 800236e8 <uart_tx_lock>
    uart_tx_r += 1;
    80005618:	00005497          	auipc	s1,0x5
    8000561c:	dc848493          	addi	s1,s1,-568 # 8000a3e0 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    80005620:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    80005624:	00005997          	auipc	s3,0x5
    80005628:	dc498993          	addi	s3,s3,-572 # 8000a3e8 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000562c:	00094703          	lbu	a4,0(s2)
    80005630:	02077713          	andi	a4,a4,32
    80005634:	c715                	beqz	a4,80005660 <uartstart+0x7e>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005636:	01f7f713          	andi	a4,a5,31
    8000563a:	9756                	add	a4,a4,s5
    8000563c:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    80005640:	0785                	addi	a5,a5,1
    80005642:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    80005644:	8526                	mv	a0,s1
    80005646:	d63fb0ef          	jal	800013a8 <wakeup>
    WriteReg(THR, c);
    8000564a:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    8000564e:	609c                	ld	a5,0(s1)
    80005650:	0009b703          	ld	a4,0(s3)
    80005654:	fcf71ce3          	bne	a4,a5,8000562c <uartstart+0x4a>
      ReadReg(ISR);
    80005658:	100007b7          	lui	a5,0x10000
    8000565c:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>
  }
}
    80005660:	70e2                	ld	ra,56(sp)
    80005662:	7442                	ld	s0,48(sp)
    80005664:	74a2                	ld	s1,40(sp)
    80005666:	7902                	ld	s2,32(sp)
    80005668:	69e2                	ld	s3,24(sp)
    8000566a:	6a42                	ld	s4,16(sp)
    8000566c:	6aa2                	ld	s5,8(sp)
    8000566e:	6b02                	ld	s6,0(sp)
    80005670:	6121                	addi	sp,sp,64
    80005672:	8082                	ret
      ReadReg(ISR);
    80005674:	100007b7          	lui	a5,0x10000
    80005678:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>
      return;
    8000567c:	8082                	ret

000000008000567e <uartputc>:
{
    8000567e:	7179                	addi	sp,sp,-48
    80005680:	f406                	sd	ra,40(sp)
    80005682:	f022                	sd	s0,32(sp)
    80005684:	ec26                	sd	s1,24(sp)
    80005686:	e84a                	sd	s2,16(sp)
    80005688:	e44e                	sd	s3,8(sp)
    8000568a:	e052                	sd	s4,0(sp)
    8000568c:	1800                	addi	s0,sp,48
    8000568e:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80005690:	0001e517          	auipc	a0,0x1e
    80005694:	05850513          	addi	a0,a0,88 # 800236e8 <uart_tx_lock>
    80005698:	184000ef          	jal	8000581c <acquire>
  if(panicked){
    8000569c:	00005797          	auipc	a5,0x5
    800056a0:	d407a783          	lw	a5,-704(a5) # 8000a3dc <panicked>
    800056a4:	e3d1                	bnez	a5,80005728 <uartputc+0xaa>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800056a6:	00005717          	auipc	a4,0x5
    800056aa:	d4273703          	ld	a4,-702(a4) # 8000a3e8 <uart_tx_w>
    800056ae:	00005797          	auipc	a5,0x5
    800056b2:	d327b783          	ld	a5,-718(a5) # 8000a3e0 <uart_tx_r>
    800056b6:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800056ba:	0001e997          	auipc	s3,0x1e
    800056be:	02e98993          	addi	s3,s3,46 # 800236e8 <uart_tx_lock>
    800056c2:	00005497          	auipc	s1,0x5
    800056c6:	d1e48493          	addi	s1,s1,-738 # 8000a3e0 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800056ca:	00005917          	auipc	s2,0x5
    800056ce:	d1e90913          	addi	s2,s2,-738 # 8000a3e8 <uart_tx_w>
    800056d2:	00e79d63          	bne	a5,a4,800056ec <uartputc+0x6e>
    sleep(&uart_tx_r, &uart_tx_lock);
    800056d6:	85ce                	mv	a1,s3
    800056d8:	8526                	mv	a0,s1
    800056da:	c83fb0ef          	jal	8000135c <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800056de:	00093703          	ld	a4,0(s2)
    800056e2:	609c                	ld	a5,0(s1)
    800056e4:	02078793          	addi	a5,a5,32
    800056e8:	fee787e3          	beq	a5,a4,800056d6 <uartputc+0x58>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800056ec:	01f77693          	andi	a3,a4,31
    800056f0:	0001e797          	auipc	a5,0x1e
    800056f4:	ff878793          	addi	a5,a5,-8 # 800236e8 <uart_tx_lock>
    800056f8:	97b6                	add	a5,a5,a3
    800056fa:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    800056fe:	0705                	addi	a4,a4,1
    80005700:	00005797          	auipc	a5,0x5
    80005704:	cee7b423          	sd	a4,-792(a5) # 8000a3e8 <uart_tx_w>
  uartstart();
    80005708:	edbff0ef          	jal	800055e2 <uartstart>
  release(&uart_tx_lock);
    8000570c:	0001e517          	auipc	a0,0x1e
    80005710:	fdc50513          	addi	a0,a0,-36 # 800236e8 <uart_tx_lock>
    80005714:	19c000ef          	jal	800058b0 <release>
}
    80005718:	70a2                	ld	ra,40(sp)
    8000571a:	7402                	ld	s0,32(sp)
    8000571c:	64e2                	ld	s1,24(sp)
    8000571e:	6942                	ld	s2,16(sp)
    80005720:	69a2                	ld	s3,8(sp)
    80005722:	6a02                	ld	s4,0(sp)
    80005724:	6145                	addi	sp,sp,48
    80005726:	8082                	ret
    for(;;)
    80005728:	a001                	j	80005728 <uartputc+0xaa>

000000008000572a <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000572a:	1141                	addi	sp,sp,-16
    8000572c:	e406                	sd	ra,8(sp)
    8000572e:	e022                	sd	s0,0(sp)
    80005730:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80005732:	100007b7          	lui	a5,0x10000
    80005736:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000573a:	8b85                	andi	a5,a5,1
    8000573c:	cb89                	beqz	a5,8000574e <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000573e:	100007b7          	lui	a5,0x10000
    80005742:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80005746:	60a2                	ld	ra,8(sp)
    80005748:	6402                	ld	s0,0(sp)
    8000574a:	0141                	addi	sp,sp,16
    8000574c:	8082                	ret
    return -1;
    8000574e:	557d                	li	a0,-1
    80005750:	bfdd                	j	80005746 <uartgetc+0x1c>

0000000080005752 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80005752:	1101                	addi	sp,sp,-32
    80005754:	ec06                	sd	ra,24(sp)
    80005756:	e822                	sd	s0,16(sp)
    80005758:	e426                	sd	s1,8(sp)
    8000575a:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000575c:	54fd                	li	s1,-1
    int c = uartgetc();
    8000575e:	fcdff0ef          	jal	8000572a <uartgetc>
    if(c == -1)
    80005762:	00950563          	beq	a0,s1,8000576c <uartintr+0x1a>
      break;
    consoleintr(c);
    80005766:	81bff0ef          	jal	80004f80 <consoleintr>
  while(1){
    8000576a:	bfd5                	j	8000575e <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000576c:	0001e517          	auipc	a0,0x1e
    80005770:	f7c50513          	addi	a0,a0,-132 # 800236e8 <uart_tx_lock>
    80005774:	0a8000ef          	jal	8000581c <acquire>
  uartstart();
    80005778:	e6bff0ef          	jal	800055e2 <uartstart>
  release(&uart_tx_lock);
    8000577c:	0001e517          	auipc	a0,0x1e
    80005780:	f6c50513          	addi	a0,a0,-148 # 800236e8 <uart_tx_lock>
    80005784:	12c000ef          	jal	800058b0 <release>
}
    80005788:	60e2                	ld	ra,24(sp)
    8000578a:	6442                	ld	s0,16(sp)
    8000578c:	64a2                	ld	s1,8(sp)
    8000578e:	6105                	addi	sp,sp,32
    80005790:	8082                	ret

0000000080005792 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80005792:	1141                	addi	sp,sp,-16
    80005794:	e406                	sd	ra,8(sp)
    80005796:	e022                	sd	s0,0(sp)
    80005798:	0800                	addi	s0,sp,16
  lk->name = name;
    8000579a:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    8000579c:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800057a0:	00053823          	sd	zero,16(a0)
}
    800057a4:	60a2                	ld	ra,8(sp)
    800057a6:	6402                	ld	s0,0(sp)
    800057a8:	0141                	addi	sp,sp,16
    800057aa:	8082                	ret

00000000800057ac <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800057ac:	411c                	lw	a5,0(a0)
    800057ae:	e399                	bnez	a5,800057b4 <holding+0x8>
    800057b0:	4501                	li	a0,0
  return r;
}
    800057b2:	8082                	ret
{
    800057b4:	1101                	addi	sp,sp,-32
    800057b6:	ec06                	sd	ra,24(sp)
    800057b8:	e822                	sd	s0,16(sp)
    800057ba:	e426                	sd	s1,8(sp)
    800057bc:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800057be:	691c                	ld	a5,16(a0)
    800057c0:	84be                	mv	s1,a5
    800057c2:	da0fb0ef          	jal	80000d62 <mycpu>
    800057c6:	40a48533          	sub	a0,s1,a0
    800057ca:	00153513          	seqz	a0,a0
}
    800057ce:	60e2                	ld	ra,24(sp)
    800057d0:	6442                	ld	s0,16(sp)
    800057d2:	64a2                	ld	s1,8(sp)
    800057d4:	6105                	addi	sp,sp,32
    800057d6:	8082                	ret

00000000800057d8 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800057d8:	1101                	addi	sp,sp,-32
    800057da:	ec06                	sd	ra,24(sp)
    800057dc:	e822                	sd	s0,16(sp)
    800057de:	e426                	sd	s1,8(sp)
    800057e0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800057e2:	100027f3          	csrr	a5,sstatus
    800057e6:	84be                	mv	s1,a5
    800057e8:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800057ec:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800057ee:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800057f2:	d70fb0ef          	jal	80000d62 <mycpu>
    800057f6:	5d3c                	lw	a5,120(a0)
    800057f8:	cb99                	beqz	a5,8000580e <push_off+0x36>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800057fa:	d68fb0ef          	jal	80000d62 <mycpu>
    800057fe:	5d3c                	lw	a5,120(a0)
    80005800:	2785                	addiw	a5,a5,1
    80005802:	dd3c                	sw	a5,120(a0)
}
    80005804:	60e2                	ld	ra,24(sp)
    80005806:	6442                	ld	s0,16(sp)
    80005808:	64a2                	ld	s1,8(sp)
    8000580a:	6105                	addi	sp,sp,32
    8000580c:	8082                	ret
    mycpu()->intena = old;
    8000580e:	d54fb0ef          	jal	80000d62 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80005812:	0014d793          	srli	a5,s1,0x1
    80005816:	8b85                	andi	a5,a5,1
    80005818:	dd7c                	sw	a5,124(a0)
    8000581a:	b7c5                	j	800057fa <push_off+0x22>

000000008000581c <acquire>:
{
    8000581c:	1101                	addi	sp,sp,-32
    8000581e:	ec06                	sd	ra,24(sp)
    80005820:	e822                	sd	s0,16(sp)
    80005822:	e426                	sd	s1,8(sp)
    80005824:	1000                	addi	s0,sp,32
    80005826:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80005828:	fb1ff0ef          	jal	800057d8 <push_off>
  if(holding(lk))
    8000582c:	8526                	mv	a0,s1
    8000582e:	f7fff0ef          	jal	800057ac <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005832:	4705                	li	a4,1
  if(holding(lk))
    80005834:	e105                	bnez	a0,80005854 <acquire+0x38>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005836:	87ba                	mv	a5,a4
    80005838:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    8000583c:	2781                	sext.w	a5,a5
    8000583e:	ffe5                	bnez	a5,80005836 <acquire+0x1a>
  __sync_synchronize();
    80005840:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    80005844:	d1efb0ef          	jal	80000d62 <mycpu>
    80005848:	e888                	sd	a0,16(s1)
}
    8000584a:	60e2                	ld	ra,24(sp)
    8000584c:	6442                	ld	s0,16(sp)
    8000584e:	64a2                	ld	s1,8(sp)
    80005850:	6105                	addi	sp,sp,32
    80005852:	8082                	ret
    panic("acquire");
    80005854:	00002517          	auipc	a0,0x2
    80005858:	f9450513          	addi	a0,a0,-108 # 800077e8 <etext+0x7e8>
    8000585c:	c83ff0ef          	jal	800054de <panic>

0000000080005860 <pop_off>:

void
pop_off(void)
{
    80005860:	1141                	addi	sp,sp,-16
    80005862:	e406                	sd	ra,8(sp)
    80005864:	e022                	sd	s0,0(sp)
    80005866:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80005868:	cfafb0ef          	jal	80000d62 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000586c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80005870:	8b89                	andi	a5,a5,2
  if(intr_get())
    80005872:	e39d                	bnez	a5,80005898 <pop_off+0x38>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80005874:	5d3c                	lw	a5,120(a0)
    80005876:	02f05763          	blez	a5,800058a4 <pop_off+0x44>
    panic("pop_off");
  c->noff -= 1;
    8000587a:	37fd                	addiw	a5,a5,-1
    8000587c:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    8000587e:	eb89                	bnez	a5,80005890 <pop_off+0x30>
    80005880:	5d7c                	lw	a5,124(a0)
    80005882:	c799                	beqz	a5,80005890 <pop_off+0x30>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80005884:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80005888:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000588c:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80005890:	60a2                	ld	ra,8(sp)
    80005892:	6402                	ld	s0,0(sp)
    80005894:	0141                	addi	sp,sp,16
    80005896:	8082                	ret
    panic("pop_off - interruptible");
    80005898:	00002517          	auipc	a0,0x2
    8000589c:	f5850513          	addi	a0,a0,-168 # 800077f0 <etext+0x7f0>
    800058a0:	c3fff0ef          	jal	800054de <panic>
    panic("pop_off");
    800058a4:	00002517          	auipc	a0,0x2
    800058a8:	f6450513          	addi	a0,a0,-156 # 80007808 <etext+0x808>
    800058ac:	c33ff0ef          	jal	800054de <panic>

00000000800058b0 <release>:
{
    800058b0:	1101                	addi	sp,sp,-32
    800058b2:	ec06                	sd	ra,24(sp)
    800058b4:	e822                	sd	s0,16(sp)
    800058b6:	e426                	sd	s1,8(sp)
    800058b8:	1000                	addi	s0,sp,32
    800058ba:	84aa                	mv	s1,a0
  if(!holding(lk))
    800058bc:	ef1ff0ef          	jal	800057ac <holding>
    800058c0:	c105                	beqz	a0,800058e0 <release+0x30>
  lk->cpu = 0;
    800058c2:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800058c6:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    800058ca:	0310000f          	fence	rw,w
    800058ce:	0004a023          	sw	zero,0(s1)
  pop_off();
    800058d2:	f8fff0ef          	jal	80005860 <pop_off>
}
    800058d6:	60e2                	ld	ra,24(sp)
    800058d8:	6442                	ld	s0,16(sp)
    800058da:	64a2                	ld	s1,8(sp)
    800058dc:	6105                	addi	sp,sp,32
    800058de:	8082                	ret
    panic("release");
    800058e0:	00002517          	auipc	a0,0x2
    800058e4:	f3050513          	addi	a0,a0,-208 # 80007810 <etext+0x810>
    800058e8:	bf7ff0ef          	jal	800054de <panic>
	...

0000000080006000 <_trampoline>:
    80006000:	14051073          	csrw	sscratch,a0
    80006004:	02000537          	lui	a0,0x2000
    80006008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000600a:	0536                	slli	a0,a0,0xd
    8000600c:	02153423          	sd	ra,40(a0)
    80006010:	02253823          	sd	sp,48(a0)
    80006014:	02353c23          	sd	gp,56(a0)
    80006018:	04453023          	sd	tp,64(a0)
    8000601c:	04553423          	sd	t0,72(a0)
    80006020:	04653823          	sd	t1,80(a0)
    80006024:	04753c23          	sd	t2,88(a0)
    80006028:	f120                	sd	s0,96(a0)
    8000602a:	f524                	sd	s1,104(a0)
    8000602c:	fd2c                	sd	a1,120(a0)
    8000602e:	e150                	sd	a2,128(a0)
    80006030:	e554                	sd	a3,136(a0)
    80006032:	e958                	sd	a4,144(a0)
    80006034:	ed5c                	sd	a5,152(a0)
    80006036:	0b053023          	sd	a6,160(a0)
    8000603a:	0b153423          	sd	a7,168(a0)
    8000603e:	0b253823          	sd	s2,176(a0)
    80006042:	0b353c23          	sd	s3,184(a0)
    80006046:	0d453023          	sd	s4,192(a0)
    8000604a:	0d553423          	sd	s5,200(a0)
    8000604e:	0d653823          	sd	s6,208(a0)
    80006052:	0d753c23          	sd	s7,216(a0)
    80006056:	0f853023          	sd	s8,224(a0)
    8000605a:	0f953423          	sd	s9,232(a0)
    8000605e:	0fa53823          	sd	s10,240(a0)
    80006062:	0fb53c23          	sd	s11,248(a0)
    80006066:	11c53023          	sd	t3,256(a0)
    8000606a:	11d53423          	sd	t4,264(a0)
    8000606e:	11e53823          	sd	t5,272(a0)
    80006072:	11f53c23          	sd	t6,280(a0)
    80006076:	140022f3          	csrr	t0,sscratch
    8000607a:	06553823          	sd	t0,112(a0)
    8000607e:	00853103          	ld	sp,8(a0)
    80006082:	02053203          	ld	tp,32(a0)
    80006086:	01053283          	ld	t0,16(a0)
    8000608a:	00053303          	ld	t1,0(a0)
    8000608e:	12000073          	sfence.vma
    80006092:	18031073          	csrw	satp,t1
    80006096:	12000073          	sfence.vma
    8000609a:	8282                	jr	t0

000000008000609c <userret>:
    8000609c:	12000073          	sfence.vma
    800060a0:	18051073          	csrw	satp,a0
    800060a4:	12000073          	sfence.vma
    800060a8:	02000537          	lui	a0,0x2000
    800060ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800060ae:	0536                	slli	a0,a0,0xd
    800060b0:	02853083          	ld	ra,40(a0)
    800060b4:	03053103          	ld	sp,48(a0)
    800060b8:	03853183          	ld	gp,56(a0)
    800060bc:	04053203          	ld	tp,64(a0)
    800060c0:	04853283          	ld	t0,72(a0)
    800060c4:	05053303          	ld	t1,80(a0)
    800060c8:	05853383          	ld	t2,88(a0)
    800060cc:	7120                	ld	s0,96(a0)
    800060ce:	7524                	ld	s1,104(a0)
    800060d0:	7d2c                	ld	a1,120(a0)
    800060d2:	6150                	ld	a2,128(a0)
    800060d4:	6554                	ld	a3,136(a0)
    800060d6:	6958                	ld	a4,144(a0)
    800060d8:	6d5c                	ld	a5,152(a0)
    800060da:	0a053803          	ld	a6,160(a0)
    800060de:	0a853883          	ld	a7,168(a0)
    800060e2:	0b053903          	ld	s2,176(a0)
    800060e6:	0b853983          	ld	s3,184(a0)
    800060ea:	0c053a03          	ld	s4,192(a0)
    800060ee:	0c853a83          	ld	s5,200(a0)
    800060f2:	0d053b03          	ld	s6,208(a0)
    800060f6:	0d853b83          	ld	s7,216(a0)
    800060fa:	0e053c03          	ld	s8,224(a0)
    800060fe:	0e853c83          	ld	s9,232(a0)
    80006102:	0f053d03          	ld	s10,240(a0)
    80006106:	0f853d83          	ld	s11,248(a0)
    8000610a:	10053e03          	ld	t3,256(a0)
    8000610e:	10853e83          	ld	t4,264(a0)
    80006112:	11053f03          	ld	t5,272(a0)
    80006116:	11853f83          	ld	t6,280(a0)
    8000611a:	7928                	ld	a0,112(a0)
    8000611c:	10200073          	sret
	...
