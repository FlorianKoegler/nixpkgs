{ stdenv, buildPythonPackage, fetchPypi
, secretstorage
, fs, gdata, python_keyczar, pyasn1, pycrypto, six, setuptools_scm
, mock, pytest, pytestrunner }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "keyring";
  version = "12.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "fe8ae61626476c554af55036d48360b422a3d32c7c429a93f972219399987b38";
  };

  buildInputs = [
    fs gdata python_keyczar pyasn1 pycrypto six setuptools_scm
  ];

  checkInputs = [ mock pytest pytestrunner ];

  propagatedBuildInputs = [ secretstorage ];

  doCheck = !stdenv.isDarwin;

  checkPhase = ''
    py.test $out
  '';

  meta = with stdenv.lib; {
    description = "Store and access your passwords safely";
    homepage    = "https://pypi.python.org/pypi/keyring";
    license     = licenses.psfl;
    maintainers = with maintainers; [ lovek323 ];
    platforms   = platforms.unix;
  };
}
