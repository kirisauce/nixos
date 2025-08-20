{ lib, stdenv, pkgs, ... }:

stdenv.mkDerivation rec {
  name = "fcitx-rime-ice-config";
  src = pkgs.fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "2025.04.06";
    sha256 = "sha256-s3r8cdEliiPnKWs64Wgi0rC9Ngl1mkIrLnr2tIcyXWw=";
  };
  dontFixup = true;
  dontCheck = true;

  installPhase = ''
    mkdir -p "$out"
    cp -r -t "$out" ./*
    chmod -R 0755 "$out"
  '';
}
