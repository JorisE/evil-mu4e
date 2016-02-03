;;; evil-mu4e.el --- evil-based key bindings for mu4e

;; Copyright (C) 2015 Joris Engbers

;; Author: Joris Engbers <info@jorisengbers.nl>
;; Package-Requires: ((mu4e))
;; Homepage: https://github.com/JorisE/evil-mu4e
;; Version: 0.0.1

; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 3, or (at your
;; option) any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package configures Keybindings for Mu4e that make sense for Evil users.

;; Installation and Use
;; ====================

;; Everything is contained in evil-mu4e.el, so you may download and load that file
;; directly. The recommended method is to use MELPA via package.el (`M-x
;; package-install RET evil-mu4e RET`).

;; Evil and Mu4e are both required. After requiring those packages, the following
;; will setup the new key bindings for you.

;; The bindings that differ from normal mu4e are listed below:

;; General commands
;; | Commmand        | evil-mu4e |
;; |-----------------+-----------|
;; | Move up         | k         |
;; | Move down       | j         |
;; | Jump to maildir | J         |
;; | Switch context  | f         |
;; | Display manual  | ?         |
;; |                 |           |
;;
;; Specific to:
;; mu4e-main-mode
;; | Command              | evil-mu4e  |
;; |----------------------+------------|
;; | Update               | u          |
;; | mark unread      | u   |
;; | mark read        | r   |
;; | mark for trash   | x   |
;; | execute marks    | e   |

;;  mu4e-view-mode
;; | Command          | key |
;; |------------------+-----|
;; | Next message     | l   |
;; | Previous message | h   |
;; | mark unread      | u   |
;; | mark read        | r   |
;; | mark for trash   | x   |
;; | execute marks    | e   |
;;; Code:

