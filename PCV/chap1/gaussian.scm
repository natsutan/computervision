(use cv)

(let* ((src (cv-load-image "twittan.jpg"))
       (dst (cv-clone-image src)))
  (cv-smooth src dst CV_GAUSSIAN 11 11 0 0)
  (cv-save-image "twittan_g.jpg" dst))


