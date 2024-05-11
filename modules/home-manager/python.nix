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
  grep-ast = pkgs.unstable.python3Packages.buildPythonPackage {
    pname = "grep-ast";
    version = "0.2.4";
    src = inputs.grep-ast;
    doCheck = false;
    propagatedBuildInputs = with pkgs.unstable.python3Packages; [
      pathspec
    ];
    extraWheels = [
      ./python/tree_sitter_languages-1.10.2-cp311-cp311-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
    ];
  };
  aider = pkgs.unstable.python3Packages.buildPythonPackage {
    pname = "aider";
    version = "0.34.0";
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
  home.packages = with pkgs.unstable; [ (python311.withPackages myPythons) ];
}
