# nixos-config

Configuration NixOS minimale avec Hyprland, en flake + home-manager.
Root **impermanent** : le sous-volume `/` est remis à zéro à chaque boot
(rollback de snapshot Btrfs), seuls les chemins déclarés survivent.

## Structure

```
flake.nix                         # inputs : nixpkgs, home-manager, disko, impermanence
hosts/nixos/
  configuration.nix               # point d'entrée (imports)
  hardware-configuration.nix      # matériel (sans fileSystems → gérés par disko)
  disko.nix                       # partitionnement déclaratif (Btrfs + sous-volumes)
  impermanence.nix                # rollback de @ au boot + état persistant
  boot.nix / networking.nix / locale.nix / users.nix
  nvidia.nix / desktop.nix / audio.nix / packages.nix
home/
  valmzn.nix                      # point d'entrée home-manager
  packages.nix / terminal.nix / hyprland.nix
```

## Layout disque (disko)

```
/dev/nvme0n1 (GPT)
├─ ESP    1 G    vfat            → /boot
├─ swap   34 G
└─ root   reste  btrfs
   ├─ @         → /        (EFFACÉ à chaque boot)
   ├─ @nix      → /nix     (persiste)
   ├─ @persist  → /persist (persiste — état déclaré via impermanence)
   ├─ @home     → /home    (persiste)
   └─ @log      → /var/log (persiste)
```

## Installation (depuis un live ISO NixOS)

> ⚠️ **Destructif** : ceci reformate `/dev/nvme0n1`. Sauvegarde tes données avant.

```bash
# 1. Récupérer la config
git clone <url> /tmp/nixos-config && cd /tmp/nixos-config

# 2. Partitionner + formater + monter sous /mnt (via disko)
sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode destroy,format,mount ./hosts/nixos/disko.nix

# 3. IMPORTANT : créer le snapshot de référence @-blank
#    (sinon le service de rollback échoue au boot)
sudo mkdir -p /mnt/btr_pool
sudo mount -o subvol=/ /dev/disk/by-partlabel/disk-main-root /mnt/btr_pool
sudo btrfs subvolume snapshot -r /mnt/btr_pool/@ /mnt/btr_pool/@-blank
sudo umount /mnt/btr_pool

# 4. Installer
sudo nixos-install --flake .#nixos

# 5. Reboot, puis copier la config dans le home (qui persiste)
```

## Au quotidien

```bash
# Rebuild après modification de la config
sudo nixos-rebuild switch --flake ~/Repos/nixos-config#nixos

# Mettre à jour les inputs
nix flake update
```

## Ajouter de l'état à persister

Tout ce qui n'est ni dans un sous-volume persistant (`/home`, `/nix`, `/var/log`)
ni déclaré dans `environment.persistence."/persist"` (voir `impermanence.nix`)
**disparaît au reboot**. Pour conserver un nouveau chemin système, l'ajouter à la
liste `directories` ou `files` de `impermanence.nix`.

### Astuce : trouver ce qui a été oublié

```bash
# Liste les fichiers présents sur @ qui ne sont pas dans le système Nix
# (candidats à persister ou à ignorer) :
sudo fd --one-file-system --type f . / 2>/dev/null
```



# Remonter tout sous /mnt sans reformater
  sudo nix --experimental-features "nix-command flakes" run \
    github:nix-community/disko/latest -- \
    --mode mount /tmp/nixos-config/hosts/nixos/disko.nix

  # Vérifier que /mnt/boot est bien monté
  mount | grep /mnt/boot

  Si /mnt/boot apparaît, crée les fichiers de mot de passe (s'ils ne sont pas déjà là) puis relance l'install :

  # Vérifier si les fichiers existent déjà
  ls -la /mnt/persist/passwords/

  # Si absents, les créer
  mkdir -p /mnt/persist/passwords
  mkpasswd -m yescrypt "ton_mot_de_passe" > /mnt/persist/passwords/valmzn
  mkpasswd -m yescrypt "mot_de_passe_root" > /mnt/persist/passwords/root
  chmod 600 /mnt/persist/passwords/{valmzn,root}

  # Relancer l'install
  sudo nixos-install --flake /tmp/nixos-config#nixos --no-root-passwd
