{ lib
, buildPythonPackage
, fetchFromGitHub
, bson
, pytestCheckHook
, pyyaml
, setuptools
}:

buildPythonPackage rec {
  pname = "pymarshal";
  version = "2.2.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "stargateaudio";
    repo = pname;
    rev = version;
    hash = "sha256-Ds8JV2mtLRcKXBvPs84Hdj3MxxqpeV5muKCSlAFCj1A=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "'pytest-runner'" ""
    substituteInPlace setup.cfg \
      --replace "--cov=pymarshal --cov-report=html --cov-report=term" ""
  '';

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    bson
  ];

  nativeCheckInputs = [
    pytestCheckHook
    bson
    pyyaml
  ];

  pytestFlagsArray = [ "test" ];

  meta = {
    description = "Python data serialization library";
    homepage = "https://github.com/stargateaudio/pymarshal";
    maintainers = with lib.maintainers; [ yuu ];
    license = lib.licenses.bsd2;
  };
}
