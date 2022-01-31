# profile::docker::swarm
#
# Turn an existing set of docker hosts into a swarm.
# 
# @Heira example:
#
# profile::docker::swarm::nodes:
#   192.168.2.31: manager        # first manager is primary
#   192.168.2.32: manager
#   192.168.2.33: worker

class profile::docker::swarm (
  Hash[String,String] $nodes = {}
)
{
  $managers  = $nodes.filter |$k,$v| { $v == 'manager' }.keys
  $workers   = $nodes.filter |$k,$v| { $v == 'worker' }.keys

  $primary     = $managers[0]
  $secondaries = $managers[1,-1]

  $node_ip = $facts['networking']['ip']

  if $node_ip == $primary { 

    class { 'profile::docker::swarm::manager':
      manager_ip => $primary
    }

    $managers.each |$manager| {
      $label = regsubst($manager, '\.', '-', 'G')
      @@profile::docker::swarm::node { "manager-${label}":
        manager_ip => $primary,
        token      => $facts['docker_manager_join_token'],
        tag        => $manager,
      }
    }

    $workers.each |$worker| {
      $label = regsubst($worker, '\.', '-', 'G')
      @@profile::docker::swarm::node { "worker-${label}":
        manager_ip => $primary,
        token      => $facts['docker_worker_join_token'],
        tag        => $worker,
      }
    }
  }

  Profile::Docker::Swarm::Node <<| tag == $node_ip |>>
}
