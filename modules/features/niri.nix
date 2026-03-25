{ self, inputs, ... }:
{

  flake.nixosModules.niri =
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
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.laptopNoctalia)
          ];

          input.mouse = {
            accel-speed = -0.2;
          };

          input.touchpad = {
            tap = null;
            natural-scroll = null;
            click-method = "clickfinger";
          };

          input.keyboard = {
            xkb.layout = "dk";
          };

          layout = {
            gaps = 0;
            focus-ring.off = null;
          };

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

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
#            "Mod+Right".focus-monitor-right = null;
#            "Mod+Left".focus-monitor-left = null;
#            "Mod+Shift+Right".move-column-to-monitor-right = null;
#            "Mod+Shift+Left".move-column-to-monitor-left = null;

            # Session
            "Mod+Shift+E".quit = null;
            "Mod+L".spawn-sh = lib.getExe pkgs.swaylock;

            # Noctalia launcher (your existing one)
            "Mod+N".spawn-sh = "${lib.getExe self'.packages.laptopNoctalia} ipc call launcher toggle";
          };

        };

      };

    };

}
