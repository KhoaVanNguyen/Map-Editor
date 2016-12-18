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
    var index : Int
    var id : Int
    var x : Int
    var y : Int
    var width : Int
    var height : Int
    
    init( url : String, index : Int, id : Int, x : Int, y : Int , width : Int, height : Int ) {
        self.imageUrl = url
        self.index = index
        self.id = id
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    init(input : [String]) {
        // input = index - id
        self.index = Int(input[0])!
        self.imageUrl = input[1]
        self.id = Int(input[1])!
        self.x = 0
        self.y = 0
        self.width = 32
        self.height = 32
        
        
    }
    
    init(input2 : [String], level : Int) {
        // input = index - id
        //index id x y
        switch level {
        case 1:
            self.imageUrl = "level1_\(input2[1])"
        case 2:
            self.imageUrl = "level2_\(input2[1])"
            
        case 3:
            self.imageUrl = "level3_\(input2[1])"
        case 4:
            self.imageUrl = "level4_\(input2[1])"
            
        default:
            self.imageUrl = input2[1]
        }
        
        self.index = Int(input2[0])!
        
        //  self.imageUrl = input2[1]
        self.id = Int(input2[1])!
        self.x = 0
        self.y = 0
        self.width = 32
        self.height = 32
    }
    
    
}
