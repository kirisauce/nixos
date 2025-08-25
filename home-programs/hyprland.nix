{ pkgs, lib, config, ... }:

{
  options.myConfig.hyprland = with lib; {
    enable = mkEnableOption "Custom hyprland options";

    monitors = mkOption {
      description = "Monitors for hyprland to use";
      default = null;
      example = {
        output = "DP-0";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1.0;
        transform = 0;
      };
    };

    waybarIntegration = mkEnableOption "waybar integration";
    nvidiaCompatible = mkEnableOption "nvidia-comptaible config";
    inputMethod = {
      enable = mkEnableOption "input method environment vaiables";
      name = mkOption {
        description = "Input method module name";
        default = "fcitx";
        example = "fcitx";
        type = types.str;
      };
    };

    extraExecOnce = mkOption {
      description = "Extra exec-once option";
      default = [];
      type = types.listOf types.str;
      example = [ ''echo "Xft.dpi: 120" | xrdb -merge'' ];
    };

    extraWindowRules = mkOption {
      description = "Extra window rules for hyprland";
      default = [];
      type = types.listOf types.str;
        example = [ "float, titile:^XUN$" ];
    };

    hyprshot.enable = mkEnableOption "hyprshot integration";
    hyprlock.enable = mkEnableOption "hyprlock integration";

    audio.enable = mkOption {
      description = "Whether to enable audio integration";
      default = true;
      example = false;
      type = types.bool;
    };
    audio.volumePercentStep = mkOption {
      description = "Volume raise/lower step in percentage (%)";
      default = 2;
      example = 5;
      type = types.int;
    };

    brightness.enable = mkOption {
      description = "Whether to enable brightness integration using brightnessctl";
      default = true;
      example = false;
      type = types.bool;
    };
    brightness.percentStep = mkOption {
      description = "Brightness raise/lower step in percentage (%)";
      default = 2;
      example = 5;
      type = types.int;
    };

    uwsmWrapper.enable = mkEnableOption "wrap exec-onces with UWSM";
  };

  config = with config.myConfig.hyprland; lib.mkIf enable {
    home.packages = with pkgs;
      [
        kitty
        mako
        fuzzel
        nautilus
        xorg.xrdb
        mpv
        xdg-user-dirs
      ]
      ++ lib.optional config.myConfig.hyprland.hyprshot.enable hyprshot
      ++ lib.optionals config.myConfig.hyprland.audio.enable [ wireplumber playerctl pavucontrol ]
      ++ lib.optional config.myConfig.hyprland.brightness.enable brightnessctl
    ;

    programs.hyprlock.enable = lib.mkDefault config.myConfig.hyprland.hyprlock.enable;

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.enable = false;

      # Use package installed in the system level
      package = null;
      portalPackage = null;
    };

    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
      hyprbars # Window title bar
    ];

    wayland.windowManager.hyprland.settings = {
      # Modified from https://github.com/Isoheptane/dotfiles/blob/blog-example/hyprland/hyprland.conf
      "$mod" = "SUPER";

      # See https://wiki.hypr.land/Configuring/Variables/ for more
      monitorv2 = monitors;

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 2;

        touchpad.natural_scroll = true;

        sensitivity = 0.1;
        accel_profile = "adaptive";
      };

      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        #col.active_border = "rgba(cceeffbb)";
        #col.inactive_border = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 12;
        rounding_power = 3.5;

        blur = {
          enabled = true;
          size = 4;
          passes = 1;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 3;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      # Default animations.
      # See https://wiki.hypr.land/Configuring/Animations/ for more
      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 8, myBezier, slide 45%"
          # "windowsMove, 1, 7, myBezier"
          # "windowsIn, 1, 3, default, popin 90%"
          # "windowsOut, 1, 3, default, popin 90%"
          "border, 1, 5, default"
          "fade, 1, 10, default"
          "workspaces, 1, 5, default"
        ];
      };

      # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      exec-once = let
        l = [
          "mako"
        ]
        ++ (lib.optionals waybarIntegration [ "waybar" ])
        ++ (lib.optionals config.myConfig.hyprpaper.enable [ "hyprpaper" ])
        ++ (lib.optionals inputMethod.enable [ "fcitx5" ])
        ++ extraExecOnce;
      in
        if uwsmWrapper.enable then builtins.map (i: "uwsm app -- ${i}") l else l
      ;

      # See https://wiki.hypr.land/Configuring/Binds/ for more
      bind =
        [
          # General
          "$mod, C, killactive"
          "$mod, T, exec, kitty"
          "$mod, E, exec, nautilus"
          "$mod, V, togglefloating"
          "$mod, F, fullscreen"
          # "$mod, R, exec, tofi-drun | xargs hyprctl dispatch exec --"
          "$mod, R, exec, fuzzel"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"

          # Move focus with $mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Scroll through existing workspaces with $mod + scroll
          "$mod, mouse_down, workspace, e-1"
          "$mod, mouse_up, workspace, e+1"

          # OBS Studio Record Start/Stop
          "$mod, F10, pass, class:^com\\.obsproject\\.Studio$"

          # Lock and sleep
          "$mod, esc, exit"
          "$mod, M, exec, hyprlock"
          "$mod SHIFT, M, exec, hyprlock & sleep 1 && systemctl suspend"
          "$mod CTRL, M, exec, hyprlock & sleep 1 && systemctl hibernate"
        ]
        ++
        # Workspace movement
        (builtins.concatLists (builtins.genList
          (n:
            let
              nWorkspace = if n == 0 then 10 else n;
            in
              [
                "$mod, ${toString n}, workspace, ${toString nWorkspace}"
                "$mod SHIFT, ${toString n}, movetoworkspace, ${toString nWorkspace}"
              ]
          )
          9
        ))
        ++
        lib.optionals hyprshot.enable (let args = "-z -o \"`xdg-user-dir PICTURES`\""; in [
          "$mod SHIFT, S, exec, hyprshot -m output ${args}"
          "$mod CTRL, S, exec, hyprshot -m window ${args}"
          "$mod ALT, S, exec, hyprshot -m region ${args}"
        ])
        ++
        lib.optionals audio.enable [
          ", XF86AudioPrev, exec, playerctl previous"
          "SHIFT, XF86AudioPrev, exec, playerctl position -5"
          ", XF86AudioNext, exec, playerctl next"
          "SHIFT, XF86AudioNext, exec, playerctl position +5"
          ", XF86AudioMute, exec, wpctl set-mute '@DEFAULT_AUDIO_SINK@' toggle"
        ]
      ;

      bindm = [
        # Move/resize windows with $mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindle = lib.optionals audio.enable [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 '@DEFAULT_AUDIO_SINK@' '${toString audio.volumePercentStep}%+'"
          ", XF86AudioLowerVolume, exec, wpctl set-volume '@DEFAULT_AUDIO_SINK@' '${toString audio.volumePercentStep}%-'"
        ]
        ++
        lib.optionals brightness.enable [
          ", XF86MonBrightnessUp, exec, brightnessctl set '+${toString brightness.percentStep}%'"
          ", XF86MonBrightnessDown, exec, brightnessctl set '${toString brightness.percentStep}%-'"
        ]
      ;

      env =
        (lib.optionals inputMethod.enable
          (let imName = inputMethod.name; in [
            "XIM,${imName}"
            "XIM_PROGRAM,${imName}"
            "INPUT_METHOD,${imName}"
            "GTK_IM_MODULE,${imName}"
            "QT_IM_MODULE,${imName}"
            "XMODIFIERS,@im=${imName}"
          ])
        )
        ++
        (lib.optionals nvidiaCompatible [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ])
      ;

      windowrule =
        [
          # QQ图片查看器
          "float, title:^图片查看器$"

          "opacity 0.91 0.84 0.93, title:^QQ$, class:^QQ$"

          # 微信
          "float, title:^预览$, class:^wechat$"
          "opacity 0.91 0.84 0.93, title:^微信$, class:^wechat$"

          # Telegram Desktop Media Viewer
          "fullscreen, title:^Media viewer$, class:^org.telegram.desktop$"

          # Visual Studio Code
          "opacity 0.92 0.86 1.0, class:^(Code|code)$, initialTitle:^Visual Studio Code$"

          # Godot Engine
          "float, title:^[a-zA-Z-_]+ \\(DEBUG\\)$, initialClass:^Godot$"
          "float, title:^[a-zA-Z-_]+ \\(DEBUG\\)$, initialTitle:^Godot$"
          "opacity 0.91 0.84 0.93, title:^.* - Godot Engine$, class:^Godot$"
        ]
        ++
        extraWindowRules
      ;
    };

    #programs.tofi = {
    #  enable = true;
    #  settings = {};
    #};

    home.file."/.config/fuzzel" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink ../config/fuzzel;
      recursive = true;
    };
  };
}
