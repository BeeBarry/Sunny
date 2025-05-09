let
  pkgs = import <nixpkgs> {config.allowUnfree = true;};
  nixpkgs-python = import (fetchTarball "https://github.com/cachix/nixpkgs-python/archive/refs/heads/main.zip");

  python-env = (nixpkgs-python.packages.${pkgs.system}."3.11").withPackages (pp:
    with pp; [
      pip
      wheel
      cython
    ]);
in
  pkgs.mkShell {
    packages = with pkgs;
      [
        vscode

        azure-cli
        # azure-cli-extensions.azure-devops
        azure-functions-core-tools

        bicep
        terraform
      ]
      # Language servers, linters, and formatters
      ++ [
        nodePackages.bash-language-server
        terraform-ls
        terraform-lsp
        basedpyright
      ];

    buildInputs = [
      python-env
    ];

    shellHook = ''
      PYTHON_BIN=${python-env}/bin/python
      [[ -d .venv ]] || $PYTHON_BIN -m venv .venv
      source .venv/bin/activate
      find . -name "requirements.txt" -exec .venv/bin/pip install -r {} \;
      .venv/bin/python --version


      if az account show &>/dev/null; then
        export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
      else
        (az login || echo "login skipped or interrupted") && \
        export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
      fi
    '';
  }
