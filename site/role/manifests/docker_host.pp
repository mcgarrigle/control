
class role::docker_host {
  include profile::docker::host
  include profile::docker::containers
  include profile::docker::swarm
  include profile::config_files
}
