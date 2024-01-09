final: prev:

let
  inherit (final) lib;
in

{
  example = lib.recurseIntoAttrs (final.callPackage ./. { });

  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonPackages: _:
      let
        example = final.example.override {
          python3Packages = pythonPackages;
        };
      in
      {
        example = example.example-python;
      })
  ];
}
