{ self, inputs, ... }: {
  flake.nixosModules.laptopMachineConfiguration =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.laptopMachineHardware
        self.nixosModules.laptopNiri
        self.nixosModules.common
      ];

      home-manager.users.mads = import ./_home.nix;
      
      networking.hostName = "laptop-nixos";
      
      boot.kernelParams = [ "i915.enable_dp_mst=1" ];

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

      virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };
      virtualisation.docker.enable = true;

      environment.systemPackages = with pkgs; [
        
      ];

      users.users.mads.extraGroups = [ "vboxusers" "docker" ];

      system.stateVersion = "25.11";
    };
}
