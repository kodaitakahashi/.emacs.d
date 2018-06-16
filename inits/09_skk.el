;; skk

(use-package skk)
;;skk-server AquaSKK
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")
(setq mac-pass-control-to-system nil)
(global-set-key "\C-x\C-j" 'skk-mode)
(autoload 'skk-mode "skk" nil t)
(autoload 'skk-auto-fill-mode "skk" nil t)
(autoload 'skk-tutorial "skk-tut" nil t)
(autoload 'skk-isearch-mode-setup "skk-isearch" nil t)
(autoload 'skk-isearch-mode-cleanup "skk-isearch" nil t)
(add-hook 'isearch-mode-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-setup)))))
(add-hook 'isearch-mode-end-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
                      (and (boundp 'skk-mode-invoked) skk-mode-invoked
                           (skk-set-cursor-properly)))))


;; web-mode上でskk-modeにする
(add-hook 'web-mode-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))

;; rjsx-mode城でskk-modeにする
(add-hook 'rjsx-mode-hooks
          '(lambda()
             (progn
               (eval-expession (ssk-mode) nil)
               )))
(add-hook 'find-file-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))
(add-hook 'isearch-mode-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-setup)))))
(add-hook 'isearch-mode-end-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
                      (and (boundp 'skk-mode-invoked) skk-mode-invoked
                           (skk-set-cursor-properly)))))


(provide '09_skk)
