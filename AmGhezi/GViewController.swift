//
//  GViewController.swift
//  AmGhezi
//
//  Created by Aria on 1/23/19.
//  Copyright © 2019 Aria. All rights reserved.
//

import UIKit
import Foundation

class GViewController: UIViewController{
    
    
    @IBOutlet weak var Wordslabel: UILabel!
    @IBOutlet weak var ExitButton: UIButton!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var BotView: UIView!
    
    var game: [String] = []
    var showWords: [Bool] = []
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for _ in 0..<game.count{
            showWords.append(false)
        }
    }
    override func viewDidLoad() {
    }
    
    func reset()
    {
        for i in 0..<showWords.count{
            showWords[i] = false
        }
    }
    
    @IBAction func exitDone(_ sender: Any) {
        reset()
        dismiss(animated: true, completion: nil)
    }
    
}
