{ pkgs, ... }: {
  packages = [
    pkgs.nodejs_20
  ];
  bootstrap = ''
    mkdir "$WS_NAME"
    cd "$WS_NAME"
    npm init -y
    npm install @11ty/eleventy --save-dev
    echo '# Hello World!' > index.md
    mkdir -p ".idx"
    cd ..
    cp ${./dev.nix} "$WS_NAME/.idx/dev.nix"
    chmod -R +w "$WS_NAME"
    mv "$WS_NAME" "$out"

    mkdir -p "$out/.idx"
    chmod -R u+w "$out"
    cp -rf ${./.idx/airules.md} "$out/.idx/airules.md"
    cp -rf "$out/.idx/airules.md" "$out/GEMINI.md"
    chmod -R u+w "$out"

    cd "$out"; npm install --package-lock-only --ignore-scripts
  '';
}