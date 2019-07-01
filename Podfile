# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'JobFinder' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for JobFinder
  pod 'Kingfisher'
  pod 'SwiftyJSON'
  pod 'GooglePlaces'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
  
  target 'JobFinderTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'JobFinderUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
