(use cv)

(let* ((src (cv-load-image "twittan.jpg"))
       (dst (cv-clone-image src)))
  (cv-smooth src dst CV_GAUSSIAN 11 11 0 0)
  (cv-save-image "output/twi_gausssian_gauche.png" dst))


