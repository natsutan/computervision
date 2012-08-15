; Gauche-CV用自作Utitiry

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

;; 行列の各要素に演算を行う                                        
(define cv-mat-operate-2d
  (lambda (src dst op)
    (let ((rows (slot-ref src 'rows))
          (cols (slot-ref src 'cols)))
      (dotimes (r rows)
               (dotimes (c cols)
                        (cv-set-real2d dst r c
                                       (op (cv-get-real2d src r c))))))))

; 画像から行列を作成する
(define copy-image-to-mat
  (lambda (img mat)
    (let ((src-mat (cv-get-mat img))
          (rows (slot-ref mat 'rows))
          (cols (slot-ref mat 'cols)))
      (dotimes (r rows)
              (dotimes (c cols)
                       (cv-set-real2d mat r c (cv-get-real2d src-mat r c)))))))


;; 縦方向と横方向のsobelフィルターの結果から、各画素のsqrt(x^2+y^2)を計算してdstに書き込む
(define-method mat-magniture-2d ((src-x <cv-mat>) (src-y <cv-mat>) dst)
  (let ((width (slot-ref src-x 'cols))
        (height (slot-ref src-x 'rows)))
    (dotimes (h height)
             (dotimes (w width)
                      (cv-set-real2d dst h w
                                     (* 0.5 (mag (cv-get-real2d src-x h w)
                                                 (cv-get-real2d src-y h w))))))))

(define-method mat-magniture-2d ((src-x <iplimage>) (src-y <iplimage>) dst)
    (let ((width (slot-ref src-x 'width))
          (height (slot-ref src-x 'height)))
       (dotimes (h height)
               (dotimes (w width)
                          (cv-set-real2d dst h w
                                         (* 0.5 (mag (cv-get-real2d src-x h w)
                                              (cv-get-real2d src-y h w))))))))

(define mag
  (lambda (x y)
    (sqrt (+ (* x x) (* y y)))))


