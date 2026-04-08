# show all available tasks
_default:
  @just --list

alias f := format-check
alias b := build
alias t := test
alias ci := ci-check

# run all ci tasks in order (mimics workflow run)
[group('workflow tasks')]
ci-check: format-check build test

# check formatting of nix files without modifying them
[group('workflow tasks')]
format-check:
  nix fmt . -- --check

# build the flake configuration
[group('workflow tasks')]
build: build-gui build-term

# run tests
[group('workflow tasks')]
test:
  @echo "No tests to run"

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

# check commits are conventional
[group("quality")]
check-commits:
  @cog check

# get current version
[group("maintenance")]
get-version:
  @cog get-version

# Get the next version number
[group("maintenance")]
get-next-version-number:
  @cog bump --auto --dry-run

# bump version
[group("maintenance")]
bump options="--auto":
  @cog bump {{options}}

# create and publish release
[group("maintenance")]
create-release: format-check
  gh workflow run release.yml
