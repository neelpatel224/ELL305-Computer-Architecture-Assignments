.mergesort:
	@ ADD YOUR CODE HERE
	@ base case (start = end) (length of array = 1)
	cmp r11, r12
	beq .return

	@ set r13 = (r11+r12)/2
	add r13, r11, r12
	div r13, r13, 8
	mul r13, r13, 4

	@ store r11, r12, r13, ra
	sub sp, sp, 16
	st r11, 0[sp]
	st r12, 4[sp]
	st r13, 8[sp]
	st ra, 12[sp]

	@ set r12 to r13 and apply mergesort
	mov r12, r13
	call .mergesort

	@ load r11, r12, r13
	ld r11, 0[sp]
	ld r12, 4[sp]
	ld r13, 8[sp]

	@ set r11 to r13 + 4 and apply mergesort
	add r11, r13, 4
	call .mergesort

	@ load r11, r12, r13
	ld r11, 0[sp]
	ld r12, 4[sp]
	ld r13, 8[sp]
 
	call .merge

	@ load ra (return address)	
	ld ra, 12[sp]
	add sp, sp, 16

	.return:
		ret

	
.merge:
	@ ADD YOUR CODE HERE
	
	@ r8 = n (number of numbers being sorted)
	sub r8, r12, r11
	div r8, r8, 4
	add r8, r8, 1
	@ r9, r10 => end address of [r11, r13], [r13+4, r12]
	mov r9, r13
	mov r10, r12
	
	@ rloop reads from the two sorted arrays from end and stores the elements in decreasing order in memory 
	@ till and sorted array is completely stored in memory
	.rloop:
		cmp r11, r9
		bgt .exit_rloop
		cmp r13, r10
		beq .exit_rloop
		bgt .exit_rloop

		ld r5, [r9]
		ld r6, [r10]

		@ add max(r5, r6) in memory
		sub sp, sp, 4
		cmp r5, r6
		bgt .store_rfive
		st r6, [sp]
		sub r10, r10, 4
		b .stored
		.store_rfive:
			st r5, [sp]
			sub r9, r9, 4
		.stored:
			nop
		
		b .rloop

		.exit_rloop:
			nop
	
	@ stores the leftout elements from first(left) sorted subarray into the memory
	.rloop1:
		cmp r11, r9
		bgt .exit_rloop1
		ld r5, [r9]
		sub sp, sp, 4
		st r5, [sp]
		sub r9, r9, 4

		b .rloop1

		.exit_rloop1:
			nop

	@ stores the leftout elements from second(right) sorted subarray into the memory
	.rloop2:
		cmp r13, r10
		bgt .exit_rloop2
		beq .exit_rloop2

		ld r6, [r10]
		sub sp, sp, 4
		st r6, [sp]
		sub r10, r10, 4
		b .rloop2

		.exit_rloop2:
			nop


	@ load the values back into the actual array locations
	mov r7, 0
	.writeloop:
		ld r6, [sp]
		st r6, [r11]
		add sp, sp, 4
		add r11, r11, 4

		add r7, r7, 1
		cmp r8, r7
		bgt .writeloop

	ret


.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12	@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7	@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11  @ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   @ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3   @ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  @ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0          @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 5	@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3
	
	
	@ ADD YOUR CODE HERE 
	@ r11 = staring address of integer array
	mov r11, r2
	@ r12 = end address (last element)
	mov r12, r4
	call .mergesort

	@ ADD YOUR CODE HERE 

	@ Print statements for the result
	ld r1, 0[r0]
	.print r1
	ld r1, 4[r0]
	.print r1
	ld r1, 8[r0]
	.print r1
	ld r1, 12[r0]
	.print r1
	ld r1, 16[r0]
	.print r1
	ld r1, 20[r0]
	.print r1
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

