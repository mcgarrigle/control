
class role::docker_host {
  include profile::docker::host         # will join swarm if designated
  include profile::docker::containers
  include profile::config_files
}
