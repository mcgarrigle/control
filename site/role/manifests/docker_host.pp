
class role::docker_host {
  include profile::config_files
  include profile::docker::host
  include profile::docker::containers
}
