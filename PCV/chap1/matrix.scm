(use cv)

;; 行列の表示
(define print-2d-matrix
  (lambda (m . args)
    (let-keywords args ((name ""))
                  (unless (string=? name "")
                    (format #t "~A = " name))
                  (let ((rows (slot-ref m 'rows))
                        (cols (slot-ref m 'cols)))
                    (display "[")
                    (dotimes (r rows)
                             (display " [")
                             (dotimes (c cols)
                                      (format #t " ~A"  (cv-get-real2d m r c)))
                             (display " ]"))
                    (display "]\n")))))

;; 行列とスカラー値の和  
(define cv-mat-adds-2d
  (lambda (src value dst)
    (cv-mat-operate-2d src dst (lambda (x) (+ x value)))))

;; 行列とスカラー値の和  
(define cv-mat-muls-2d
  (lambda (src value dst)
    (cv-mat-operate-2d src dst (lambda (x) (* x value)))))

;; 行列の各要素に演算を行う                                        
(define cv-mat-operate-2d
  (lambda (src dst op)
    (let ((rows (slot-ref src 'rows))
          (cols (slot-ref src 'cols)))
      (dotimes (r rows)
               (dotimes (c cols)
                        (cv-set-real2d dst r c
                                       (op (cv-get-real2d src r c))))))))

(define a (make-cv-mat-from-uvector 3 3 1 #f64(1.0 -2.0 3.0 4.0 5.0 6.0 -7.0 8.0 -9.0)))
(define b (make-cv-mat-from-uvector 3 3 1 #f64(10.0 -9.0 8.0 7.0 6.0 4.0 -3.0 2.0 -1.0)))
(define x (cv-clone-mat a))

(print-2d-matrix a :name "A")
(print-2d-matrix b :name "B")

(cv-add a b x)
(print-2d-matrix x :name "A + B")

(cv-sub a b x)
(print-2d-matrix x :name "A - B")

(cv-mul a b x)
(print-2d-matrix x :name " A mul B")

(cv-invert a x)
(print-2d-matrix x :name "inv(A)")

(cv-mat-mul a b x)
(print-2d-matrix x :name "A・B")

;(cv-cross-product a b x)
;(print-2d-matrix x :name "a×b")

(format #t "det A = ~A~%" (cv-det a))

(cv-transpose a x)
(print-2d-matrix x  :name "転置 A")

(cv-mat-adds-2d a 5 x)
(print-2d-matrix x :name "A+5")

(cv-mat-muls-2d a 5 x)
(print-2d-matrix x :name "A*5")

;; 3次元ベクトルの内積、外積
(define c (make-cv-mat-from-uvector 3 1 1 #f64(1.0 -2.0 3.0)))
(define d (make-cv-mat-from-uvector 3 1 1 #f64(4.0 -5.0 6.0)))
(define x2 (cv-clone-mat c))
 
(format #t "C・D = ~A~%" (cv-dot-product c d))
(cv-cross-product c d x2)
(print-2d-matrix x2 :name "A×B")