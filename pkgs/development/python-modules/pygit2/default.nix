{ stdenv, lib, buildPythonPackage, fetchPypi, isPyPy, libgit2, six, cffi }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "pygit2";
  version = "0.27.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "6febce4aea72f12ed5a1e7529b91119f21d93cb2ccb3f834eea26af76cc9a4cb";
  };

  preConfigure = lib.optionalString stdenv.isDarwin ''
    export DYLD_LIBRARY_PATH="${libgit2}/lib"
  '';

  propagatedBuildInputs = [ libgit2 six ] ++ lib.optional (!isPyPy) cffi;

  preCheck = ''
    # disable tests that require networking
    rm test/test_repository.py
    rm test/test_credentials.py
    rm test/test_submodule.py
  '';

  meta = with lib; {
    description = "A set of Python bindings to the libgit2 shared library";
    homepage = https://pypi.python.org/pypi/pygit2;
    license = licenses.gpl2;
  };
}
