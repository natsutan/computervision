(use cv)

(require "../proj2d/proj2d")
(import proj2d)
	  
(define a (make-hm-point-2d 5 3))
(define b (make-hm-point-2d 11 5))
(define c (make-hm-point-2d 2 2))
(define d (make-hm-point-2d 3 3))

(define l (make-hm-line-2d-from-points a b))

(format #t "c = ~A ~A~%" c (on-line? l c))
(format #t "d = ~A ~A~%" d (on-line? l d))

