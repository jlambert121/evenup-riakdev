# == Class: riakdev::prep
#
# This class sets up the environment for installing instances.  It should not
# be called directly
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class riakdev::prep(
  $version      = $::riakdev::version,
  $install_dir  = $::riakdev::install_dir,
  $static_url   = $::riakdev::static_url,
) {

  group { 'riak':
    ensure => 'present',
    system => true,
  }

  file { $install_dir:
    ensure => directory,
    owner  => root,
    group  => root,
  }

  # TODO - move static path to hiera
  exec { 'fetch_dev':
    command   => "/usr/bin/curl -o ${install_dir}/riak-dev-instance-${version}.tar.gz ${static_url}/riak-dev-instance-${version}.tar.gz",
    cwd       => $install_dir,
    creates   => "${install_dir}/riak-dev-instance-${version}.tar.gz",
    path      => '/usr/bin:/bin',
    logoutput => on_failure,
    require   => File[$install_dir],
  }
}
