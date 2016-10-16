//
//  Tile.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class Tile {
    
    var imageUrl : String
    var x : Int
    var y : Int
    var index : Int
    
    init(_url : String, _x : Int, _y : Int, _index : Int) {
        self.imageUrl = _url
        self.x = _x
        self.y = _y
        self.index = _index
    }
}
