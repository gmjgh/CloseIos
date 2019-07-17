//
//  MainRepo.swift
//  Close
//
//  Created by User on 7/12/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import RxSwift

protocol MainRepo {
    func sendMessage(_ sendMode: PushModes, _ message: String, _ receiver: String)->Observable<String>
    func createGroup()->Observable<String>
    func inviteToGroup()->Observable<String>
    func purge()->Observable<String>
}
