final: prev: {

  zsh-z = prev.zsh-z.overrideAttrs (attrs: rec {
    pname = "zsh-z";
    version = "unstable-2023-01-27";
    src = prev.fetchFromGitHub {
      owner = "agkozak";
      repo = pname;
      rev = "c28d8f5f16424c7855a627f50ff986de952d8d2d";
      sha256 = "sha256-O8wP6XUR3OgMLgloiM/C8c3k/v85+U+QwtxjR6ePFBk=";
    };
  });
  landscapeWallpaper = builtins.fetchurl {
    url = "https://images8.alphacoders.com/133/1336966.jpeg";
    sha256 = "99ba832936425307f1827793bd4a4e9055b0761c6b6c88871fdb575de884b109";
  };
  avatarPicture = builtins.readFile ".avatar.jpg";
}
