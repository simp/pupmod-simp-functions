# == Define: functions::init_mod_nice
#
# This define changes the nice level of a script in an init script
# on Red Hat-like systems.
#
# == Parameters
#
# [*name*]
#   The service that you wish to modify.  This should be the name of the file
#   in /etc/init.d
#
# [*nice_level*]
#   The nice level that you wish for this application.
#   Any number greater than 19 will be treated as 19 and any number less than
#   -20 will be treated as -20
#
# == Examples
#
#   init_mod_nice { 'rsyslog':
#     nice_level => '-20'
#   }
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::init_mod_nice (
  $nice_level
) {

  init_ulimit { "mod_nice_$name":
    target => $name,
    item   => 'max_nice',
    value  => $nice_level
  }

  validate_integer($nice_level)
}
