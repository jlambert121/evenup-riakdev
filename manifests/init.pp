# == Class: riakdev
#
# This class installs, configures, and joines together a four node riak
# "development" cluster.
#
#
# === Parameters
#
# [*version*]
#   String.  What version number of riak should be installed
#   Default: 1.2.1
#
# [*num_instances*]
#   Integer.  Number of dev instances to install
#   Default: 4
#
# [*pb_initial_port*]
#   Integer.  Base PB listener port
#   Default: 8081
#
# [*http_initial_port*]
#   Integer.  Base http listener port
#   Default: 8091
#
# [*handoff_initial_port*]
#   Integer.  Base handoff port
#   Default: 8101
#
# [*install_dir*]
#   String.  Path where the development nodes should be installed
#   Default: /var/lib/riak
#
#
# === Examples
#
# * Installation:
#     class { 'riakdev':
#       version => '1.3.1',
#     }
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class riakdev(
  $version              = '1.2.1',
  $num_instances        = 4,
  $pb_initial_port      = 8081,
  $http_initial_port    = 8091,
  $handoff_initial_port = 8101,
  $install_dir          = '/var/lib/riak',
  $static_url           = 'http://files/',
) {

  anchor { '::riakdev::begin': } ->
  class { '::riakdev::prep': } ->
  class { '::riakdev::instances': } ->
  class { '::riakdev::finish': } ->
  anchor { '::riakdev::end': }

}
