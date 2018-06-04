;; cask


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

;; hl-line

(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)

;; org-bullets

(require 'org-bullets)

(setq org-bullets-bullet-list '(
                                "◉"
                                "○"
                                "●"))

;; gist

(require 'gist)

;; org-jira

(setq jiralib-url (getenv "JIRA_PATH"))

;; multi-term

(require 'multi-term)

(setq multi-term-program "/usr/local/bin/zsh")

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

;; Powerline

(require 'powerline)
(powerline-default-theme)

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
  (set-default-font "-*-Hack-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
  (blink-cursor-mode 0)
  (setq-default line-spacing 2))

;; Helm

(require 'helm)
(require 'helm-config)

(helm-autoresize-mode 1)
(setq helm-split-window-in-side-p 1)

;; keybindings

(defun last-thing-from-kill-ring ()
  (substring-no-properties (car kill-ring)))

(global-set-key (kbd "C-c C-y") (lambda ()
                                  (interactive)
                                  (shell-command (concat "echo -n \"" (last-thing-from-kill-ring) "\" | pbcopy"))))

(global-set-key (kbd "C-c C-g") (lambda ()
                                  (interactive)
                                  (if mark-active
                                      (helm-grep-git-1 default-directory t nil (buffer-substring-no-properties (region-beginning) (region-end)))
                                    (helm-grep-do-git-grep t))))

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
;; this is old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; helm-ls-git

(require 'helm-ls-git)

(global-set-key (kbd "C-x C-d") 'helm-browse-project)

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

;; Shift the selected region right if distance is postive, left if
;; negative

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)

;; hydra

(require 'hydra)

;; hydras

(load "~/.emacs.d/hydras/window")
(global-set-key (kbd "C-c w") 'hydra-window/body)

;; scratch buffer

(setq initial-scratch-message nil)
(setq initial-major-mode 'org-mode)

;; Number of lines

(setq linum-format "%d ")

;; company-mode

(require 'company)

(setq company-dabbrev-downcase nil)

(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'company-backends '(company-capf company-dabbrev))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-j") 'company-complete-selection))

;; company-sourcekit

(require 'company-sourcekit)

;; (setq company-sourcekit-use-yasnippet 1)
;; (add-hook 'swift-mode-hook (lambda ()
;;                           (set (make-local-variable 'company-backends) '(company-sourcekit))
;;                           (company-mode)))

;; Spaces instead of tabs

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" default)))
 '(package-selected-packages
   (quote
    (protobuf-mode zenburn-theme yasnippet web-mode use-package undo-tree swift-mode smex smartparens projectile prodigy powerline popwin pallet nyan-mode multiple-cursors multi-term magit idle-highlight-mode hydra htmlize helm-ls-git flycheck-cask expand-region exec-path-from-shell dumb-jump drag-stuff company-sourcekit ace-jump-mode)))
 '(safe-local-variable-values
   (quote
    ((org-todo-keyword-faces
      ("HOLD" . "yellow")
      ("SUSPENDED" . "grey")))))
 '(tab-stop-list
   (quote
    (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tab-width 4))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(defvaralias 'c-basic-offset 'tab-width)

;; Ace jump mode

(require 'ace-jump-mode)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(add-hook 'org-mode-hook
          (lambda ()
            ;; When org-mode starts it (org-mode-map) overrides the ace-jump-mode.
            (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)
            (local-set-key (kbd "\C-c a") 'org-agenda)
            (org-bullets-mode t)
            (setq org-clock-into-drawer t)
            (org-indent-mode t)))

;; swift-mode

(require 'swift-mode)
(require 'swift-project-settings)

(setq swift-basic-offset 4)

;; dumb-jump

(require 'dumb-jump)

(defun enable-dumb-jump ()
  (dumb-jump-mode)
  (local-set-key (kbd "M-.") 'dumb-jump-go))

(add-hook 'swift-mode-hook 'enable-dumb-jump)
(add-hook 'objc-mode-hook 'enable-dumb-jump)

;; Org mode

(defun org-archive-all-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))

;; yasnippet

;; (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet)
;; (yas-global-mode 1)

;; Undo tree

(require 'undo-tree)

(global-undo-tree-mode)

;; iBuffer

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Folding an xml

(require 'hideshow)
(require 'sgml-mode)
(require 'nxml-mode)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "<!--\\|<[^/>]*[^/]>"
               "-->\\|</[^/>]*[^/]>"

               "<!--"
               sgml-skip-tag-forward
               nil))

(add-hook 'nxml-mode-hook 'hs-minor-mode)

(define-key nxml-mode-map (kbd "C-c h") 'hs-toggle-hiding)

;; XMl mode 4 spaces

(setq nxml-child-indent 4
      nxml-attribute-indent 4)

;; Color theme

(load-theme 'zenburn t)

;; Hiding extra panels

(menu-bar-mode -1)

;; Clipboard

(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
    (delete-region (region-beginning) (region-end)))

;; magit

(require 'magit)

(global-set-key (kbd "C-c g") 'magit-status)

;; git-gutter

(require 'git-gutter)

(set-face-foreground 'git-gutter:modified "blue")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(set-face-background 'git-gutter:added "gray")
(set-face-background 'git-gutter:modified "gray")
(set-face-background 'git-gutter:deleted "gray")

(add-hook 'prog-mode-hook (lambda ()
                            (git-gutter-mode 1)
                            (custom-set-variables
                             '(git-gutter:modified-sign "~")
                             '(git-gutter:added-sign "+")
                             '(git-gutter:deleted-sign "-"))))


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

;; Kill this buffer instead of prompt

(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Don't show initial buffer

(setq inhibit-startup-message t)

;; Other stuff

(global-set-key (kbd "C-j") #'newline-and-indent)

(delete-selection-mode t)
(setq max-lisp-eval-depth 10000)

;; Automatic generated shit I have no idea about


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)