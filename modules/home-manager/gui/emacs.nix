{
  programs.emacs = {
    enable = true;
    extraConfig =
      # lisp
      ''
        (set-frame-font "Maple Mono CN-16:Regular")
        (add-to-list 'default-frame-alist '(font . "Maple Mono CN-24:Regular"))
        (set-face-attribute 'default t :font "Maple Mono CN-16:Regular")
      '';
  };
}
