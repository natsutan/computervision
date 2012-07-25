(use cv)

(let* ((src (cv-load-image "twittan.jpg"))
       (dst (cv-clone-image src))
       (region_x 10)
       (region_y 300)
       (region_h 150)
       (region_w 110)
       (region (make-image region_w region_h  (ref src 'depth) (ref src 'n-channels)))
       (box (make-cv-rect region_x region_y region_w region_h)))
  ; 領域をコピーして反転
  (slot-set! src 'roi box)
  (cv-copy src region)
  (cv-flip region region -1)
  ; コピー先にroiを設定し、コピー後元に戻す。
  (let ((roi-save (slot-ref dst 'roi)))
    (slot-set! dst 'roi box)
    (cv-copy region dst)
    (slot-set! dst 'roi roi-save))
  
  (cv-save-image "twittan_cc.jpg" dst))


