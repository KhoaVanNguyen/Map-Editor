//
//  Tree.swift
//  MapEditor
//
//  Created by Khoa on 10/22/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation


class Tree{
    
    var screen : Int
    var treeNode : Node
    var bitmapHeight : Int
    
    
    // init Node - 0
    init(left : Int , top : Int , size : Int , tiles : [Tile], screen : Int, bitmapHeight : Int) {
        
        treeNode = Node(left: left, top: top, size: size, id: 0)
        self.treeNode.listObject = tiles
        self.screen = screen
        self.bitmapHeight = bitmapHeight
    }
    
    // ex params: list Object  - leftTop node
    func Divide(tiles : [Tile] , node : Node ){
        
        // erase gameObject of node first
        
        node.listObject = [Tile]()
        
        let nodeRect = NSRect(x: node.left, y: node.top, width: node.size, height: node.size)
        for i in 0..<tiles.count{
            
            let tempRect = NSRect(x: tiles[i].x, y: tiles[i].y, width: tiles[i].width, height: tiles[i].height)
            
            
            if ( nodeRect.intersects(tempRect) ){
                node.listObject.append(tiles[i])
            }
            
        }
    }
    
    
    
    func Build(node : Node){
        if ( node.size < screen || node.listObject.count == 0  ){
            return
        }
        else {
            
            node.leftTop =  Node(left: node.left, top: node.top, size: node.size / 2, id: node.id * 8 + 1);
            node.rightTop =  Node(left: node.left + node.size / 2, top: node.top, size: node.size / 2, id: node.id * 8 + 2);
            node.leftBottom = Node(left: node.left, top: node.top + node.size / 2, size: node.size / 2, id: node.id * 8 + 3);
            node.rightBottom = Node( left: node.left + node.size / 2, top: node.top + node.size / 2, size: node.size / 2, id: node.id * 8 + 4);
            
            
            Divide(tiles: node.listObject, node: node.leftTop!)
            Divide(tiles: node.listObject, node: node.rightBottom!)
            Divide(tiles: node.listObject, node: node.leftBottom!)
            Divide(tiles: node.listObject, node: node.rightBottom!)

            node.listObject = [Tile]()

            
            Build(node: node.leftTop!)
            Build(node: node.rightTop!)
            Build(node: node.leftBottom!)
            Build(node: node.rightBottom!)
        
        }
    }
    
    func Save(node : Node ){
        
        var tempStr = ""
        if ( node == nil ){
            return
        }
        else {
            tempStr += "\(node.id) \(node.left) \(bitmapHeight - node.top) \(node.size) "
            // Game Object cua mot node
            if ( node.listObject != nil ){
            for i in 0..<node.listObject.count{
                tempStr += " \(node.listObject[i].index)"
                }
            }
            
    
            
            writeToFile(content: tempStr, fileName: "quadtree.txt")
         
            // De Quy va Save lai
            Save( node: node.leftTop! );
            Save( node: node.rightTop! );
            Save( node: node.leftBottom!);
            Save( node: node.rightBottom!);
        }
        
    }
  
}
