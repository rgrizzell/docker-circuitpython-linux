variable "DEFAULT_TAG" {
  default = "rgrizzell/circuitpython:9.2.1"
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {
  tags = ["${DEFAULT_TAG}"]
}

// Default target if none specified
group "default" {
  targets = ["local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
}

target "local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "base" {
  inherits = ["image"]
  target = "base"
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}

target "runtime" {
  inherits = ["base"]
  target = "runtime"
}
