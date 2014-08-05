# Class: zookeeper::service

class zookeeper::service(
  $cfg_dir = $zookeeper::cfg_dir
){

  file { '/etc/init.d/zookeeper':
    ensure  => present,
    content => template('zookeeper/initd.zookeeper.erb'),
    mode    => '0755'
  }

  service { 'zookeeper':
    ensure     => 'running',
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [
      Package['zookeeperd'],
      File["${cfg_dir}/zoo.cfg"],
      File['/etc/init.d/zookeeper']
    ]
  }
}
