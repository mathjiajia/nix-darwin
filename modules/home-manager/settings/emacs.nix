{
  programs.emacs = {
    enable = true;
    extraConfig = # lisp
      ''
        (add-to-list 'default-frame-alist
          '(font . "Maple Mono NF CN-28"))
      '';
  };
}
