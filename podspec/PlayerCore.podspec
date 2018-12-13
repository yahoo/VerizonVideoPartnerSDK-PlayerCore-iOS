Pod::Spec.new do |s|
  s.name             = 'PlayerCore'
  s.version          = 'new_version'
  s.summary          = 'PlayerCore contains important player logic which is used by Oath Video Partner SDK.'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.swift_version    = '4.2'
  
  s.homepage         = 'https://github.com/OathAdPlatforms/OathVideoPartnerSDK-PlayerCore-iOS'
  
  s.authors           = {
    'Andrey Moskvin' => 'andrey.moskvin@oath.com',
    'Alexey Demedetskiy' => 'alexey.demedetskiy@oath.com',
    'Bogdan Bilonog' => 'bogdan.bilonog@oath.com',
    'Roman Tysiachnik' => 'roman.tysiachnik@oath.com',
    'Vladyslav Anokhin' => 'vladyslav.anokhin@oath.com'
  }
  s.source = { :git => 'git@github.com:OathAdPlatforms/OathVideoPartnerSDK-PlayerCore-iOS.git',
               :tag => s.version.to_s }

  s.source_files     = 'PlayerCore/**/*.swift'
  s.exclude_files    = 'PlayerCore/*Test*'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  
  s.frameworks = 'CoreGraphics', 'CoreMedia'
end
