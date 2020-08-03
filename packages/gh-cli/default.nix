{stdenv, fetchurl, buildFHSUserEnv}:
let
  gh = stdenv.mkDerivation rec {
    pname = "gh";
    version ="0.11.0";
    src =
      if stdenv.hostPlatform.system == "x86_64-linux" then
        fetchurl {
          url = "https://github.com/cli/cli/releases/download/v${version}/${pname}_${version}_linux_amd64.tar.gz";
          sha256 = "1nl7a9602cpizriyhr2pmn4xaysqz8k7wgig8q9bb1rlw0w58c8i";
        }
      else throw "${pname}-${version} is not supported on ${stdenv.hostPlatform.system}";
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p $out
      cp -r bin $out
    '';
  };

in buildFHSUserEnv {
  name = "gh";
  targetPkgs = pkgs: [ gh ];
  runScript = "${gh}/bin/gh";
}
