nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/disko.nix \
  --arg device '"/dev/sda"'

nixos-generate-config --root /mnt
mv ./configuration.nix /mnt/etc/nixos/configuration.nix
nixos-install --root /mnt