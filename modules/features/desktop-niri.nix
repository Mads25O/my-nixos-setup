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
            focus-ring.off = null;
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
            "Mod+Q".close-window = null;
            "Mod+F".maximize-column = null;
            "Mod+Shift+F".fullscreen-window = null;
            "Mod+C".center-column = null;

            # Column
            "Mod+comma".consume-window-into-column = null;
            "Mod+period".expel-window-from-column = null;

            # Focus movement
            "Mod+Left".focus-column-left = null;
            "Mod+Right".focus-column-right = null;
            "Mod+Down".focus-window-down = null;
            "Mod+Up".focus-window-up = null;

            # Move windows
            "Mod+Shift+Left".move-column-left = null;
            "Mod+Shift+Right".move-column-right = null;
            "Mod+Shift+Down".move-window-down = null;
            "Mod+Shift+Up".move-window-up = null;

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
            "Mod+Tab".focus-workspace-down = null;
            "Mod+Shift+Tab".focus-workspace-up = null;

            # Overview
            "Mod+O".toggle-overview = null;

            # Screenshots
            "Print".screenshot = null;
            "Ctrl+Print".screenshot-screen = null;
            "Alt+Print".screenshot-window = null;

            # Monitor movement (your existing ones)
            "Mod+Alt+Right".focus-monitor-right = null;
            "Mod+Alt+Left".focus-monitor-left = null;
            "Mod+Alt+Shift+Right".move-column-to-monitor-right = null;
            "Mod+Alt+Shift+Left".move-column-to-monitor-left = null;

            # Session
            "Mod+Shift+E".quit = null;
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
