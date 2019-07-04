//
//  Created by Amir on 7/3/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import RxSwift

class BaseViewModel: Errorable {
    
    var loading : Bool = false
    var onError = PublishSubject<Exception> ()
    var bag = DisposeBag()
   
   
    
    init() {
        onError.subscribe(onNext: { (exception) in
            switch exception {
            case .timeout: break
                
            default : break
            }
            
            
        }).disposed(by: bag)
    }
}
