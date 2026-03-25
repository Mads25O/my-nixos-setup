{ self, inputs, ... }: {

  flake.nixosConfigurations.desktopMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.desktopMachineConfiguration
    ];
  };

}
