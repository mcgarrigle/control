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
  $managers = $nodes.filter |$k,$v| { $v == 'manager' }.keys
  $workers  = $nodes.filter |$k,$v| { $v == 'worker'  }.keys

  $primary     = $managers[0]
  $secondaries = $managers[1,-1]

  $node_ip = $facts['networking']['ip']

  if $node_ip == $primary { 

    # swarm init the primary

    docker::swarm {'manager-primary':
      init           => true,
      advertise_addr => $manager_ip,
    }

    # join secondaries

    $secondaries.each |$manager| {
      $label = regsubst($manager, '\.', '-', 'G')
      @@docker::swarm { "manager-${label}":
        join       => true,
        manager_ip => $primary,
        token      => $facts['docker_manager_join_token'],
        tag        => $manager,
      }
    }

    # join workers

    $workers.each |$worker| {
      $label = regsubst($worker, '\.', '-', 'G')
      @@docker::swarm { "worker-${label}":
        join       => true,
        manager_ip => $primary,
        token      => $facts['docker_worker_join_token'],
        tag        => $worker,
      }
    }
  }

  # if there are swarm joins then collect them here

  Docker::Swarm <<| tag == $node_ip |>>
}
