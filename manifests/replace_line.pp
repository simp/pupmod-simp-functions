# == Define: functions::replace_line
#
# This function replaces a line using a PERL match and replace.
#
# Example:
#
#  replace_line { 'replace_me':
#     file => '/tmp/tobeadded',
#     pattern => 'replace me',
#     replacement => 'with this stuff'
#  }
#
# == Parameters
#
# [*file*]
#   The file to edit.
#
# [*pattern*]
#   The PCRE to match.
#
# [*replacement*]
#   The replacement text.
#
# [*refreshonly*]
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
define functions::replace_line(
  $file,
  $pattern,
  $replacement,
  $refreshonly = false
  ) {

  exec { "replace_line_${name}":
    command     => "/usr/bin/perl -pi -e 's/$pattern/$replacement/' '$file'",
    onlyif      => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /$pattern/; END { exit \$ret; }' '$file'",
    refreshonly => $refreshonly
  }

  validate_string($file)
  validate_string($pattern)
  validate_bool($refreshonly)
}
