#!/bin/bash

./.build/release/_PRODUCT/bin/swiftshield obfuscate \
              --ignore-public \
              --project-file /Users/guogh/Desktop/works/flipped-ios/Flipped.xcworkspace \
              --scheme Flipped \
              --verbose \
              --black-list /Users/guogh/Desktop/per_work/swiftshield/blackList.txt \
              --ignore-targets Alamofire,CryptoSwift,RxGesture,FileKit,FilesProvider,Kingfisher,SnapKit,WCDBSwift,Lottie,Differentiator,JXSegmentedView,SwifterSwift,RxCocoa,RxSwift,RxRelay,PhoneNumberKit,SwiftyStoreKit,ObjectMapper,Moya,WCDBSwift,SwiftyUserDefaults,SwiftyJSON,RxDataSources,URLNavigator,Spring