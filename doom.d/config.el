;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq user-full-name "Mu Tong"
      user-mail-address "moutong945@gmail.com")
(set-language-environment "UTF-8")

(load! "lisp/init-ui")
(load! "lisp/init-org")
(load! "lisp/init-theme")
(load! "lisp/init-func")
(load! "lisp/init-auto-insert")
(load! "lisp/init-keybindings")
;;==========================================================
;;                       => Evil <=                        =
;;==========================================================
;; Cursor
(setq evil-emacs-state-cursor 'box)
(setq evil-normal-state-cursor 'box)
(setq evil-visual-state-cursor 'hollow)
(setq evil-insert-state-cursor 'bar)
(setq evil-replace-state-cursor 'hbar)
(setq evil-operator-state-cursor 'hollow)
;; Keybindings
(define-key evil-insert-state-map (kbd "C-f") 'forward-char)
(define-key evil-insert-state-map (kbd "C-b") 'backward-char)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
;;===========================================================
;;=                      => Scheme <=                       =
;;===========================================================
(setq scheme-program-name "mit-scheme")
(setq geiser-mit-binary "/usr/local/bin/mit-scheme")
(setq geiser-active-implementations '(mit chez))
;; configurations for paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;;===========================================================
;;=                      => Python <=                       =
;;===========================================================
(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")
;;===========================================================
;;=                   => Abbrev mode <=                     =
;;===========================================================
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
                                            ;; signature
                                            ("mt" "dalu")
                                            ;; emacs regex
                                            ))
