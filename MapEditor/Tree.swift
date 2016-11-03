//
//  Tree.swift
//  MapEditor
//
//  Created by Khoa on 10/22/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation


var isWriteFirstNode = false
var nodeDetails = ""
class Tree{
    
    var screen : Int
    var treeNode : Node?
    var bitmapHeight : Int
    
    
    
    // init Node - 0
    init(left : Int , top : Int , size : Int , tiles : [Tile], screen : Int, bitmapHeight : Int) {
        
        treeNode = Node(left: left, top: top, size: size, id: 0)
        self.treeNode?.listObject = tiles
        self.screen = screen
        self.bitmapHeight = bitmapHeight
        
        globalTiles = tiles
    }
    
    // ex params: list Object  - leftTop node
    func Divide( node :  Node ){
        
      
        // erase gameObject of node first
        
        node.listObject = [Tile]()
        
        let nodeRect = NSRect(x: node.left, y: node.top - node.size, width: node.size, height: node.size)
        var i = globalTiles.count - 1;
        while ( i >= 0 ){
            
          let tempRect = NSRect(x: globalTiles[i].x, y: globalTiles[i].y , width: globalTiles[i].width, height: globalTiles[i].height)
            
                if ( nodeRect.intersects(tempRect) && nodeRect.size.width < CGFloat(200)
                    && globalTiles[i].id != -1 ){
                    node.listObject.append(globalTiles[i])
                    globalTiles.remove(at: i)
                }
            i -= 1;
        }
}
    
    
    
    
    func Build(node :  Node){
        
        
//        if (!isWriteFirstNode){
//            nodeDetails  = GetNodeDetails(node: node)
//            quadTreeStr += nodeDetails + "\n"
//            
//            isWriteFirstNode = true
//            nodeDetails = ""
//        }
        if ( node.size < screen || globalTiles.count == 0  ){
            return
        }
        else {
            

            node.leftTop =  Node(left: node.left, top: node.top , size: node.size / 2, id: node.id * 8 + 1);
            node.rightTop =  Node(left: node.left + node.size / 2, top: node.top , size: node.size / 2, id: node.id * 8 + 2);
            node.leftBottom = Node(left: node.left, top: node.top / 2 , size: node.size / 2, id: node.id * 8 + 3);
            node.rightBottom = Node( left: node.left + node.size / 2, top: node.top / 2, size: node.size / 2, id: node.id * 8 + 4);

            Divide(node: node.leftTop!)
            Divide( node: node.rightTop!)
            Divide( node: node.leftBottom!)
            Divide( node: node.rightBottom!)

            node.listObject = [Tile]()

            Build(node: node.leftTop!)
            Build(node: node.rightTop!)
            Build(node: node.leftBottom!)
            Build(node: node.rightBottom!)
        
        }
    }
    
    func Save(node : Node?  ){       
        if node == nil{
            return
        }
        else
        {
            quadTreeStr += "\(node!.id) \(node!.left) \(node!.top) \(node!.size) "
            // Game Object cua mot node
            if ( node?.listObject.count != 0 ){
                for i in 0..<Int((node?.listObject.count)!){
                    quadTreeStr += "\(node!.listObject[i].index) "
                }
            }
            quadTreeStr += "\n"
            
            // De Quy va Save lai
            Save( node: node?.leftTop )
            Save( node: node?.rightTop )
            Save( node: node?.leftBottom )
            Save( node: node?.rightBottom )
        }
       
    }
    func GetNodeDetails( node : Node ) -> String{
        var str = "\(node.id) \(node.left) \(node.top) \(node.size)"
        str += "\n"
        return str
    }
}
