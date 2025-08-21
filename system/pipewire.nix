{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  gsettings-schemas.packages = with pkgs; [
    pulseaudio
    pipewire
  ];
}
