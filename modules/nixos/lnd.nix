{ pkgs, ... }: { environment.systemPackages = with pkgs; [ lnd ]; }
