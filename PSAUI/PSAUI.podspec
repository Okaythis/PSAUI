#
# Be sure to run `pod lib lint PSAUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'PSAUI'
s.version          = '0.0.1'
s.summary          = 'User Interface for PSA framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.homepage         = 'https://okaythis.com'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
s.author           = { 'Okay This' => 'hello@okaythis.com' }
s.source           = { :git => 'https://github.com/Okaythis/PSAUI.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '10.0'

s.source_files = 'PSAUI/Classes/**/*'

s.dependency 'PSACommon'

# s.resource_bundles = {
#   'PSAUI' => ['PSAUI/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
