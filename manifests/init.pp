# == Class: system_role
#
# A module (and facts) for identifying information about a system.
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#    Whether or not the data should be present on the system or not
#    (default: present)
# [*application*]
#    The name of the application that is being clustered. (required)
# [*tier*]
#    The tier of the application (prod, dev, test, etc.) (optional)
# [*node_number*]
#    The number of the node in the cluster. (optional)
#
# === Examples
#
#  class { system_role:
#    application => 'main-web',
#    tier        => 'prod',
#    node_number => 0,
#  }
#
# === Authors
#
# Phil Fenstermacher <pcfens@wm.edu>
#
class system_role (
  $ensure      = 'present',
  $application = undef,
  $tier        = undef,
  $node_number = undef,
){
  # No underscores in application_name or tier
  validate_re($application, '^[a-zA-Z0-9-]+$')
  if $tier {
    validate_re($tier, '^[a-zA-Z0-9]+$')
  }

  if $node_number and !is_integer($node_number) {
    fail('$node_number must be an integer')
  }

  file { '/etc/system_role':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template('system_role/system_role.erb'),
  }
}
