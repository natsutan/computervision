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



;; 縦方向と横方向のsobelフィルターの結果から、各画素のsqrt(x^2+y^2)を計算してdstに書き込む
(define calc-mag
  (lambda (src-x src-y dst)
    (let ((width (slot-ref src-x 'width))
          (height (slot-ref src-x 'height)))
       (dotimes (h height)
               (dotimes (w width)
                          (cv-set-real2d dst h w
                                         (* 0.5 (mag (cv-get-real2d src-x h w)
                                              (cv-get-real2d src-y h w)))))))))
  
(define mag
  (lambda (x y)
    (sqrt (+ (* x x) (* y y)))))
    
          
(define src (cv-load-image "box.png"))
(define src-gray (make-image (ref src 'width) (ref src 'height) IPL_DEPTH_8U 1))
(cv-cvt-color src src-gray CV_BGR2GRAY)
(cv-save-image "twi-grayg.jpg" src-gray)

;(define src-gray-mat (cv-get-mat src-gray))

; sobelの結果は IPL_DEPTH_32F の深さの画像になる。
(let* ((dst-x (make-image (slot-ref src-gray 'width) (slot-ref src 'height) IPL_DEPTH_32F 1))
       (dst-y (cv-clone-image dst-x))
       (dst-mag (cv-clone-image dst-x)))
  (cv-sobel src-gray dst-x 1 0)
  (cv-sobel src-gray dst-y 0 1)
  (cv-save-image "sobel_gx.jpg" dst-x)
  (cv-save-image "sobel_gy.jpg" dst-y)
  (calc-mag dst-x dst-y dst-mag)
  (cv-save-image "sobel_g.jpg" dst-mag))


;;http://opencv.jp/opencv-2svn/py/imgproc_image_filtering.html

;  (cv-smooth src dst CV_GAUSSIAN 11 11 0 0)
;  (cv-save-image "twittan_g.jpg" dst))


(define gaussian-derivative-kernel
;  (list->f64vector '(2 0 -2)))
  (list->f64vector '(-0.0008865661415095036 -0.001412685469567413 -0.0021499611530628854 -0.003121889403706018 -0.0043194505939397635 -0.005684639434506561 -0.007099218201540253 -0.008385074439221362 -0.00932130455927855 -0.00967921725836255 -0.009270 -0.007997 -0.005892 -0.003128 0.000000 0.003128 0.005892 0.007997  -0.009270 0.00967921725836255 0.00932130455927855 0.008385074439221362 0.007099218201540253 0.005684639434506561 0.0043194505939397635 0.003121889403706018 0.0021499611530628854 0.001412685469567413 0.0008865661415095036)))
;  (list->f64vector (map (lambda (x) (* x x )) '(-0.0008865661415095036 -0.001412685469567413 -0.0021499611530628854 -0.003121889403706018 -0.0043194505939397635 -0.005684639434506561 -0.007099218201540253 -0.008385074439221362 -0.00932130455927855 -0.00967921725836255 -0.009270 -0.007997 -0.005892 -0.003128 0.000000 0.003128 0.005892 0.007997  -0.009270 0.00967921725836255 0.00932130455927855 0.008385074439221362 0.007099218201540253 0.005684639434506561 0.0043194505939397635 0.003121889403706018 0.0021499611530628854 0.001412685469567413 0.0008865661415095036))))




(let* ((src-gray-n (cv-clone-image src-gray))
       (dst-x (cv-clone-image src-gray))
       (dst-xm (cv-get-mat dst-x))
       (dst-y (cv-clone-image src-gray))
       (dst (cv-clone-image src-gray))
       (dst-mag (cv-clone-image src-gray))
       (gdfilter-x (make-cv-mat-from-uvector 1 29 1 gaussian-derivative-kernel))
       (gdfilter-y (make-cv-mat-from-uvector 29 1 1 gaussian-derivative-kernel)))
  (cv-normalize gdfilter-x gdfilter-x 0.05 0 CV_C)
  (cv-smooth src-gray dst-x CV_GAUSSIAN 29 29 5 0)
  (cv-filter-2d src-gray dst-x gdfilter-x )
  (cv-normalize dst-x dst-x 100 0 CV_C)
  
                                        ;  (cv-mat-adds-2d src-gray-n src-gray-n 100)
                                        ;  (cv-smooth src-gray-n dst-x CV_GAUSSIAN 29 29 5 0)
                                        ;  (cv-filter-2d dst-x dst-x gdfilter-x )
                                        ; (cv-mat-adds-2d src-gray-n src-gray-n -100)
  (cv-save-image "box_gx.png" dst-x)
                                        ;  (cv-normalize gdfilter-x gdfilter-x 0.05 0 CV_C)
                                        ;
  
                                        ;  (print-2d-matrix gdfilter-x :name "gdfx(norm)")
                                        ;  (print-2d-matrix gdfilter-y :name "gdfy(norm)")
  
                                        ;  (cv-smooth src-gray dst-xm CV_GAUSSIAN 29 29 5 0)
                                        ;  (cv-filter-2d src-gray dst-xm gdfilter-x )
  
                                        ;  (print-2d-matrix dst-xm)
                                        ;  (calc-mag dst-x dst-x dst-mag)
;  (print-2d-matrix dst-mag)
  
                                        ;  (cv-smooth src-gray dst-y CV_GAUSSIAN 29 29 5 0)
                                        ;  (cv-filter-2d dst-y dst-y gdfilter-y )  
  
                                        ;  (cv-normalize dst-x dst-x 200 0 CV_C)
                                        ;  (cv-normalize dst-y dst-y 200 0 CV_C)
                                        ;  (cv-save-image "box_gx.png" dst-x)
                                        ;  (cv-save-image "box_gy.png" dst-y)
                                        ;  (calc-mag dst-x dst-y dst-mag)
                                        ;  (cv-save-image "box_mag.png" dst-mag)
  )



