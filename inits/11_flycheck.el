;; 文法チェック
(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package flycheck-pos-tip)
  :init
  ;; エコーエリアではなくtipに表示する
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
(provide '11_flycheck)
