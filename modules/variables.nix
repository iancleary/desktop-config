# { config, lib, options, ... }:
# {
#   options.variables = lib.mkOption {
#     type = lib.types.attrs;
#     default = { };
#   };
#   config._module.args.variables = options.variables;
# }

{ lib, ... }: {
  options.variables = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
}
