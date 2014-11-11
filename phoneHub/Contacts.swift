//
//  Contacts.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import CoreData

class Contacts: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var memo: String
    @NSManaged var hasCalled: NSNumber
    @NSManaged var status: String
    @NSManaged var firstTime: NSNumber
    @NSManaged var createStamp: NSDate
    @NSManaged var callStamp: NSDate

}