(require 'evil)
(require 'mu4e)

(defcustom evil-mu4e-state 'motion
  "State to use for al "
  :group 'mu4e
  :type  'symbol)


;;; By default all mu4e modes except for mu4e-compose-mode will start in
;;; evil-emacs-state. This section makes all modes start in evil-motion-state.

(defvar evil-mu4e-emacs-to-evil-mu4e-state-modes
  '(mu4e-main-mode
    mu4e-headers-mode
    mu4e-view-mode)
  "Modes that should switch from emacs state to `evil-mu4e-state'")

(defun evil-mu4e-set-state ()
    "Associate all relevant modes with the evil-mu4e-state"
(dolist (mode evil-mu4e-emacs-to-evil-mu4e-state-modes)
  (evil-set-initial-state mode evil-mu4e-state)))



;;; Define bindings

(defvar evil-mu4e-mode-map-bindings
  `((,evil-mu4e-state mu4e-main-mode-map "J"               mu4e~headers-jump-to-maildir)
    (,evil-mu4e-state mu4e-main-mode-map "j"               next-line)
    (,evil-mu4e-state mu4e-main-mode-map "k"               previous-line)
    (,evil-mu4e-state mu4e-main-mode-map "u"               mu4e-update-mail-and-index)
    (,evil-mu4e-state mu4e-main-mode-map "gr"              mu4e-update-mail-and-index)
    (,evil-mu4e-state mu4e-main-mode-map "b"               mu4e-headers-search-bookmark)
    (,evil-mu4e-state mu4e-main-mode-map "N"               mu4e-news)
    (,evil-mu4e-state mu4e-main-mode-map "f"               mu4e-context-switch)
    (,evil-mu4e-state mu4e-main-mode-map "?"               mu4e-display-manual)


    (,evil-mu4e-state mu4e-headers-mode-map "J"            mu4e~headers-jump-to-maildir)
    (,evil-mu4e-state mu4e-headers-mode-map "j"            next-line)
    (,evil-mu4e-state mu4e-headers-mode-map "k"            previous-line)
    (,evil-mu4e-state mu4e-headers-mode-map "f"            mu4e-context-switch)
    (,evil-mu4e-state mu4e-headers-mode-map "?"            mu4e-display-manual)
    (,evil-mu4e-state mu4e-headers-mode-map ,(kbd "RET")   mu4e-headers-view-message)
    (,evil-mu4e-state mu4e-headers-mode-map "n"            mu4e-headers-search-narrow)
    (,evil-mu4e-state mu4e-headers-mode-map "u"            mu4e-headers-mark-for-unread)
    (,evil-mu4e-state mu4e-headers-mode-map "r"            mu4e-headers-mark-for-read)
    (,evil-mu4e-state mu4e-headers-mode-map "x"            mu4e-headers-mark-for-trash)
    (,evil-mu4e-state mu4e-headers-mode-map "e"            mu4e-mark-execute-all)


    (,evil-mu4e-state mu4e-view-mode-map "J"               mu4e~headers-jump-to-maildir)
    (,evil-mu4e-state mu4e-view-mode-map "\C-j"            mu4e-view-headers-next)
    (,evil-mu4e-state mu4e-view-mode-map "\C-k"            mu4e-view-headers-prev)
    (,evil-mu4e-state mu4e-view-mode-map "h"               mu4e-view-headers-prev)
    (,evil-mu4e-state mu4e-view-mode-map "?"               mu4e-display-manual)
    (,evil-mu4e-state mu4e-view-mode-map "u"               mu4e-view-mark-for-unread)
    (,evil-mu4e-state mu4e-view-mode-map "r"               mu4e-view-mark-for-read)
    (,evil-mu4e-state mu4e-view-mode-map "x"               mu4e-view-mark-for-trash)
    (,evil-mu4e-state mu4e-view-mode-map "e"               mu4e-mark-execute-all)
    (,evil-mu4e-state mu4e-view-mode-map "\C-u"              evil-scroll-up))
  "All evil-mu4e bindings.")

(defun evil-mu4e-set-bindings ()
    "Set the bindings."
(dolist (binding evil-mu4e-mode-map-bindings)
    (evil-define-key
     (nth 0 binding) (nth 1 binding) (nth 2 binding) (nth 3 binding))))


;;; Update mu4e-main-view
;;; To avoid confusing the main-view is updated to show the keys that are in use
;;; for evil-mu4e.

(defvar evil-mu4e-begin-region-basic "\n  Basics"
  "The place where to start overriding Basic section.")

(defvar evil-mu4e-end-region-basic "a new message\n"
  "The place where to end overriding Basic section.")

(defvar evil-mu4e-new-region-basic
  "Define the evil-mu4e Basic region."
(concat (mu4e~main-action-str "\t* [J]ump to some maildir\n" 'mu4e-jump-to-maildir)
(mu4e~main-action-str "\t* enter a [s]earch query\n" 'mu4e-search)
(mu4e~main-action-str "\t* [c]ompose a new message\n" 'mu4e-compose-new)))

(defvar evil-mu4e-begin-region-misc "\n  Misc"
  "The place where to start overriding Misc section.")

(defvar evil-mu4e-end-region-misc "q]uit"
  "The place where to end overriding Misc section.")

(defvar evil-mu4e-new-region-misc
  "Define the evil-mu4e Misc region."
  (concat
   (mu4e~main-action-str "\t* [f]Switch focus\n" 'mu4e-context-switch)
   (mu4e~main-action-str "\t* [u]pdate email & database\n"
                         'mu4e-update-mail-and-index)

   ;; show the queue functions if `smtpmail-queue-dir' is defined
   (if (file-directory-p smtpmail-queue-dir)
       (mu4e~main-view-queue)
     "")
   "\n"

   (mu4e~main-action-str "\t* [N]ews\n" 'mu4e-news)
   (mu4e~main-action-str "\t* [A]bout mu4e\n" 'mu4e-about)
   (mu4e~main-action-str "\t* [?]help\n" 'mu4e-display-manual)
   (mu4e~main-action-str "\t* [q]uit\n" 'mu4e-quit))
  )

(defun evil-mu4e-replace-region (new-region start end)
  "Replace the region between START and END from the mu4e-main-view with new-region. Where START end END end are regular expressions."
  ;; move to start of region
  (goto-char (point-min))
  (re-search-forward start)

  ;; insert new headings
  (insert "\n\n")
  (insert new-region)
  ;; Delete text until end of region.
  (let ((start-point (point))
        (end-point (re-search-forward end)))
    (delete-region start-point end-point)))


(defun evil-mu4e-update-main-view ()
  (evil-mu4e-replace-region evil-mu4e-new-region-basic evil-mu4e-begin-region-basic evil-mu4e-end-region-basic)
  (evil-mu4e-replace-region evil-mu4e-new-region-misc evil-mu4e-begin-region-misc evil-mu4e-end-region-misc)
)



;;; Initialize evil-mu4e

;;;###autoload
(defun evil-mu4e-init ()
  "Initialize evil-mu4e."
  (evil-mu4e-set-state)
  (evil-mu4e-set-bindings)

  (add-hook 'mu4e-main-mode-hook 'evil-mu4e-update-main-view)
)

(evil-mu4e-init)

(provide 'evil-mu4e)
;;; evil-mu4e.el ends here
