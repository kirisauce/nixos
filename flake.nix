{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Use the mirror
    nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations.kirisauce-p16pro-nixos = nixpkgs.lib.nixosSystem {
      modules =
        let
          machinePath = ./machines/kirisauce-p16pro-nixos;
        in [
          (machinePath + /configuration.nix)
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kirisauce = machinePath + /home-kirisauce.nix;
          }
        ];
    };
  };
}

