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

;; 縦方向と横方向のsobelフィルターの結果から、各画素のsqrt(x^2+y^2)を計算してdstに書き込む
(define mat-magniture-2d
  (lambda (src-x src-y dst)
    (let ((width (slot-ref src-x 'cols))
          (height (slot-ref src-x 'rows)))
       (dotimes (h height)
               (dotimes (w width)
                          (cv-set-real2d dst h w
                                         (* 0.5 (mag (cv-get-real2d src-x h w)
                                              (cv-get-real2d src-y h w)))))))))
  
(define mag
  (lambda (x y)
    (sqrt (+ (* x x) (* y y)))))
    


(define src (cv-load-image "twittan.jpg"))
;(define src (cv-load-image "box.png"))
(define src-gray (make-image (ref src 'width) (ref src 'height) IPL_DEPTH_8U 1))
(cv-cvt-color src src-gray CV_BGR2GRAY)
(cv-save-image "src_gray.jpg" src-gray)

(define dst-mat-gx (make-cv-mat (ref src 'height) (ref src 'width)  CV_32F))
(define dst-mat-g (cv-clone dst-mat-gx))

(define dst-mat-gdx (cv-clone dst-mat-gx))
(define dst-mat-gdy (cv-clone dst-mat-gx))
(define dst-mat-gdmag (cv-clone dst-mat-gx))

(define gaussian-kernel
  (list->f64vector '(0.00013383062461474178 0.004431861620031266 0.053991127420704416 0.24197144565660075 0.3989434693560978 0.24197144565660075 0.053991127420704416 0.004431861620031266 0.00013383062461474178)))

(define derivative-gaussian-kernel
  (list->f64vector '(-0.0005353224984589671 -0.0132955848600938 -0.10798225484140883 -0.24197144565660075 0.0 0.24197144565660075 0.10798225484140883 0.0132955848600938 0.0005353224984589671)))

(define gfilter-x (make-cv-mat-from-uvector 1 (uvector-length gaussian-kernel)  1 gaussian-kernel))
(define gfilter-y (make-cv-mat-from-uvector (uvector-length gaussian-kernel) 1 1 gaussian-kernel))

(define gdfilter-x (make-cv-mat-from-uvector 1 (uvector-length derivative-gaussian-kernel)  1 derivative-gaussian-kernel))
(define gdfilter-y (make-cv-mat-from-uvector (uvector-length derivative-gaussian-kernel) 1 1 derivative-gaussian-kernel))

(display 'a)

;(cv-normalize gfilter-x gfilter-x 1 0 CV_C)

(cv-filter-2d src-gray dst-mat-gx gfilter-x)
(display 'b)

(cv-filter-2d dst-mat-gx dst-mat-g gfilter-y)

(cv-save-image "box_test_g.jpg" (cv-get-image dst-mat-g))
(display 'c)


(cv-filter-2d src-gray dst-mat-gdx gdfilter-x)
(cv-filter-2d dst-mat-gdx dst-mat-gdx gfilter-y)
(cv-save-image "box_test_gdx.jpg" (cv-get-image dst-mat-gdx))
;(print-2d-matrix dst-mat-gdx)

(cv-filter-2d src-gray dst-mat-gdy gdfilter-y)
(cv-filter-2d dst-mat-gdy dst-mat-gdy gfilter-x)
(cv-save-image "box_test_gdy.jpg" (cv-get-image dst-mat-gdy))
;(print-2d-matrix dst-mat-gdx)
(display 'd)

(mat-magniture-2d dst-mat-gdx dst-mat-gdy dst-mat-gdmag)
(cv-save-image "box_test_gdmag.jpg" (cv-get-image dst-mat-gdmag))
(display 'e)
                                        ;(cv-normalize gfilter-y gfilter-y 0.1 0 CV_C)




