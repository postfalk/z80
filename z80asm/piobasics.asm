org 00000h

loop: ld a,00fh
	  out (003h),a
	  ld a,0ffh
	  out (002h),a
	  jp loop
