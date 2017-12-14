{ lib, pkgs, fetchurl, python3Packages }:
let
  python-ewmh = pkgs.callPackage ./python-ewmh.nix {};
in
python3Packages.buildPythonPackage rec {
  name = "caffeine-${version}";
  version = "2.9.4";
  src = fetchurl {
    url = "https://launchpad.net/~caffeine-developers/+archive/ubuntu/ppa/+files/caffeine_${version}.tar.gz";
    sha256 = "0gwz967hwwf3vs6fb5d8d7758amxww3isma2d4y3dnsizc7g94w7";
  };

  # no tests available
  # doCheck = false;

  propagatedBuildInputs = with pkgs; with python3Packages; [ libappindicator-gtk3 pygobject3 python-ewmh ];
  patchPhase = ''
    sed -i -e 's/^subprocess/# subprocess/g' setup.py
  '';

  meta = with lib; {
    description = "A status bar application able to temporarily prevent the activation of both the screensaver and the sleep powersaving mode.";
    homepage = "https://launchpad.net/caffeine";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
  };

}
