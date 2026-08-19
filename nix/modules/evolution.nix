{pkgs, ...}:

{
  ## install `evolutionWithPlugins` so that `evolution` is well integrated
  ## with Evolution's subprocesses.
  home.packages = with pkgs; [
    evolutionWithPlugins
  ];

  ## the following user services override the same services 
  ## eventually installed by the OS system/image, making sure
  ## everything is under the management of NIX
  systemd.user.services.evolution-source-registry = {
    Unit = {
      Description = "Evolution source registry";
    };

    Service = {
      Type = "dbus";
      BusName = "org.gnome.evolution.dataserver.Sources5";
      ExecStart = "${pkgs.evolution-data-server}/libexec/evolution-source-registry";
    };
  };

  systemd.user.services.evolution-calendar-factory = {
    Unit = {
      Description = "Evolution calendar service";
    };

    Service = {
      Type = "dbus";
      BusName = "org.gnome.evolution.dataserver.Calendar8";
      ExecStart = "${pkgs.evolution-data-server}/libexec/evolution-calendar-factory";
    };
  };

  systemd.user.services.evolution-addressbook-factory = {
    Unit = {
      Description = "Evolution address book service";
    };

    Service = {
      Type = "dbus";
      BusName = "org.gnome.evolution.dataserver.AddressBook10";
      ExecStart = "${pkgs.evolution-data-server}/libexec/evolution-addressbook-factory";
    };
  };

  systemd.user.services.evolution-user-prompter = {
    Unit = {
      Description = "Evolution user prompter";
    };

    Service = {
      Type = "dbus";
      BusName = "org.gnome.evolution.dataserver.UserPrompter0";
      ExecStart = "${pkgs.evolution-data-server}/libexec/evolution-user-prompter";
    };
  };
}
