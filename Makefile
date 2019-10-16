all: /usr/share/emacs24/site-lisp/haskell-mode /usr/share/emacs/site-lisp/elpa-src/company-0.8.12 .emacs.d/dash-el .emacs.d/flycheck .emacs.d/f-el .emacs.d/s-el .emacs.d/intero elm

/usr/share/emacs24/site-lisp/haskell-mode:
	apt-get install -y haskell-mode


# XX ` elpa-epl ` is also installed but what for?

# not sure what this is for
/usr/share/emacs/site-lisp/elpa-src/company-0.8.12:
	apt-get install -y elpa-company


.emacs.d/dash-el:
	apt-get install -y dash-el
	bash -c 'set -euo pipefail; l=`dpkg -L elpa-dash | egrep '\''/dash\.el$$'\''`; ln -s "$$l" .emacs.d/dash-el'

/usr/share/emacs25/site-lisp/elpa/flycheck-30:
	apt-get install -y elpa-flycheck

.emacs.d/flycheck: /usr/share/emacs25/site-lisp/elpa/flycheck-30
	ln -s /usr/share/emacs25/site-lisp/elpa/flycheck-30 .emacs.d/flycheck


/usr/share/emacs25/site-lisp/elpa/f-0.19.0:
	apt-get install -y elpa-f

.emacs.d/f-el: /usr/share/emacs25/site-lisp/elpa/f-0.19.0
	ln -s /usr/share/emacs25/site-lisp/elpa/f-0.19.0 .emacs.d/f-el


/usr/share/emacs25/site-lisp/s-el:
	apt-get install -y s-el

.emacs.d/s-el: /usr/share/emacs25/site-lisp/s-el
	ln -s /usr/share/emacs25/site-lisp/s-el .emacs.d/s-el


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

