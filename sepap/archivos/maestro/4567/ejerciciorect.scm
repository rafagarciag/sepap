(define (sumatoria n)
	(cond ((> n 0) (+ n (sumatoria(- n 1))))
	      (else (+ n 0))
	)
)

