(defhydra hydra-window (:hint nil)
  "
Movement^^        ^Split^            ^Resize^                      ^Misc^
-------------------------------------------------------------------------------------
_h_ ←           _|_ vertically       _]_ increase horizontally    _dw_ close window
_j_ ↓           ___ horizontally     _[_ decrease horizontally    _df_ close file
_k_ ↑                              _+_ increase vertically      _o_  close other
_l_ →                              _-_ decrease vertically      _q_  exit
                                 _=_ balance windows
"
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
  
  ("o" delete-other-windows :exit t)
  ("dw" delete-window)
  ("df" kill-this-buffer)
  
  ("q" nil))
