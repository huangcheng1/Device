Pod::Spec.new do |s|
  s.name             = 'Device'
  s.version          = '0.1.0'
  s.summary          = ' Device.'
  s.description      = <<-DESC
  Device 设备信息
                       DESC

  s.homepage         = 'https://github.com/huangcheng1/Device'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'acct<blob>=<NULL>' => '632300630@qq.com' }
  s.source           = { :git => 'https://github.com/huangcheng1/Device.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SCCDevice/Classes/**/*'
  s.frameworks = 'UIKit', 'SystemConfiguration' , 'CoreTelephony'
  s.libraries = 'stdc++'
end
