{ stdenv, buildPythonPackage, fetchPypi, six, setuptools_scm, pytest, freezegun }:
buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "python-dateutil";
  version = "2.7.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "9d8074be4c993fbe4947878ce593052f71dac82932a677d49194d8ce9778002e";
  };

  buildInputs = [ setuptools_scm ];
  propagatedBuildInputs = [ six ];
  checkInputs = [ pytest freezegun ];

  checkPhase = ''
    py.test
  '';

  # Infinite recursion with freezegun
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Powerful extensions to the standard datetime module";
    homepage = https://pypi.python.org/pypi/python-dateutil;
    license = "BSD-style";
  };
}
