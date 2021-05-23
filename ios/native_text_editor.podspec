#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint native_text_editor.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'native_text_editor'
  s.version          = '0.0.1'
  s.summary          = 'A Simple Text Editors.'
  s.description      = <<-DESC
A Simple Text Editors.
                       DESC
 s.homepage         = 'https://github.com/JideGuru/native_text_editor.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'jideguru' => 'guruliciousjide@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = ['Classes/**/*']
  s.dependency 'Flutter'
  s.dependency 'WordPress-Aztec-iOS', '~> 1.19.4'
  s.dependency 'WordPress-Editor-iOS', '~> 1.19.4'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
