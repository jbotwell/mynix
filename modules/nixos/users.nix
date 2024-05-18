{pkgs, ...}: {
  users.users.john = {
    isNormalUser = true;
    description = "john";
    extraGroups = ["networkmanager" "wheel" "sway"];
    shell = pkgs.bash;
    hashedPassword = "$6$nhupSF2Neq$m61opyOxxlZAt10pdgSw/ORYlLOGa8efAF7dfKVRas8Wl4hVaSUI4d5poAk9VnMFY/xejKkZjst26INwMWrZZ.";
  };
}
