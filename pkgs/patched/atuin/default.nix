{ atuin }:
atuin.overrideAttrs (_: {
  # less bloat.. but rust is bloat! the compile times are horrendous
  buildFeatures = [ "client" ];
})
