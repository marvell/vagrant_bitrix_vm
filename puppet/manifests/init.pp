Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/opt/vagrant_ruby/bin/' ] }

node default {
	class { "update": stage => "update" }
	class { "packages": stage => "packages" }
}

stage { "update": before => Stage["packages"] }
class update {
	exec { 'apt-get update':
		command => 'apt-get update'
	}
}

stage { "packages": before => Stage["main"] }
class packages {
	package {
		"build-essential": ensure => latest;
		"libshadow": ensure => latest, provider => 'gem', require => Package["build-essential"];
		"lsb-release": ensure => latest, require => Package["build-essential"];
		"git": ensure => latest, require => Package["build-essential"];
		"wget": ensure => latest, require => Package["build-essential"];
		"ruby": ensure => latest, require => Package["build-essential"];
		"ruby-dev": ensure => latest, require => Package["ruby"];
		"libgemplugin-ruby": ensure => latest, require => Package["ruby"];
		"puppet": ensure => latest, provider => "gem", require => Package["ruby"];
		"facter": ensure => latest, provider => "gem", require => Package["puppet"];
		"librarian-puppet": ensure => latest, provider => "gem", require => Package["facter"];
		"hiera": ensure => latest, provider => "gem", require => Package["puppet"];
	}

	exec { "copy_puppet_files":
		command => "cp /vagrant/puppet/Puppetfile /etc/puppet/ && cp /vagrant/puppet/hiera.yaml /etc/puppet/",
		require => Package["librarian-puppet"]
	}

	exec { "fresh_puppet_install":
		cwd => "/etc/puppet",
		command => "sudo librarian-puppet install --clean",
		require => Exec['copy_puppet_files']
	}

	exec { "update_puppet":
		cwd => "/etc/puppet",
		command => "sudo librarian-puppet update",
		require => Exec['fresh_puppet_install']
	}
}