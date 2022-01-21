
# Defines a config file transforming the supplied hash
# into a config file in either YAML or INI file
# format

# @parameters:
#
# String $path: The name of the file to be created
# String $format: Either yaml or inifile
# String $owner: The owner of the file
# String $group:
# String $mode:

# --------------------------------------------

define profile::config_file(
  String $path = $name,
  String $format = 'yaml',
  String $owner = 'nobody',
  String $group = $owner,
  String $mode  = '0644',
  Hash   $content,
){

   if $format == 'yaml' {
     file { $path:
       content => to_yaml($content),
       owner   => $owner,
       group   => $group,
       mode    => $mode,
     }
   }

   if $format == 'inifile' {
     $defaults = { path => $path }
     inifile::create_ini_settings($content, $defaults)
   }
}
