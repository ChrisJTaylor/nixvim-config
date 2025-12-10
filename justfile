# show all available tasks
_default:
  @just --list

# build the flake configuration
[group('building')]
build-gui:
  nix build .

# build the flake configuration
[group('building')]
build-term:
  nix build .#terminal

# run this configuration of nixvim
[group('running')]
run-gui:
  nix run .

# run this configuration of nixvim
[group('running')]
run-term:
  nix run .#terminal

# update the flakes, also fixes formatting and runs the checks after updating
[group('maintenance')]
update: format 
  nix flake update
  just check

# run the checks to verify the configuration
[group('quality')]
check options="":
  nix flake check {{options}}

# format nix files in the project
[group('quality')]
format:
  nix fmt .
