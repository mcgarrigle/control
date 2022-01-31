
define profile::docker::swarm::node(
  String $manager_ip,
  String $token,
)
{
  # $worker_ip = $facts['networking']['ip']
  # notify { "swarm node ${title} ${worker_ip} ${manager_ip} ${token}": }

  docker::swarm { $title:
    join       => true,
    manager_ip => $manager_ip,
    token      => $token
  }
}
