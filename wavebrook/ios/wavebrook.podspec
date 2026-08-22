Pod::Spec.new do |s|
  s.name             = 'wavebrook'
  s.version          = '2.2.0-beta.1'
  s.summary          = 'Wavebrook Flutter plugin'
  s.description      = 'Flutter bindings for the Wavebrook iOS SDK core.'
  s.homepage         = 'https://wavebrook.com'
  s.license          = { :type => 'Proprietary', :text => 'Copyright Wavebrook. All rights reserved.' }
  s.author           = { 'Wavebrook' => 'info@wavebrook.com' }
  s.source           = { :path => '.' }

  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'

  s.source_files     = 'wavebrook/Sources/wavebrook/**/*'

  s.dependency 'Flutter'
  s.dependency 'WavebrookCore', '2.0.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
