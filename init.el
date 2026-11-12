;; setup for using a custom file for initialization  -*- lexical-binding: t; -*-
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
