//
//  ViewController.swift
//  SpeechTest
//
//  Created by jaki on 2018/4/10.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit
import Speech
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SFSpeechRecognizer.requestAuthorization { (status) in
            
        };
        
        let rec = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: URL(fileURLWithPath: ""))
        rec?.recognitionTask(with: request, resultHandler: { (result, error) in
            print(result)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

