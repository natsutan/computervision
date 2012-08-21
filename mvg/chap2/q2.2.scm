(use cv)

(require "../proj2d/proj2d")
(import proj2d)
	  
(define a (make-hm-point-2d 5 3))
(define b (make-hm-point-2d 11 5))
(define c (make-hm-point-2d 2 5))
(define d (make-hm-point-2d 5 0))
(define l0 (make-hm-line-2d-from-points a b))
(define l1 (make-hm-line-2d-from-points c d))

(define x (intersection-of-lines l0 l1))
(format #t "~A~%" x)
