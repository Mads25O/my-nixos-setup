{ self, inputs, ... }: {
  flake.nixosModules.desktopMachineConfiguration =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.desktopMachineHardware
        self.nixosModules.desktopNiri
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users.mads = import ./_home.nix;
      };

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # NVIDIA SHIT
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      };
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";   
      };

      networking.hostName = "desktop-nixos";
      networking.networkmanager.enable = true;

      time.timeZone = "Europe/Copenhagen";
      i18n.defaultLocale = "en_DK.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "da_DK.UTF-8";
        LC_IDENTIFICATION = "da_DK.UTF-8";
        LC_MEASUREMENT = "da_DK.UTF-8";
        LC_MONETARY = "da_DK.UTF-8";
        LC_NAME = "da_DK.UTF-8";
        LC_NUMERIC = "da_DK.UTF-8";
        LC_PAPER = "da_DK.UTF-8";
        LC_TELEPHONE = "da_DK.UTF-8";
        LC_TIME = "da_DK.UTF-8";
      };

      services.xserver.enable = true;
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      services.xserver.xkb = {
        layout = "dk";
        variant = "";
      };

      console.keyMap = "dk-latin1";
      services.printing.enable = true;

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.users.mads = {
        isNormalUser = true;
        description = "Mads Overgård";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
      };

      programs.firefox.enable = true;
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        kitty
        spotify
        tree
        fuzzel
        unzip
        git
        cage
      ];

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      system.stateVersion = "25.11";
    };
}
