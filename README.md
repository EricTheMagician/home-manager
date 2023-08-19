# My home-manager config

To build and switch, run:

1. Your username running user is eric and home directory is "/home/eric"
```bash
# locally
home-manager switch --flake .#eric
# if home-manager is also available
home-manager switch --flake github:EricTheMagician/home-manager#eric
# or more generally
mkdir ~/.config/home-manager -p
cd ~/.config/home-manager
nix build github:EricTheMagician/home-manager#homeConfigurations.eric.activationPackage
./result/activate
```

