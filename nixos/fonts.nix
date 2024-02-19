{ inputs, pkgs, ... }:

{
  fonts ={
    fontDir.enable = true;
    package = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      sarasa-gothic
      liberation_ttf
      fira-code
      fira-code-symbols
      source-code-pro
      dina-font
      proggyfonts
    ];

    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono CJK SC"
          "Sarasa Mono SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
    };
  }
}