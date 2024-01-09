{ stdenv
, src
, cargoDeps
, rust-cbindgen
, rustPlatform
}:

let
  cargoTOML = builtins.fromTOML (builtins.readFile ./Cargo.toml);
in

stdenv.mkDerivation {
  pname = "example-c";
  inherit (cargoTOML.package) version;

  inherit src cargoDeps;

  buildAndTestSubdir = "bindings/c";
  cargoBuildType = "release";

  nativeBuildInputs = [
    rust-cbindgen
    rustPlatform.cargoSetupHook
    rustPlatform.cargoBuildHook
    rustPlatform.cargoInstallHook
  ];

  postInstall = ''
    pushd $buildAndTestSubdir
    cbindgen -o $out/include/example.h
    popd
  '';

  strictDeps = true;
}
