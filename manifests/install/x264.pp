class zoneminder::install::x264 {
  exec { "clone-x264":
    command => "git clone $zoneminder::params::x264_source x264",
    cwd => "/usr/local/src",
    timeout => 600,
    creates => "/usr/local/src/x264",
    before => Exec["configure-x264"]
  }

  exec { "configure-x264":
    command => "/usr/local/src/x264/configure $zoneminder::params::x264_configure_options",
    cwd => "/usr/local/src/x264",
    creates => "/usr/local/src/x264/config.log",
    notify => Exec["make-x264"]
  }

  exec { "make-x264":
    command => "make -j `grep processor /proc/cpuinfo|wc -l`",
    cwd => "/usr/local/src/x264",
    timeout => 0,
    refreshonly => true,
    notify => Exec["make-install-x264"]
  }

  exec { "make-install-x264":
    command => "make install",
    cwd => "/usr/local/src/x264",
    refreshonly => true,
  }

}
