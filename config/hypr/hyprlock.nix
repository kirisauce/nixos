{
  backgroundImage,
  ...
}:

let
  font_family = "LXGW WenKai";
  monitor = "";
in
{
  label = let
    defaultOptions = {
      inherit font_family monitor;
      font_size = "26";
      color = "rgba(200, 200, 200, 0.9)";
    };
  in
  [
    (defaultOptions // {
      text = ''Hi there, <span foreground="##ccddffcc">$USER</span>'';

      position = "0, 80";
      halign = "center";
      valign = "center";
    })
    (defaultOptions // {
      text = "$TIME";

      font_family = "Maple Mono NF CN";
      font_size = 80;
      position = "0, 0";
      halign = "right";
      valign = "top";
    })
    (defaultOptions // {
      text = ''cmd[update:60000] echo $(date +"%Y/%m/%d")'';

      font_family = "Maple Mono NF CN";
      font_size = 35;
      position = "0, -160";
      halign = "right";
      valign = "top";
    })
  ];

  input-field = {
    inherit monitor;

    size = "20%, 5%";
    outline_thickness = 3;
    inner_color = "rgba(0, 0, 0, 0.0)";

    outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
    fail_color  = "rgba(ff6633ee) rgba(ff0066ee) 40deg";

    font_color = "rgb(143, 143, 143)";
    fade_on_empty = "false";
    rounding = 15;

    position = "0, -20";
    halign = "center";
    valign = "center";
  };

  background = {
    inherit monitor;

    path = if backgroundImage == null then "screenshot" else backgroundImage;
    blur_passes = 2;
    color = "rgba(138, 43, 80, 1.0)";
  };
}