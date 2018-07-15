//
//  Item.swift
//  Todoey
//
//  Created by Nicole Letha Daniels on 7/14/18.
//  Copyright © 2018 Nicole Daniels. All rights reserved.
//

import Foundation

class Item : Codable {
    var title : String
    var done : Bool
    
    init(title : String = "", done : Bool = false) {
        self.title = title
        self.done = done
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as! String
        self.done = decoder.decodeBool(forKey: "done")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "title")
        coder.encode(self.done, forKey: "done")
    }
}
