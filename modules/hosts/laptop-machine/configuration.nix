{ self, inputs, ... }: {
  flake.nixosModules.laptopMachineConfiguration =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.laptopMachineHardware
        self.nixosModules.niri
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; };
        users.mads = import ./_home.nix;
      };

      # Suspend when closing the lid
      services.logind.settings.Login.HandleLidSwitch = "suspend";

      # Actually lock the screen (log out) when closing the lid
      security.pam.services.swaylock = {};

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Work monitors
      boot.kernelParams = [ "i915.enable_dp_mst=1" ];

      networking.hostName = "laptop-nixos";
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

      # Touchpad
      services.libinput.enable = true;
      services.libinput.touchpad = {
        tapping = true;
        tappingDragLock = true;
        clickMethod = "clickfinger";
        naturalScrolling = false;
        disableWhileTyping = true;
      };

      # Audio
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      services.printing.enable = true;

      # Mullvad
      services.mullvad-vpn.enable = true;

      # Tor
      services.tor = {
        enable = true;
        client.enable = true;
      };

      # Virtualisation
      virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };
      virtualisation.docker.enable = true;

      # Auto-upgrade
      system.autoUpgrade.enable = true;
      system.autoUpgrade.allowReboot = false;

      users.users.mads = {
        isNormalUser = true;
        description = "Mads Overgård";
        extraGroups = [ "networkmanager" "wheel" "vboxusers" "docker" ];
        packages = with pkgs; [];
      };

      programs.firefox.enable = true;
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        # Base tools
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
        dig
        exiftool
        file
        util-linux
        appimage-run
        python3
        usbutils

        # GUI apps
        kitty
        spotify
        obsidian
        discord
        vlc
        libreoffice
        vscode
        pavucontrol
        tor-browser
        mullvad-vpn

        # Security / CTF tools
        wireshark
        burpsuite
        steghide
        zsteg

        # Fonts
        nerd-fonts.jetbrains-mono
        nerd-fonts.inconsolata
        nerd-fonts.geist-mono

        # Niri / Wayland
        fuzzel
      ];

      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      system.stateVersion = "25.11";
    };
}
