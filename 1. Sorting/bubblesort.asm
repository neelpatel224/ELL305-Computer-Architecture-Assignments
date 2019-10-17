.bubblesort:
	@ ADD YOUR CODE HERE
	@ r2 = start (start address of array)
	@ r3 = n (number of elements in array)

	mul r4, r3, 4
	sub r4, r4, 4			@ r4 = end (end address of array)
	
	mov r9, -1				@ r9 = i for nloop (goes from 0 to n-1)
	.nloop:
		add r9, r9, 1		@ increment in nloop counter

		mov r5, r2			@ r5 = current address

		mul r10, r9, 4
		sub r10, r4, r10	@ r10 = end address for inner loop (after this address, all elements are sorted)
		
		.loop:
			
			add r6, r5, 4	@ r6 = next address
			
			ld r7, [r5]		@ r7 = value at r5
			ld r8, [r6]		@ r8 = value at r6
			
			cmp r8, r7
			bgt .skip		@ if r7 <= r8, no need for swap 
			beq .skip
			st r8, [r5]		@ swapping
			st r7, [r6]

			.skip:
				nop

			mov r5, r6		@ update current address for next loop

			cmp r4, r6		@ check loop breaking condition
			bgt .loop
		
		
		cmp r3, r9			@ check nloop breaking condition
		bgt .nloop
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

	mov r2, 0       @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 6	@ REPLACE 6 WITH N, where, N is the number of numbers being sorted
	
	@ ADD YOUR CODE HERE

	call .bubblesort
	
	@ ADD YOUR CODE HERE

	@ Print statements
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

