{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
                                                                                                                                                                                                                                                              
  boot.loader.systemd-boot.enable = true;                                                                                                                                                                                                                     
  boot.loader.efi.canTouchEfiVariables = true;                                                                                                                                                                                                                
                                                                                                                                                                                                                                                              
  networking.hostName = "ruslan-ideapad";                                                                                                                                                                                                                     
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.                                                                                                                                                                        
                                                                                                                                                                                                                                                              
  networking.networkmanager.enable = true;                                                                                                                                                                                                                    
  programs.nm-applet.enable = true;                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                              
  time.timeZone = "Europe/Kyiv";                                                                                                                                                                                                                              
  i18n.defaultLocale = "en_US.UTF-8";                                                                                                                                                                                                                         
  i18n.extraLocaleSettings = {                                                                                                                                                                                                                                
    LC_ADDRESS = "uk_UA.UTF-8";                                                                                                                                                                                                                               
    LC_IDENTIFICATION = "uk_UA.UTF-8";                                                                                                                                                                                                                        
    LC_MEASUREMENT = "uk_UA.UTF-8";                                                                                                                                                                                                                           
    LC_MONETARY = "uk_UA.UTF-8";                                                                                                                                                                                                                              
    LC_NAME = "uk_UA.UTF-8";                                                                                                                                                                                                                                  
    LC_NUMERIC = "uk_UA.UTF-8";                                                                                                                                                                                                                               
    LC_PAPER = "uk_UA.UTF-8";                                                                                                                                                                                                                                 
    LC_TELEPHONE = "uk_UA.UTF-8";                                                                                                                                                                                                                             
    LC_TIME = "uk_UA.UTF-8";                                                                                                                                                                                                                                  
  };                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                              
  services.xserver.enable = true;                                                                                                                                                                                                                             
  services.xserver.displayManager.lightdm.enable = true;                                                                                                                                                                                                      
  services.xserver.desktopManager.mate.enable = true;                                                                                                                                                                                                         
  services.xserver.libinput.enable = true;                                                                                                                                                                                                                    
  services.xserver.xkb = {                                                                                                                                                                                                                                    
    layout = "us";                                                                                                                                                                                                                                            
    variant = "";                                                                                                                                                                                                                                             
  };                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                              
  hardware.pulseaudio.enable = false;                                                                                                                                                                                                                         
  security.rtkit.enable = true;                                                                                                                                                                                                                               
  services.pipewire = {                                                                                                                                                                                                                                       
    enable = true;                                                                                                                                                                                                                                            
    alsa.enable = true;                                                                                                                                                                                                                                       
    alsa.support32Bit = true;                                                                                                                                                                                                                                 
    pulse.enable = true;                                                                                                                                                                                                                                      
    # If you want to use JACK applications, uncomment this                                                                                                                                                                                                    
    #jack.enable = true;                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                              
    # use the example session manager (no others are packaged yet so this is enabled by default,                                                                                                                                                              
    # no need to redefine it in your config for now)                                                                                                                                                                                                          
    #media-session.enable = true;                                                                                                                                                                                                                             
  };                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                              
  users.users.ruslan = {                                                                                                                                                                                                                                      
    isNormalUser = true;                                                                                                                                                                                                                                      
    description = "Ruslan Popov";                                                                                                                                                                                                                             
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      thunderbird
      vscode
# TODO: Override    
  (vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
    ];
  })
      telegram-desktop
      nextcloud-client
      skypeforlinux
      tmuxPlugins.power-theme
      jetbrains.idea-ultimate
      docker-compose
      jabref
      # ESP-IDF
      gpt4all
      logseq
      thunderbird
      discord
      i3
      rustup
      nodejs_22
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    openssl
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
      OLLAMA_MODELS = "/run/media/ruslan/d2bb3ec7-a6e3-493f-aeaa-2775d4a4df58/gguf_models";
    };
  };

  virtualisation.docker.enable = true;

  programs.firefox.enable = true;

  # TODO: Now I don't understand. There are 3 namespaces: user.packages, environment.systemPackages, and programs...
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    emacs-gtk # TODO: Not sure if it should be there. Added because of the service.
    git
    keepassxc
    btop
    neofetch
    texliveFull # I am very generous.
    pandoc
    gparted
    lshw
    gh
    gcc
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.en_US
    flameshot
    ark
    qbittorrent
  ];

  services.gnome.gnome-keyring.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true; 
        enableOffloadCmd = true;
      };

      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
