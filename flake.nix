{
  description = "My macOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [ "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      _ = self;

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              bash-language-server
              lua-language-server
              nixd
              nixfmt-rfc-style
              nodePackages.vscode-json-languageserver
              prettierd
              stylua
              taplo
              yaml-language-server
            ];
          };
        }
      );
    };
}
