{ self, inputs, ... }: {

  flake.nixosConfigurations.oldlaptopMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.oldlaptopMachineConfiguration
    ];
  };

}
