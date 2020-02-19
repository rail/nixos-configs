{ ... }:
{
  services.znapzend = {
    enable = true;
    autoCreation = true;
    pure = true;
    zetup = {
      "rpool/HOME" = {
        plan = "15min=>5min,4hour=>15min,2day=>1hour,7day=>1day,3week=>1week";
        enable = true;
        destinations = {
          local = {
            dataset = "backup/HOME";
            plan = "1hour=>5min,4day=>1hour,1week=>1day,1year=>1week,10year=>1month";
          };
        };
      };
    };
  };
}
