(define (readall port result) 
        (let ((line (read-line port)))
        (if (eof-object? line) (reverse result)
            (cons line (readall port result)))))
(define inp (readall (open-input-file "3.txt") ()))
;; extend input horizontally, because I'm too lazy to rewrite to mod
(define ext-inp (list->vector
        (let* ((l (length inp))
              (b (string-length (car inp)))
              (n (+ 1 (quotient (* l 7) b))))
             (map (lambda (s) (fold-left string-append "" (make-list n s)))
                  inp))))
(define (at x y) (eq? (string-ref (vector-ref ext-inp y) x) #\#))
(define (count y n slope)
        (cond ((= y (length inp)) n)
              ((at (* slope y) y) (count (+ y 1) (+ n 1) slope))
              (else (count (+ y 1) n slope))))
(define (count2 x n)
        (cond ((> (* 2 x) (length inp)) n)
              ((at x (* 2 x)) (count2 (+ x 1) (+ n 1)))
              (else (count2 (+ x 1) n))))
(newline)
(display (count 0 0 3))
(newline)
(display (* (count 0 0 1) (count 0 0 3) (count 0 0 5) (count 0 0 7) (count2 0 0)))
