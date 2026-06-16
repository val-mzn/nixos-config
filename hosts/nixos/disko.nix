{ config, lib, pkgs, ... }:

{
  # --- Partitionnement déclaratif (disko) ---
  # Layout pour l'impermanence : root Btrfs avec sous-volumes, seul @ est effacé.
  disko.devices.disk.main = {
    device = "/dev/nvme0n1";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        swap = {
          size = "34G";
          content = {
            type = "swap";
            resumeDevice = true;
          };
        };

        root = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];

            # Crée le snapshot de référence @-blank juste après le formatage,
            # nécessaire pour que le service de rollback au boot puisse fonctionner.
            postCreateHook = ''
              MNTPOINT=$(mktemp -d)
              mount -o subvol=/ /dev/disk/by-partlabel/disk-main-root "$MNTPOINT"
              trap 'umount "$MNTPOINT"; rmdir "$MNTPOINT"' EXIT
              btrfs subvolume snapshot -r "$MNTPOINT/@" "$MNTPOINT/@-blank"
            '';

            subvolumes = {
              "@" = {
                mountpoint = "/";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@nix" = {
                mountpoint = "/nix";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@persist" = {
                mountpoint = "/persist";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@home" = {
                mountpoint = "/home";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@log" = {
                mountpoint = "/var/log";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
            };
          };
        };
      };
    };
  };

  # /persist doit être monté tôt et marqué "needed for boot" : c'est lui qui
  # contient l'état réinjecté par impermanence avant le démarrage des services.
  fileSystems."/persist".neededForBoot = true;
}
