# == Define: functions::line
#
# This function ensures that a line is either present or absent
# from a file.  The entire line must be specified.
#
# The function was collected from
# http://reductivelabs.com/trac/puppet/wiki/Recipes/SimpleText on
# August 4, 2008.
#
# Slight modifications may be present.
#
# Example:
#
#   line { 'add_me':
#     file => '/tmp/tobeadded',
#     line => 'A test line',
#     ensure => 'present',
#   }
#
# == Parameters
#
# [*file*]
#   The file to edit.
#
# [*line*]
#   The line to ensure is either present or absent.
#
# [*ensure*]
#   Set to present (default) to enact the line and 'absent' to redact it.
#
# [*refreshonly*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::line(
  $file,
  $line,
  $ensure = 'present',
  $refreshonly = false
) {

  case $ensure {
    default: {
      err ( "unknown ensure value ${ensure}" )
    }
    present: {
      exec { "/bin/echo '${line}' >> '${file}'":
        unless      => "/bin/grep -qFx '${line}' '${file}'",
        refreshonly => $refreshonly
      }
    }
    absent: {
      exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
        onlyif      => "/bin/grep -qFx '${line}' '${file}'",
        refreshonly => $refreshonly
      }
    }
  }

  validate_string($file)
  validate_string($line)
  validate_bool($refreshonly)
}
