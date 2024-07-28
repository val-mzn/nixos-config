nix --experimental-features "nix-command flakes" \
    run github:nix-community/disko -- \
    --mode disko ./disko.nix \
    --arg device '"/dev/sda"'

nixos-generate-config --no-filesystems --root /mnt
nixos-install --root /mnt