
class profile::docker::swarm (
  String $swarm_name,
  Optional[Hash] $nodes = {}
)
{
   $nodes.each | $node, $role | {
     $label = regsubst($worker, '\.', '-')
     @@profile::docker::swarm::worker { "${swarm_name}-${label}":
       manager_ip => $facts['networking']['ip'],
       token      => 'this token'
       tag        => $worker
     }
  }
}
