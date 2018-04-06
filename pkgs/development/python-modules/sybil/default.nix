{ stdenv, buildPythonApplication, fetchPypi, fetchpatch
, pytest, nose }:

buildPythonApplication rec {
  pname   = "sybil";
  version = "1.0.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "86332553392f865403883e44695bd8d9d47fe3887c01e17591955237b8fd2d8f";
  };

  patches = fetchpatch {
    url = https://github.com/cjw296/sybil/commit/cfce5ca39bc45a12d00ddc6a3e0b864426ad2eac.patch;
    sha256 = "0qk817v0zmnr31pzxn1r16jq1nbjd6rl09q6mkxji5sva3zc36gq";
  };

  checkInputs = [ pytest nose ];

  checkPhase = ''
    py.test tests
  '';

  meta = with stdenv.lib; {
    description = "Automated testing for the examples in your documentation.";
    homepage    = https://github.com/cjw296/sybil/;
    license     = licenses.mit;
  };
}
