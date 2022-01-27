
define profile::docker::swarm::worker(
  String $manager_ip,
  String $token,
)
{
  notify { "${manager_ip} ${token}": }
}
