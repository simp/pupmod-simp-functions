# == Define: functions::apend_if_no_such_line
#
# This function appends lines to a file if they do not currently
# exist within the file using fixed word grep matches (no regexes).
#
# Uses the Puppet Labs stdlib modified function 'simp_file_line'.
#
# Example:
#
#  append_if_no_such_line { 'add_me':
#     file => '/tmp/tobeadded',
#     pattern => 'Add Me!'
#  }
#
# == Parameters
#
# [*file*]
#  The file to edit.
#
# [*line*]
#   The POSIX regular expression to match.
#
# [*refreshonly*]
#
# [*deconflict*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::append_if_no_such_line(
  $file,
  $line,
  $refreshonly = 'ignored',
  $deconflict = false
  ) {

  simp_file_line { $name:
    path       => $file,
    line       => $line,
    deconflict => $deconflict
  }

  validate_string($file)
  validate_string($line)
  validate_bool($deconflict)
}
