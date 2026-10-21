{ self, inputs, ... }:
{

  flake.nixosModules.laptopNiri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.laptopNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {

      packages.laptopNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        v2-settings = true;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          input.mouse = {
            accel-speed = -0.2;
          };

          input.touchpad = {
            tap = _: {};
            natural-scroll = _: {};
            click-method = "clickfinger";
          };

          input.keyboard = {
            xkb.layout = "dk";
          };

          layout = {
            gaps = 10;
            focus-ring.off = _: {};
          };
        
          window-rules = [
            {
              geometry-corner-radius = 12;
              clip-to-geometry = true;
            }
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          binds = {
            # Apps
            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+S".spawn-sh = lib.getExe pkgs.fuzzel;
            "Mod+B".spawn-sh = lib.getExe pkgs.firefox;

            # Window management
            "Mod+Q".close-window = _: {};
            "Mod+F".maximize-column = _: {};
            "Mod+Shift+F".fullscreen-window = _: {};
            "Mod+C".center-column = _: {};

            # Column
            "Mod+comma".consume-window-into-column = _: {};
            "Mod+period".expel-window-from-column = _: {};

            # Focus movement
            "Mod+Left".focus-column-left = _: {};
            "Mod+Right".focus-column-right = _: {};
            "Mod+Down".focus-window-down = _: {};
            "Mod+Up".focus-window-up = _: {};

            # Move windows
            "Mod+Shift+Left".move-column-left = _: {};
            "Mod+Shift+Right".move-column-right = _: {};
            "Mod+Shift+Down".move-window-down = _: {};
            "Mod+Shift+Up".move-window-up = _: {};

            # Resize
            "Mod+Minus".set-column-width = "-10%";
            "Mod+Plus".set-column-width = "+10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Plus".set-window-height = "+10%";

            # Workspaces
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+Shift+1".move-column-to-workspace = 1;
            "Mod+Shift+2".move-column-to-workspace = 2;
            "Mod+Shift+3".move-column-to-workspace = 3;
            "Mod+Shift+4".move-column-to-workspace = 4;
            "Mod+Tab".focus-workspace-down = _: {};
            "Mod+Shift+Tab".focus-workspace-up = _: {};

            # Overview
            "Mod+O".toggle-overview = _: {};

            # Screenshots
            "Print".screenshot = _: {};
            "Ctrl+Print".screenshot-screen = _: {};
            "Alt+Print".screenshot-window = _: {};

            # Monitor movement (your existing ones)
#            "Mod+Right".focus-monitor-right = _: {};
#            "Mod+Left".focus-monitor-left = _: {};
#            "Mod+Shift+Right".move-column-to-monitor-right = _: {};
#            "Mod+Shift+Left".move-column-to-monitor-left = _: {};

            # Session
            "Mod+Shift+E".quit = _: {};
            "Mod+L".spawn-sh = lib.getExe pkgs.swaylock;

            # Noctalia launcher (your existing one)
            "Mod+N".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          };

        };

      };

    };

}
