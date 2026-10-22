_final: prev: {
  sioyek = prev.sioyek.overrideAttrs {
    # https://github.com/NixOS/nixpkgs/pull/566097
    postInstall = ''
      mkdir -p sioyek.app/Contents/Resources
      cp -r pdf_viewer/shaders sioyek.app/Contents/Resources/shaders
      cp pdf_viewer/{prefs,prefs_user,keys,keys_user}.config tutorial.pdf sioyek.app/Contents/Resources/

      mkdir -p $out/Applications $out/bin
      cp -r sioyek.app $out/Applications
      ln -s $out/Applications/sioyek.app/Contents/MacOS/sioyek $out/bin/sioyek
    '';
  };
}
