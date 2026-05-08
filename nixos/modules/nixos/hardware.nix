{ ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.extraConfig."51-razer-softvol" = {
      "monitor.alsa.rules" = [{
        matches = [{ "device.name" = "alsa_card.usb-Razer_Razer_Leviathan_V2_X_000000000000000-01"; }];
        actions.update-props = {
          "api.alsa.soft-mixer" = true;
          "api.alsa.ignore-dB" = true;
        };
      }];
    };

    wireplumber.extraConfig."52-razer-default-sink" = {
      "wireplumber.settings"."default-audio-sink" =
        "alsa_output.usb-Razer_Razer_Leviathan_V2_X_000000000000000-01.analog-stereo";
    };
  };

  hardware.graphics.enable = true;
}
