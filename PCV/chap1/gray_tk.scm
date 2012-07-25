; tk の初期化
(use tk)
(wish-path "wish")
(with-module tk (set! *tk-debug* #t))
(tk-init '())

; package と image コマンドを使えるようにする。
(define-tk-command tk-package package)
(define-tk-command tk-image image)

; 実際の処理
(tk-package 'require 'Img)
(tk-image 'create 'photo 'im :file "twittan.jpg")
(tk-call 'im 'write "twittan_gg.jpg" '-grayscale)

; tkのウィンドウを閉じる
(tk-shutdown)

;;; 上手く動いたときのデバッグ出力
;> gauche__tk__do package require Img
;< ok
;1.4.0.4
;> gauche__tk__do image create photo im -file "twittan.jpg"
;< ok
;im
;> gauche__tk__do im write "twittan_gg.jpg" -grayscale
;< ok