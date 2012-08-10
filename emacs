(add-to-list 'load-path "~/.emacs.d/")

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;remove toolbar and icons
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))	
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;Color thems
;(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-robin-hood)


;Auto-complete http://cx4a.org/software/auto-complete/

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(define-key ac-mode-map (kbd "C-`") 'ac-fuzzy-complete)

;; Set up the Common Lisp environment
(add-to-list 'load-path "/usr/share/common-lisp/source/slime/")
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(require 'slime)
(slime-setup '(slime-fancy))
(add-hook 'slime-mode-hook
	  (lambda ()
	    (global-set-key (kbd "C-SPC") 'slime-fuzzy-complete-symbol)))

;; Add utf-8 encoding for slime
(setq slime-net-coding-system 'utf-8-unix)

;;run slime and set it as default page
(slime)
(setq inhibit-startup-screen t)
(setq initial-buffer-choice "*slime-repl sbcl*")

;;define  maximized window and run at startup
(defun toggle-fullscreen (&optional f)
      (interactive)
      (let ((current-value (frame-parameter nil 'fullscreen)))
           (set-frame-parameter nil 'fullscreen
                                (if (equal 'maximized current-value)
                                    (if (boundp 'old-fullscreen) old-fullscreen nil)
                                    (progn (setq old-fullscreen current-value)
                                           'maximized)))))
(global-set-key [f11] 'toggle-fullscreen)
    ; Make new frames fullscreen by default. Note: this hook doesn't do
    ; anything to the initial frame if it's in your .emacs, since that file is
    ; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)
(toggle-fullscreen)

;;; Unbind `C-x f'
(global-unset-key "\C-xf")

;;; Rebind `C-x C-b' for `buffer-menu'
(global-set-key "\C-x\C-b" 'buffer-menu)

;;; Keybinding for `occur'
(global-set-key "\C-f" 'occur)

;;split windows
;(split-window-vertically)

;; add persistent TODO list
(defun toggle-todo (&optional f)
  (interactive)
  (let ((todo-window (get-buffer-window "*TODO*")))
    (if todo-window
	(progn 
	  (save-buffer)
	  (delete-window todo-window))
      (find-file-other-window "*TODO*"))))
  
(global-set-key [f12] 'toggle-todo)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector [solarized-bg red green yellow blue magenta cyan solarized-fg])
 '(custom-safe-themes (quote ("d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(fci-rule-color "#073642"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'solarized-dark)
