# show all available tasks
_default:
  @just --list

# build the flake configuration
build:
  nix build .

# run this configuration of nixvim
run:
  nix run .

# update the flakes
update:
  nix flake update

# run the checks to verify the configuration
check options="":
  nix flake check {{options}}

# format nix files in the project
format:
  nix fmt .
