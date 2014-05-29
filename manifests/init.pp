# == Class: selinux
#
# This module manages the SELinux configuration file.
#
class selinux (
  $mode        = 'disabled',
  $type        = 'targeted',
  $config_file = '/etc/selinux/config',
  $setlocaldefs = undef
) {

  validate_re($mode, '^enforcing|permissive|disabled$', "mode is ${mode} and must be either 'enforcing', 'permissive' or 'disabled'.")
  validate_re($type, '^targeted|strict$', "type is ${type} and must be either 'targeted' or 'strict'.")
  validdate_re($setlocaldefs, '^0|1$', "local defs is ${setlocaldefs} must be either 0 or 1

  file { 'selinux_config':
    ensure  => 'file',
    path    => $config_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('selinux/config.erb'),
  }
}
