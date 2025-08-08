{...}: {
  services.kmonad = {
    enable = true;
    keyboards = {
      myKMonadOutput = {
        device = "/dev/input/event0";
        config = builtins.readFile ../../../files/keyboard.kbd;
      };
    };
  };
}
