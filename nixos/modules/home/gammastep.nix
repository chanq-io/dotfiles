{ ... }:

{
  # Blue-light filter. Manual location (London) avoids needing geoclue
  # permissions + network. Adjust lat/lon if shrike ever moves.
  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = "51.5074";
    longitude = "-0.1278";

    temperature = {
      day = 6500;
      night = 3500;
    };
  };
}
