require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-cardscan"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-cardscan
                   DESC
  s.homepage     = "https://github.com/getbouncer/react-native-cardscan"
  s.license      = "MIT"
  s.authors      = { "Stefano Suryanto" => "stefanocsuryanto@gmail.com" }
  s.source       = { :git => "https://github.com/getbouncer/react-native-cardscan.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '13.0'

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React-Core"
  s.dependency "StripeCardScan", '~> 24.0.0'
end

