{ self, inputs, ... }: {

  flake.nixosConfigurations.laptopMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopMachineConfiguration
    ];
  };

}
