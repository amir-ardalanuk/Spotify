////
////  File.swift
////  Patoghi Driver
////
////  Created by amir Ardalani on 7/1/18.
////  Copyright © 2018 Golrang. All rights reserved.
////
//
//import Alamofire
//import RxSwift
//import AlamofireObjectMapper
//
//protocol Wrapable {}
//
//extension Wrapable {
//    
//    
//    /// all Service call with this ! please if you want to Check the Value check the **response.result.value**
//    ///
//    /// - Parameters:
//    ///   - url: the url of servive
//    ///   - param: param need to send
//    ///   - method: *Optional* CRUD
//    /// - Returns: return the OBservable with generic T that you selected in Call
//    func request<T : BaseResponse>(url: String,
//                                   param: Parameters? = nil,
//                                   method: HTTPMethod = .post ,
//                                   encoding : ParameterEncoding = JSONEncoding.default ,
//                                   hasToken : Bool = true)
//        -> Observable<Result<T>> {
//            
//            print("param for : " , url ,param ?? [])
//            
//            let header : HTTPHeaders = self.generateHeader(hasToken: hasToken)
//            
//            let observer = PublishSubject<Result<T>>()
//            callApi(observer: observer, url: url, header: header, method: method, param: param, encoding: encoding  )
//            return observer
//    }
//    
//    
//    func request<T : BaseResponse>(url: String,
//                                   param: Parameters? = nil,
//                                   method: HTTPMethod = .post ,
//                                   encoding : ParameterEncoding = JSONEncoding.default ,
//                                   hasToken : Bool = true ,
//                                   cb : @escaping (Result<T>)-> Void){
//        
//        print("param for : " , url ,param ?? [])
//        
//        let header : HTTPHeaders = self.generateHeader(hasToken: hasToken)
//        Alamofire.request(url, method: method, parameters: param, encoding: encoding, headers: header).validate()
//            .responseObject { (response: DataResponse<T>) in
//                if let code = response.response?.statusCode ,code == 401{
//                    self.refreshToken(oldToken: StoreDAL.shared.getToken() ?? "", cb: { isSucc in
//                        if isSucc {
//                            self.request(url: url, param: param, method: method, encoding: encoding, hasToken: true, cb: cb)
//                        }else{
//                            cb(.failure(ClubError.userNotValid))
//                        }
//                    })
//                    
//                    return
//                }
//                
//                if let code = response.response?.statusCode ,  code == 403 {
//                    cb(.failure(ClubError.userNotValid))
//                    return
//                }
//                
//                switch response.result {
//                    
//                case .success(let value):
//                    
//                    guard value.success else {
//                        if ( value.errorCode ?? 0 ) == 10 { // for user not Valid ! !
//                           cb(.failure(ClubError.userNotValid))
//                            return
//                        }
//                        else if let message = value.message {
//                             cb(Result.failure(ClubError.failure(message: message)))
//                        } else {
//                            cb(Result.failure(ClubError.noValidData))
//                        }
//                        return
//                    }
//                    
//                    cb(Result.success(value))
//                    
//                case .failure(let error):
//                    
//                    switch error._code {
//                        
//                    case  NSURLErrorTimedOut:
//                        cb(Result.failure(ClubError.timeout))
//                    case NSURLErrorNotConnectedToInternet,NSURLErrorNetworkConnectionLost:
//                        cb(Result.failure(ClubError.notConnected))
//                    default:
//                        cb(Result.failure(ClubError.failure(message: error.localizedDescription)))
//                    }
//                }
//        }
//        }
//    
//        func callApi<T : BaseResponse>(observer : PublishSubject<Result<T>> ,url : String , header : HTTPHeaders , method : HTTPMethod , param : Parameters? , encoding  :ParameterEncoding ){
//            Alamofire.request(url, method: method, parameters: param, encoding: encoding, headers: header).validate()
//                .responseObject { (response: DataResponse<T>) in
//                    if let code = response.response?.statusCode ,code == 401{
//                        self.refreshToken(oldToken: StoreDAL.shared.getToken() ?? "", cb: { isSucc in
//                            if isSucc {
//                                
//                                self.callApi(observer: observer, url: url, header: self.generateHeader(hasToken: true), method: method, param: param, encoding: encoding)
//                            }else{
//                                observer.onNext(.failure(ClubError.userNotValid))
//                                observer.onCompleted()
//                            }
//                        })
//                        
//                        return
//                    }
//                    
//                    if let code = response.response?.statusCode ,  code == 403 {
//                        
//                        observer.onNext(.failure(ClubError.userNotValid))
//                        observer.onCompleted()
//                        return
//                    }
//                    
//                    switch response.result {
//                        
//                    case .success(let value):
//                        
//                        guard value.success else {
//                            if ( value.errorCode ?? 0 ) == 10 { // for user not Valid ! !
//                                observer.onNext(.failure(ClubError.userNotValid))
//                                return
//                            }
//                            else if let message = value.message {
//                                observer.onNext(Result.failure(ClubError.failure(message: message)))
//                            } else {
//                                observer.onNext(Result.failure(ClubError.noValidData))
//                            }
//                            observer.onCompleted()
//                            return
//                        }
//                        
//                        observer.onNext(Result.success(value))
//                        
//                    case .failure(let error):
//                        
//                        switch error._code {
//                            
//                        case  NSURLErrorTimedOut:
//                            observer.onNext(Result.failure(ClubError.timeout))
//                        case NSURLErrorNotConnectedToInternet,NSURLErrorNetworkConnectionLost:
//                            observer.onNext(Result.failure(ClubError.notConnected))
//                        default:
//                            observer.onNext(Result.failure(ClubError.failure(message: error.localizedDescription)))
//                        }
//                    }
//                    observer.onCompleted()
//            }
//        }
//        
//        func refreshToken(oldToken _token : String , cb : @escaping (_ state : Bool)->Void){
//            guard let mobile = StoreDAL.shared.get()?.mobilePhone else {return}
//            _ = CustomerService.shared.getClientToken(oldToken: _token, phone: mobile).subscribe(onNext: { (res) in
//                switch (res){
//                case .failure(let er):
//                    cb(false)
//                case .success(let val):
//                    //AppConfig.shared.token = val.data
//                    StoreDAL.shared.saveToken(token: val.data ?? "")
//                    cb(true)
//                }
//            })
//        }
//        
//        func generateHeader(hasToken : Bool )->HTTPHeaders {
//            var header : HTTPHeaders = ["Content-Type" : "application/json"]
//            if let token =  StoreDAL.shared.getToken(), hasToken {
//                header.updateValue("Bearer \( token )", forKey: "Authorization")
//            }
//            return header
//        }
//}
