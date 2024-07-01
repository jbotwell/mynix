{pkgs, ...}: {
  home.packages = with pkgs; [
    vale
  ];

  home.file.".vale.ini".text = ''
    MinAlertLevel = suggestion

    Packages = write-good

    [*]
    BasedOnStyles = Vale, write-good
  '';
}
