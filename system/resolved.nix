{ lib, pkgs, config, ... }:

{
  networking.nameservers = [
    # Alibaba DNS
    "223.5.5.5"
    "223.6.6.6"
  ];

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    dnsovertls = "false";
  };
}
