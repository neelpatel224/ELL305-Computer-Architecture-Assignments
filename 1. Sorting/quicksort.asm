.partition:
	ld r6, [r4]			@ r6 = pivot (last element of array)
	sub r5, r2, 4		@ r5 = i (address of last smaller element in swapping process till now)

	mov r8, r2			@ r8 = j (start to end-4)
	.loop:
		ld r9, [r8]		@ r9 = arr[j]
		
		cmp r9, r6
		bgt .skip		@ if arr[j] is greater than pivot, do nothing

		add r5, r5, 4	@ if arr[j] is less than or equal to pivot, swap (i+1)th and (j)th element
		ld r10, [r5]
		st r9, [r5]
		st r10, [r8]

		.skip:
			nop

		add r8, r8, 4

		cmp r4, r8		@ exit loop, if reached end address of array
		bgt .loop

	add r5, r5, 4		@ swap pivot and arr[i], so finally r5 has address of pivot
	ld r10, [r5]
	st r6, [r5]
	st r10, [r4]
	ret

.quicksort:
	@ ADD YOUR CODE HERE

	@ base case (start < end) (number of elements <= 1)
	cmp r2, r4
	beq .return
	bgt .return

	@ four elements are to be stored in memory
	sub sp, sp, 16

	@ store r4(end address), r2(start address), ra(return address) in memory
	st r4, 4[sp]
	st r2, 8[sp]
	st ra, 12[sp]
	
	@ partition and get r5(pivot address) 
	call .partition

	@ store r5(pivot address) in memory
	st r5, 0[sp]
	
	@ set r4(end) to r5(pivot address)-4 and apply quicksort
	sub r4, r5, 4
	call .quicksort

	@ load r5, r4 from memory
	ld r5, 0[sp]
	ld r4, 4[sp]

	@ set r2(start) to r5(pivot address)+4 and apply quicksort
	add r2, r5, 4
	call .quicksort

	@ load ra (return address) and free memory
	ld ra, 12[sp]
	add sp, sp, 16

	.return:
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

	call .quicksort

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

