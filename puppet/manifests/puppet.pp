Exec { path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/opt/vagrant_ruby/bin' ] }
File { owner => '0', group => '0', mode => '0644' }

define puppet_module_install {
	exec { "puppet module install ${name} >/dev/null": }
}

if ! defined('apt') {
	package {
		'ruby': ensure => 'installed';
		'puppet': ensure => 'latest', provider => 'gem', require => Package['ruby'];
	}
	puppet_module_install { 'puppetlabs/apt': require => Package['puppet']}
	puppet_module_install { 'puppetlabs/apache': require => Package['puppet']}

	file { '/etc/puppet/hiera.yaml':
		ensure => 'file',
		source => '/vagrant/puppet/hiera.yaml'
	}

	exec { 'aptitude update': }
} else {
	class { 'apt':
		always_apt_update => true,
	}
}