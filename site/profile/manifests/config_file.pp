
# Defines a config file transforming the supplied Hash
# into a config file in either YAML or INI file
# format.

# @parameters:
#
# String $path: The name of the file to be created
# String $format: Either 'yaml' or 'inifile'
# String $owner: The owner of the file
# String $group: The group of the file
# String $mode: The file permissions  
# Hash   $content: A Hash contaiing the configuration

# --------------------------------------------

define profile::config_file(
  String $path   = $name,
  String $format = 'yaml',
  String $owner  = 'nobody',
  String $group  = $owner,
  String $mode   = '0644',
  Hash   $content,
){
   case $format {
     'yaml':    { $text = to_yaml($content) }
     'inifile': { $text = hash2ini($content) }
     'properties': { $text = hash2properties($content) }
     default:   { fail("format ${format} not known") }
   }

   file { $path:
     content => $text,
     owner   => $owner,
     group   => $group,
     mode    => $mode,
   }
}
