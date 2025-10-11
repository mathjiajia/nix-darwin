# Overlay to fix assimp on Darwin
# Applies the patch from https://github.com/NixOS/nixpkgs/pull/449045
final: prev: {
  assimp = prev.assimp.overrideAttrs (oldAttrs: rec {
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      (prev.lib.cmakeBool "ASSIMP_BUILD_TESTS" doCheck)
    ];
    
    # Some matrix tests fail on non-x86_64-linux:
    # https://github.com/assimp/assimp/issues/6246
    # https://github.com/assimp/assimp/issues/6247
    # On Darwin, the bundled googletest is not compatible with Clang 21.
    #  contrib/googletest/googletest/include/gtest/gtest-printers.h:498:35:
    #  error: implicit conversion from 'char16_t' to 'char32_t' may change the meaning of the represented code unit
    #  [-Werror,-Wcharacter-conversion]
    doCheck = prev.stdenv.hostPlatform.isLinux && prev.stdenv.hostPlatform.isx86_64;
  });
}