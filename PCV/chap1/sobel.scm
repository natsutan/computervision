(use gauche.uvector)
(use cv)
(load "./cvutil.scm")


(define src (cv-load-image "twittan.jpg"))
(define src-gray (make-image (ref src 'width) (ref src 'height) IPL_DEPTH_8U 1))
(cv-cvt-color src src-gray CV_BGR2GRAY)

; sobelの結果は IPL_DEPTH_32F の深さの画像になる。
(let* ((dst-x (make-image (slot-ref src-gray 'width) (slot-ref src 'height) IPL_DEPTH_32F 1))
       (dst-y (cv-clone-image dst-x))
       (dst-mag (cv-clone-image dst-x)))
  (cv-sobel src-gray dst-x 1 0)
  (cv-sobel src-gray dst-y 0 1)
  (cv-save-image "output/twi_sobel_gauche.png" dst-x)
  (cv-save-image "output/twi_sobel_gauche.png" dst-y)
  (mat-magniture-2d dst-x dst-y dst-mag)
  (cv-save-image "output/twi_sobel_gauche.png" dst-mag))

