class jre {
        package { 'jre-1.7.0_40-fcs.x86_64':
                provider => 'rpm',
                ensure => installed,
                source => 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=80804'
        }
}

