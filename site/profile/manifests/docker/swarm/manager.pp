
class profile::docker::swarm::manager(
  String $manager_ip
)
{
   # $manager_ip = $facts['networking']['ip']
   notify { "swarm manager ${manager_ip}": }
#   $workers.each | $worker | {
#     $label = regsubst($worker, '\.', '-')
#     notify { "exporting ${worker}": }
#     @@profile::docker::swarm::worker { "swarm-${label}":
#       manager_ip => $manager_ip,
#       token      => '<this token>',
#       tag        => $worker
#     }
#  }
}
