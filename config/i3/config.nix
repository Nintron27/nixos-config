{
  modifier = "Mod4";
  bars = [ ]; # use polybar instead

  window = {
    border = 2;
  };

  gaps = {
    inner = 12;
    outer = 6;
    smartGaps = false;
    smartBorders = "on";
  };

  startup = [
    {
      command = "exec $HOME/.config/polybar/launch.sh";
      always = true;
      notification = false;
    }
  #  { command = "exec firefox"; }
  #  { command = "exec steam"; }
  #  { command = "exec Discord"; }
  #] ++ lib.optionals isDesktop [
  #  { command = "xrand --output HDMI-0 --right-of DP-4"; notification = false; }
  #] ++ [
  #  # allow polybar to resize itself
  #  { command = "systemctl --user restart polybar"; always = true; notification = false; }
  ];

  #assigns = {
  #  "2: web" = [{ class = "^Firefox$"; }];
  #  "4" = [{ class = "^Steam$"; }];
  #  "6" = [{ class = "HexChat$"; }];
  #  "7" = [{ class = "^Discord$"; }];
  #};

  # colors
  colors = {
    focused          = { childBorder = "#f5c2e7"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#f5e0dc"; border = "#f5c2e7"; };
    focusedInactive = { childBorder = "#cba6f7"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#f5e0dc"; border = "#cba6f7"; };
    unfocused        = { childBorder = "#cba6f7"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#f5e0dc"; border = "#cba6f7"; };
    urgent           = { childBorder = "#fab387"; background = "#1e1e2e"; text = "#fab387"; indicator = "#6c7086"; border = "#fab387"; };
    placeholder      = { childBorder = "#6c7086"; background = "#1e1e2e"; text = "#cdd6f4"; indicator = "#6c7086"; border = "#6c7086"; };
    background = "#1e1e2e";
  };

  keybindings = import ./keybindings.nix "Mod4";
}
