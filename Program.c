//C program

int func(int arg0, int arg1) {
	if (arg0 < arg1) {
		return arg0;
	}
	else if (arg0 > arg1) {
		return arg1;
	}
	else {
		return 0;
	}
}

int main(int argc, int argv[]) {
	//Load arguments
	int arg0 = argv[0];
	int arg1 = argv[1];
	
	//Call func and store output into argv[2]
	argv[2] = func(arg0, arg1);
	
	//Increment argv[2]
	argv[2]++;
	
	//Simple for loop
	for (int i = 3; i >= 1; i--);
	
	return 0;
}

//Assembly program (address of instruction to the left of instruction)
//Program should stop at 112 HALT

main:
		//Retrieve arguments
100		MOV r2, 0
101		LD r0, r2 //arg0 = argv[0]
102		MOV r2, 1
103		LD r1, r2 //arg1 = argv[1]
		
		//Call func
104		MVR LR, PC
105		B func
		
		//Store output of func into argv[2]
106		MOV r2, 2
107		STR r2, r0 
		
		//Increment argv[2]
108		MOV r0, 1
109		LD r1, r2
10A		ADD r1, r0, r1
10B		STR r2, r1
		
		//Simple for loop
10C		MOV r1, 3 //i = 0
loop:	
		//i >= 1
10D		CMP r1,r0
10E		BLT loop_exit
		//i--
10F		SUB r1, r1, r0
110		B loop
		
loop_exit:
		//return 0
111		MOV r0, 0
112		HALT
		
func:
113		CMP r0, r1
114		BLT func_end
115		BGT great
		//Equal
116		MOV r0, 0
117		B func_end
great:
118		MVR r0, r1
func_end:
		//return
119		MOV r1, 1
11A		ADD LR, LR, r1
11B		MVR PC, LR
