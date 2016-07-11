(require 'helm)
(require 'ido)

(defhydra hydra-window (:hint nil)
  "hydra window"
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)

  ("]" enlarge-window-horizontally)
  ("[" shrink-window-horizontally)
  ("+" enlarge-window)
  ("-" shrink-window)
  ("=" balance-windows)
  
  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)))
  ("_" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))

  ("b" helm-buffers-list)
  ("p" helm-browse-project)
  ("f" ido-find-file)

  ("r" rotate-windows)
  ("o" delete-other-windows :exit t)
  ("dw" delete-window)
  ("df" kill-this-buffer)
  ("da" (lambda ()
          (interactive)
          (kill-this-buffer)
          (delete-window)))
  
  ("q" nil))
