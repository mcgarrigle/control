
class role::docker::swarm::manager {
  include profile::config_files
  include profile::docker::host
  include profile::docker::containers
  include profile::docker::swarm::manager
}
