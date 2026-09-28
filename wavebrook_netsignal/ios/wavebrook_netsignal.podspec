Pod::Spec.new do |s|
  s.name             = 'wavebrook_netsignal'
  s.version          = '1.2.0'
  s.summary          = 'Wavebrook NetSignal Flutter plugin'
  s.description      = 'Flutter bindings for the Wavebrook NetSignal iOS SDK.'
  s.homepage         = 'https://wavebrook.com'
  s.license          = { :type => 'Proprietary', :text => 'Copyright Wavebrook. All rights reserved.' }
  s.author           = { 'Wavebrook' => 'info@wavebrook.com' }
  s.source           = { :path => '.' }

  s.platform         = :ios, '15.0'
  s.swift_version    = '5.0'

  s.source_files     = 'wavebrook_netsignal/Sources/wavebrook_netsignal/**/*'

  s.dependency 'Flutter'
  s.dependency 'WavebrookNetSignal', '1.0.1'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
