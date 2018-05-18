source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'

inhibit_all_warnings!

use_frameworks!

def networking
    pod 'Moya/RxSwift'
    pod 'ReachabilitySwift'
    pod 'SDWebImage'
end

def reactive
    pod 'RxSwift'
    pod 'RxCocoa'
end

target 'UBSChallenge' do
    networking
    reactive
end
