{ lib
, newScope
, rustPlatform
, python3Packages
}:

lib.makeScope newScope (self: {
  src = lib.cleanSourceWith {
    filter = path: type: type == "directory" || !lib.hasSuffix ".nix" (baseNameOf path);
    src = lib.cleanSource ./.;
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = "${self.src}/Cargo.lock";
  };

  example-c = self.callPackage ./bindings/c {
    inherit rustPlatform;
  };

  example-python = self.callPackage ./bindings/python {
    inherit rustPlatform python3Packages;
  };
})
