;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/home/henke/git/klarna/OTP/otp/../install/R14B03/lib/erlang/lib/eqc-1.26.1/emacs/")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/home/henke/git/klarna/OTP/otp/../install/R14B03/lib/erlang/lib/eqc-1.26.1")
;; EQC Emacs Mode -- Configuration End

;; ido mode
(ido-mode t)
(require 'ido)

;; erlang mode setup
(setq load-path (cons  "/home/henke/git/klarna/OTP/otp/lib/tools/emacs" load-path))
(setq erlang-root-dir "/home/henke/git/klarna/OTP/otp")
(setq exec-path (cons "/home/henke/git/klarna/OTP/otp/bin" exec-path))
(require 'erlang-start)

;(autoload 'erlang "erlang" "Erlang mode" t)

;; distel
;;(add-to-list 'load-path "/home/henke/git/distel/elisp")
;;  (require 'distel)
;;  (distel-setup)

(add-to-list 'load-path "/home/henke/git/edts")
  (require 'edts-start)

(setq edts-projects
      '(( ;; kred.
         (name       . "kred")
         (root       . "~/git/klarna/dev")
         (node-sname . "kred")
         (start-command . "./bin/kred -no_cron -D"))))

;; Se till att yaws-filer också blir erlang-mode
;(setq auto-mode-alist (append (list (cons "\\.yaws$" 'erlang-mode)) auto-mode-alist))
(setq mac-option-modifier nil mac-command-modifier 'meta x-select-enable-clipboard t)
; Show both row and column numbers
(setq column-number-mode t)

(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
;(setq whitespace-style '(lines))
;(setq whitespace-line-column 80)
;(global-whitespace-mode 1)

; Put goto-line on M-g
(global-set-key [?\M-g] 'goto-line)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(erlang-indent-level 2: t)
 '(safe-local-variable-values (quote ((allout-layout . t)))))

; turn on paren match highlighting
(show-paren-mode 1)
; highlight entire expression, the other option is to highlight 'parenthesis
; (setq show-paren-style 'expression)
(setq show-paren-style 'parenthesis)

;; easily move around the buffer
(global-set-key [C-left] 'windmove-left)          ; move to left windnow
(global-set-key [C-right] 'windmove-right)        ; move to right window
(global-set-key [C-up] 'windmove-up)              ; move to upper window
(global-set-key [C-down] 'windmove-down)          ; move to downer window
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; character encoding
(set-terminal-coding-system 'iso-8859-1)
(setq default-buffer-file-coding-system 'iso-8859-1)
(prefer-coding-system 'iso-8859-1)
(set-language-environment "Latin-1")
(setq file-buffer-coding 'iso-8859-1)

