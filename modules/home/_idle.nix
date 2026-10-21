{ pkgs, inputs, ... }:
let
  noctalia = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
  lock = "${pkgs.lib.getExe noctalia} ipc call lockScreen lock";
in
{
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = lock;
      lock = lock;
    };
  };
}
