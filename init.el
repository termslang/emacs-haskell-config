;;;OCAML;;;;;;;;;;;;;;;;;;;;
;;
;; brew install opam
;; opam init
;; eval $(opam env)
;; brew install ocaml
;; brew install gmp
;; opam install merlin ocp-indent tuareg utop
;;
;; brew install conf-gmp-powm-sec
;; brew install pkg-config
;; opam install cryptokit
;;
;; opam install sha
;; opam install zarith
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; default window size
(defun get-default-height ()
       (/ (- (display-pixel-height) 120)
          (frame-char-height)))
(add-to-list 'default-frame-alist '(width . 155))
(add-to-list 'default-frame-alist (cons 'height (get-default-height)))
(delete-other-windows)
(split-window-horizontally)
(next-multiframe-window)
(setf initial-buffer-choice "~/ocaml/")
;; scrolling
(setq scroll-step 1
   scroll-conservatively 10000)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; line numbers
(global-linum-mode 1)

;; no tabs
(setq c-basic-indent 2)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

(show-paren-mode 1)

;; font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 150
                    :weight 'normal
                    :width 'normal)



(package-initialize)

;; disable automatic description as this is both annoying and can easily
;; get intero stuck
;(global-eldoc-mode -1)

(add-hook 'minibuffer-setup-hook
    (lambda () (setq truncate-lines nil)))

(setq resize-mini-windows t) ; grow and shrink as necessary
(setq max-mini-window-height 10) ; grow up to max of 10 lines

(setq minibuffer-scroll-window t)
(setq ns-pop-up-frames nil)
(setq dired-dwim-target t)
(put 'dired-find-alternate-file 'disabled nil)


(require 'cl)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(defvar required-packages
  '(
    color-theme
    dracula-theme
    solarized-theme
    which-key
    company
    company-ghc
    flycheck
    flycheck-pos-tip
    flycheck-color-mode-line
    haskell-mode
    )
   "a list of packages to ensure are installed at launch.")
; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))
; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))


(require 'which-key)
(which-key-mode)

(fset 'yes-or-no-p 'y-or-n-p)



(require 'speedbar)
(speedbar-add-supported-extension ".hs")
(speedbar-add-supported-extension ".cabal")
(speedbar-add-supported-extension ".el")
;(custom-set-variables
; '(speedbar-show-unknown-files t)
;)


; popwin
; (require 'popwin)
; (popwin-mode 1)


;;COLOR THEMES

(require 'color-theme)
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(load-theme 'solarized-dark t)

;; COMPLETION

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-ghc-show-info t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(package-selected-packages
   (quote
    (company-ghc which-key solarized-theme seti-theme projectile popwin popup neotree flycheck-pos-tip flycheck-color-mode-line dracula-theme dired-subtree dante company color-theme))))
(setq company-minimum-prefix-length 1)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0.2)




(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc)









(require 'haskell-interactive-mode)
;(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)




;; ERRORS ON THE FLY

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;(add-hook 'haskell-mode-hook #'flycheck-haskell-setup)


;tooltip errors
(require 'flycheck-pos-tip)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(require 'flycheck-color-mode-line)
(add-hook 'flycheck-mode-hook
  'flycheck-color-mode-line-mode)

;; only flycheck on save
(setq flycheck-check-syntax-automatically '(save mode-enabled))
;(setq flymake-no-changes-timeout 10)
;(setq flymake-start-syntax-check-on-newline t)





;; HASKELL ;;

;; will search for cabal in these directories
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/Users/mb/Library/Haskell/bin"))
(setq exec-path (cons "/Users/mb/Library/Haskell/bin" exec-path))


(setq haskell-tags-on-save t)
(setq haskell-stylish-on-save t)

;; I use version control, don't annoy me with backup files everywhere
(setq make-backup-files nil)
(setq auto-save-default nil)




;; cycle through buffers with Ctrl-Tab
(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "M-<left>") 'windmove-left)          ; move to left window
(global-set-key (kbd "M-<right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "M-<down>") 'windmove-down)          ; move to lower window
(global-set-key (kbd "C-`") 'next-buffer)
(global-set-key (kbd "C-~") 'previous-buffer)


(global-set-key (kbd "C-x C-a") 'speedbar)
;(global-set-key (kbd "C-,") 'flycheck-list-errors)
;(global-set-key (kbd "C-.") 'haskell-compile)
(global-set-key (kbd "C-'") 'imenu)



;(define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
;(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)




;(eval-after-load 'haskell-mode '(progn
;  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
;  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
;  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
;  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
;(eval-after-load 'haskell-cabal '(progn
;  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal))
;)
;(custom-set-variables '(haskell-process-type 'cabal-repl))


;a few convenient shortcuts
;(define-key haskell-mode-map (kbd "C-c C-`") 'haskell-interactive-bring)
;(define-key haskell-mode-map (kbd "C-l C-l") 'haskell-process-load-or-reload)
;(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)




;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line


;; TODO merlin use packages
;; (merlin-use Z)

