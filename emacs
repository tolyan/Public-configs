;Auto-complete http://cx4a.org/software/auto-complete/
(add-to-list 'load-path "~/.emacs.d/")
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
(split-window-vertically)

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
