{unstable, ...} @ inputs: let
  pkgs = import unstable {system = "x86_64-linux";};
  py = pkgs.python312;
  pyPackages = pkgs.python312Packages;
  aider = pyPackages.buildPythonPackage {
    pname = "aider";
    version = "0.30.0";
    src = fetchGit {
      url = "https://github.com/paul-gauthier/aider";
      rev = "b14ca861c1709cc3e53160560f09f6ebf16f2d66";
    };
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
    src = fetchGit {
      url = "https://github.com/paul-gauthier/grep-ast";
      rev = "4adb83e164f31c3a9ae364de8a7b14b9481aca60";
    };
    doCheck = false;
    propagatedBuildInputs = with pyPackages; [
      pathspec
      # not defined in nixpkgs
      tree-sitter-languages
    ];
  };
  tree-sitter-languages = pyPackages.buildPythonPackage rec {
    pname = "tree_sitter_languages";
    version = "1.10.2";
    format = "wheel";
    src = pyPackages.fetchPypi {
      inherit pname version format;
      sha256 = "bS8c0dG91lMy+cK2fUnc8UjPHe11KFHRWaw+XuT00mA=";
      python = "cp312";
      abi = "cp312";
      platform = "manylinux_2_17_x86_64.manylinux2014_x86_64";
    };
    propagatedBuildInputs = with pyPackages; [tree-sitter];
  };
in
  pkgs.mkShell {buildInputs = [(py.withPackages (ps: [aider]))];}
