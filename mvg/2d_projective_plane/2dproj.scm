
(define-module 2dproj 
  (define-class <2d-point> ()
    (x :init-value 0.0 :init-keyword :x :accessor x-of)
    (y :init-value 0.0 :init-keyword :y :accessor y-of))
  
  (define-class <2d-homo-point> ()
    (x :init-value 0.0 :init-keyword :x :accessor x-of)
    (y :init-value 0.0 :init-keyword :y :accessor y-of)
    (w :init-value 1.0 :init-keyword :w :accessor w-of))
    
  (define-class <2d-homo-line> () (a b c))


  (define make-2d-homo-line-from-2points
    (lambda (p0 p1)
      ))
  
  (export <2d-point> <2d-homo-point> <2d-homo-line>)
)




