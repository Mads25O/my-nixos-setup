{ self, inputs, ... }: {

  flake.nixosConfigurations.laptopMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopMachineConfiguration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.mads = import ./_home.nix;
      }
    ];
  };

}
