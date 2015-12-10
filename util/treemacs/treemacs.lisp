;;;; treemacs.lisp

(in-package #:treemacs)

;;; "treemacs" goes here. Hacks and glory await!

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


;; (defun make-mode-line-window (parent screen)
;;   "Create a window suitable for a modeline."
;;   (xlib:create-window
;;    :parent parent
;;    :x 0 :y 0 :width 1 :height 1
;;    :background (alloc-color screen *mode-line-background-color*)
;;    :border (alloc-color screen *mode-line-border-color*)
;;    :border-width *mode-line-border-width*
;;    ;; You can click the modeline
;;    :event-mask (xlib:make-event-mask :button-press :exposure)
;;    ;; these windows are not controlled by the window manager
;;    :override-redirect :on))


(defun setup-art-window (screen win width height)
   
  ;; raise and resize it.
  (xlib:with-state (win)
    (setf (xlib:drawable-height win) height
	  (xlib:drawable-width win) (+ width (* *message-window-padding* 2))
	  (xlib:window-priority win) :above)
    (stumpwm::setup-win-gravity screen win *message-window-gravity*))
  (xlib:map-window win)
  ;; Have to flush this or the window might get cleared
  ;; after we've already started drawing it.
  (xlib:display-finish-output *display*))




(defun make-art-window-gc (window screen)
  (xlib:create-gcontext :drawable window
                        :font (when (typep (stumpwm::screen-font screen) 'xlib:font) (stumpwm::screen-font screen))
                        :foreground (stumpwm::alloc-color screen *mode-line-foreground-color*)
                        :background (stumpwm::alloc-color screen *mode-line-background-color*)))


(defun make-art-window ()
  "\"It is good to love many things, for therein lies the true strength,
     and whosoever loves much performs much, and can accomplish much,
     and what is done in love is well done.\" --Vincent van Gogh"
  (let* ((screen (current-screen))
	 (screen-number (stumpwm::screen-number screen)))
    (let ((window (xlib:create-window :parent (xlib:screen-root screen-number)
			:x 100 :y 0 :width 200 :height 100
			:background (stumpwm::alloc-color screen "black")
			:bit-gravity :north-east
			:border (stumpwm::alloc-color screen "gold")
			:border-width 3
			:colormap (xlib:screen-default-colormap
				   screen-number)
			:event-mask '(:exposure))))
      (make-art-window-gc window screen)
      (setup-art-window screen window 50 300))
))

(defcommand draw-art () ()
  "draw some art. Provided by the treemacs module"
  (make-art-window))  

