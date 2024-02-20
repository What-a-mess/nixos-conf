{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "rime-ice";
  version = "2024_02_18T13_06_31Z-2";
  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "6d438fb8f4de5e54e0fb2e1daf0635d729277493";
    hash = "sha256-bKwzulM6Xl3+Xr0Nk9jNKXKfbDJyPr8u90jHceCVwo8=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    cp -r * $out/share/rime-data/
  '';

  meta = with lib; {
    description = "Rime 配置：雾凇拼音 | 长期维护的简体词库 ";
    homepage = "https://dvel.me/posts/rime-ice/";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}