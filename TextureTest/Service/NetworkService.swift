//
//  NetworkService.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

import SystemConfiguration

import Alamofire
import Moya
import Sniffer

class DefaultAlamofireManager: SessionManager {
    static let shareManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        Sniffer.enable(in: configuration)
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

final class NetworkService: NetworkServieType {
    
    // MARK: Singleton
    
    static let shared = NetworkService()
    
    private init() {}
    
    private let provider: MoyaProvider<NaverAPI> = {
        let provider = MoyaProvider<NaverAPI>(endpointClosure: MoyaProvider.defaultEndpointMapping,
                                              requestClosure: MoyaProvider<NaverAPI>.defaultRequestMapping,
                                              stubClosure: MoyaProvider.neverStub,
                                              callbackQueue: nil,
                                              manager: DefaultAlamofireManager.shareManager,
                                              plugins: [],
                                              trackInflights: false)
        return provider
    }()
    
    func request(_ api: NaverAPI) -> Observable<String> {
        return connectedToNetwork
            .flatMap { [weak self] flag -> Observable<Response> in
                if flag {
                    guard let observer = self?.provider.rx.request(api).asObservable() else { return Observable.empty() }
                    return observer
                } else {
                    return Observable.error(NaverAPIError.noCommunication)
                }
        }
        .mapString()
        .flatMap { data -> Observable<String> in
            return Observable.just(data)
        }
    }
    
    var connectedToNetwork: Observable<Bool> {
        return Observable.create { observer -> Disposable in
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else { return Disposables.create() }
            
            var flags: SCNetworkReachabilityFlags = []
            
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                observer.onNext(false)
                observer.onCompleted()
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            observer.onNext(isReachable && !needsConnection)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
