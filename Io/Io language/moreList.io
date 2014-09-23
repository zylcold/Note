
ListCount := Object clone
ListCount listc := method(
		a ,
		i := 0
		m := 0
	while(i < (a size),	
		z := 0
		while(z < (a  at(i) size),
			m = m + (a at(i) at(z))
			z = z + 1
		)
		i =i + 1 
	)
		m println
	)
	

a := list (1,2,3,4,5,6,7,8,9)
c := list(a,a)
ListCount listc(c)