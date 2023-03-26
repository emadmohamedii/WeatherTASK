# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!


def shared_pods
  
  pod 'MBProgressHUD'
  pod 'RxSwift'
  pod 'RxCocoa'
  
  #CoreData
  pod 'RxCoreData'
  pod 'RxDataSources'

  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'Kingfisher'
  pod "SwiftyJSON"
  
  
end


target 'SHTask' do
  
  shared_pods
end

target 'SHTaskTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'SHTaskUITests' do
  # Pods for testing
end
