{
  extraConfigLua = ''
    vim.schedule(function() require("vim._extui").enable({ msg = { target = "msg" } }) end)
  '';
}
