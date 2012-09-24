(define-module proj2d
  (use cv)
  (define delta 0.0001)
  
  ;;; <hm-point-2d>
  (define-class <hm-point-2d> ()
    ((matrix :accessor mat)))
  
  (define-method initialize ((self <hm-point-2d>) initializes)
    (next-method)
    (set! (ref self 'matrix) (make-cv-mat 1 3 CV_32FC1)))
  
  (define make-hm-point-2d
    (lambda (x y)
      (let* ((p (make <hm-point-2d>))
             (m (mat p)))
        (cv-set-real2d m 0 0 x)
        (cv-set-real2d m 0 1 y)
        (cv-set-real2d m 0 2 1.0)
        p)))

  (define make-hm-point-2d-from-3value
    (lambda (x y w)
      (let* ((p (make <hm-point-2d>))
             (m (mat p)))
        (cv-set-real2d m 0 0 x)
        (cv-set-real2d m 0 1 y)
        (cv-set-real2d m 0 2 w)
        p)))
  
  (define x-of
    (lambda (p)
      (let* ((m (mat p))
             (x (cv-get-real2d m 0 0))
             (w (cv-get-real2d m 0 2)))
        (/ x w))))
  
  (define y-of
    (lambda (p)
      (let* ((m (mat p))
             (y (cv-get-real2d m 0 1))
             (w (cv-get-real2d m 0 2)))
        (/ y w))))

  (define-method object-equal? ((a <hm-point-2d>) (b <hm-point-2d>))
    (and (equal? (x-of a) (x-of b))
         (equal? (y-of a) (y-of b))))

  
  (define-method write-object ((p <hm-point-2d>) port)
    (format port "(~a, ~a)" (x-of p) (y-of p)))

  ;;; <hm-line-2d>
  ;;; ax + by + c = 0
  (define-class <hm-line-2d> ()
    ((matrix :accessor mat)))

  (define-method initialize ((self <hm-line-2d>) initializes)
    (next-method)
    (set! (ref self 'matrix) (make-cv-mat 1 3 CV_32FC1)))
  
  (define a-of
    (lambda (p)
      (let ((m (mat p)))
        (cv-get-real2d m 0 0))))
  
  (define b-of
    (lambda (p)
      (let* ((m (mat p)))
        (cv-get-real2d m 0 1))))
  
  (define c-of
    (lambda (p)
      (let ((m (mat p)))
        (cv-get-real2d m 0 2))))

  (define make-hm-line-2d-from-points
    (lambda (p0 p1)
      (let ((l (make <hm-line-2d>))
            (a (- (y-of p1) (y-of p0)))
            (b (- (x-of p0) (x-of p1)))
            (c (- (* (y-of p0) (x-of p1))
                  (* (x-of p0) (y-of p1)))))
        (when (and (equal? a 0.0) (equal? b 0.0))
          (error "2 point are same." ))
        (let ((m (mat l)))
          (cv-set-real2d m 0 0 a)
          (cv-set-real2d m 0 1 b)
          (cv-set-real2d m 0 2 c)
          l))))
  
  (define-method write-object ((p <hm-line-2d>) port)
    (format port "~ax + ~ay + ~a = 0" (a-of p) (b-of p) (c-of p)))

  (define on-line?
    (lambda (l p)
      (let ((matl (mat l))
            (matp (mat p)))
        (let ((r (cv-dot-product matp matl)))
          (< (abs r) delta)))))
            
  (define intersection-of-lines
    (lambda (l0 l1)
      (let ((x (cv-clone-mat (mat l0)))
            (p (make <hm-point-2d>)))
        (cv-cross-product (mat l0) (mat l1) x)
        (set! (mat p) x)
        p)))


  ;; transform by projective matrix H
  (define-method transform ((H <cv-mat>) (x <hm-point-2d>))
    (let ((a00 (cv-get-real2d H 0 0))
          (a01 (cv-get-real2d H 0 1))
          (a02 (cv-get-real2d H 0 2))
          (a10 (cv-get-real2d H 1 0))
          (a11 (cv-get-real2d H 1 1))
          (a12 (cv-get-real2d H 1 2))
          (a20 (cv-get-real2d H 2 0))
          (a21 (cv-get-real2d H 2 1))
          (a22 (cv-get-real2d H 2 2)))
      (let ((xdash (+ (* (x-of x) a00) (* (y-of x) a01) a02))
            (ydash (+ (* (x-of x) a10) (* (y-of x) a11) a12))
            (wdash (+ (* (x-of x) a20) (* (y-of x) a21) a22)))
        (make-hm-point-2d-from-3value xdash ydash wdash))))

  
  (export <hm-point-2d> x-of y-of make-hm-point-2d
          <hm-line-2d> a-of b-of c-of make-hm-line-2d-from-points
          on-line? intersection-of-lines
          transform
          )
)



