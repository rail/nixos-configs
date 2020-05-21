{ pkgs, ...}:
{

  environment.systemPackages = with pkgs; [
    fd
  ];
  environment.variables = {
    FZF_DEFAULT_COMMAND = "fd --type file --color=always";
    FZF_DEFAULT_OPTS = "--ansi";
  };
}
