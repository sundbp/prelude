;;; my-clojure.el --- my clojure settings
;;; Commentary:

;;; Code:

(require 'cider-mode)

(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))

(define-key cider-mode-map (kbd "M-RET") 'cider-doc)
(define-key cider-repl-mode-map (kbd "M-RET") 'cider-doc)

(setq cider-debug-print-level 5)
(setq cider-debug-print-length 200)
(setq cider-repl-history-file "~/.cider-history")

(provide 'my-clojure)
;;; my-clojure.el ends here
