
class role::docker_host {
  include profile::docker::host
  include profile::docker::containers
}
