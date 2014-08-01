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

;; load path
(add-to-list 'load-path "~/.emacs.d/")
(require 'load-paths)

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
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開


(provide 'init)
