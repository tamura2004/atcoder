/* Generated by Nim Compiler v0.13.0 */
/*   (c) 2015 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: Linux, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w  -I/home/tamura/.choosenim/toolchains/nim-0.13.0/lib -o /home/tamura/project/atcoder/src/nimcache/stdlib_hashes.o /home/tamura/project/atcoder/src/nimcache/stdlib_hashes.c */
#define NIM_INTBITS 64

#include "nimbase.h"
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
struct  TGenericSeq  {
NI len;
NI reserved;
};
struct  NimStringDesc  {
  TGenericSeq Sup;
NIM_CHAR data[SEQ_DECL_SIZE];
};
static N_INLINE(NI, HEX21HEX26_115004)(NI h, NI val);
static N_INLINE(void, nimFrame)(TFrame* s);
N_NOINLINE(void, stackoverflow_22201)(void);
static N_INLINE(void, popFrame)(void);
static N_INLINE(NI, HEX21HEX24_115027)(NI h);
N_NIMCALL(NI, hashdata_115049)(void* data, NI size);
static N_INLINE(NI, addInt)(NI a, NI b);
N_NOINLINE(void, raiseOverflow)(void);
static N_INLINE(NI, subInt)(NI a, NI b);
static N_INLINE(NI, hash_115401)(void* x);
static N_INLINE(NI, hash_115801)(NI x);
static N_INLINE(NI, hash_115805)(NI64 x);
static N_INLINE(NI, hash_115809)(NIM_CHAR x);
N_NIMCALL(NI, hash_115827)(NimStringDesc* x);
N_NOINLINE(void, raiseIndexError)(void);
N_NIMCALL(NI, hash_115859)(NimStringDesc* sbuf, NI spos, NI epos);
N_NIMCALL(NI, hashignorestyle_115892)(NimStringDesc* x);
static N_INLINE(NIM_BOOL, ismagicidentseparatorrune_114008)(NCSTRING cs, NI i);
static N_INLINE(NI, chckRange)(NI i, NI a, NI b);
N_NOINLINE(void, raiseRangeError)(NI64 val);
N_NIMCALL(NI, hashignorestyle_115975)(NimStringDesc* sbuf, NI spos, NI epos);
N_NIMCALL(NI, hashignorecase_116059)(NimStringDesc* x);
N_NIMCALL(NI, hashignorecase_116130)(NimStringDesc* sbuf, NI spos, NI epos);
static N_INLINE(NI, hash_116202)(NF x);
extern TFrame* frameptr_19436;

static N_INLINE(void, nimFrame)(TFrame* s) {
	NI LOC1;
	LOC1 = 0;
	{
		if (!(frameptr_19436 == NIM_NIL)) goto LA4;
		LOC1 = ((NI) 0);
	}
	goto LA2;
	LA4: ;
	{
		LOC1 = ((NI) ((NI16)((*frameptr_19436).calldepth + ((NI16) 1))));
	}
	LA2: ;
	(*s).calldepth = ((NI16) (LOC1));
	(*s).prev = frameptr_19436;
	frameptr_19436 = s;
	{
		if (!((*s).calldepth == ((NI16) 2000))) goto LA9;
		stackoverflow_22201();
	}
	LA9: ;
}

static N_INLINE(void, popFrame)(void) {
	frameptr_19436 = (*frameptr_19436).prev;
}

static N_INLINE(NI, HEX21HEX26_115004)(NI h, NI val) {
	NI result;
	nimfr("!&", "hashes.nim")
	result = 0;
	nimln(53, "hashes.nim");
	result = (NI)((NU64)(h) + (NU64)(val));
	nimln(54, "hashes.nim");
	result = (NI)((NU64)(result) + (NU64)((NI)((NU64)(result) << (NU64)(((NI) 10)))));
	nimln(55, "hashes.nim");
	result = (NI)(result ^ (NI)((NU64)(result) >> (NU64)(((NI) 6))));
	popFrame();
	return result;
}

