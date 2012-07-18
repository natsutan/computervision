
(define-module 2dproj 
  (define-class <2d-point> ()
    (x :init-value 0.0 :init-keyword :x :accessor x-of)
    (y :init-value 0.0 :init-keyword :y :accessor y-of))
  
  (define-class <2d-homo-point> (<2d-point>)
    (w :init-value 1.0 :init-keyword :w :accessor w-of))
    
  (define-class <2d-homo-line> () (a b c))
  
  
  (export <2d-point> <2d-homo-point> <2d-homo-line>)
)




