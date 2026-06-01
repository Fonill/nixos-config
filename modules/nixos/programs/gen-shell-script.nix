{ pkgs, ... }:

let
  gen-shell-script = pkgs.writeShellScriptBin "gen-shell" ''
    if [ $# -eq 0 ]; then
      echo "Usage: gen-shell <packages...>"
      exit 1
    fi

    FILE="flake.nix"
    PKGS="$*"

    cat > "$FILE" <<EOF
{
  description = "Dev Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        $PKGS
      ];
    };
  };
}
EOF
    echo "Created $FILE with: $PKGS"

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git add "$FILE"
        echo "Added $FILE to git"
    fi
  '';
in

{
    environment.systemPackages = [
        gen-shell-script
    ];
}