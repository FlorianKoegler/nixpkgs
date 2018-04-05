{ stdenv, buildPythonPackage, fetchPypi
, setuptools_scm, entrypoints, secretstorage
, pytest }:

buildPythonPackage rec {
  pname = "keyring";
  version = "12.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "fe8ae61626476c554af55036d48360b422a3d32c7c429a93f972219399987b38";
  };

  # https://github.com/jaraco/keyring/issues/314
  postPatch = ''
    touch LICENSE
  '';

  nativeBuildInputs = [ setuptools_scm ];

  checkInputs = [ pytest ];

  propagatedBuildInputs = [ entrypoints ] ++ stdenv.lib.optional stdenv.isLinux secretstorage;

  doCheck = !stdenv.isDarwin;

  checkPhase = ''
    py.test
  '';

  meta = with stdenv.lib; {
    description = "Store and access your passwords safely";
    homepage    = "https://pypi.python.org/pypi/keyring";
    license     = licenses.psfl;
    maintainers = with maintainers; [ lovek323 ];
    platforms   = platforms.unix;
  };
}