static N_INLINE(NI, HEX21HEX24_115027)(NI h) {
	NI result;
	nimfr("!$", "hashes.nim")
	result = 0;
	nimln(60, "hashes.nim");
	result = (NI)((NU64)(h) + (NU64)((NI)((NU64)(h) << (NU64)(((NI) 3)))));
	nimln(61, "hashes.nim");
	result = (NI)(result ^ (NI)((NU64)(result) >> (NU64)(((NI) 11))));
	nimln(62, "hashes.nim");
	result = (NI)((NU64)(result) + (NU64)((NI)((NU64)(result) << (NU64)(((NI) 15)))));
	popFrame();
	return result;
}

static N_INLINE(NI, addInt)(NI a, NI b) {
	NI result;
{	result = 0;
	result = (NI)((NU64)(a) + (NU64)(b));
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (((NI) 0) <= (NI)(result ^ a));
		if (LOC3) goto LA4;
		LOC3 = (((NI) 0) <= (NI)(result ^ b));
		LA4: ;
		if (!LOC3) goto LA5;
		goto BeforeRet;
	}
	LA5: ;
	raiseOverflow();
	}BeforeRet: ;
	return result;
}

static N_INLINE(NI, subInt)(NI a, NI b) {
	NI result;
{	result = 0;
	result = (NI)((NU64)(a) - (NU64)(b));
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (((NI) 0) <= (NI)(result ^ a));
		if (LOC3) goto LA4;
		LOC3 = (((NI) 0) <= (NI)(result ^ (NI)((NU64) ~(b))));
		LA4: ;
		if (!LOC3) goto LA5;
		goto BeforeRet;
	}
	LA5: ;
	raiseOverflow();
	}BeforeRet: ;
	return result;
}

