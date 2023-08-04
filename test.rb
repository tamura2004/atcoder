require "yaml"
require "erb"

yaml = YAML.load_file("tool/config.yaml")
pp yaml
