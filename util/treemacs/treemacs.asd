;;;; treemacs.asd

(asdf:defsystem #:treemacs
  :description "Treemacs is a contrib module for StumpWM"
  :author "Dave Loyall <dave@the-good-guys.net>"
  :license "GPLv3 or later"
  :depends-on (#:stumpwm)
  :serial t
  :components ((:file "package")
               (:file "treemacs")))