N_NIMCALL(NI, hashdata_115049)(void* data, NI size) {
	NI result;
	NI h;
	NCSTRING p;
	NI i;
	NI s;
	nimfr("hashData", "hashes.nim")
	result = 0;
	nimln(66, "hashes.nim");
	h = ((NI) 0);
	nimln(71, "hashes.nim");
	p = ((NCSTRING) (data));
	nimln(72, "hashes.nim");
	i = ((NI) 0);
	nimln(73, "hashes.nim");
	s = size;
	{
		nimln(74, "hashes.nim");
		while (1) {
			NI TMP295;
			NI TMP296;
			nimln(357, "system.nim");
			if (!(((NI) 0) < s)) goto LA2;
			nimln(75, "hashes.nim");
			h = HEX21HEX26_115004(h, ((NI) (((NU8)(p[i])))));
			nimln(76, "hashes.nim");
			TMP295 = addInt(i, ((NI) 1));
			i = (NI)(TMP295);
			nimln(77, "hashes.nim");
			TMP296 = subInt(s, ((NI) 1));
			s = (NI)(TMP296);
		} LA2: ;
	}
	nimln(78, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

static N_INLINE(NI, hash_115401)(void* x) {
	NI result;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(97, "hashes.nim");
	result = (NI)((NU64)(((NI) (x))) >> (NU64)(((NI) 3)));
	popFrame();
	return result;
}

static N_INLINE(NI, hash_115801)(NI x) {
	NI result;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(109, "hashes.nim");
	result = x;
	popFrame();
	return result;
}

static N_INLINE(NI, hash_115805)(NI64 x) {
	NI result;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(113, "hashes.nim");
	result = ((NI) (((NI32)(NU32)(NU64)(x))));
	popFrame();
	return result;
}

static N_INLINE(NI, hash_115809)(NIM_CHAR x) {
	NI result;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(117, "hashes.nim");
	result = ((NI) (((NU8)(x))));
	popFrame();
	return result;
}

N_NIMCALL(NI, hash_115827)(NimStringDesc* x) {
	NI result;
	NI h;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(125, "hashes.nim");
	h = ((NI) 0);
	{
		NI i_115841;
		NI HEX3Atmp_115852;
		NI TMP297;
		NI res_115855;
		i_115841 = 0;
		HEX3Atmp_115852 = 0;
		nimln(126, "hashes.nim");
		TMP297 = subInt((x ? x->Sup.len : 0), ((NI) 1));
		HEX3Atmp_115852 = (NI)(TMP297);
		nimln(1874, "system.nim");
		res_115855 = ((NI) 0);
		{
			nimln(1875, "system.nim");
			while (1) {
				NI TMP298;
				if (!(res_115855 <= HEX3Atmp_115852)) goto LA3;
				nimln(1876, "system.nim");
				i_115841 = res_115855;
				nimln(127, "hashes.nim");
				if ((NU)(i_115841) > (NU)(x->Sup.len)) raiseIndexError();
				h = HEX21HEX26_115004(h, ((NI) (((NU8)(x->data[i_115841])))));
				nimln(1895, "system.nim");
				TMP298 = addInt(res_115855, ((NI) 1));
				res_115855 = (NI)(TMP298);
			} LA3: ;
		}
	}
	nimln(128, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

N_NIMCALL(NI, hash_115859)(NimStringDesc* sbuf, NI spos, NI epos) {
	NI result;
	NI h;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(135, "hashes.nim");
	h = ((NI) 0);
	{
		NI i_115875;
		NI res_115888;
		i_115875 = 0;
		nimln(1874, "system.nim");
		res_115888 = spos;
		{
			nimln(1875, "system.nim");
			while (1) {
				NI TMP299;
				if (!(res_115888 <= epos)) goto LA3;
				nimln(1876, "system.nim");
				i_115875 = res_115888;
				nimln(137, "hashes.nim");
				if ((NU)(i_115875) > (NU)(sbuf->Sup.len)) raiseIndexError();
				h = HEX21HEX26_115004(h, ((NI) (((NU8)(sbuf->data[i_115875])))));
				nimln(1895, "system.nim");
				TMP299 = addInt(res_115888, ((NI) 1));
				res_115888 = (NI)(TMP299);
			} LA3: ;
		}
	}
	nimln(138, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

static N_INLINE(NIM_BOOL, ismagicidentseparatorrune_114008)(NCSTRING cs, NI i) {
	NIM_BOOL result;
	NIM_BOOL LOC1;
	NIM_BOOL LOC2;
	NI TMP301;
	NI TMP302;
	nimfr("isMagicIdentSeparatorRune", "etcpriv.nim")
	result = 0;
	nimln(21, "etcpriv.nim");
	nimln(22, "etcpriv.nim");
	LOC1 = 0;
	nimln(21, "etcpriv.nim");
	LOC2 = 0;
	LOC2 = ((NU8)(cs[i]) == (NU8)(226));
	if (!(LOC2)) goto LA3;
	nimln(22, "etcpriv.nim");
	TMP301 = addInt(i, ((NI) 1));
	LOC2 = ((NU8)(cs[(NI)(TMP301)]) == (NU8)(128));
	LA3: ;
	LOC1 = LOC2;
	if (!(LOC1)) goto LA4;
	nimln(23, "etcpriv.nim");
	TMP302 = addInt(i, ((NI) 2));
	LOC1 = ((NU8)(cs[(NI)(TMP302)]) == (NU8)(147));
	LA4: ;
	result = LOC1;
	popFrame();
	return result;
}

static N_INLINE(NI, chckRange)(NI i, NI a, NI b) {
	NI result;
{	result = 0;
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (a <= i);
		if (!(LOC3)) goto LA4;
		LOC3 = (i <= b);
		LA4: ;
		if (!LOC3) goto LA5;
		result = i;
		goto BeforeRet;
	}
	goto LA1;
	LA5: ;
	{
		raiseRangeError(((NI64) (i)));
	}
	LA1: ;
	}BeforeRet: ;
	return result;
}

N_NIMCALL(NI, hashignorestyle_115892)(NimStringDesc* x) {
	NI result;
	NI h;
	NI i;
	NI xlen;
	nimfr("hashIgnoreStyle", "hashes.nim")
	result = 0;
	nimln(142, "hashes.nim");
	h = ((NI) 0);
	nimln(143, "hashes.nim");
	i = ((NI) 0);
	nimln(144, "hashes.nim");
	xlen = (x ? x->Sup.len : 0);
	{
		nimln(145, "hashes.nim");
		while (1) {
			NIM_CHAR c;
			if (!(i < xlen)) goto LA2;
			nimln(146, "hashes.nim");
			if ((NU)(i) > (NU)(x->Sup.len)) raiseIndexError();
			c = x->data[i];
			nimln(147, "hashes.nim");
			{
				NI TMP300;
				if (!((NU8)(c) == (NU8)(95))) goto LA5;
				nimln(148, "hashes.nim");
				TMP300 = addInt(i, ((NI) 1));
				i = (NI)(TMP300);
			}
			goto LA3;
			LA5: ;
			{
				NIM_BOOL LOC8;
				NI TMP303;
				nimln(149, "hashes.nim");
				LOC8 = 0;
				LOC8 = ismagicidentseparatorrune_114008(x->data, i);
				if (!LOC8) goto LA9;
				nimln(150, "hashes.nim");
				TMP303 = addInt(i, ((NI) 3));
				i = (NI)(TMP303);
			}
			goto LA3;
			LA9: ;
			{
				NI TMP305;
				nimln(152, "hashes.nim");
				{
					NI TMP304;
					nimln(1098, "system.nim");
					if (!(((NU8)(c)) >= ((NU8)(65)) && ((NU8)(c)) <= ((NU8)(90)))) goto LA14;
					nimln(153, "hashes.nim");
					TMP304 = addInt(((NI) (((NU8)(c)))), ((NI) 32));
					c = ((NIM_CHAR) (((NI)chckRange((NI)(TMP304), ((NI) 0), ((NI) 255)))));
				}
				LA14: ;
				nimln(154, "hashes.nim");
				h = HEX21HEX26_115004(h, ((NI) (((NU8)(c)))));
				nimln(155, "hashes.nim");
				TMP305 = addInt(i, ((NI) 1));
				i = (NI)(TMP305);
			}
			LA3: ;
		} LA2: ;
	}
	nimln(157, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

N_NIMCALL(NI, hashignorestyle_115975)(NimStringDesc* sbuf, NI spos, NI epos) {
	NI result;
	NI h;
	NI i;
	nimfr("hashIgnoreStyle", "hashes.nim")
	result = 0;
	nimln(165, "hashes.nim");
	h = ((NI) 0);
	nimln(166, "hashes.nim");
	i = spos;
	{
		nimln(167, "hashes.nim");
		while (1) {
			NIM_CHAR c;
			if (!(i <= epos)) goto LA2;
			nimln(168, "hashes.nim");
			if ((NU)(i) > (NU)(sbuf->Sup.len)) raiseIndexError();
			c = sbuf->data[i];
			nimln(169, "hashes.nim");
			{
				NI TMP306;
				if (!((NU8)(c) == (NU8)(95))) goto LA5;
				nimln(170, "hashes.nim");
				TMP306 = addInt(i, ((NI) 1));
				i = (NI)(TMP306);
			}
			goto LA3;
			LA5: ;
			{
				NIM_BOOL LOC8;
				NI TMP307;
				nimln(171, "hashes.nim");
				LOC8 = 0;
				LOC8 = ismagicidentseparatorrune_114008(sbuf->data, i);
				if (!LOC8) goto LA9;
				nimln(172, "hashes.nim");
				TMP307 = addInt(i, ((NI) 3));
				i = (NI)(TMP307);
			}
			goto LA3;
			LA9: ;
			{
				NI TMP309;
				nimln(174, "hashes.nim");
				{
					NI TMP308;
					nimln(1098, "system.nim");
					if (!(((NU8)(c)) >= ((NU8)(65)) && ((NU8)(c)) <= ((NU8)(90)))) goto LA14;
					nimln(175, "hashes.nim");
					TMP308 = addInt(((NI) (((NU8)(c)))), ((NI) 32));
					c = ((NIM_CHAR) (((NI)chckRange((NI)(TMP308), ((NI) 0), ((NI) 255)))));
				}
				LA14: ;
				nimln(176, "hashes.nim");
				h = HEX21HEX26_115004(h, ((NI) (((NU8)(c)))));
				nimln(177, "hashes.nim");
				TMP309 = addInt(i, ((NI) 1));
				i = (NI)(TMP309);
			}
			LA3: ;
		} LA2: ;
	}
	nimln(178, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

N_NIMCALL(NI, hashignorecase_116059)(NimStringDesc* x) {
	NI result;
	NI h;
	nimfr("hashIgnoreCase", "hashes.nim")
	result = 0;
	nimln(182, "hashes.nim");
	h = ((NI) 0);
	{
		NI i_116073;
		NI HEX3Atmp_116123;
		NI TMP310;
		NI res_116126;
		i_116073 = 0;
		HEX3Atmp_116123 = 0;
		nimln(183, "hashes.nim");
		TMP310 = subInt((x ? x->Sup.len : 0), ((NI) 1));
		HEX3Atmp_116123 = (NI)(TMP310);
		nimln(1874, "system.nim");
		res_116126 = ((NI) 0);
		{
			nimln(1875, "system.nim");
			while (1) {
				NIM_CHAR c;
				NI TMP312;
				if (!(res_116126 <= HEX3Atmp_116123)) goto LA3;
				nimln(1876, "system.nim");
				i_116073 = res_116126;
				nimln(184, "hashes.nim");
				if ((NU)(i_116073) > (NU)(x->Sup.len)) raiseIndexError();
				c = x->data[i_116073];
				nimln(185, "hashes.nim");
				{
					NI TMP311;
					nimln(1098, "system.nim");
					if (!(((NU8)(c)) >= ((NU8)(65)) && ((NU8)(c)) <= ((NU8)(90)))) goto LA6;
					nimln(186, "hashes.nim");
					TMP311 = addInt(((NI) (((NU8)(c)))), ((NI) 32));
					c = ((NIM_CHAR) (((NI)chckRange((NI)(TMP311), ((NI) 0), ((NI) 255)))));
				}
				LA6: ;
				nimln(187, "hashes.nim");
				h = HEX21HEX26_115004(h, ((NI) (((NU8)(c)))));
				nimln(1895, "system.nim");
				TMP312 = addInt(res_116126, ((NI) 1));
				res_116126 = (NI)(TMP312);
			} LA3: ;
		}
	}
	nimln(188, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

N_NIMCALL(NI, hashignorecase_116130)(NimStringDesc* sbuf, NI spos, NI epos) {
	NI result;
	NI h;
	nimfr("hashIgnoreCase", "hashes.nim")
	result = 0;
	nimln(196, "hashes.nim");
	h = ((NI) 0);
	{
		NI i_116146;
		NI res_116198;
		i_116146 = 0;
		nimln(1874, "system.nim");
		res_116198 = spos;
		{
			nimln(1875, "system.nim");
			while (1) {
				NIM_CHAR c;
				NI TMP314;
				if (!(res_116198 <= epos)) goto LA3;
				nimln(1876, "system.nim");
				i_116146 = res_116198;
				nimln(198, "hashes.nim");
				if ((NU)(i_116146) > (NU)(sbuf->Sup.len)) raiseIndexError();
				c = sbuf->data[i_116146];
				nimln(199, "hashes.nim");
				{
					NI TMP313;
					nimln(1098, "system.nim");
					if (!(((NU8)(c)) >= ((NU8)(65)) && ((NU8)(c)) <= ((NU8)(90)))) goto LA6;
					nimln(200, "hashes.nim");
					TMP313 = addInt(((NI) (((NU8)(c)))), ((NI) 32));
					c = ((NIM_CHAR) (((NI)chckRange((NI)(TMP313), ((NI) 0), ((NI) 255)))));
				}
				LA6: ;
				nimln(201, "hashes.nim");
				h = HEX21HEX26_115004(h, ((NI) (((NU8)(c)))));
				nimln(1895, "system.nim");
				TMP314 = addInt(res_116198, ((NI) 1));
				res_116198 = (NI)(TMP314);
			} LA3: ;
		}
	}
	nimln(202, "hashes.nim");
	result = HEX21HEX24_115027(h);
	popFrame();
	return result;
}

static N_INLINE(NI, hash_116202)(NF x) {
	NI result;
	NF y;
	nimfr("hash", "hashes.nim")
	result = 0;
	nimln(206, "hashes.nim");
	y = ((NF)(x) + (NF)(1.0000000000000000e+00));
	nimln(207, "hashes.nim");
	result = (*((NI*) ((&y))));
	popFrame();
	return result;
}
NIM_EXTERNC N_NOINLINE(void, stdlib_hashesInit000)(void) {
	nimfr("hashes", "hashes.nim")
	popFrame();
}

NIM_EXTERNC N_NOINLINE(void, stdlib_hashesDatInit000)(void) {
}

