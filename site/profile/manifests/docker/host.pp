
class profile::docker::host(
  Optional[String]  $version = 'latest',
  Optional[Boolean] $use_upstream_package_source = true
) {

  class { 'docker': 
     version => $version,
     use_upstream_package_source => $use_upstream_package_source,
  }
}
