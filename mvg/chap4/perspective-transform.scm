(use srfi-1)
(use cv)

(require "../proj2d/proj2d")
(import proj2d)
(load "../cvutil/cvutil.scm")

;; 変換元の4角形
(define src-rect '((5 5) (15 5) (15 15) (5 15)))

;; 行列Hの計算
(define pts-src (map (lambda (p) (make-cv-point-2d32f (first p) (second p))) src-rect))
(define pts-dst (map (lambda (p) (make-cv-point-2d32f (first p) (second p))) '((20 15) (25 20) (25 25) (15 20))))
(define H (make-cv-mat 3 3 CV_32F)) 
(cv-get-perspective-transform pts-src pts-dst H)

;; 結果の確認と表示
(format #t "Projective matrix H~%") 
(print-2d-matrix H)

(define display-transform
  (lambda (H)
    (lambda (x)
      (let ((xh (make-hm-point-2d (first x) (second x))))
        (let ((xdash (transform H xh)))
          (format #t "~A -> ~A~%" x xdash))))))
(map (display-transform H) src-rect)



