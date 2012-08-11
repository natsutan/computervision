(use gauche.uvector)
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

(define copy-image-to-mat
  (lambda (img mat)
    (let ((src-mat (cv-get-mat img))
          (rows (slot-ref mat 'rows))
          (cols (slot-ref mat 'cols)))
      (dotimes (r rows)
              (dotimes (c cols)
                       (cv-set-real2d mat r c (cv-get-real2d src-mat r c)))))))
      
;; 行列とスカラー値の和  
(define cv-mat-adds-2d
  (lambda (src value dst)
    (cv-mat-operate-2d src dst (lambda (x) (+ x value)))))

;; 行列とスカラー値の和  
(define cv-mat-muls-2d
  (lambda (src value dst)
    (cv-mat-operate-2d src dst (lambda (x) (* x value)))))

;; 行列とスカラー値の和  
(define cv-mat-sqrt-2d
  (lambda (src dst)
    (cv-mat-operate-2d src dst (lambda (x) (sqrt x)))))


;; 行列の各要素に演算を行う                                        
(define cv-mat-operate-2d
  (lambda (src dst op)
    (let ((rows (slot-ref src 'rows))
          (cols (slot-ref src 'cols)))
      (dotimes (r rows)
               (dotimes (c cols)
                        (cv-set-real2d dst r c
                                       (op (cv-get-real2d src r c))))))))



(define src (cv-load-image "box.png"))
(define src-gray (make-image (ref src 'width) (ref src 'height) IPL_DEPTH_8U 1))
(cv-cvt-color src src-gray CV_BGR2GRAY)

(define dst-mat-x (make-cv-mat 100 100 CV_64FC1))
(define dst-mat-mx (cv-clone-mat dst-mat-x))
(define dst-mat-mx2 (cv-clone-mat dst-mat-x))

(define dst-mat-y (make-cv-mat 100 100 CV_64FC1))
(define dst-mat-my (cv-clone-mat dst-mat-x))

(define dst-mat-mag (make-cv-mat 100 100 CV_64FC1))


                                        ;(copy-image-to-mat src-gray dst-mat)

(define gaussian-derivative-kernel
;  (list->f64vector '(2 0 -2)))
  (list->f64vector '(-0.0008865661415095036 -0.001412685469567413 -0.0021499611530628854 -0.003121889403706018 -0.0043194505939397635 -0.005684639434506561 -0.007099218201540253 -0.008385074439221362 -0.00932130455927855 -0.00967921725836255 -0.009270 -0.007997 -0.005892 -0.003128 0.000000 0.003128 0.005892 0.007997  -0.009270 0.00967921725836255 0.00932130455927855 0.008385074439221362 0.007099218201540253 0.005684639434506561 0.0043194505939397635 0.003121889403706018 0.0021499611530628854 0.001412685469567413 0.0008865661415095036)))

(define gaussian-kernel
  (list->f64vector '(0.057938 0.066645 0.073654 0.078209 0.079788 0.078209 0.073654 0.066645 0.057938)))

(define gdfilter-x (make-cv-mat-from-uvector 1 29 1 gaussian-derivative-kernel))
(define gfilter-y (make-cv-mat-from-uvector 9 1 1 gaussian-kernel))

(define gdfilter-y (make-cv-mat-from-uvector 29 1 1 gaussian-derivative-kernel))
(define gfilter-x (make-cv-mat-from-uvector 1 9 1 gaussian-kernel))

(cv-normalize gdfilter-x gdfilter-x 0.1 0 CV_C)
;(cv-filter-2d src-gray dst-mat-x gfilter-x )
;(cv-filter-2d dst-mat-x dst-mat-x gfilter-y )
(cv-filter-2d src-gray dst-mat-x gdfilter-x  (make-cv-point 15 0))
(cv-mul dst-mat-x dst-mat-x dst-mat-mx)
(cv-mat-sqrt-2d dst-mat-mx dst-mat-mx2)
(cv-save-image "box_test_mat.jpg" (cv-get-image dst-mat-mx2))


;(cv-normalize gfilter-y gfilter-y 0.1 0 CV_C)
(cv-filter-2d src-gray dst-mat-x gdfilter-x )
;(cv-filter-2d dst-mat-x dst-mat-x gfilter-y )
(cv-mul dst-mat-x dst-mat-x dst-mat-mx)

(cv-filter-2d src-gray dst-mat-y gdfilter-y)
;(cv-filter-2d dst-mat-y dst-mat-y gfilter-x )
(cv-mul dst-mat-y dst-mat-y dst-mat-my)
;(cv-save-image "box_test_y.jpg" (cv-get-image dst-mat-my))

(cv-add dst-mat-mx dst-mat-my dst-mat-mag)
(cv-normalize dst-mat-mag dst-mat-mag 255.0 0 CV_C)


;(cv-set-real2d dst-mat 0 0 30.5)
;(cv-set-real2d dst-mat 0 1 -10.5)
;(print-2d-matrix dst-mat)

;(cv-smooth src-gray dst-mat CV_GAUSSIAN 11 11 0 0)
;(define dst-mat (cv-get-mat src-gray))
;(print-2d-matrix dst-mat-mx)
(cv-save-image "box_test.jpg" (cv-get-image dst-mat-mag))



