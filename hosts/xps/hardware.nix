{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.nixos-hardware.nixosModules.dell-xps-13-9360 ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Only include ZFS datasets that are required for `initrd`:
  # https://github.com/NixOS/nixpkgs/blob/c62f50e86d942d868f7fb96f0450ec0f8ba6bc04/nixos/lib/utils.nix#L10-L14
  fileSystems = {
    "/" = {
      device = "zroot/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };
    "/nix" = {
      device = "zroot/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };
    "/var" = {
      device = "zroot/var";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };
    "/var/log" = {
      device = "zroot/var/log";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/2E0B-8E47";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp58s0.useDHCP = lib.mkDefault true;
  networking.hostId = "14e382a3";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
