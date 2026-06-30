{ self, inputs, ... }:
{

  flake.nixosModules.desktopNiri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.desktopNiri;
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

      packages.desktopNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          input.mouse = {
            accel-speed = -0.2;
          };

          input.keyboard = {
            xkb.layout = "dk";
          };

          layout = {
            gaps = 0;
            focus-ring.off = {};
          };

          window-rules = [
            {
              matches = [{ app-id = "^spotify$"; }];
              draw-border-with-background = false;
            }
          ];

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          extraConfig = ''
            output "DP-1" {
              position x=0 y=0
            }
            output "DP-3" {
              position x=2560 y=0
            }
          '';

          binds = {
            # Apps
            "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+S".spawn-sh = lib.getExe pkgs.fuzzel;
            "Mod+B".spawn-sh = lib.getExe pkgs.firefox;

            # Window management
            "Mod+Q".close-window = {};
            "Mod+F".maximize-column = {};
            "Mod+Shift+F".fullscreen-window = {};
            "Mod+C".center-column = {};

            # Column
            "Mod+comma".consume-window-into-column = {};
            "Mod+period".expel-window-from-column = {};

            # Focus movement
            "Mod+Left".focus-column-left = {};
            "Mod+Right".focus-column-right = {};
            "Mod+Down".focus-window-down = {};
            "Mod+Up".focus-window-up = {};

            # Move windows
            "Mod+Shift+Left".move-column-left = {};
            "Mod+Shift+Right".move-column-right = {};
            "Mod+Shift+Down".move-window-down = {};
            "Mod+Shift+Up".move-window-up = {};

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
            "Mod+Tab".focus-workspace-down = {};
            "Mod+Shift+Tab".focus-workspace-up = {};

            # Overview
            "Mod+O".toggle-overview = {};

            # Screenshots
            "Print".screenshot = {};
            "Ctrl+Print".screenshot-screen = {};
            "Alt+Print".screenshot-window = {};

            # Monitor movement (your existing ones)
            "Mod+Alt+Right".focus-monitor-right = {};
            "Mod+Alt+Left".focus-monitor-left = {};
            "Mod+Alt+Shift+Right".move-column-to-monitor-right = {};
            "Mod+Alt+Shift+Left".move-column-to-monitor-left = {};

            # Session
            "Mod+Shift+E".quit = {};
            "Mod+L".spawn-sh = lib.getExe pkgs.swaylock;

            # Noctalia launcher (your existing one)
            "Mod+N".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            "Mod+Shift+S".spawn-sh = "${lib.getExe pkgs.cage} -- ${lib.getExe pkgs.spotify}";
            "Mod+V".spawn-sh = "cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy";
          };

        };

      };

    };

}
