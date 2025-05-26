# Nixvim config

## How to
- Build it: `nix build .`
- Try it (without cloning locally): `nix run github:ChrisJTaylor/nixvim-config`
- Run it (after cloning locally): `nix run .`
- Install in your profile (permanent): `nix profile install .`
- Consume it from your main config flake:
  ```
  inputs.nixvim-config.url = "github:ChrisJTaylor/nixvim-flake";

  # Inside your `home.packages` or `environment.systemPackages`
  home.packages = [ inputs.nixvim-config.packages.${system}.default ];
  ```
