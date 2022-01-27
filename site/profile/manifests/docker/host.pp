
class profile::docker::host(
  Optional[String]  $version = 'latest',
  Optional[Boolean] $use_upstream_package_source = true,
  Optional[String]  $registry = undef,
  Optional[String]  $email = undef,
  Optional[String]  $username = undef,
  Optional[String]  $password = undef,
) {

  class { 'docker': 
     version => $version,
     use_upstream_package_source => $use_upstream_package_source,
  }

  if $registry {
    docker::registry { "registry":
      server   => $registry,
      email    => $email,
      username => $username,
      password => $password,
    }
  }

  Profile::Docker::Swarm::Worker <<| tag == $facts['networking']['ip'] |>>
}
