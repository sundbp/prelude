;;; my-clojure.el --- my clojure settings
;;; Commentary:

;;; Code:

(require 'cider-mode)
(require 'cider-repl)

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(define-key cider-mode-map (kbd "M-RET") 'cider-doc)
(define-key cider-repl-mode-map (kbd "M-RET") 'cider-doc)

(setq cider-debug-print-level 5)
(setq cider-debug-print-length 200)
(setq cider-repl-history-file "~/.cider-history")

(defun sundbp-slurp (f)
  "Read file contents."
  (with-temp-buffer
    (insert-file-contents f)
    (buffer-substring-no-properties
     (point-min)
     (point-max))))

(defun sundbp-cider-refresh ()
  (interactive)
  (let* ((proj-dir (clojure-project-dir (cider-current-dir)))
         (repl-conf (split-string (sundbp-slurp (concat proj-dir ".repl-file")) "\n"))
         (repl-file (concat proj-dir (car repl-conf)))
         (refresh-cmd (car (cdr repl-conf))))
    (cider-switch-to-relevant-repl-buffer '())
    (cider-load-file repl-file)
    (goto-char (point-max))
    (insert refresh-cmd)
    (cider-repl-return)))

(defun sundbp-cider-refresh-in-repl ()
  (interactive)
  (let* ((proj-dir (nrepl-project-directory-for (nrepl-current-dir)))
         (repl-conf (split-string (sundbp-slurp (concat proj-dir ".repl-file")) "\n"))
         (repl-file (concat proj-dir (car repl-conf)))
         (refresh-cmd (car (cdr repl-conf))))
    (cider-load-file repl-file)
    (goto-char (point-max))
    (insert refresh-cmd)
    (cider-repl-return)))

(define-key cider-mode-map (kbd "C-c M-k") 'sundbp-cider-refresh)
(define-key cider-repl-mode-map (kbd "C-c M-k") 'sundbp-cider-refresh-in-repl)

(define-key cider-mode-map (kbd "M-/") 'comment-or-uncomment-region)
(define-key cider-mode-map (kbd ";") 'sp-comment)
(define-key cider-mode-map (kbd "RET") 'sp-newline)

(require 'dash-at-point)
(global-set-key (kbd "s-d") 'dash-at-point)
(global-set-key (kbd "s-e") 'dash-at-point-with-docset)

(setq initial-major-mode 'clojure-mode)

(require 'clj-refactor)

(setq cljr-favor-prefix-notation nil)

(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(provide 'my-clojure)
;;; my-clojure.el ends here
