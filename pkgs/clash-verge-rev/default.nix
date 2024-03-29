{ lib
, stdenv
, fetchurl
, dpkg
, wrapGAppsHook
, autoPatchelfHook
, clash-meta
, openssl
, webkitgtk
, udev
, libayatana-appindicator
}:

stdenv.mkDerivation rec {
  pname = "clash-verge-rev";
  version = "1.5.1";

  src = fetchurl {
    url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${version}/clash-verge_${version}_amd64.deb";
    hash = "sha256-6tYMbVTmKa1Vk113qmdvtgJIGbCpzuQiCW/V9n/nMXU=";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    openssl
    webkitgtk
    stdenv.cc.cc
  ];

  runtimeDependencies = [
    (lib.getLib udev)
    libayatana-appindicator
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv usr/* $out
    # rm $out/bin/{clash,clash-meta}

    runHook postInstall
  '';

  # postFixup = ''
  #   ln -s ${lib.getExe clash-meta} $out/bin/clash-meta
  # '';

  meta = with lib; {
    description = "Continuation of Clash Verge - A Clash Meta GUI based on Tauri";
    homepage = "https://github.com/clash-verge-rev/clash-verge-rev";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ zendo ];
    mainProgram = "clash-verge";
  };
}