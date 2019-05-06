(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(CUA-mode-global-mark-cursor-blink nil)
 '(CUA-mode-overwrite-cursor-color "orange")
 '(blink-cursor nil)
 '(case-fold-search t)
 '(compilation-finish-function (quote ude-compilation-finish-function) t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(delete-selection-mode t nil (delsel))
 '(global-font-lock-mode t nil (font-lock))
 '(kill-whole-line t)
 '(mouse-wheel-follow-mouse t)
 '(mouse-wheel-mode t nil (mwheel))
 '(mouse-yank-at-point t)
 '(paren-mode (quote paren) nil (paren))
 '(pc-select-selection-keys-only t)
 '(pc-selection-mode t nil (pc-select))
 '(quack-pretty-lambda-p t)
 '(rmail-summary-scroll-between-messages t t)
 '(scroll-bar-mode (quote right))
 '(show-paren-delay 0)
 '(show-paren-mode t nil (paren))
 '(strokes-mode nil nil (strokes))
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(paren-face-match ((((class color)) (:background "#f070ff"))))
 '(paren-face-mismatch ((((class color)) (:foreground "white" :background "red"))))
 '(paren-match ((t (:background "#f070ff"))))
 '(paren-mismatch ((t (:background "red"))))
 '(show-paren-match-face ((((class color)) (:background "#d8f0ff"))));;"#c0e8ff"
 '(show-paren-mismatch-face ((((class color)) (:background "red")))))

;he die obigen match farben settings ausser der letzten haben gar keine wirkung?!

;;^- pc-se* zeug muss aktiv sein damit forward-sexp-mark vorhanden ist. so komisch.


;; SLIME48
(setq user-home (getenv "HOME"))
(add-to-list 'load-path (concat user-home "/CAMPBELL/SLIME48/slime48"))

(autoload 'slime "slime"
  "Start an inferior^_superior Lisp and connect to its Swank server."
  t)

(autoload 'slime-mode "slime"
  "SLIME: The Superior Lisp Interaction Mode for Emacs (minor-mode)."
  t)

(eval-after-load "slime"
  '(progn
     (slime-setup)
     (setq slime-lisp-implementations
           `((s48 ("scheme48") :init slime48-init-command)
             ,@slime-lisp-implementations))))

(autoload 'slime48-init-command "slime48"
  "Return a string to initialize Scheme48 running under SLIME.")

;; This snippet lets you specify a scheme48-package local variable,
;; in a file's -*- line or local variables section, and have SLIME48
;; automatically evaluate code in the right package.  For instance,
;; all of my Scheme48 source files start with:
;;   ;;; -*- Mode: Scheme; scheme48-package: ... -*-
(eval-after-load "slime48"
  '(add-hook 'slime-mode-hook
             (lambda ()
               (if (and (boundp 'scheme48-package)
                        scheme48-package)
                   (setq slime-buffer-package
                         (with-output-to-string
                           (princ scheme48-package)))))))
;; / SLIME48


(require 'cl) ;; for |case| and |list*|


(setq auto-mode-alist
      (list* '("\\.md$" . markdown-mode)
	     '("\\.\\(?:scm\\|sch\\|scme\\|bee\\|ast\\)$" . scheme-mode)
	     auto-mode-alist))

;;(setq-default indent-tabs-mode nil)


(if (equal (getenv "USER") "chrisclojure")
    (progn
      (load "/home/chrisclojure/.emacs.d/package.el")
      (add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
      (setq auto-mode-alist
	    (cons '("\\.\\(?:clj)$" . clojure-mode)
		  auto-mode-alist))
      
      (load "/home/chrisclojure/src/clojure-mode/clojure-mode.el")
      
      (add-to-list 'load-path "/home/chrisclojure/src/slime")  ; your SLIME directory
      (setq inferior-lisp-program "lein swank") ; your Lisp system
      (require 'slime)
      (slime-setup)))


(defun cj-doublequote ()
  (interactive)
  ;; insert a space unless we are after whitespace or a left paren or bracket
  (case (char-before)
    ((?( ? ?\n ?\t) 
      nil)
    ;; huh, paren matcher in elisp mode doesn't handle this syntax right
    (t 
      (insert " ")))
  (insert "\"\"")
  (move-to-column (- (current-column) 1)))


(global-set-key "\M-g" 'goto-line)
(global-set-key '[f1] 'cj-doublequote)

(global-set-key (kbd "M-§") (lambda (&optional _foo)
			      (interactive)
			      (kill-buffer)))

(global-set-key (kbd "C-z") (lambda (&optional _foo)
			      (interactive)
			      ;; same as C-u
			      (universal-argument)))


(defun scroll-up-one ()
  (interactive)
  (scroll-up 1))
(defun scroll-down-one ()
  (interactive)
  (scroll-down 1))
  
(global-set-key [(control meta down)] 'scroll-up-one)
(global-set-key [(control meta up)] 'scroll-down-one)

(global-set-key "\C-v" 'scroll-up)


(autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)
(add-hook 'xsl-mode-hook
          'turn-on-font-lock)
(setq auto-mode-alist
      (append
       (list
        '("\\.fo" . xsl-mode)
        '("\\.xsl" . xsl-mode)
	)
       auto-mode-alist))
;; Uncomment if using abbreviations
;(abbrev-mode t)


; http://www.emacswiki.org/cgi-bin/wiki/CPerlMode
; http://www.emacswiki.org/cgi-bin/wiki/IndentingPerl

(setq cperl-indent-level 4)
(setq cperl-font-lock t)
(setq cperl-hairy t)


(add-hook 'markdown-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))

(add-hook 'perl-mode-hook
	  (lambda () 
	    (define-key perl-mode-map [(return)] 
	      (lambda () (interactive)
		(perl-indent-command)
		(newline-and-indent)))
	    (define-key perl-mode-map [(shift return)] 'newline)
	    (font-lock-mode)
	    (imenu-add-menubar-index)))

(add-hook 'cperl-mode-hook
	  (lambda () 
	    (define-key cperl-mode-map [(return)]
	      (lambda () (interactive) (cperl-indent-command) (newline-and-indent)))
	    (define-key cperl-mode-map [(shift return)] 'newline)
	    (imenu-add-menubar-index)))


(add-hook 'c-mode-common-hook
          (lambda ()
             (define-key c-mode-base-map [(return)] 'newline-and-indent)
             (define-key c-mode-base-map [(shift return)] 'newline)
	     (setq c-basic-offset 8) ;; default is 2!
	     (setq c-default-style "linux") ;; default anyway?
             (font-lock-mode)
             (imenu-add-menubar-index)))


(when (file-exists-p "~/src/arduino-mode/arduino-mode.el")
  (load-file "~/src/arduino-mode/arduino-mode.el"))


(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)


;; from http://www.emacswiki.org/emacs/RevertBuffer
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
	(revert-buffer t t t) )))
  (message "Refreshed open files.") )

;; but also see auto-revert-mode, see below in scheme-mode


(global-set-key [(meta s)] 'save-buffer)

(iswitchb-mode)
;; (iswitchb-default-keybindings)  not available anymore in emacs24
(setq iswitchb-default-method 'samewindow)
;; ^ instead of always-frame (raise does not work for tty..)

(defun iswitchb-make-buflist (default)
  "Modified version by pflanze.
\(Currently visible buffers are *NOT* put at the end of the list anymore.)
Set `iswitchb-buflist' to the current list of buffers.
The hook `iswitchb-make-buflist-hook' is run after the list has been 
created to allow the user to further modify the order of the buffer names
in this list.  If DEFAULT is non-nil, and corresponds to an existing buffer,
it is put to the start of the list."
  (setq iswitchb-buflist 
        (let* ((curbuf (buffer-name))
               (buflist 
                (delq nil 
                      (mapcar
                       (lambda (x)
                         (let ((b-name (buffer-name x)))
                           (if (not
                                (or
                                 (iswitchb-ignore-buffername-p b-name)
                                 (equal b-name curbuf)))
                               b-name)))
                       (buffer-list)))))
          (nconc buflist (list (buffer-name)))
          (run-hooks 'iswitchb-make-buflist-hook)
          ;; Should this be after the hooks, or should the hooks be the
          ;; final thing to be run?
          (if default
              (progn
                (setq buflist (delete default buflist))
                (setq buflist (cons default buflist))
                ))
          buflist)))

(global-set-key [(control tab)] 'other-window)
;(global-set-key [(control shift tab)] (lambda() (other-window -1)))
(global-set-key [(control shift iso-lefttab)] (lambda() (interactive) (other-window -1)))
;(global-set-key [(control shift iso-lefttab)] '(other-window -1))


(if (= emacs-major-version 21)
    (require 'ilisp))
(require 'cmuscheme)


; for Gambit-C
(when (file-exists-p "~/.emacs.d/gambit.el")
  (load-file "~/.emacs.d/gambit.el")
  (autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
  (autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
  (add-hook 'inferior-scheme-mode-hook (function gambit-inferior-mode))
  (add-hook 'scheme-mode-hook (function gambit-mode))
  (setq scheme-program-name "loop -c /opt/chj/emacs/bin/gam-emacs"))


(defun gambit-show-definition (name)
  "Bring up the definition of the given function or macro. Requires |show-def| from chj-schemelib's cj-env.scm."
  (interactive (comint-get-source "Show definition of: "
				  ;; XX bogus, use a different procedure?:
				  scheme-prev-l/c-dir/file
                                  scheme-source-modes
				  nil))
  (scheme-send-string (concat "(show-def " name "\)\n")))

(defun gambit-show-definition-region (start end)
  "Send the current region to gambit-show-definition."
  (interactive "r")
  (gambit-show-definition (buffer-substring start end)))

(defun gambit-show-definition-last-sexp ()
  (interactive)
  (gambit-show-definition-region (save-excursion (backward-sexp) (point)) (point)))


;; for julia
(when (file-exists-p "~/.emacs.d/julia-mode.el")
  (load-file "~/.emacs.d/julia-mode.el"))


(when (file-exists-p "~/.emacs.d/pretty-lambdada.el")
  (load-file "~/.emacs.d/pretty-lambdada.el")
  (pretty-lambda-for-modes))


(tool-bar-mode 0)


(defun cj-noop ()
  (interactive)
  nil)

(defun cj-up-list ()
  (interactive)
  (up-list)
  (insert " "))

(defun cj-type-lambda ()
  (interactive)
  (insert "lambda"))

(defun cj-type-lambda-form ()
  (interactive)
  (insert "(lambda ())")
  (left-char 2))

(defun cj-scheme-load-buffer ()
  (interactive)
  (save-buffer)
  (scheme-load-file (buffer-file-name)))

(defun cj-wget-repl ()
  (interactive)
  (shell-command "daemonize --bg -q 'wget http://127.0.0.1/cgi-bin/scmcgi/repl'"))


(defvar cj-first-fn-block 
  '(;; note, F4 does not work, f4 does
    ([f2] . cj-up-list)
    ([f3] . insert-parentheses)
    ([f4] . move-past-close-and-reindent)
    ([f5] . cj-scheme-load-buffer)
    ([f6] . cj-wget-repl)
    ([f8] . gambit-show-definition-last-sexp)
    ([(control return)] . move-past-close-and-reindent)
    ("ł" . cj-type-lambda-form)
    ("Ł" . cj-type-lambda)))


(defun cj-set-slime-keybindings ()
  (dolist (p `(
	       ,@cj-first-fn-block
	       ))
    ;;(define-key slime-mode-map (car p) (cdr p))
    (local-set-key (car p) (cdr p))))

(add-hook 'slime-mode-hook 'cj-set-slime-keybindings t)
(add-hook 'slime-repl-mode-hook 'cj-set-slime-keybindings t)
(add-hook 'slime-repl-read-mode-hook 'cj-set-slime-keybindings t)

(add-hook 'inferior-scheme-mode-hook
	  (lambda()
	    (dolist (p `(,@cj-first-fn-block
			 ([(control meta p)] . backward-down-list)
			 ([(control meta n)] . up-list)
			 ))
	      (define-key inferior-scheme-mode-map (car p) (cdr p)))
	    "yes, append it"))


;;;   (add-to-list 'load-path "/path/to/elisp")
(if (file-exists-p "~/.emacs.d/paredit.el")
    (load-file "~/.emacs.d/paredit.el"))
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)


(add-hook 'scheme-mode-hook
	  (lambda()
	    (imenu-add-menubar-index)

	    (dolist (p `(([(meta q)] . reindent-lisp)
			 ([(return)] . newline-and-indent)
			 ([(meta left)] . backward-sexp)
			 ([(meta right)] . forward-sexp)
			 ([(meta shift left)] . backward-sexp-mark)
			 ([(meta shift right)] . forward-sexp-mark)
			 ([(control meta x)] . scheme-send-definition)
			 ([(meta ret)] . scheme-send-definition)
			 ([(shift return)] . newline)
			 ,@cj-first-fn-block
			 ([(control meta p)] . backward-down-list)
			 ([(control meta n)] . up-list)
			 ))
	      (define-key scheme-mode-map (car p) (cdr p))))
	  "yes, append it")


(add-hook 'scheme-mode-hook (lambda ()
			      (paredit-mode +1)
			      (auto-revert-mode +1)))

