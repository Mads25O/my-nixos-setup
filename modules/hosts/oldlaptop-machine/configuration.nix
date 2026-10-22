{ self, inputs, ... }: {
  flake.nixosModules.oldlaptopMachineConfiguration =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.oldlaptopMachineHardware
        self.nixosModules.laptopNiri
        self.nixosModules.common
        self.nixosModules.sddm
      ];

      # Legacy BIOS: GRUB instead of systemd-boot from common.nix
      boot.loader.systemd-boot.enable = lib.mkForce false;
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
      boot.loader.grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };

      home-manager.users.mads = import ./_home.nix;

      networking.hostName = "oldlaptop-nixos";

      services.logind.settings.Login.HandleLidSwitch = "suspend";
      security.pam.services.swaylock = {};

      services.libinput.enable = true;
      services.libinput.touchpad = {
        tapping = true;
        tappingDragLock = true;
        clickMethod = "clickfinger";
        naturalScrolling = false;
        disableWhileTyping = true;
      };

      environment.systemPackages = with pkgs; [

      ];

      system.stateVersion = "25.11";
    };
}
