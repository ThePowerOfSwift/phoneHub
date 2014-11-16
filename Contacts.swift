//
//  Contacts.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/16/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import CoreData

class Contacts: NSManagedObject {

    @NSManaged var called: NSDate?
    @NSManaged var created: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var memo: String
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var phoneType: String
    @NSManaged var photo: NSData
    @NSManaged var status: String

}
