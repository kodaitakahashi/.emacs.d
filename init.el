;;英字フォント設定
(set-face-attribute 'default nil
                    :family "Ricty-Regular"
                    :height 140)
;;日本語フォント設定
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))
;; ウィンドウ設定
(setq initial-frame-alist
      (append
       '((top . 22)
         (left . 0)
         (width . 175)
         (height . 30)
         ) initial-frame-alist))
;; 背景透過
(if window-system (progn
                    (set-background-color "Black")
                    (set-foreground-color "LightGray")
                    (set-cursor-color "Gray")
                    (set-frame-parameter nil 'alpha 70) ;透明度
                    ))
;;起動時のメニューの削除
(setq inhibit-startup-message t)
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
;;行番号表示
(global-linum-mode t)
;;カレントディレクトリ指定
(cd "~/")
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
(global-unset-key (kbd "C-o"))
;;global-set-key
                                        ;ウィンドウ移動(下)
(global-set-key (kbd "C-c <down>") 'windmove-down)
                                        ;ウィンドウ移動(上)
(global-set-key (kbd "C-c <up>") 'windmove-up)
                                        ;ウィンドウ移動(左)
(global-set-key (kbd "C-c <left>") 'windmove-left)
                                        ;ウィンドウ移動(右)
(global-set-key (kbd "C-c <right>") 'windmove-right)
                                        ;eshell起動
(global-set-key [down] 'eshell)
                                        ;リロード
(global-set-key (kbd "C-c r") 'eval-buffer)
;;PATHの読み込み
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":" )))
(add-to-list 'exec-path path))
;;tramp
(require 'tramp)
(setq tramp-default-method "ssh")
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
;;undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "C-x u") 'undo-tree-redo)
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
;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-hook 'sgml-mode-hook 'web-mode)
;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;;js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;;ruby
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

(require 'ruby-block)
(ruby-block-mode t) ;endの対応している行のハイライト
(setq ruby-block-highlight-toggle t)

;;ruby-end
(require 'ruby-end) 
(add-hook 'ruby-mode-hook  ;endや括弧の自動挿入
          '(lambda()
             (abbrev-mode 1)
             (electric-pair-mode t)
             (electric-indent-mode t)
             (electric-layout-mode t)))
;;;markdown
;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq markdown-command-needs-filename t) 
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;scala
(require 'scala-mode2)
(add-hook 'scala-mode-hock '(lambda ()
                              (local-set-key (kbd "RET") 'newline-and-indent)
                              (local-set-key (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)
                              ))
;; scss-mode
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
;; インデント幅を2にする
;; コンパイルは compass watchで行うので自動コンパイルをオフ
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
          '(lambda() (scss-custom)))
(require 'skk)
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
;;find-fileでskk-modeにする
(add-hook 'find-file-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))
;; ミニバッファ上でも skk-mode にする
;; skk-latin-mode でアルファベット入力にしておく
(add-hook 'minibuffer-setup-hook
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               (skk-latin-mode (point))
               ;; ミニバッファ上に「nil」と表示させないために, 空文字をミニバッファに表示
               (minibuffer-message "")
               )))
;; ruby-mode上でskk-modeにする
(add-hook 'ruby-mode-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))
;; php-mode上でskk-modeにする
(add-hook 'php-mode-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))
;; scss-mode上でskk-modeにする
(add-hook 'scss-mode-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))
;; web-mode上でskk-modeにする
(add-hook 'web-mode-hooks
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               )))
(provide 'init)
