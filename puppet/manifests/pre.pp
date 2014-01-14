package {
	'curl': ensure => 'present';
	'git': ensure => 'present';
}

file { '/root/.profile':
	ensure => 'file',
	source => '/vagrant/files/root/.profile',
	owner => '0',
	group => '0',
	mode => '0644',
}