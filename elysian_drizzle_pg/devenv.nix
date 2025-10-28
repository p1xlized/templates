{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  env.GREET = "devenv";
  packages = [ pkgs.bun ];

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_15;
    initialDatabases = [ { name = "weapons"; } ];
    initialScript = "CREATE EXTENSION IF NOT EXISTS timescaledb;";
  };

}
