//
//  ViewController.swift
//  faceDetectionDemo
//
//  Created by Jason Mach on 9/30/19.
//  Copyright © 2019 Jason Mach. All rights reserved.
//

import UIKit
import Vision
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(named: "sample1") else {return}
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaleHeight = view.frame.width / image.size.width * image.size.height
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaleHeight)
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(imageView)
        let request = VNDetectFaceRectanglesRequest { (req,err)
            in
            
            if let err = err {
                print("failed to detect faces",err)
                return
            }
            
    
            
            
            req.results?.forEach({ (res) in
                print(res)
                    guard let faceObservation = res as?
                     VNFaceObservation else { return }
                    print(faceObservation.boundingBox)
                
                    let x = self.view.frame.width * faceObservation.boundingBox.origin.x
    
                    let height = scaleHeight * faceObservation.boundingBox.height
                
                    let y = scaleHeight * (1 - faceObservation.boundingBox.origin.y) - height
                
                
                    let width = self.view.frame.width * faceObservation.boundingBox.width
                
                
                
                
                    //let y = view.frame.height *
                
                    let blueView = UIView()
                    blueView.backgroundColor = .blue
                    blueView.backgroundColor?.withAlphaComponent(0.5)
                    blueView.alpha = 0.4
                    blueView.frame = CGRect(x: x, y: y, width: width, height: height)
                    self.view.addSubview(blueView)
                })
            
            print(req)
        }
        
        guard let cgImage = image.cgImage else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([request])
        } catch let reqError {
            print("Failed to dectects any faces",reqError)
        }
    }


}

