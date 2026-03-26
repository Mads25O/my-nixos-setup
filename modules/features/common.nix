{ self, inputs, ... }: {
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.networkmanager.enable = true;
      networking.firewall.enable = true;

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
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
      };

      programs.firefox.enable = true;
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        # Common system packages
        wget 
        curl 
        git 
        neovim 
        fastfetch 
        htop 
        tree 
        bat
        p7zip
        unzip 
        zip 
        jq
        file
        util-linux 
        python3
        kitty
        fuzzel

        # Common software
        spotify 
        obsidian 
        discord
        vscode 
        mullvad-vpn

        # Cybersecurity tools
        dig
        exiftool
        wireshark 
        burpsuite 
        
        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.inconsolata
        nerd-fonts.geist-mono
      ];

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      # Mullvad
      services.mullvad-vpn.enable = true;

      # Auto upgrade
      system.autoUpgrade.enable = true;
      system.autoUpgrade.allowReboot = true;
    };
}
