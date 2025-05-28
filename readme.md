# Nixvim config

Nixified Neovim configuration using `nixvim`.

## Prerequisites*
- Nix in some form or another
- Flakes enabled
- Git, probably?
- Also computer... keyboard too?

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
  
  ### Further info
  [Nixvim documentation]: https://nix-community.github.io/nixvim/index.html
  [Nixos]: https://nixos.org/
  [Nix first steps]: https://nix.dev/tutorials/first-steps/
  
  ------------------------
  * Not an exhaustive list
