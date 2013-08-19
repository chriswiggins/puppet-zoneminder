class zoneminder::install::yasm {

  exec { "download-yasm":
    command => "curl $zoneminder::params::yasm_source | tar zxv -C /usr/local/src",
    cwd => "/usr/local/src",
    creates => "/usr/local/src/yasm-1.2.0",
    timeout => 600,
    before => Exec["configure-yasm"]
  }

  exec { "configure-yasm":
    command => "/usr/local/src/yasm-1.2.0/configure",
    cwd => "/usr/local/src/yasm-1.2.0",
    creates => "/usr/local/src/yasm-1.2.0/config.log",
    notify => Exec["make-yasm"]
  }

  exec { "make-yasm":
    command => "make -j `grep processor /proc/cpuinfo|wc -l`",
    cwd => "/usr/local/src/yasm-1.2.0",
    timeout => 0,
    refreshonly => true,
    notify => Exec["make-install-yasm"]
  }

  exec { "make-install-yasm":
    command => "make install",
    cwd => "/usr/local/src/yasm-1.2.0",
    refreshonly => true,
  }
  
}
