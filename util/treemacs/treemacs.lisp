;;;; treemacs.lisp

(in-package #:treemacs
	    (:use #:stumpwm))

;;; "treemacs" goes here. Hacks and glory await!

(defun draw-art ()
  "draw some art. Provided by the treemacs module"
  )  
;;(current-screen)
;;(screen-message-cc screen)


;;(make-ccontext :win message-window
;; :screen screen
;; :font font
;; :gc (xlib:create-gcontext
;;      :drawable message-window
;;      :font (when (typep font 'xlib:font) font)
;;      :foreground fg
;;      :background bg))

;; (message-window (xlib:create-window :parent (xlib:screen-root screen-number)
;;                                     :x 0 :y 0 :width 1 :height 1
;;                                     :background bg
;;                                     :bit-gravity :north-east
;;                                     :border border
;;                                     :border-width 1
;;                                     :colormap (xlib:screen-default-colormap
;;                                                screen-number)
;;                                     :event-mask '(:exposure)))



(defun setup-art-window (screen width height)
  (let ((win (screen-message-window screen)))
    ;; Now that we know the dimensions, raise and resize it.
    (xlib:with-state (win)
      (setf (xlib:drawable-height win) height
            (xlib:drawable-width win) (+ width (* *message-window-padding* 2))
            (xlib:window-priority win) :above)
      (setup-win-gravity screen win *message-window-gravity*))
    (xlib:map-window win)
    (incf (screen-ignore-msg-expose screen))
    ;; Have to flush this or the window might get cleared
    ;; after we've already started drawing it.
    (xlib:display-finish-output *display*)))
