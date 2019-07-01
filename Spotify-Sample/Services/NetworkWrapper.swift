//
//  File.swift
//  Patoghi Driver
//
//  Created by amir Ardalani on 7/1/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Alamofire
import RxSwift
import AlamofireObjectMapper
import ObjectMapper
protocol Wrapable {}

extension Wrapable {
    
    
    /// all Service call with this ! please if you want to Check the Value check the **response.result.value**
    ///
    /// - Parameters:
    ///   - url: the url of servive
    ///   - param: param need to send
    ///   - method: *Optional* CRUD
    /// - Returns: return the OBservable with generic T that you selected in Call
    func request<T : Mappable>(url: String,
                                   param: Parameters? = nil,
                                   method: HTTPMethod = .post ,
                                   encoding : ParameterEncoding = JSONEncoding.default ,
                                   hasToken : Bool = true)
        -> Observable<Result<T>> {
            
            print("param for : " , url ,param ?? [])
            
            let header : HTTPHeaders = self.generateHeader(hasToken: hasToken)
            
            let observer = PublishSubject<Result<T>>()
            callApi(observer: observer, url: url, header: header, method: method, param: param, encoding: encoding  )
            return observer
    }
    
        func callApi<T : Mappable>(observer : PublishSubject<Result<T>> ,
                                       url : String ,
                                       header : HTTPHeaders ,
                                       method : HTTPMethod ,
                                       param : Parameters? ,
                                       encoding  :ParameterEncoding ){
            Alamofire.request(url, method: method, parameters: param, encoding: encoding, headers: header).validate()
                .responseObject { (response: DataResponse<T>) in
                  
                    switch response.result {
                        
                    case .success(let value):
                        observer.onNext(Result.success(value))
                        
                    case .failure(let error):
                        
                        switch error._code {
                            
                        case  NSURLErrorTimedOut:
                            observer.onNext(Result.failure(SpotifyError.timeout))
                        case NSURLErrorNotConnectedToInternet,NSURLErrorNetworkConnectionLost:
                            observer.onNext(Result.failure(SpotifyError.notConnected))
                        default:
                            observer.onNext(Result.failure(SpotifyError.failure(message: error.localizedDescription)))
                        }
                    }
                    observer.onCompleted()
            }
        }
    
        //TODO: Add Token From Spotify
        func generateHeader(hasToken : Bool )->HTTPHeaders {
            var header : HTTPHeaders = ["Content-Type" : "application/json"]
//            if let token =  StoreDAL.shared.getToken(), hasToken {
//                header.updateValue("Bearer \( token )", forKey: "Authorization")
//            }
            return header
        }
}
