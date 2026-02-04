{
  extraConfigLua = ''
    vim.schedule(function() require("vim._core.ui2").enable({ msg = { target = "msg" } }) end)
  '';
}
