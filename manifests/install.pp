class zoneminder::install {
  package { $zoneminder::params::prerequisites:
    ensure => installed,
    before => Class["zoneminder::install::ffmpeg"]
  }

  include zoneminder::install::yasm, zoneminder::install::x264, zoneminder::install::ffmpeg, zoneminder::install::zoneminder  
  Class['zoneminder::install::yasm'] -> Class['zoneminder::install::x264'] -> Class['zoneminder::install::ffmpeg'] -> Class['zoneminder::install::zoneminder']
}
