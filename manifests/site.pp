import '/vagrant/modules/jre/manifests/*'

group { "puppet":
    ensure => "present",
}

File { owner => vagrant, group => vagrant, mode => 0644 }

file { '/home/vagrant/.bashrc':
    content => "echo 'May you never need to Stand One Up By Hand again!'"
}

package { "vim-enhanced":
    ensure => present,
}


package { 'jre-1.7.0_40-fcs.x86_64':
    provider => 'rpm',
    ensure => installed,
    source => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=80804'
}

