{ ... }:

{

  services.pipewire.enable = true;

  services.pipewire.configs = {
    "99-disable-x11-bell" = {
      "context.properties" = {
        "module.x11.bell" = false;
      };
    };
  };
}
