class zoneminder::install::httpsegmenter {

  file { "/usr/local/src/httpsegmenter/segmenter.c":
    ensure => file,
    source => "puppet:///modules/zoneminder/httpsegmenter/segmenter.c",
    owner => 'root',
    group => 'root',
    mode => 0444,
    before => Exec["make-httpsegmenter"],
  }
  
  file { "/usr/local/src/httpsegmenter/Makefile":
    ensure => file,
    source => "puppet:///modules/zoneminder/httpsegmenter/Makefile",
    owner => 'root',
    group => 'root',
    mode => 0444,
    before => Exec["make-httpsegmenter"],
  }

  exec { "make-httpsegmenter":
    command => "make",
    cwd => "/usr/local/src/httpsegmenter",
    refreshonly => true,
    notify => Exec["make-install-httpsegmenter"]
  }

  exec { "make-install-httpsegmenter":
    command => "make install",
    cwd => "/usr/local/src/httpsegmenter",
    refreshonly => true,
  }
}
