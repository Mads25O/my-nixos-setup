{ self, inputs, ... }: {
  flake.nixosModules.common =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      services.flatpak.enable = true;

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_DATA_DIRS = [
          "/var/lib/flatpak/exports/share"
          "$HOME/.local/share/flatpak/exports/share"
        ];
      };

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.plymouth = {
        enable = true;
        theme = "rings";
        themePackages = [ pkgs.adi1090x-plymouth-themes ];
      };

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
      services.xserver.xkb = {
        layout = "dk";
        variant = "";
      };
      
      # KDE Plasma
      services.desktopManager.plasma6.enable = true;

      # Aktiver hvilken session SDDM starter som standard
      services.displayManager.defaultSession = lib.mkForce "niri";
      
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
        wl-clipboard
        pulseaudio # gives you pactl, e.g. for audio-speaker / audio-headphones aliases
        appimage-run
        
        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.inconsolata
        nerd-fonts.geist-mono
      ];

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      # Auto upgrade
      system.autoUpgrade.enable = true;
      system.autoUpgrade.allowReboot = true;

      # Auto delete old generations
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

    };
}
