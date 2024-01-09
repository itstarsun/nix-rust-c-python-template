{ lib
, stdenv
, src
, cargoDeps
, rustPlatform
, python3Packages
, darwin
}:

let
  cargoTOML = builtins.fromTOML (builtins.readFile ./Cargo.toml);
in

python3Packages.toPythonModule (stdenv.mkDerivation (finalAttrs: {
  pname = "example-python";
  inherit (cargoTOML.package) version;

  inherit src cargoDeps;

  buildAndTestSubdir = "bindings/python";

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
    python3Packages.pipInstallHook
    python3Packages.pythonImportsCheckHook
  ];

  buildInputs = lib.optionals stdenv.isDarwin (with darwin; [
    libiconv
  ]);

  doCheck = true;
  doInstallCheck = finalAttrs.doCheck;

  nativeInstallCheckInputs = [
    python3Packages.unittestCheckHook
  ];

  unittestFlagsArray = [ "-s" "${finalAttrs.buildAndTestSubdir}/tests" ];

  pythonImportsCheck = [
    "example"
  ];

  strictDeps = true;
}))
