{ ... }: {
  flake.nixosModules.sddm = 
    { pkgs, ... }:
    let
      sddmTheme = pkgs.sddm-astronaut.override {
        embeddedTheme = "japanese_aesthetic";
        themeConfig = {
          Font = "JetBrainsMono Nerd Font";
          HourFormat = "HH:mm";
          DateFormat = "dddd d. MMMM";
        };
      };
    in
    {
      services.displayManager.sddm = {
        enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = [ sddmTheme ];
      };

      environment.systemPackages = [ sddmTheme ];
    };
}
