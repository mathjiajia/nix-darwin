{
  programs.sagemath = {
    enable = true;
    package = null;
    initScript =
      # py
      ''
        %colors linux
        QUIET = var("alpha beta gamma delta epsilon zeta eta theta iota kappa mu nu xi omicron rho sigma tau upsilon phi chi psi omega");
      '';
  };
}
