
# see: profile::config_file
#
# @Example hiera
#
#   "/etc/foo.conf":
#    content:
#      a: 1
#      b: 2
#      c: 3
#  "/etc/bar.conf":
#    format: inifile
#    content:
#      header1:
#        a: 1
#        b: 2
#      header2:
#        c: 3
#        d: 4

class profile::config_files(
  Optional[Hash] $files = lookup('profile::config_files', undef, undef, {})
){
  $defaults = {}
  create_resources(profile::config_file, $files, $defaults)
}
