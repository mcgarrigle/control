
class profile::docker::swarm (
  Optional[Array[String]] $workers = []
)
{
#   if length($workers) > 0 {
#     $workers.each |$worker| {
#       notify { "worker ${worker}": }
#       $label = regsubst($worker, '\.', '-')
#       @@profile::docker::swarm::worker { "worker-${label}":
#         manager_ip => $facts['networking']['ip'],
#         token      => 'this token',
#         tag        => $worker
#       }
#    }
#  }
}
