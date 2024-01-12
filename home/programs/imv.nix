{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # default binds https://man.archlinux.org/man/imv.1.en#DEFAULT_BINDS
    imv
  ];

  home.file."/home/${config.home.username}/.config/imv/config".text = ''
    # Default config for imv

    [options]

    # Suppress built-in key bindings, and specify them explicitly in this
    # config file.
    suppress_default_binds = true

    [aliases]
    # Define aliases here. Any arguments passed to an alias are appended to the
    # command.
    # alias = command to run

    [binds]
    # Define some key bindings
    q = quit
    y = exec echo working!

    # Image navigation
    <Left> = prev
    <bracketleft> = prev
    <Right> = next
    <bracketright> = next
    gg = goto 1
    <Shift+G> = goto -1

    # Panning
    j = pan 0 -50
    k = pan 0 50
    h = pan 50 0
    l = pan -50 0

    # Zooming
    <Up> = zoom 1
    <Shift+plus> = zoom 1
    i = zoom 1
    <Down> = zoom -1
    <minus> = zoom -1
    o = zoom -1

    # Rotate Clockwise by 90 degrees
    r = rotate by 90

    # Other commands
    x = close
    f = fullscreen
    d = overlay
    p = exec echo $imv_current_file
    c = center
    s = scaling next
    <Shift+S> = upscaling next
    a = zoom actual
    <Shift+R> = reset

    # Gif playback
    <period> = next_frame
    <space> = toggle_playing

    # Slideshow control
    t = slideshow +1
    <Shift+T> = slideshow -1
  '';
}
