{ ... }:

{
  services.gammastep = {
    enable          = true;
    provider        = "manual";
    latitude        = 52.2226;
    longitude       = 4.5322;
    temperature     = { day = 6000; night = 4200; };
    settings        = {
      general = {
          brightness-day = "1.0";
          brightness-night = "0.8";
      };
    };
    tray            = true;
  };   
}