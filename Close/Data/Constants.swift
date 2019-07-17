//
//  Constants.swift
//  Close
//
//  Created by User on 7/12/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

let baseUrlEndpoint = "baseUrl"

let send = "send"

let baseSenderUuid = "senderUUID"

let sendMode = "mode"

let sendBody = "body"

let sendReceiver = "receiver"

let groupCreate = "create"

let groupCreateName = "groupName"

let groupCreateMembers = "members"

let groupInvite = "invite"

let groupInviteName = "groupCreateName"

let groupInviteMembers = "groupCreateMembers"

enum PushModes: String{
    case PRIVATE_MESSAGE
    case GROUP_MESSAGE
    case GENERAL_MESSAGE
    case GROUP_CREATION
}
