//
//  phoneHub.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/13/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import CoreData

class phoneHub: NSManagedObject {

    @NSManaged var memo: String
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var status: String

}
