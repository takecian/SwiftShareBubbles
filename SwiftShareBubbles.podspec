Pod::Spec.new do |s|
  s.name             = 'SwiftShareBubbles'
  s.version          = '0.1.1'
  s.summary          = 'Animated Social share buttons control for iOS written in Swift.'
  s.description      = <<-DESC
Animated Social share buttons control for iOS written in Swift. This library is inspired AAShareBubbles.
                       DESC

  s.homepage         = 'https://github.com/takecian/SwiftShareBubbles'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'takecian' => 'takecian@gmail.com' }
  s.source           = { :git => 'https://github.com/takecian/SwiftShareBubbles.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/takecian'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftShareBubbles/**/*'
  s.resource_bundles = {
    'SwiftShareBubbles' => ['SwiftShareBubbles/SwiftShareBubbles.bundle']
  }

end
