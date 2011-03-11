Alan Gandarilla		A01087768
Humberto Garza		A01087554

(define (sumatoria n)
	(cond ((> n 0) (+ n (sumatoria(- n 1))))
	      (else (+ n 0))
	)
)

(define (despliegaHola n)
	(cond((> n 0) (display "Hola!")
     		      (newline)
		      (despliegaHola (- n 1)))))
)

(define (secuencia n)
	(cond((> n 1) (display n)(display " ")(secuencia (- n 1)))
	      (else (display "1"))
	)
)

(define (cuentaDigitos n)
	(cond((> n 10)
		(+ 1 (cuentaDigitos (quotient n 10)))
 	     )
	     (else 1)
	)
)

(define (fibo n)
	(cond ((> n 2)
	      (+ (fibo (- n 1)) (fibo (- n 2)))
	      )
	      (else 1)
	)
)
