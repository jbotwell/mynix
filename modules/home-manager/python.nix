{ pkgs, inputs, ... }:

let
  myPythons = ps:
    with ps; [
      # for the correct working of Jupyter + Magma
      jupyter
      jupyterlab
      ilua
      pynvim
      ueberzug
      pillow
      pnglatex
      plotly
      pyperclip
      # other tools
      pip
      aider
    ];
  # these are needed for aider
  tree-sitter-languages = pkgs.unstable.python3Packages.buildPythonPackage {
    pname = "tree-sitter-languages";
    version = "1.10.2";
    src = inputs.tree-sitter-languages;
    doCheck = false;
    nativeBuildInputs = [ pkgs.unstable.python3Packages.cython ];
    propagatedBuildInputs = with pkgs.unstable.python3Packages; [ tree-sitter ];
  };
  grep-ast = pkgs.unstable.python3Packages.buildPythonPackage {
    pname = "grep-ast";
    version = "0.2.4";
    src = inputs.grep-ast;
    doCheck = false;
    propagatedBuildInputs = with pkgs.unstable.python3Packages; [
      tree-sitter-languages
      pathspec
    ];
  };
  aider = pkgs.unstable.python3Packages.buildPythonPackage {
    pname = "aider";
    version = "0.30.0";
    src = inputs.aider;
    doCheck = false;
    propagatedBuildInputs = with pkgs.unstable.python3Packages; [
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
      grep-ast
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
    ];
  };
in {
  home.packages = with pkgs.unstable; [
    (python311.withPackages myPythons)
  ];
}
