//
//  MainRepoRest.swift
//  Close
//
//  Created by User on 7/12/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import RxSwift

class MainRepoRest: MainRepo{
    func sendMessage(_ sendModeValue: PushModes, _ message: String, _ receiver: String)->Observable<String> {
        return NetworkManager.shared.post(send, [sendMode:sendModeValue.rawValue, sendBody:message, sendReceiver:receiver])
    }
    
    func createGroup()->Observable<String> {
        return Observable.empty()
    }
    
    func inviteToGroup()->Observable<String> {
        return Observable.empty()
    }
    
    func purge()->Observable<String> {
        return Observable.empty()
    }
    
}
