
class role::docker::swarm::manager {
  include profile::config_files
  include profile::docker::host
  include profile::docker::containers
  #  working include profile::docker::swarm::manager
  include profile::docker::swarm
}
