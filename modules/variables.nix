{ config, ... }:
{
  options.variables = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
  config._module.args.variables = options.variables;
}
