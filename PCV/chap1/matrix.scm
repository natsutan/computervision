(use cv)

; 行列の表示
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
  


(define a (make-cv-mat-from-uvector 3 3 1 #f64(1.0 -2.0 3.0 4.0 5.0 6.0 -7.0 8.0 -9.0)))
(define b (make-cv-mat-from-uvector 3 3 1 #f64(10.0 -9.0 8.0 7.0 6.0 4.0 -3.0 2.0 -1.0)))
(define x (cv-clone-mat a))

(print-2d-matrix a :name "A")
(print-2d-matrix b :name "B")

;X = A + B	cvmAdd(A, B, X)	X = A + B
(cv-add a b x)
(print-2d-matrix x :name "A + B")

(cv-sub a b x)
(print-2d-matrix x :name "A - B")

(cv-mul a b x)
(print-2d-matrix x :name " A mul B")

(cv-invert a x)
(print-2d-matrix x :name "inv(A)")

(display "a dot b =")
(print (* a b))
;(print (cv-dot-product a b))
;(print-2d-matrix x :name "a・b")




;X = A・B (内積)	cvmDotProduct(A, B)	X = A.dot(B)
;X = A × B (外積)	cvmCrossProduct(A, B, X)	X = A.cross(B)
;|A| (行列式)	cvmDet(A)	determinant(A)
;print("転置 A")

;print("A + 5")
;print(a + 5)

;print("Aの5倍")
;print(a * 5)
