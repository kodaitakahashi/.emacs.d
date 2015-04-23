;;英字フォント設定
(set-face-attribute 'default nil
                    :family "Ricty-Regular"
                    :height 140)

;;日本語フォント設定
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

;; 背景透過
(if window-system (progn
                    (set-background-color "Black")
                    (set-foreground-color "LightGray")
                    (set-cursor-color "Gray")
                    (set-frame-parameter nil 'alpha 70) ;透明度
                    ))
;;フォントサイズ
(defconst FONT_SIZE 12)

;;バックアップファイルを作らない
(setq make-backup-files nil)

;;.#*をつくらない
(setq auto-save-default nil)
;; ファイル末の開業がなければ追加
(setq require-final-newline t)

;; tabは４文字 改行後は自動インデント
(setq-default tab-width 4 indent-tabs-mode nil)

;;ツールバー非表示
(tool-bar-mode -1)

;;メニューバー非表示
(menu-bar-mode -1)

;; set font and screen
(progn

  ;; 文字の色を設定します。
  (add-to-list 'default-frame-alist '(foreground-color . "azure1"))

  ;; 背景色を設定します。
  (add-to-list 'default-frame-alist '(background-color . "black"))

  ;; カーソルの色を設定します。
  (add-to-list 'default-frame-alist '(cursor-color . "green"))

  ;; マウスポインタの色を設定します。
  (add-to-list 'default-frame-alist '(mouse-color . "green"))

  ;; モードラインの文字の色を設定します。
  (set-face-foreground 'mode-line "white")

  ;; モードラインの背景色を設定します。
  (set-face-background 'mode-line "DimGrey")

  ;; 選択中のリージョンの色を設定します。
  (set-face-background 'region "Blue")

  ;; モードライン（アクティブでないバッファ）の文字色を設定します。
  (set-face-foreground 'mode-line-inactive "gray30")

  ;; モードライン（アクティブでないバッファ）の背景色を設定します。
  (set-face-background 'mode-line-inactive "gray85")
  )

                                        ;====================================
;;全角スペースとかに色を付ける
                                        ;====================================
(defface my-face-b-1 '((t (:background "SeaGreen"))) nil)
(defface my-face-b-1 '((t (:background "SeaGreen"))) nil)
(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
(defface my-face-u-1 '((t (:foreground "SeaGreen" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                              (if font-lock-mode
                                  nil
                                (font-lock-mode t))))

;;global-unset-key
(global-unset-key [up])
(global-unset-key [right])
(global-unset-key [down])
(global-unset-key [left])

;;global-set-key
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key [down] 'eshell)

;; cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)


;; packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;;emmet-mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; CSSにも使う
(add-hook 'web-mode-hook  'emmet-mode) ;; phpにも使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開

;; php-mode
;(require 'php-mode)

;(setq php-mode-force-pear t) ;PEAR規約のインデント設定にする
;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode)) ;*.phpのファイルのときphp-modeを自動起動する

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-hook 'sgml-mode-hook 'web-mode)


;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;;rub
;;ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist'("\\.rb$latex".ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;;ruby-electric
;(require 'ruby-electric)
;(add-hook 'ruby-mode-hook'(lambda()(ruby-electric-mode t)))
;(setq ruby-electric-expand-delimiters-list nil)

;;ruby-block----highlight matching block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

(provide 'init)
