#include <MOR_Header.h>

#ifndef GENERAL_MACROS_H

#define PVAR_1(VAR) private #VAR
#define PVAR_2(VAR1,VAR2) private [#VAR1,#VAR2]
#define PVAR_3(VAR1,VAR2,VAR3) private [#VAR1,#VAR2,#VAR3]
#define PVAR_4(VAR1,VAR2,VAR3,VAR4) private [#VAR1,#VAR2,#VAR3,#VAR4]
#define PVAR_5(VAR1,VAR2,VAR3,VAR4,VAR5) private [#VAR1,#VAR2,#VAR3,#VAR4,#VAR5]

#define PVAR_VAL_1(VAR) PVAR_1(VAR); VAR

#define PARAM_1(ONE) PVAR_1(ONE); ONE = _this select 0
#define PARAM_2(ONE,TWO) PVAR_2(ONE,TWO); ONE = _this select 0; TWO = _this select 1
#define PARAM_3(ONE,TWO,THREE) PVAR_3(ONE,TWO,THREE); ONE = _this select 0; TWO = _this select 1; THREE = _this select 2
#define PARAM_4(ONE,TWO,THREE,FOUR) PVAR_4(ONE,TWO,THREE,FOUR); ONE = _this select 0; TWO = _this select 1; THREE = _this select 2; FOUR = _this select 3
#define PARAM_5(ONE,TWO,THREE,FOUR,FIVE) PVAR_5(ONE,TWO,THREE,FOUR,FIVE); ONE = _this select 0; TWO = _this select 1; THREE = _this select 2; FOUR = _this select 3; FIVE = _this select 4

#define WAIT(CODE,DELAY) waitUntil {sleep DELAY;CODE;}
#define PRECOMPILE(PATH) call compile preProcessFileLineNumbers PATH

#endif // GENERAL_MACROS_H