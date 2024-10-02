{config, services, pkgs, inputs, lib, ...}:

{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  services.flatpak = {
    remotes = lib.mkOptionDefault [{
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];

    packages = [
      "com.github.IsmaelMartinez.teams_for_linux"
      "com.github.flxzt.rnote"
      "io.github.flattool.Warehouse"
      "io.gitlab.idevecore.Pomodoro"
      "com.github.johnfactotum.Foliate"
      "org.kde.arianna"
      "io.gitlab.news_flash.NewsFlash"
      "org.feichtmeier.Musicpod"
      "com.modrinth.ModrinthApp"
      "org.gnome.Boxes"
    ];
  };
}