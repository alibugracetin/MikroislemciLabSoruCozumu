;AT89s8253 1 makine �evrimi 1.2usn oldugu i�in 1 sn i�in gerekli makine �evrimi:
;	1 sn/1.2u sn = 833334 �evrim yapar. 16 bitlik zamanlayici 1 kullanilarak yapilacak
;olan bu soruda bu kadar �evrime ulasabilmek i�in 833334/65535 = 12,716 defa yapilmasi gerekir. 
;TL1 ve TH1 sayicilarinin 0 dan 65535 e kadar 12 defa sayip ardindan 46924 den 65535 e kadar 
;tekrar saymasi gerekmektedir.46924 sayisi B74Ch sayisina esittir. D�s�k nibble TL1'a 
;y�ksek nibble TH1'a atilmalidir.

	org 00h
		sjmp basla
		
		basla:
		
		mov tmod,#10010000b; 4 ve 5. bit mod1(16 bitlik sayici/zamanlayici modu)
						   ; 6. bit zamanlayici (C/T0 = 0 ise zamanlayici modu)
						   ; 7. bit donanimsal/yazilimsal start (GATE0 = 1 ise donanimsal start)
						   ; Donanimsal start i�in P3.2 pininden lojik 1 olmasi gerekir. 
						   ; bu soruda P3.2 pinine bir buton baglanmadigi ve portlarin reset sonrasi
						   ; degeri FFh oldugu i�in yazilimsal yada donanimsal start vermek birseyi 
						   ; degistirmeyecektir. Her sartta timer/counter 1 �alisacaktir.
						   
		
		mov tl1,#4ch;
		mov th1,#0b7h;
		mov R0,#13d; 12 defa 0 dan 65535'e kadar sayacak 13. sayisi 46924'den 65535'e kadar sayacaktir
		
bekle:	jb P0.0,bekle; 
bekle2: jnb P0.0,bekle2;	26. ve 27. satirda P0.0 butonuna basilip �ekildiginde 1sn araliklarla led yanar

		xx:
		setb tr1; TCON T/C1 baslatiliyor.
		cpl P1.0;
		
		x:
		jnb tf1,x; tasma kontrolu yapiliyor
		clr tf1;   eger tasma varsa temizleniyor
				 ;Tasma ger�eklesirse TCON daki TF1  biti setlenir
				  
		djnz R0,x; Bu islem 12+0,716 defa ger�eklestirilir
		
		;32.satirdan 37. satira kadar 1 sn i�in gerekli olan sayma islemleri ger�eklestirilir.
		
		mov R0,#13d;
		mov tl1,#4ch;
		mov th1,#0b7h;
		;islem sonrasinda degerler tekrar y�klenir
		sjmp xx
		
		end;