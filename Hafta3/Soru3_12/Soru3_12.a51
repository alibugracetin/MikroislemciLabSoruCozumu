org 00h
	sjmp basla
	basla:
	
		bekle:jb P1.0,bekle;  //P1.0 basilmasi bekleniyor
		jnb P1.0,x1;		 //Basilinca x1 dallaniyor.
		
		x1:	
			;//y�ksek nibble icin
			mov a,P3; 
			swap a;				//y�ksek nibble ile d�s�k niblle yer degistiriyor
			anl a,#00001111b;	//d�s�k nibblar filtreleniyor
			mov 10h,a;			//filtrelenilen hali acc'ye atiliyor
				
			mov a,P0;			
			anl a,#00001111b;	//d�s�k nibble filtreleniyor
			
			cjne a,10h,x2; 		//esitdegilse x2 gider
			sjmp x3;			//esitse x3
							
				x3:
					mov a,P0;
					mov b,#4d;
					mul ab;		//P0'in 4kati alinir
					mov P2,a;	//sonuc P2'de g�sterilir
					sjmp basla;
					
				
				x2:
					mov R0,#225d;
					mov a,#0ffh;
					
						x4:
							cpl a;		//P2 yanip sonmesini saglar
							mov P2,a;
							djnz R0,x4;
			
	end