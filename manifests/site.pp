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

class jre ( $src ) {
    package { 'package':
        provider => 'rpm',
        ensure => installed,
        name => "jre-1.7.0_40-fcs.i586",
        source => "${jre::src}"
    }
}

class { 'jre':
    src => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=80802',
}
