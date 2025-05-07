{
  programs.wofi = {
    enable = true;
    settings = {
      width = "60%";
      height = "40%";
      prompt = "";
      allow_images = true;
      allow_markup = true;
      exec_search = true;
      hide_scroll = true;
      insensitive = true;
      location = "center";
      columns = 3;
      gtk_dark = true;
      orientation = "vertical";
      image_size = 32;
      layer = "top";
    };
    style = ''
      * {
        all: initial;
        font-family: Dosis;
        font-size: 1rem;
        background-color: transparent;
      }

      #window {
        border-radius: 12px;
      }

      #input {
        border-radius: 12px;
        padding: 0.75em;
        margin-bottom: 1.5em;
      }

      #outer-box {
        padding: 1.5em;
      }

      #text {
        margin: 0.25em;
      }

      #img {
        background-color: transparent;
        margin: 0.5em;
      }

      #entry {
        border-radius: 12px;
        background-color: transparent;
      }

      #entry:selected {
        font-weight: bold;
      }
    '';
  };
}
