;;; my-ui-and-misc.el --- prelude personalizations
;;; Commentary:
;;;; UI settings and some prelude defaults

;;; Code:

;; UI
(toggle-scroll-bar -1)

;; OSX
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(remove-if (lambda (x)
             (eq 'font (car x)))
           default-frame-alist)
(cond
 ((and (window-system) (eq system-type 'darwin))
  (add-to-list 'default-frame-alist '(font . "Anonymous Pro 18"))))

;; flyspell
;;(setq prelude-flyspell nil)
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;; guru-mode off
(add-hook 'prelude-prog-mode-hook
          (lambda ()
            (guru-mode -1)) t)

;; whitespace
;;(setq prelude-clean-whitespace-on-save nil)
(setq whitespace-line-column 120
      whitespace-style '(face trailing tabs lines-tail empty))

;; emacs-live M-SPC
(defun sundbp-delete-whitespace-except-one ()
  (interactive)
  (just-one-space -1))
(global-set-key (kbd "M-SPC ") 'sundbp-delete-whitespace-except-one)

;; window navigation
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; comments
(global-set-key (kbd "C-/") 'comment-or-uncomment-region)

(provide 'my-ui-and-misc)
;;; my-ui-and-misc.el ends here
