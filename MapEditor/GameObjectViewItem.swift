//
//  GameObjectViewItem.swift
//  MapEditor
//
//  Created by Khoa on 11/4/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class GameObjectViewItem: NSCollectionViewItem {
    @IBOutlet weak var gameObjectImage: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func loadImage( imgUrl : String){
        gameObjectImage.image = NSImage(named: imgUrl)
    }
}
