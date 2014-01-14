class { 'apache':
	default_vhost => false,
	mpm_module => 'prefork',
}

class { 'apache::mod::rewrite': }
class { 'apache::mod::php': }

apache::vhost { 'example.dev':
	docroot => '/var/www',
	port => 80,
}