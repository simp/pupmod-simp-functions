# == Define: functions::prepend_if_no_such_line
#
# This function uses the simp_file_line type to prpend a line to a file.
#
# Example:
#
#  line { 'add_me':
#     file => '/tmp/tobeadded',
#     line => 'A test line',
#  }
#
# == Parameters
#
# [*file*]
#   The file to edit.
#
# [*line*]
#   The line to prepend if not already present.
#
# [*refreshonly*]
# [*deconflict*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::prepend_if_no_such_line (
  $file,
  $line,
  $refreshonly = 'ignored',
  $deconflict = false
) {

  simp_file_line { $name:
    path       => $file,
    line       => $line,
    prepend    => true,
    deconflict => $deconflict
  }

  validate_string($file)
  validate_string($line)
  validate_bool($deconflict)
}
