//
//  ViewController.swift
//  MLKitDemo
//
//  Created by WildCat on 11/05/2018.
//  Copyright © 2018 WildCat. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    lazy var vision = Vision.vision()
    var textDetector: VisionTextDetector?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FirebaseApp.configure()
        
        // Important note: you must download your own GoogleService-Info.plist first.
        performTextRecognition()
    }
    
    func performTextRecognition() {
        textDetector = vision.textDetector()
        let uiImage = UIImage(named: "demo_image")
        let visionImage = VisionImage(image: uiImage!)
        let visionMetaData = VisionImageMetadata()
        visionMetaData.orientation = .bottomRight
        visionImage.metadata = visionMetaData
        
        textDetector!.detect(in: visionImage) { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                print("Error. You should also check the console for error messages.")
                // ...
                return
            }
            
            // Recognized and extracted text
            print("Detected text has: \(features.count) blocks")
            for block in features {
                print("\"\(block.text)\"")
            }
            // ...
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

