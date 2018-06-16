;;ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-hook 'ruby-mode '(lambda ()
                        (local-set-key (kbd "RET") 'newline-and-indent)
                        ))
(add-to-list 'auto-mode-alist'("\\.rb$latex".ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
                                        ;インデントの改良
(setq ruby-deep-indent-paren-style nil)
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))
; マジックコメント解除
(custom-set-variables
 '(ruby-insert-encoding-magic-comment nil))

;; rubocop
(use-package rubocop)

(use-package ruby-block)
(ruby-block-mode t) ;endの対応している行のハイライト
(setq ruby-block-highlight-toggle t)
;;ruby-end
(use-package ruby-end) 
(add-hook 'ruby-mode-hook  ;endや括弧の自動挿入
          '(lambda()
             (abbrev-mode 1)
             (electric-pair-mode t)
             (electric-indent-mode t)
             (electric-layout-mode t)))
