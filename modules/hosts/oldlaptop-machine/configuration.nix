{ self, inputs, ... }: {
  flake.nixosModules.oldlaptopMachineConfiguration =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.oldlaptopMachineHardware
        self.nixosModules.laptopNiri
        self.nixosModules.common
        self.nixosModules.sddm
      ];

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

      # users.users.mads.extraGroups = [ "vboxusers" "docker" ];

      system.stateVersion = "25.11";
    };
}
