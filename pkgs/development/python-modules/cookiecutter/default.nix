{ stdenv, buildPythonPackage, fetchPypi, isPyPy
, itsdangerous, pytest, freezegun, docutils, jinja2, future, binaryornot, click
, whichcraft, poyo, jinja2_time }:

buildPythonPackage rec {
  pname = "cookiecutter";
  version = "1.6.0";

  # not sure why this is broken
  disabled = isPyPy;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1316a52e1c1f08db0c9efbf7d876dbc01463a74b155a0d83e722be88beda9a3e";
  };

  buildInputs = [ itsdangerous pytest freezegun docutils ];
  propagatedBuildInputs = [
    jinja2 future binaryornot click whichcraft poyo jinja2_time
  ];

  meta = with stdenv.lib; {
    homepage = https://github.com/audreyr/cookiecutter;
    description = "A command-line utility that creates projects from project templates";
    license = licenses.bsd3;
    maintainers = with maintainers; [ kragniz ];
  };
}
