{ ... }:
{

  services.znapzend = {
    enable = true;
    autoCreation = true;
    pure = true;
    features.sendRaw = true;
    zetup = {
      # to create: sudo zfs send -w rpool/HOME@...  | sudo zfs receive -F backup/HOME
      "rpool/safe/home" = {
        plan = "4hour=>15min,2day=>1hour,7day=>1day,3week=>1week";
        enable = true;
        destinations = {
          local = {
            presend = "zpool import -Nf backup";
            postsend = "zpool export backup";
            dataset = "backup/safe/home";
            plan = "4day=>1hour,1week=>1day,1year=>1week,10year=>1month";
          };
        };
      };
    };
  };
}
