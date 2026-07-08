{
  stdenv,
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  makeDesktopItem,
  copyDesktopItems,
  electron,
  makeWrapper,
}:

buildNpmPackage (finalAttrs: {
  pname = "zennotes-desktop";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "ZenNotes";
    repo = "zennotes";
    tag = "v${finalAttrs.version}";
    hash = "sha256-+tLPVnnMbtMa5blSwHav9ZMlnkUsrdG62mMGxhbmy6g=";
  };

  npmDepsHash = "sha256-7IpGnxVjaJvfSZyKjOylGMhFqa1bx8Ry5O1yqYfNnCE=";

  npmWorkspace = "apps/desktop";

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };

  nativeBuildInputs = [
    makeWrapper
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    copyDesktopItems
  ];

  dontNpmInstall = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/node_modules/zennotes-monorepo
    cp -r . $out/lib/node_modules/zennotes-monorepo/

    for size in 16 32 48 64 128 256 512; do
      install -Dm644 apps/desktop/build/icons/''${size}x''${size}.png $out/share/icons/hicolor/''${size}x''${size}/apps/${finalAttrs.pname}.png
    done

    mkdir -p $out/bin
    makeWrapper ${electron}/bin/electron $out/bin/${finalAttrs.pname} \
      --add-flags "$out/lib/node_modules/zennotes-monorepo/apps/desktop"

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = finalAttrs.pname;
      desktopName = "ZenNotes";
      exec = "${finalAttrs.pname} %U";
      icon = finalAttrs.pname;
      comment = "Keyboard-first local Markdown notes";
      categories = [
        "Office"
        "Utility"
        "TextEditor"
      ];
      startupWMClass = "ZenNotes";
      mimeTypes = [
        "text/markdown"
        "x-scheme-handler/zennotes"
      ];
    })
  ];

  meta = {
    description = "Keyboard-first local Markdown notes with Vim motions, diagrams, and MCP integration";
    homepage = "https://zennotes.org/";
    changelog = "https://github.com/ZenNotes/zennotes/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ justkrysteq ];
    mainProgram = finalAttrs.pname;
    inherit (electron.meta) platforms;
  };
})
