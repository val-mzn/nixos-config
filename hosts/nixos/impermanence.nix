{ config, lib, pkgs, ... }:

{
  # --- Rollback du sous-volume root au boot ---
  # À chaque démarrage, @ est supprimé et recréé depuis le snapshot vide @-blank
  # (pris une seule fois à l'installation). Tout ce qui n'est pas déclaré
  # persistant disparaît donc à chaque reboot.
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback du sous-volume Btrfs root vers un état vierge";
    wantedBy = [ "initrd.target" ];
    after = [ "dev-disk-by\\x2dpartlabel-disk\\x2dmain\\x2droot.device" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /mnt
      # Monte le top-level du volume Btrfs (subvolid=5), pas un sous-volume
      mount -o subvol=/ /dev/disk/by-partlabel/disk-main-root /mnt

      # Supprime l'ancien root et tous ses éventuels sous-volumes imbriqués
      btrfs subvolume list -o /mnt/@ | cut -f9 -d' ' | while read subvol; do
        btrfs subvolume delete "/mnt/$subvol"
      done
      btrfs subvolume delete /mnt/@

      # Recrée un root vierge depuis le snapshot de référence
      btrfs subvolume snapshot /mnt/@-blank /mnt/@

      umount /mnt
    '';
  };

  # --- État explicitement conservé (bind-mount depuis /persist) ---
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/lib/nixos" # mapping uid/gid stable
      "/var/lib/systemd" # état systemd (timers, etc.)
      "/var/lib/bluetooth" # appairages Bluetooth
      "/etc/NetworkManager/system-connections" # connexions Wi-Fi/réseau
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  # Après rollback, /usr est recréé par l'activation NixOS (usrbinenv) sous
  # umask root 077 → mode 0700, ce qui casse les apps qui scannent
  # /usr/share/icons (Spotify, etc.). On force 0755 via tmpfiles.
  systemd.tmpfiles.rules = [
    "d /usr 0755 root root - -"
  ];

  # Note : /home, /nix et /var/log sont des sous-volumes séparés (non effacés),
  # donc tes fichiers persistent sans rien déclarer ici.
}
