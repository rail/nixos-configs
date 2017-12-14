{ lib, pkgs, fetchFromGitHub, python3Packages }:

python3Packages.buildPythonPackage rec {
  name = "python-ewmh-${version}";
  version = "0.1.6";
  src = fetchFromGitHub {
    owner = "parkouss";
    repo = "pyewmh";
    rev = "refs/tags/v0.1.6";
    sha256 = "1hydpyqr5v1qd05aafhahfhpdl0gybfrs5knrgs5pslhygy80qyq";
  };

  propagatedBuildInputs = with python3Packages; [ xlib ];

  meta = with lib; {
    description = "An implementation of EWMH (Extended Window Manager Hints) for python 2 and 3, based on Xlib";
    homepage = "https://github.com/parkouss/pyewmh/";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
  };

}

