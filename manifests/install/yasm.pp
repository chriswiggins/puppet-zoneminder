class zoneminder::install::yasm {

  exec {"mkdir-yasm":
    command => "mkdir -p /usr/local/src/yasm",
    cwd => "/usr/local/src",
    creates => "/usr/local/src/yasm",
    before => Exec["download-yasm"]
  }

  exec { "download-yasm":
    command => "curl $zoneminder::params::yasm_source | tar zxv -C /usr/local/src/yasm",
    cwd => "/usr/local/src",
    timeout => 600,
    before => Exec["configure-yasm"]
  }

  exec { "configure-yasm":
    command => "/usr/local/src/yasm/configure",
    cwd => "/usr/local/src/yasm",
    creates => "/usr/local/src/yasm/config.log",
    notify => Exec["make-yasm"]
  }

  exec { "make-yasm":
    command => "make -j `grep processor /proc/cpuinfo|wc -l`",
    cwd => "/usr/local/src/yasm",
    timeout => 0,
    refreshonly => true,
    notify => Exec["make-install-yasm"]
  }

  exec { "make-install-yasm":
    command => "make install",
    cwd => "/usr/local/src/yasm",
    refreshonly => true,
  }
  
}
