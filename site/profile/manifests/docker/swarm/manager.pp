
class profile::docker::swarm::manager(
  String $manager_ip
)
{
  docker::swarm {'swarm_primary':
    init           => true,
    advertise_addr => $manager_ip,
  }
}
