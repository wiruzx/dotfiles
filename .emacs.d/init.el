;; Packages

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; TODO: Use configuration inside of the sexp
(use-package zenburn-theme :ensure t)
(use-package org-ai :ensure t)
(use-package ag :ensure t)
(use-package projectile :ensure t)
(use-package expand-region :ensure t)
(use-package org-bullets :ensure t)
(use-package pbcopy :ensure t)
(use-package ace-jump-mode :ensure t)
(use-package undo-tree :ensure t)
(use-package magit :ensure t)

;; Org AI

(require 'org-ai)
(add-hook 'org-mode-hook #'org-ai-mode)

(setq org-ai-openai-api-token (getenv "OPENAI_API_KEY"))
(setq org-ai-default-chat-model "gpt-4")

;; Org capture

(setq org-directory "~/Developer/badoo-journal")
(setq org-inbox-file (concat org-directory "/inbox.org"))
;; (setq org-agenda-text-search-extra-files
;;       (directory-files (concat org-directory "/journal") t "\.org$"))

;; Change set mark shortcut

(global-set-key (kbd "M-SPC") 'set-mark-command)

;; Fix window buffer switching

(setq ido-default-buffer-method 'samewindow)

;; Haskell mode

(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))

;; Fix env

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))

;; window size & position

(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (width . 85)
              (height . 25)
              (left . 100)
              (right . 100)))
      (setq default-frame-alist
            '(
              (width . 85)
              (height . 25)
              (left . 100)
              (right . 100)))))

;; projectile

