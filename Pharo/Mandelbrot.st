'From Pharo10.0.0 of 31 March 2022 [Build information: Pharo-10.0.0+build.507.sha.d573db28acad28e61f3de16d51cd9e269e0196b5 (64 Bit)] on 20 April 2022 at 10:55:20.134 pm'!
Object subclass: #Mandelbrot
	instanceVariableNames: 'width height maxd result'
	classVariableNames: ''
	package: 'Mandelbrot'!
!Mandelbrot commentStamp: 'JorgRamb 4/3/2022 09:03' prior: 0!
I represent a Mandelbrot generating instance!


!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/13/2022 22:36'!
generate: toStream

	"https://stackoverflow.com/questions/34232965/how-to-construct-a-string-instance-from-a-sequence-of-integers"

	^ result := (1.0 to: -1.0 by: -2.0 / (height - 1)) collect: [ :y | 
		            (-2.0 to: 1.0 by: 3.0 / (width - 1))
			            collect: [ :x | 
				            | d c |
				            "d := self mzReal: x Imaginary: y. Optimized version, but ugly"
				            d := self mz: x + y i.
				            c := d < 0
					                 ifTrue: [ Character space ]
					                 ifFalse: [ 
					                 Character value: $a asciiValue + (d % 26) ].
				            toStream nextPut: c.
				            c ]
			            as: String.
		            toStream
			            nextPut: Character cr.
			            toStream flush ]! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/13/2022 22:44'!
mzReal: cx Imaginary: cy

	| zx zy x2 y2 i |
	zx := 0.0.
	zy := 0.0.
	x2 := 0.0.
	y2 := 0.0.
	i := 0.
	[ 	zy := zx * zy * 2 + cy.
	zx := x2 - y2 + cx.
	x2 := zx * zx.
	y2 := zy * zy.
	i := i + 1 ] doWhileFalse: [ i >= maxd | (x2 + y2 >= 4.0) ].
	^ i < maxd
		  ifTrue: [ i ]
		  ifFalse: [ -1 ]! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/13/2022 22:45'!
mz: c

	"z(n+1) = zn^2 + c
	This version requires the Complex package:
	Metacello new
		smalltalkhubUser: 'Pharo' project: 'MetaRepoForPharo70';
		configuration: 'Complex';
		version: #stable;
		load.
	"

	| z i |
	z := 0.0 + 0.0 i.
	i := 0.
	[ 
	z := z squared + c.
	i := i + 1.] doWhileFalse: [ 
	i >= maxd | (z squaredNorm >= 4.0) ].

	^ i < maxd
		  ifTrue: [ i ]
		  ifFalse: [ -1 ]! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/13/2022 22:53'!
generate

	"https://stackoverflow.com/questions/34232965/how-to-construct-a-string-instance-from-a-sequence-of-integers"

	^ result := (1.0 to: -1.0 by: -2.0 / (height - 1)) collect: [ :y | 
		            (-2.0 to: 1.0 by: 3.0 / (width - 1))
			            collect: [ :x | 
				            | d |
				            "d := self mzReal: x Imaginary: y. Optimized version, but ugly"
				            d := self mz: x + y i.
				             (d < 0
						             ifTrue: [ Character space ]
						             ifFalse: [ 
						             Character value: $a asciiValue + (d % 26) ]) ]
			            as: String ]! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/5/2022 08:18'!
maxd: anInteger

	maxd := anInteger! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/4/2022 23:26'!
width: anObject

	width := anObject! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/13/2022 22:23'!
generateFast

	"https://stackoverflow.com/questions/34232965/how-to-construct-a-string-instance-from-a-sequence-of-integers"

	^ result := (1.0 to: -1.0 by: -2.0 / (height - 1)) collect: [ :y | 
		            (-2.0 to: 1.0 by: 3.0 / (width - 1))
			            collect: [ :x | 
				            | d |
				            d := self mzReal: x Imaginary: y. "Optimized version, but ugly"
				            "d := self mz: x + y i."
				            d < 0
					            ifTrue: [ Character space ]
					            ifFalse: [ Character value: $a asciiValue + (d % 26) ] ]
			            as: String ]! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/4/2022 23:26'!
result

	^ result! !

!Mandelbrot methodsFor: 'accessing' stamp: 'JorgRamb 4/4/2022 23:26'!
height: anObject

	height := anObject! !


!Mandelbrot methodsFor: 'initialization' stamp: 'JorgRamb 4/4/2022 23:30'!
initialize

	width := 140.
	height := 50.
	maxd := 1e5.
	^ self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Mandelbrot class
	instanceVariableNames: ''!

!Mandelbrot class methodsFor: 'accessing' stamp: 'JorgRamb 4/20/2022 22:21'!
run

<example>
	Transcript clear
		show: ((self new
				  maxd: 1e5;
				  generate) joinUsing: Character cr);
		cr.
	^ nil! !
