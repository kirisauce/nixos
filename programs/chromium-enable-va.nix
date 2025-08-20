{ pkgs, lib, config, ... }:

{
  options.myConfig.chromium.va-support = lib.mkEnableOption "chromium vaapi support";

  config = lib.mkIf config.myConfig.chromium.va-support {
    nixpkgs.overlays = [
      (final: prev: {
        chromium = prev.chromium.override {
	  commandLineArgs = [
            "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
            "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
            "--enable-features=UseMultiPlaneFormatForHardwareVideo"
            "--ignore-gpu-blocklist"
            "--enable-zero-copy"
          ];
	};
      })
    ];
  };
}
