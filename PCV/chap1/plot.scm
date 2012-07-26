;http://opencv.jp/cookbook/opencv_drawing.html

(use cv)

(let* ((src (cv-load-image "twittan.jpg"))
       (dst (cv-clone-image src)))
  (cv-line dst
           (make-cv-point 100 200)
           (make-cv-point 100 500)
           (make-cv-scalar 200 0 0))
  (cv-save-image "twittan_cc.jpg" dst)

  )
