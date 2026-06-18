sudo nix --experimental-features "nix-command flakes" run \
  github:nix-community/disko/latest -- \
  --mode mount /tmp/nixos-config/hosts/nixos/disko.nix

ls -la /mnt/persist/passwords/

mkdir -p /mnt/persist/passwords
mkpasswd -m yescrypt "password" > /mnt/persist/passwords/valmzn
mkpasswd -m yescrypt "password" > /mnt/persist/passwords/root
chmod 600 /mnt/persist/passwords/{valmzn,root}

sudo nixos-install --flake /tmp/nixos-config#nixos --no-root-passwd