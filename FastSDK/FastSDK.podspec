Pod::Spec.new do |s|
         s.name            = "FastSDK"
         s.version         = "0.1"
         s.summary         = "fast develop sdk"
         s.homepage        = 'https://github.com/zhaomy/FastDevelopKit/wiki'
         s.license         = 'MIT'
         s.author          = { 'zhaomy' => 'https://github.com/zhaomy/FastDevelopKit/wiki' }
         s.platform        = :ios,'7.0'
         #s.source          = { :git => "/Users/zhao/Desktop/work/FastDevelopKit/FastSDK" }
         s.source_files    = '**/*.{h,m,md}'
         s.preserve_paths  = 'FastDevelopKit/FastSDK'
         
         #s.xcconfig        = { 'LIBRARY_SEARCH_PATHS' => '/Users/zhao/Desktop/work/FastDevelopKit/FastSDK' }    
 
         s.dependency 'AFNetworking','~> 3.0.4' 
         s.dependency 'Masonry','~> 0.6.4' 
         s.dependency 'SVProgressHUD',''~> 2.0-beta8''
         s.dependency 'MJRefresh','~> 3.1.0'
         s.dependency 'SDWebImage','~> 3.7.5'

         
        end
