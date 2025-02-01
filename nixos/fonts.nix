{ pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      sarasa-gothic
      liberation_ttf
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      source-code-pro
      dina-font
      proggyfonts
      wqy_zenhei
      wqy_microhei
    ];

    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Fira Code"
          "FiraCode Nerd Font"
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
  };
}