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


(setq auto-mode-alist
      (cons '("\\.\\(?:scm\\|sch\\|scme\\|bee\\|ast\\)$" . scheme-mode)
	    auto-mode-alist))

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


; 
;(require 'cua)
;(load "/usr/share/emacs/site-lisp/emacs-goodies-el/cua.el")
;(CUA-mode t)
;(CUA-mode)
;; ^- in the hope that switching it off once solves the weird problems I had without it, and switching it off again makes it's key stuff away. yep it does.
;; need to ~reinitialize pending-delete-mode now, though: it's on but doesn't show regions, so.. switch off and on again:
(pending-delete-mode)
(pending-delete-mode)

;; folding-mode doesn't work on first attempt to switch it on, so try to switch on once for frer?:
;(folding-mode)
;(folding-mode)
; doesn't help
;ah, folding-add-to-marks-list  is better. asks for what to use. ah wohl reason for failure

; folding-fold-region  C-f @ C-.. stuff keybindings don't work!!!
; sigh.

(require 'cl) ;; for |case|

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


(global-set-key "\M-g" 'goto-line) ; quoting required!
;(global-set-key '[(super 2)] 'foobarcj) why what how ? todo.
;I'll use f1 instead f
(global-set-key '[f1] 'cj-doublequote)

(defun scroll-up-one ()
  (interactive) ; <bpalmer> did you remember to make it interactive?  <Riastradh> Interactive functions in elisp are horrific.
  (scroll-up 1))
(defun scroll-down-one ()
  (interactive)
  (scroll-down 1))
  
(global-set-key [(control meta down)] 'scroll-up-one)
(global-set-key [(control meta up)] 'scroll-down-one)

(global-set-key "\C-v" 'scroll-up)

; 17.6.04:
; entweder mit nxml-mode, oder xslide
; latter isch ned automatisch da scheissigerweise
; /usr/share/doc/xslide/dot_emacs
(autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)
;; Turn on font lock when in XSL mode <--- was isch das? ç
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


; 17.6.04:
; http://www.emacswiki.org/cgi-bin/wiki/WikifiedEmacsLispList
;  -> http://yersinia.org/homes/paolino/emacs/multi-mode-mode.el

;; (autoload 'multi-mode
;;   ;"multi-mode" cj:
;;   "/usr/local/share/emacs/site-lisp/multi-mode-mode.el"
;;   "Allowing multiple major modes in a buffer."
;;   t)
;(require 'multi-mode-mode)
;(defalias 'multi-mode multi-mode-mode)
;(defalias 'multi-mode 'multi-mode-mode)
; nein sondern:
;(multi-mode-mode 1)
; geht eh nicht funk

;  http://www.hisemailaddress.org/ver1/downloads/.emacs

;; (defun xsp-mode () (interactive)
;;   (multi-mode 1
;; 	      'xml-mode
;; 	      '("<xsp:logic>" perl-mode)
;; 	      '("</xsp:logic>" xml-mode)))


; http://www.emacswiki.org/cgi-bin/wiki/CPerlMode
; http://www.emacswiki.org/cgi-bin/wiki/IndentingPerl

;(defalias 'perl-mode 'cperl-mode)
; ^- schlussendlich ist es simpel und einfach der cperl mode an sich, der pending-delete nicht funktionnieren lasst

(setq cperl-indent-level 4)
(setq cperl-font-lock t)
;; (setq cperl-electric-lbrace-space t)
;; ; ^-?
;; (setq cperl-electric-parens t)
;; (setq cperl-electric-linefeed t)
;; (setq cperl-electric-keywords t)

;(setq cperl-highlight-variables-indiscriminately t) 
; ^- It's not working with cperl-mode 4.23 as shiped with emacs. Get some newer version.
(setq cperl-hairy t)


(add-hook 'cperl-mode-hook
	  (lambda () 
	    (define-key cperl-mode-map [(return)] (lambda () (interactive) (cperl-indent-command) (newline-and-indent)))
	    (define-key cperl-mode-map [(shift return)] 'newline)
	    ;(font-lock-mode) unnecessary now since cperl-font-lock is t
	    (imenu-add-menubar-index)
	    ;(pending-delete-mode 1); egal ob mit oder ohne 1, nüt
	    ;(delete-selection-mode 1)
	    ;;(pending-delete-mode t nil (pending-del)) nix ich pending-del gibtsned
	    ;(setq transient-mark-mode t)
	    ;(require 'pending-del)  (pending-delete-on nil)  
	    ))

; noch mehr
;(column-number-mode 1)
;(pending-delete-mode) mann geht nicht? war drin aber in cperl mode nichts?


;;todo: ob dies alles nötig isch auch bei gnuem.?
(add-hook 'c-mode-common-hook
          (lambda ()
             (define-key c-mode-base-map [(return)] 'newline-and-indent)
             (define-key c-mode-base-map [(shift return)] 'newline)
             (setq c-basic-offset 4)
             (font-lock-mode) ; =syntax hilighting, sigh
             (imenu-add-menubar-index)
             )
          )

;(global-set-key [(return)] 'newline-and-indent)
;(global-set-key [(shift return)] 'newline)
; argh, das bekommt dem gnu emacs nicht?! macht minibuffer futsch

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;(fset 'yes-or-no-p 'y-or-n-p)
;http://www.emacswiki.org/emacs/YesOrNoP
;http://www.emacswiki.org/emacs/RevertBuffer
;oder just
;(defalias 'yes-or-no-p 'y-or-n-p)

;; or, from http://www.emacswiki.org/emacs/RevertBuffer
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (not (buffer-modified-p)))
	(revert-buffer t t t) )))
  (message "Refreshed open files.") )

;; but also see auto-revert-mode, see below in scheme-mode


(add-hook 'perl-mode-hook
	  (lambda () 
	    (define-key perl-mode-map [(return)] 
	      (lambda () (interactive)
		(perl-indent-command)
		(newline-and-indent)))
	    (define-key perl-mode-map [(shift return)] 'newline)
	    (font-lock-mode)
	    (imenu-add-menubar-index)
	    ))
;trarig


; Load the LAML Emacs support.
; This fragment has been inserted by the LAML configuration program.
; You can delete it if you do not want it. Do not edit it, however.

;(load "/opt/laml/emacs-support/dot-emacs-contribution.el")

; End of LAML Emacs configuration.


(global-set-key [(meta s)] 'save-buffer)

(iswitchb-mode)
(iswitchb-default-keybindings)
(setq iswitchb-default-method 'samewindow) ; instead of always-frame (raise geht nicht für tty..)

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
  (setq scheme-program-name "loop -c ~/bin/gam-emacs"))


(when (file-exists-p "~/.emacs.d/pretty-lambdada.el")
  (load-file "~/.emacs.d/pretty-lambdada.el")
  (pretty-lambda-for-modes))


(tool-bar-mode)


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
  (backward-char-nomark 2))


(defvar cj-first-fn-block 
  '(
    ([f2] . cj-up-list)
    ([f3] . insert-parentheses)
    ([f4] . move-past-close-and-reindent)
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
	    (dolist (p `(;; note, muss kleinbuchstaben sein, F4 geht silently nicht !!!
			 ,@cj-first-fn-block
			 ;;([f4] . gambit-continue)
			 ([f5] . gambit-crawl-backtrace-newer)
			 ([f6] . gambit-crawl-backtrace-older)
			 ([f8] . gambit-step-continuation)
			 ([f9] . gambit-leap-continuation)
			 ;; f8 is reset to gambit-continue by someone? grr
			 ;; cj Sun, 19 Mar 2006 20:12:38 +0100: (but maybe look into Ria's paredit.el)
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

(defun cj-filetim ()
  (interactive)
  (let ((tim (visited-file-modtime)))
    (insert "{mtime " (if (listp tim)
			  (current-time-string tim)
			"-") "}")))

(defun cj-curtim ()
  (interactive)
  (insert "{" (current-time-string) "}"))

;(global-set-key "\C-udiaeresis" 'cj-curtim)
;(global-set-key "\C-ü" 'cj-curtim)
;(global-set-key "\C-¨" 'cj-filetim)
;achgehendochnich. aber so eher:
;(global-set-key [(control ü)] 'cj-curtim)
;(global-set-key [(control ¨)] 'cj-filetim)
;ehr??

(defun cj-tim (u)
  (interactive "P");; "p" does not work actually!
  (if u
      (cj-filetim)
    (cj-curtim)))

(global-set-key [(control ^)] 'cj-tim)



;; parenface
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
       (:foreground ;;"dimgray"
	;;"#c070e0" zu violettlich
	;;"#a0c0ff" zu hell
	"#80a0ff" ;; yeah  well vielleicht zu schwach
	)))
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

;; /parenface

;; yegge:
;(if (fboundp 'menu-bar-mode) ;; weil xemacs das nid hat "??!!!??"
;    (menu-bar-mode nil))
;; ah und dann kam  von jemand anderm noch der tip dass man das  besser über X properties macht weil dann schon beim aufstart die bar weg isch.
;; und dann gibts noch scroll-bar-mode und   den bildleiste hab ich eh schon weg.


(global-set-key [(control ?,)] 'advertised-undo)
(global-set-key [(control ?.)] 'advertised-undo)
(global-set-key [(control ?-)] 'advertised-undo)

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
