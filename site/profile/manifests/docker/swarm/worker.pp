
define profile::docker::swarm::worker(
  String $manager_ip,
  String $token,
)
{
  $worker_ip = $facts['networking']['ip']
  notify { "swarm worker ${worker_ip} ${manager_ip} ${token}": }
}
