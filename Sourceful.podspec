Pod::Spec.new do |s|
  s.name = 'Sourceful'
  s.version = '0.2.0'
  s.license = 'MIT'
  s.summary = 'A native source editor for iOS and macOS.'
  s.homepage = 'https://github.com/twostraws/Sourceful'
  s.social_media_url = 'http://twitter.com/twostraws'
  s.authors = { 'Louis D\'hauwe' => 'louisdhauwe@silverfox.be', 'Paul Hudson' => 'paul@hackingwithswift.com' }
  s.source = { :git => 'https://github.com/twostraws/Sourceful.git', :tag => s.version }
  s.module_name  = 'Sourceful'

  s.ios.deployment_target = '12.0'
  s.osx.deployment_target  = '10.14'

  s.source_files = 'Sources/**/*.swift'
end
