{ unstable, ... }@inputs:
let
  py = unstable.python312;
  pyPackages = unstable.python312Packages;
  aider = py.pkgs.buildPythonPackage {
    pname = "aider";
    version = "0.34.0";
    src = inputs.aider;
    doCheck = false;
    propagatedBuildInputs = with pyPackages; [
      configargparse
      gitpython
      openai
      tiktoken
      jsonschema
      rich
      prompt-toolkit
      numpy
      scipy
      backoff
      pathspec
      networkx
      diskcache
      packaging
      sounddevice
      soundfile
      beautifulsoup4
      pyyaml
      pillow
      diff-match-patch
      playwright
      pypandoc
      litellm
      google-generativeai
      # not defined in nixpkgs
      grep-ast
    ];
  };
  grep-ast = pyPackages.buildPythonPackage {
    pname = "grep-ast";
    version = "0.2.4";
    src = inputs.grep-ast;
    doCheck = false;
    propagatedBuildInputs = with pyPackages; [
      pathspec
      # not defined in nixpkgs
      tree-sitter-languages
    ];
  };
  tree-sitter-languages = pkgs.unstable.python3Packages.buildPythonPackage rec {
    pname = "tree_sitter_languages";
    version = "1.10.2";
    format = "wheel";
    src = pyPackages.fetchPypi {
      inherit pname version format;
      sha256 = "muNKwxSnFwviSZig+ZTBrIB2HY1L0SavJ+5ToCPTuEk=";
      python = "cp312";
      abi = "cp312";
      platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    };
    postInstall = ''
      mv $out/lib/python3.12/site-packages/tree_sitter_languages/core.cpython-312-x86_64-linux-gnu.so $out/lib/python3.12/site-packages/tree_sitter_languages/core.so
    '';
  };
in unstable.mkShell { buildInputs = [ py.withPackages [ aider ] ]; }
