Pod::Spec.new do |s|
  s.name             = 'PlayerCore'
  s.version          = '1.0.3'
  s.summary          = 'PlayerCore contains important player logic which is used by Verizon Video Partner SDK.'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.swift_version    = '4.2'
  
  s.homepage         = 'https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS'
  
  s.authors           = {
    'Andrey Moskvin' => 'andrey.moskvin@oath.com',
    'Roman Tysiachnik' => 'roman.tysiachnik@oath.com',
    'Vladyslav Anokhin' => 'vladyslav.anokhin@oath.com'
  }
  s.source = { :git => 'https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS.git',
               :tag => s.version.to_s }

  s.source_files     = 'PlayerCore/**/*.swift'
  s.exclude_files    = 'PlayerCore/*Test*'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  
  s.frameworks = 'CoreGraphics', 'CoreMedia'
end
