# == Define: functions::renice
#
# This define changes the nice level of a running process of a given name.
#
# Example:
#
#   renice { "rsyslog":
#     renice_level => '-20'
#   }
#
# == Parameters
#
# [*name*]
#   The service that you wish to modify. This should be the name of the running
#   process as returned by 'ps'
#
# [*priority*]
#   The *adjustment* that you would like to make to the nice level. This uses
#   'renice' so all of the standard renice caveats apply.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::renice(
  $priority
) {

  exec { "auto_renice_$name":
    command =>
      "/usr/bin/renice $priority `/bin/ps --no-headers -C $name -o pid`",
    onlyif  => "/bin/ps -C $name"
  }
}
