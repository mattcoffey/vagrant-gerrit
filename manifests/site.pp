group { "puppet":
    ensure => "present",
}

File { owner => vagrant, group => vagrant, mode => 0644 }

file { '/home/vagrant/.bashrc':
    content => "echo 'May you never need to Stand One Up By Hand again!'"
}
