
class profile::docker::swarm::manager(
  String $swarm_name,
  Optional[Array[String]] $workers = []
)
{
   $workers.each | $worker | {
     $label = regsubst($worker, '\.', '-')
     @@profile::docker::swarm::worker { "${swarm_name}-${label}":
       manager_ip => $facts['networking']['ip'],
       token      => 'this token'
       tag        => $worker
     }
  }
}
