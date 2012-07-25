package require Img

image create photo im -file "twittan.jpg" 
im write "twittan_tg.jpg" -grayscale
puts im