
# see: https://forge.puppet.com/modules/puppetlabs/docker
#  and https://github.com/puppetlabs/puppetlabs-docker/blob/main/REFERENCE.md#dockerrun
#
# Example:
# ---
# profile::docker::containers:
#   webserver:
#     image: httpd
#     restart_service: true
#     pull_on_start: true

class profile::docker::containers (
  Optional[Hash] $containers = lookup('profile::docker::containers', undef, undef, {})
) {

  $defaults = {}
  create_resources(docker::run, $containers, $defaults)
  
}
