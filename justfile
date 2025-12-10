# show all available tasks
_default:
  @just --list

# build the flake configuration
build-gui:
  nix build .

# build the flake configuration
build-term:
  nix build .#terminal

# run this configuration of nixvim
run-gui:
  nix run .

# run this configuration of nixvim
run-term:
  nix run .#terminal

# update the flakes
update:
  nix flake update

# run the checks to verify the configuration
check options="":
  nix flake check {{options}}

# format nix files in the project
format:
  nix fmt .
