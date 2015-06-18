# == Define: functions::init_mod_open_files
#
# This define changes the ulimit in an init script on Red Hat-like systems.
#
# == Parameters
#
# [*name*]
#   The service that you wish to modify.  This should be the name of the file
#   in /etc/init.d
#
# [*max_open_files*]
#   The maximum number of open files that this application should be allowed to
#   have. Defaults to 1024.
#
# == Examples
#
#   init_mod_open_files { 'rsyslog':
#     max_open_files => '2048'
#   }
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::init_mod_open_files (
  $max_open_files = '1024'
) {

  init_ulimit { "mod_open_files_$name":
    target => $name,
    item   => 'max_open_files',
    value  => $max_open_files
  }

  validate_integer($max_open_files)
}
