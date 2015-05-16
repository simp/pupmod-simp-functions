# == Define: functions::delete_lines
#
# This function deletes lines from a file if they exist using
# POSIX regular expression matching.
#
# This function was collected from
# http://reductivelabs.com/trac/puppet/wiki/Recipes/SimpleText on
# August 4, 2008.
#
# Slight modifications may be present.
#
# Example:
#
#   delete_lines { 'delete_me':
#     file => '/tmp/tobeadded',
#     pattern => "[[:space:]]\+To be removed.*",
#   }
#
# == Parameters
#
# [*file*]
#   The file to edit.
#
# [*pattern*]
#   The POSIX regular expression to match.
#
# [*refreshonly*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::delete_lines(
  $file,
  $pattern,
  $refreshonly = false
) {

  exec { "/bin/sed -i -r -e '/$pattern/d' $file":
    onlyif      => "/bin/grep -E '$pattern' '$file'",
    refreshonly => $refreshonly
  }

  validate_string($file)
  validate_string($pattern)
  validate_bool($refreshonly)

}
