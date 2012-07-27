(use cv)

(define plot  
  (lambda (dst x y)
    (cv-circle dst
               (make-cv-point x y) ; 中心座標
               3 ; 半径
               (make-cv-scalar 200 0 0) ; 色
               -1 ; thickness
               1 ; 種類
               )))

(let* ((src (cv-load-image "twittan.jpg"))
       (dst (cv-clone-image src)))
  (cv-line dst
           (make-cv-point 100 200)
           (make-cv-point 100 500)
           (make-cv-scalar 200 0 0))
  (plot dst 100 200)
  (plot dst 100 500)
  (cv-save-image "twittan_cc.jpg" dst))
