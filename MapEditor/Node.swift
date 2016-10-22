//
//  Tree.swift
//  MapEditor
//
//  Created by Khoa on 10/22/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation


class Node{
    
    var id : Int
    var left : Int
    var top : Int
    var size : Int
    //var key: T?
   
    var leftTop: Node?
    var rightTop: Node?
    var leftBottom: Node?
    var rightBottom: Node?
    var listObject : [Tile]
    
    init() {
        id = 0
        left = 0
        top = 0
        size = 0
        leftTop = nil
        rightTop = nil
        leftBottom = nil
        rightBottom = nil
        listObject = [Tile]()
    }
    init(left : Int, top : Int, size : Int, id : Int) {
        self.left = left
        self.top = top
        self.size = size
        self.id = id
        leftTop = nil
        rightTop = nil
        leftBottom = nil
        rightBottom = nil
        listObject = [Tile]()
        
    }
}








