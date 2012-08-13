(use gauche.uvector)
(use cv)

(load "./cvutil.scm")

; Gaussian カーネル
(define gaussian-kernel
  (list->f64vector '(0.00013383062461474178 0.004431861620031266 0.053991127420704416 0.24197144565660075 0.3989434693560978 0.24197144565660075 0.053991127420704416 0.004431861620031266 0.00013383062461474178)))

; Derivative Gaussian カーネル(Gaussian の一次微分)
(define derivative-gaussian-kernel
  (list->f64vector '(-0.0005353224984589671 -0.0132955848600938 -0.10798225484140883 -0.24197144565660075 0.0 0.24197144565660075 0.10798225484140883 0.0132955848600938 0.0005353224984589671)))

(define src (cv-load-image "twittan.jpg"))
(define src-gray (make-image (ref src 'width) (ref src 'height) IPL_DEPTH_8U 1))
(cv-cvt-color src src-gray CV_BGR2GRAY)


(define dst-mat-gx (make-cv-mat (ref src 'height) (ref src 'width)  CV_32F))
(define dst-mat-gy (cv-clone dst-mat-gx))
(define dst-mat-derivative-gaussian (cv-clone dst-mat-gx))

; ガウシアンフィルター行列　
(define gaussian-filter-x (make-cv-mat-from-uvector 1 (uvector-length gaussian-kernel)  1 gaussian-kernel))
(define gaussian-filter-y (make-cv-mat-from-uvector (uvector-length gaussian-kernel) 1 1 gaussian-kernel))
; ガウシアンの一次フィルター行列
(define d-gaussian-filter-x (make-cv-mat-from-uvector 1 (uvector-length derivative-gaussian-kernel)  1 derivative-gaussian-kernel))
(define d-gaussian-filter-y (make-cv-mat-from-uvector (uvector-length derivative-gaussian-kernel) 1 1 derivative-gaussian-kernel))

;; x方向への derivative-gaussian
(cv-filter-2d src-gray dst-mat-gx d-gaussian-filter-x)
(cv-filter-2d dst-mat-gx dst-mat-gx gaussian-filter-y)  ; y方向にはガウシアンフィルターを適用(numpyに準拠)

(cv-save-image "output/twi_derivertive_gaussian_x_gauche.png" (cv-get-image dst-mat-gx))

(cv-filter-2d src-gray dst-mat-gy gaussian-filter-x)
(cv-filter-2d dst-mat-gy dst-mat-gy d-gaussian-filter-y)
(cv-save-image "output/twi_derivertive_gaussian_y_gauche.png" (cv-get-image dst-mat-gy))

(mat-magniture-2d dst-mat-gx dst-mat-gy dst-mat-derivative-gaussian)
(cv-normalize dst-mat-derivative-gaussian dst-mat-derivative-gaussian 255 0 CV_C)
(cv-save-image "output/twi_derivertive_gaussian_gauche.png" (cv-get-image dst-mat-derivative-gaussian))




