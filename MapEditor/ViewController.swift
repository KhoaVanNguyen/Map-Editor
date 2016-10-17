//
//  ViewController.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa
import ImageIO
import AppKit
class ViewController: NSViewController, NSCollectionViewDataSource , NSCollectionViewDelegate{
    
    @IBOutlet weak var mapCollectionView: NSCollectionView!
    
    @IBOutlet weak var tileCollectionView: NSCollectionView!
   
    var currentTileID = 0;

    var exportedImage = NSImage()
    
    var cursor = NSCursor()
    let tileImages = [0,1,2,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18,19,20,
                      21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
                     40,41,42,43,44,45,46,47,48]
    var trackArray = [480]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapCollectionView()
        configureTileCollectionView()
        
        initTrackArray()
        
        mapCollectionView.delegate = self
        mapCollectionView.dataSource = self
        
        tileCollectionView.delegate = self
        tileCollectionView.dataSource = self
        
        changeCursorImge(index: "\(currentTileID)")
       
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
   

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if collectionView == self.mapCollectionView{
            return 1
        }
        else{
            return 1
        
        }
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mapCollectionView{
            return 480
        }
        else{
            return tileImages.count
        }
    }
    

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
       
        if ( collectionView == self.mapCollectionView  ){
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath) as! CollectionViewItem
        return item
        }
        else {
            let item = collectionView.makeItem(withIdentifier: "TileCollectionViewItem", for: indexPath) as! TileCollectionViewItem
           item.loadTile("\(tileImages[indexPath.item])")
            
            print("\(tileImages[indexPath.item])")
            return item
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if collectionView == self.mapCollectionView{
            let index = convertToStringFrom(indexPaths)
            let item = collectionView.item(at: index) as! CollectionViewItem
            item.changeImage("\(currentTileID)")
            
            // track 
            
            trackArray[index] = currentTileID
            
           // changeCursorImge(index: "\(currentTileID)")
        }
        else{
            
            let index = convertToStringFrom(indexPaths)
            currentTileID = index
             print(index)
            changeCursorImge(index: "\(index)")
           
        }
    }
    
    // Functions
    private func configureMapCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
        // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        mapCollectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        mapCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        mapCollectionView.isSelectable = true
    }
    private func configureTileCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
        // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        mapCollectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        tileCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        tileCollectionView.isSelectable = true
    }
    
    func initTrackArray(){
        var i = 0
        while ( i < 480){
            trackArray.append(0)
            i += 1
        }
    }
 
    override func mouseEntered(with event: NSEvent) {
     
            changeCursorImge(index: "\(currentTileID)")
    }
    
    func changeCursorImge(index : String){
        let img = NSImage(named: "\(index)")
        let resizeImg = resizeTo(image: img!, w: 32, h: 32)
        let point = NSPoint(x: 10, y: 10)
        cursor = NSCursor(image: resizeImg, hotSpot: point)
        cursor.set()
    }
    
    
    func exportImage(){
        let rows = 1
        let columns = 48
        var width = 0.0
        let height = 0
        
        if ( rows == 1 ){
            for i in 0..<tileImages.count{
                let tileW = NSImage(named: "\(i)")?.size.width
                // let tileH = NSImage(named: "\(i)")?.size.heigh
                width += Double(tileW!)
            }
        
        }
        
        print(" width \(width)")
        
    }
    
    @IBAction func exportImageBtn(_ sender: Any) {
        exportImage()
        
        let rect = CGRect(x: 50, y: 50, width: 1538, height: 320)
        
      //  let inputImg = NSImage(named: "47")
        
        let wallImg = NSImage(named: "47")
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    
        let context = CGContext(
            data: nil,
            width: Int(rect.width),
            height: Int(rect.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue)
        
       // drawFunc(context: context)
        let temp = CGRect(x: 100, y: 320, width: 50, height: 50)
        
        context?.setStrokeColor(CGColor.black)
        context?.setFillColor(CGColor.black)
       
    
        let imageRef  = wallImg?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        
//        imageRef?.cropping(to: temp)
        
        context?.draw(imageRef!, in: temp)
        let image = context!.makeImage()
      
        
        
        
    
//        let cgImgRef = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        let bmpImgRef = NSBitmapImageRep(cgImage: image!)
        
    
        let pngData = bmpImgRef.representation(using: .PNG, properties: [:])
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
             let file = "image.png"
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
               try  pngData?.write(to: path)
            }
            catch {/* error handling here */}
            
            
        }

    }
    @IBAction func saveBtn(_ sender: Any) {
        let file = "file.txt"
       

        var outputText = ""
        for i in 0..<trackArray.count{
            outputText += "\(trackArray[i]) "
        }
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try outputText.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            

        }
    }
}



