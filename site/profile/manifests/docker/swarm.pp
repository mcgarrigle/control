
class profile::docker::swarm (
  Hash[String,String] $nodes = {}
)
{
  $primaries = $nodes.filter |$k,$v| { $v == 'primary' }
  $managers  = $nodes.filter |$k,$v| { $v == 'manager' }
  $workers   = $nodes.filter |$k,$v| { $v == 'worker' }

  if length($primaries) != 1 {
    fail("need exactly one primary")
  }

  $node_ip = $facts['networking']['ip']

  if $primaries[$node_ip] { 

    $primary_ip = $node_ip

    class { 'profile::docker::swarm::manager':
      manager_ip => $primary_ip
    }

    $managers.each |$manager, $void| {
      $label = regsubst($manager, '\.', '-', 'G')
      @@profile::docker::swarm::node { "manager-${label}":
        manager_ip => $primary_ip,
        token      => 'manager token',
        tag        => $manager,
      }
    }

    $workers.each |$worker, $void| {
      $label = regsubst($worker, '\.', '-', 'G')
      @@profile::docker::swarm::node { "worker-${label}":
        manager_ip => $primary_ip,
        token      => 'worker token',
        tag        => $worker,
      }
    }
  }

  Profile::Docker::Swarm::Node <<| tag == $node_ip |>>
}
