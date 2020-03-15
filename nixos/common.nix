{ config, pkgs, ... }:

# Everything that is identical between my laptop and desktop is here.
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.interfaces.wwp0s29u1u6i6.useDHCP = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fi";
    defaultLocale = "en_US.UTF-8";
  };
  time.timeZone = "Europe/Helsinki";

  environment.systemPackages = with pkgs; [
    # not much needed here, home-manager gets most stuff on a per-user basis
    curl git
  ];
  programs.vim.defaultEditor = true;
  programs.fish.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    liberation_ttf
    fira-code
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.awesome.enable = true;
    windowManager.default = "awesome";
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    extraLayouts.fi-molemak = {
      description = "Finnish colemak with some modifier customization";
      languages = ["fi"];
      symbolsFile = /home/mole/dotfiles/molemak/symbols;
      #keycodesFile = /home/mole/dotfiles/molemak/keycodes;
      #geometryFile = /home/mole/dotfiles/molemak/geometry;
      #typesFile = /home/mole/dotfiles/molemak/types;
      #compatFile = /home/mole/dotfiles/molemak/compat;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mole = {
    isNormalUser = true;
    home = "/home/mole";
    description = "mole";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
