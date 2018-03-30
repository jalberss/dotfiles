(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/")
             t)
(package-initialize)
;(add-to-list 'load-path
 ;             "~/.emacs.d/plugins/yasnippet")
;(require 'yasnippet)
;(yas-global-mode 1)
(exec-path-from-shell-initialize)
;(require 'auto-complete)
;(require 'auto-complete-config)
					;(ac-config-default)

;; Git stuff
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-set-key (kbd "C-x c") 'compile)


(require 'yasnippet)
(yas-global-mode 0)

; For compiling text to pdf automatically
(require 'tex)
(TeX-global-PDF-mode t)

(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-source 'ac-sources-c-headers)
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1
 /usr/local/include"
	      ))
					;now call from c/c++ hooks

(global-auto-revert-mode 1)
(global-linum-mode 1)
(rainbow-delimiters-mode 1)


(require 'rust-mode)
(add-hook 'rust-mode-hook #'global-flycheck-mode)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook 'linum-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'rainbow-delimiters-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
(add-hook 'objc-mode-hook 'my:ac-c-header-init)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(setq c-default-style '((c-mode . "gnu")))


; C++/C
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'projectile-mode)
(add-hook 'c++-mode-hook 'company-mode)
(global-flycheck-mode)
(add-hook 'c++-mode-hook 'function-args-mode)
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)



(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(add-hook 'c++-mode-hook 'helm-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(with-eval-after-load 'helm-gtags
  (require 'helm-projectile)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-;") 'company-complete-common)
  (helm-projectile-on)
  (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "C-c g r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "C-c g s") 'helm-gtags-find-symbol)
      (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
      (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
      (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
      (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
      (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
      (define-key helm-gtags-mode-map (kbd "C-c p C-g") 'helm-projectile-grep))















(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)


(require 'doremi)
(require 'linum)
(defun linum-update-window-scale-fix (win)
  "fix linum for scaled text"
  (set-window-margins win
		      (ceiling (* (if (boundp 'text-scale-mode-step)
				      (expt text-scale-mode-step
					    text-scale-mode-amount) 1)
				  (if (car (window-margins))
				      (car (window-margins)) 1)
				  ))))
(advice-add #'linum-update-window :after #'linum-update-window-scale-fix)



					; define iedat
(define-key global-map (kbd "C-c ;") 'iedit-mode)
(require 'ido)
(ido-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (inkpot)))
 '(custom-safe-themes
   (quote
    ("b0f529f09b32b18ce9192d4fd1379266c1e143999ef5b326a13b7c8bbe0f6a5d" default)))
 '(linum-relative-current-symbol "->")
 '(linum-relative-plusp-offset 0)
 '(max-mini-window-height 0.1)
 '(package-selected-packages
   (quote
    (function-args helm-flycheck flycheck-irony company-irony swift-mode magit mkdown helm-gtags helm-projectile projectile helm etags-table linum-relative auctex haskell-mode fzf doremi rainbow-delimiters browse-kill-ring multiple-cursors flycheck flycheck-rust ## inkpot-theme company racer rainbow-mode exec-path-from-shell cargo rust-mode racket-mode jedi irony iedit ctags-update ctags ac-clang ac-c-headers)))
 '(send-mail-function nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; For Multiple cursors from MELPA
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-unset-key (kbd "M-<down-mouse-1>")) (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(load
 "/Users/JAlbers/.opam/system/share/emacs/site-lisp/tuareg-site-file")


(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'ocp-indent)
(require 'merlin)

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var"
   "share")))))
      (when (and opam-share (file-directory-p opam-share))
       ;; Register Merlin
       (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
       (autoload 'merlin-mode "merlin" nil t nil)
       ;; Automatically start it in OCaml buffers

       (add-hook 'tuareg-mode-hook 'merlin-mode t)
       (add-hook 'caml-mode-hook 'merlin-mode t)
       ;; Use opam switch to lookup ocamlmerlin binary
       (setq merlin-command 'opam)
       (setq merlin-ac-setup 'easy)
       (with-eval-after-load 'company
	 (add-to-list 'company-backends 'merlin-company-backend))
					; Enable company on merlin managed buffers
       (add-hook 'merlin-mode-hook 'company-mode)
					; Or enable it globally:
					; (add-hook 'after-init-hook 'global-company-mode)
       ))


(put 'upcase-region 'disabled nil)



;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;; hslint on the command line only likes this indentation mode;
;; alternatives commented out below.
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; Ignore compiled Haskell files in filename completions
(add-to-list 'completion-ignored-extensions ".hi")

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-undo-tree-mode)
