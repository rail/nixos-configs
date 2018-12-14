{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (yarn.override { nodejs = nodejs-10_x; })
    arcanist
    nix-index
    nodejs-10_x
    patchelf
    python3.pkgs.autopep8
    python3.pkgs.flake8
    python3.pkgs.ipython
    python3.pkgs.isort
    python3.pkgs.mypy
    python3.pkgs.black
    python3.pkgs.virtualenv
    python3.pkgs.virtualenvwrapper
    python3Full
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.Nix
        ms-python.python
        # WakaTime.vscode-wakatime
      ]
      ++
      vscode-utils.extensionsFromVscodeMarketplace [

        # {
        #   name = "code-runner";
        #   publisher = "formulahendry";
        #   version = "0.6.33";
        #   sha256 = "166ia73vrcl5c9hm4q1a73qdn56m0jc7flfsk5p5q41na9f10lb0";
        # }
        {
          name = "org-mode";
          publisher = "tootone";
          version = "0.5.0";
          sha256 = "0sjplq9h3mc42f41gcyr30ixix8sclgsdi5mcgqazh2bh7g2hz5x";
        }
        {
          name = "vscode-eslint";
          publisher = "dbaeumer";
          version = "1.7.2";
          sha256 = "1czq88rb7db8j7xzv1dsx8cp42cbsg7xwbwc68waq5md14wx0ggr";
        }
        # {
        #   name = "puppet-vscode";
        #   publisher = "jpogran";
        #   version = "0.14.0";
        #   sha256 = "0jyfkmlb4slr8pd6zngd4nihj2z7rlyv6f7qi98hvf0bv5mqd34x";
        # }

      ];
    })
  ];
}