(require 'ag)
(require 'projectile)

(projectile-mode t)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Fix backspace invoking help
(global-set-key "\C-h" 'delete-backward-char)

;; expand-region

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; winner-mode

(when (fboundp 'winner-mode)
  (winner-mode 1))

(global-set-key (kbd "C-c u") 'winner-undo)
(global-set-key (kbd "C-c r") 'winner-redo)

;; org todo states

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
        (sequence "HOLD(h)")
        (sequence "|" "CANCELED(c)" "SUSPENDED(s)")))

(setq org-todo-keyword-faces
      '(("HOLD" . "yellow") ("SUSPENDED" . "grey")))

;; org-bullets

(require 'org-bullets)

(setq org-bullets-bullet-list '(
                                "◉"
                                "○"
                                "●"))

;; org-jira

(setq jiralib-url (getenv "JIRA_PATH"))

;; Mouse scrolling

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

;; Setup mode line

;; @see http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
;; But I need global-mode-string,
;; @see http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_360.html
;; use setq-default to set it for /all/ modes
(setq-default mode-line-format
  (list
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b " 'face 'font-lock-keyword-face
        'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
      (propertize "%02l" 'face 'font-lock-type-face) ","
      (propertize "%02c" 'face 'font-lock-type-face)
    ") "

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face) ;; size
    "] "

    ;; the current major mode for the buffer.
    "["

    '(:eval (propertize "%m" 'face 'font-lock-string-face
              'help-echo buffer-file-coding-system))
    "] "


    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
              'face 'font-lock-preprocessor-face
              'help-echo (concat "Buffer is in "
                           (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
              (concat ","  (propertize "Mod"
                             'face 'font-lock-warning-face
                             'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat ","  (propertize "RO"
                             'face 'font-lock-type-face
                             'help-echo "Buffer is read-only"))))
    "] "

    ;;global-mode-string, org-timer-set-timer in org-mode need this
    (propertize "%M" 'face 'font-lock-type-face)

    " --"
    ;; i don't want to see minor-modes; but if you want, uncomment this:
    ;; minor-mode-alist  ;; list of minor modes
    "%-" ;; fill with '-'
    ))

;; GUI Emacs settings

(when window-system
  ;; Setting smooth scrolling
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse 't)
  (setq scroll-step 1)

  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (set-fringe-mode '(4 . 0))
  ;;(set-default-font "-*-Hack-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
  (blink-cursor-mode 0)
  (setq-default line-spacing 2))

;; Windows swapping

(defun rotate-windows (arg)
  "Rotate your windows; use the prefix argument to rotate the other direction"
  (interactive "P")
  (if (not (> (count-windows) 1))
      (message "You can't rotate a single window!")
    (let* ((rotate-times (prefix-numeric-value arg))
           (direction (if (or (< rotate-times 0) (equal arg '(4)))
                          'reverse 'identity)))
      (dotimes (_ (abs rotate-times))
        (dotimes (i (- (count-windows) 1))
          (let* ((w1 (elt (funcall direction (window-list)) i))
                 (w2 (elt (funcall direction (window-list)) (+ i 1)))
                 (b1 (window-buffer w1))
                 (b2 (window-buffer w2))
                 (s1 (window-start w1))
                 (s2 (window-start w2))
                 (p1 (window-point w1))
                 (p2 (window-point w2)))
            (set-window-buffer-start-and-point w1 b2 s2 p2)
                        (set-window-buffer-start-and-point w2 b1 s1 p1)))))))

;; Ido mode

(ido-mode t)

;; scratch buffer

(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

;; Number of lines

(setq linum-format "%d ")

;; Spaces instead of tabs

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" default))
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(org-agenda-files
   '("/Users/shamanov/Developer/badoo-journal/today.org" "/Users/shamanov/Developer/badoo-journal/next.org" "/Users/shamanov/Developer/badoo-journal/inbox.org" "/Users/shamanov/Developer/badoo-journal/suspended.org" "/Users/shamanov/Developer/badoo-journal/backlog.org" "/Users/shamanov/Developer/badoo-journal/notes.org"))
 '(package-selected-packages
   '(protobuf-mode zenburn-theme yasnippet web-mode use-package undo-tree swift-mode smex smartparens projectile prodigy powerline popwin pallet nyan-mode multiple-cursors multi-term magit idle-highlight-mode hydra htmlize helm-ls-git flycheck-cask expand-region exec-path-from-shell drag-stuff ace-jump-mode))
 '(safe-local-variable-values
   '((org-todo-keyword-faces
      ("HOLD" . "yellow")
      ("SUSPENDED" . "grey"))))
 '(tab-stop-list
   '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
 '(tab-width 4))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(defvaralias 'c-basic-offset 'tab-width)

;; Intercepting urls

(defun jira-link-recognizer (string)
  (if (string-match "https?://jira\.*?/browse/\\([a-zA-Z]*-[0-9]*\\)" string)
      (if-let ((issue-number (match-string 1 string)))
          (cons string issue-number))))

(defun github-repo-link-recognizer (string)
  (if (string-match "https?:\/\/github.com\/\\([a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+\\)\/?" string)
      (if-let ((repo-name (match-string 1 string)))
          (cons string repo-name))))

(defun github-hash-digits-recognizer (kind string)
  (if (string-match (concat "https?:\/\/github\.com\/.*\/\\([a-zA-Z0-9_-]+\\)\/" kind "\/\\([0-9]+\\)") string)
      (if-let ((repo-name (match-string 1 string))
               (number (match-string 2 string)))
          (cons string (concat repo-name " #" number)))))

(defun github-issue-link-recognizer (string)
  (github-hash-digits-recognizer "issues" string))

(defun github-pull-link-recognizer (string)
  (github-hash-digits-recognizer "pull" string))

(defvar org-link-recognizers '(jira-link-recognizer
                               github-pull-link-recognizer
                               github-issue-link-recognizer
                               github-repo-link-recognizer))

(defun find-recognizer (value recognizers)
  (if-let ((head (car recognizers)))
      (if-let ((match (funcall head value)))
          match
        (find-recognizer value (cdr recognizers)))))

(defun org-insert-link-interceptor ()
  "If it could recognizer the link from the clipboard it'll prettify and paste it"
  (interactive)
  (let ((clipboard (shell-command-to-string "pbpaste")))
    (if-let ((match (find-recognizer clipboard org-link-recognizers)))
        (insert (org-make-link-string (car match) (cdr match)))
      (funcall-interactively #'org-insert-link))))

;; Ace jump mode

(require 'ace-jump-mode)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key (kbd "C-c c") (lambda () (interactive) (org-capture nil "t")))
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)

(setq org-capture-templates '(("t" "TODO" entry (file org-inbox-file) "* TODO %?")))

(add-hook 'org-mode-hook
          (lambda ()
            ;; When org-mode starts it (org-mode-map) overrides the ace-jump-mode.
            (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)
            (local-set-key (kbd "C-c C-l") 'org-insert-link-interceptor)
            (setq-local org-complete-tags-always-offer-all-agenda-tags t)
            (org-bullets-mode t)
            (setq org-clock-into-drawer t)
            (org-indent-mode t)))

;; Undo tree

(require 'undo-tree)

(global-undo-tree-mode)

;; iBuffer

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Color theme

(load-theme 'zenburn t)

;; Hiding extra panels

(menu-bar-mode -1)

;; Clipboard

(require 'pbcopy)
(turn-on-pbcopy)

;; magit

(require 'magit)

(global-set-key (kbd "C-c g") 'magit-status)

;; Russian keyboard support

(when (eq system-type 'darwin)
  (quail-define-package
   "russian-mac" "Russian" "RU" nil
   "ЙЦУКЕН Russian Mac layout"
   nil t t t t nil nil nil nil nil t)

  ;; >< 1! 2" 3№ 4% 5: 6, 7. 8; 9( 0) -_ =+
  ;;     Й  Ц  У  К  Е  Н  Г  Ш  Щ  З  Х  Ъ
  ;;      Ф  Ы  В  А  П  Р  О  Л  Д  Ж  Э  Ё
  ;;   ][  Я  Ч  С  М  И  Т  Ь  Б  Ю  /?

  (quail-define-rules
					; row 1
   ("§" ?>)
					; row 2
   ("q" ?й) ("w" ?ц) ("e" ?у) ("r" ?к) ("t" ?е) ("y" ?н) ("u" ?г) ("i" ?ш)
   ("o" ?щ) ("p" ?з) ("[" ?х) ("]" ?ъ)
					; row 3
   ("a" ?ф) ("s" ?ы) ("d" ?в) ("f" ?а) ("g" ?п) ("h" ?р) ("j" ?о) ("k" ?л)
   ("l" ?д) (";" ?ж) ("'" ?э) ("\\" ?ё)
					; row 4
   ("`" ?\]) ("z" ?я) ("x" ?ч) ("c" ?с) ("v" ?м) ("b" ?и) ("n" ?т) ("m" ?ь)
   ("," ?б) ("." ?ю)
					; Shift row 1
   ("±" ?<) ("@" ?\") ("#" ?№) ("$" ?%) ("%" ?:) ("^" ?,) ("&" ?.)
   ("*" ?\;)
					; Shift row 2
   ("Q" ?Й) ("W" ?Ц) ("E" ?У) ("R" ?К) ("T" ?Е) ("Y" ?Н) ("U" ?Г) ("I" ?Ш)
   ("O" ?Щ) ("P" ?З) ("{" ?Х) ("}" ?Ъ)
					; Shift row 3
   ("A" ?Ф) ("S" ?Ы) ("D" ?В) ("F" ?А) ("G" ?П) ("H" ?Р) ("J" ?О) ("K" ?Л)
   ("L" ?Д) (":" ?Ж) ("\"" ?Э) ("|" ?Ё)
					; Shift row 4
   ("~" ?\[) ("Z" ?Я) ("X" ?Ч) ("C" ?С) ("V" ?М) ("B" ?И) ("N" ?Т) ("M" ?Ь)
   ("<" ?Б) (">" ?Ю)))


;; Short messages

(defalias 'yes-or-no-p 'y-or-n-p)

;; Confirmation for killing emacs

(setq confirm-kill-emacs 'y-or-n-p)

;; Kill this buffer instead of prompt

(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Don't show initial buffer

(setq inhibit-startup-message t)

;; Other stuff

(delete-selection-mode t)
(setq max-lisp-eval-depth 10000)

;; Generated

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
