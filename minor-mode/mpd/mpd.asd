;;;; mpd.asd

(asdf:defsystem #:mpd
  :serial t
  :description "Describe mpd here"
  :author "Morgan Veyret, Ivy Foster"
  :license "GPLv2"
  :depends-on ("stumpwm")
  :components ((:file "package")
               (:file "mpd")))