(defun cj-tex-compile-in-cwd ()
  (interactive)
  (save-buffer)
  (tex-compile "." (concat "latex -interaction=nonstopmode "
			   (shell-quote-argument
			    (buffer-file-name (current-buffer))))))

(add-hook 'latex-mode-hook
	  (lambda()
	    (dolist (p `(
			 ([(meta p)] . cj-tex-compile-in-cwd)
			 ))
	      (define-key latex-mode-map (car p) (cdr p))))
	  "yes, append it")


(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)

(setq history-length 200)

(defun cj-chop (str)
  (substring str 0 (- (length str) 1)))

(defun cj-filetim ()
  (interactive)
  (let ((tim (visited-file-modtime)))
    (insert "{mtime " (if (listp tim)
			  (cj-chop
			   (shell-command-to-string
			    (concat "perl -we '$t= "
				    (number-to-string (car tim))
				    "* 2**16 + "
				    (number-to-string (cadr tim))
				    "; exec \"date\", \"-d\", \"\\@$t\"'")))
			"-") "}")))

(defun cj-curtim ()
  (interactive)
  (insert "{"
	  (cj-chop (shell-command-to-string "date"))
	  "}"))

(defun cj-tim (u)
  (interactive "P");; "p" does not work actually!
  (if u
      (cj-filetim)
    (cj-curtim)))

(global-set-key [(control ^)] 'cj-tim)



;; ==== parenface ==================================================
;; (von http://foldr.org/~michaelw/log/programming/lisp/lispin von haskell.org)
;;http://www.uncommon-sense.net/interests/programming/parenface.el

;; Add a paren-face to emacs and add support for it to the various lisp modes.
;;
;; Based on some code that Boris Schaefer
;; <http://www.uncommon-sense.net/this-site/contact.html> posted to
;; comp.lang.scheme in message
;; <87hf8g9nw5.fsf@qiwi.uncommon-sense.net>.

(defvar paren-face 'paren-face)

(defface paren-face
    '((((class color))
       (:foreground
	"#80a0ff")))
  "Face for displaying a paren."
  :group 'faces)

(defmacro paren-face-add-support (keywords)
  "Generate a lambda expression for use in a hook."
  `(lambda ()
    (let* ((regexp "(\\|)")
           (match (assoc regexp ,keywords)))
      (unless (eq (cdr match) paren-face)
        (setq ,keywords (append (list (cons regexp paren-face)) ,keywords))))))

;; Keep the compiler quiet.
(eval-when-compile
  (defvar scheme-font-lock-keywords-2 nil)
  (defvar lisp-font-lock-keywords-2 nil))

(add-hook 'scheme-mode-hook           (paren-face-add-support scheme-font-lock-keywords-2))
(add-hook 'lisp-mode-hook             (paren-face-add-support lisp-font-lock-keywords-2))
(add-hook 'emacs-lisp-mode-hook       (paren-face-add-support lisp-font-lock-keywords-2))
(add-hook 'lisp-interaction-mode-hook (paren-face-add-support lisp-font-lock-keywords-2))

(provide 'parenface)

;; /parenface ========================================================


;; Use less screen estate (from Yegge)
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode nil))
;; But, tip to do that through X properties so that the bar is disabled
;; during start up already.

;; Then there's also scroll-bar-mode.


(global-set-key [(control ?,)] 'undo)
(global-set-key [(control ?.)] 'undo)
(global-set-key [(control ?-)] 'undo)

(setq inhibit-splash-screen t)

;; http://constantly.at/2009/05/on-line-wrapping-in-emacs-23pre/
(if (>= emacs-major-version 23)
    (progn
      (setq line-move-visual nil)
      ;; but actually just turn it off completely, for me, okay? Not
      ;; sure I'll ever like it anywhere.
      '(progn
	(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
	(add-hook 'text-mode-hook
		  (lambda () (set (make-local-variable 'line-move-visual) t))))))


;; had this (well, or equivalent/similar) in xemacs
(setq enable-recursive-minibuffers t)

;; and, disable multi-line, since that "wobbles around" too much
;; visually for me
(setq resize-mini-windows nil)
;; <fsbot> A value of nil means don't automatically resize mini-windows.
;; <fsbot> A value of t means resize them to fit the text displayed in them.
;; <fsbot> A value of `grow-only', the default, means let mini-windows grow only;

;; X window (frame) title:
(setq frame-title-format (list user-login-name ": %b"))
;;  "@" system-name   only uses space, I never use emacs via remote X

;; emacs25 requires this so as not to duplicate all input lines in
;; inferior-scheme mode:
(setq comint-process-echoes t)


;; Avoid jumping around in run-scheme or run-python windows
(setq scroll-conservatively 100)
