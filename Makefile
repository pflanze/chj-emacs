all: .emacs.d/haskell-mode .emacs.d/company .emacs.d/dash-el .emacs.d/flycheck .emacs.d/f-el .emacs.d/s-el

# remember, can't use dirs as make targets!
.emacs.d/haskell-mode: .emacs.d/haskell-mode/haskell.el
.emacs.d/haskell-mode/haskell.el:
	sbin/apt-install-and-symlink-dir haskell-mode haskell.el .emacs.d/haskell-mode elpa-haskell-mode

# XX ` elpa-epl ` is also installed but what for?

# not sure what this is for
.emacs.d/company: .emacs.d/company/company.el
.emacs.d/company/company.el:
	sbin/apt-install-and-symlink-dir elpa-company company.el .emacs.d/company

.emacs.d/dash-el: .emacs.d/dash-el/dash.el
.emacs.d/dash-el/dash.el:
	sbin/apt-install-and-symlink-dir dash-el dash.el .emacs.d/dash-el elpa-dash

.emacs.d/flycheck: .emacs.d/flycheck/flycheck.el
.emacs.d/flycheck/flycheck.el:
	sbin/apt-install-and-symlink-dir elpa-flycheck flycheck.el .emacs.d/flycheck 

.emacs.d/f-el: .emacs.d/f-el/f.el
.emacs.d/f-el/f.el:
	sbin/apt-install-and-symlink-dir elpa-f f.el .emacs.d/f-el

.emacs.d/s-el: .emacs.d/s-el/s.el
.emacs.d/s-el/s.el:
	sbin/apt-install-and-symlink-dir s-el s.el .emacs.d/s-el elpa-s


# XXX  also building needs ` libtinfo-dev ` ?
.emacs.d/intero: #  /home/cjaeger/src/intero
	ln -s /home/cjaeger/src/intero .emacs.d




elm: .emacs.d/elm-mode/elm-mode.el .emacs.d/flycheck-elm/flycheck-elm.el /usr/local/bin/elm-oracle

.emacs.d/elm-mode/elm-mode.el:
	sbin/git-clone-commit https://github.com/jcollard/elm-mode elm-mode a01626ce462fffc11af1f7e64f6d520e363157f9

.emacs.d/flycheck-elm/flycheck-elm.el:
	sbin/git-clone-commit https://github.com/bsermons/flycheck-elm flycheck-elm debd0af563cb6c2944367a691c7fa3021d9378c1


#Secure way?:
# .emacs.d/elm-oracle/....el:
# 	sbin/git-clone-commit https://github.com/ElmCast/elm-oracle elm-oracle
# 	etc...

#But no have time, so follow https://www.lambdacat.com/post-modern-emacs-setup-for-elm/ :
# XXX security
/usr/local/bin/elm-oracle:
	npm install -g elm-oracle

