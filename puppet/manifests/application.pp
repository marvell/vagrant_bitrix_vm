class { 'apache':
	default_vhost => false,
}
apache::mod { 'rewrite': }
apache::vhost { $::domain:
	port => 80,
	docroot => "/var/www",
	override => ["All"],
	require => File["/var/www"]
}