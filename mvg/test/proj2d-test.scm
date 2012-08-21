(use cv)

(use gauche.test)
(test-start "proj2d")
(load "../proj2d/proj2d.scm")  ; テストすべきプログラムをロード
(import proj2d)  ; モジュールを定義している場合はインポート

(test-module 'proj2d) ; モジュールの一貫性チェック

;;; <hm-point-2d>
(test-section "hm-point-2d")
(define a (make-hm-point-2d 5 3))
(test* "x-of" 5.0 (x-of a))
(test* "y-of" 3.0 (y-of a))

(define b (make-hm-point-2d 4 2))
(test* "equal0" #t (equal? a a))
(test* "equal1" #f (equal? a b))

;;; <hm-line-2d>
(test-section "hm-point-line")
(test* "error" (test-error) (make-hm-line-2d-from-points a a))

(define a (make-hm-point-2d 5 3))
(define b (make-hm-point-2d 11 5))
(define c (make-hm-point-2d 2 2))
(define d (make-hm-point-2d 3 3))
(define l (make-hm-line-2d-from-points a b))
(test* "on-line0" #t (on-line? l a))
(test* "on-line1" #t (on-line? l b))
(test* "on-line2" #t (on-line? l c))
(test* "on-line3" #f (on-line? l d))

(define a (make-hm-point-2d 5 3))
(define b (make-hm-point-2d 11 5))
(define c (make-hm-point-2d 2 5))
(define d (make-hm-point-2d 5 0))
(define l0 (make-hm-line-2d-from-points a b))
(define l1 (make-hm-line-2d-from-points c d))

(define x (intersection-of-lines l0 l1))
(test* "intersection" (make-hm-point-2d 3.5 2.5) (intersection-of-lines l0 l1))

(test-end :exit-on-failure #t)