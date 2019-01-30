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
    
    var level: Int = 0
    var game: [String] = []
    var wordsLabels : [UILabel] = []
    var showWords: [Bool] = []
    var letters: [Character] = []
    var letterBool: [Bool] = []
    var lettersLabel: [UILabel] = []
    var letterSeen: [String] = []
    var wordsLeft = 0
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        //making boolean list
        for _ in 0..<game.count{
            showWords.append(false)
        }
        //making letters list
        var maxWord = ""
        for i in game{
            if maxWord.count < i.count{
                maxWord = i
            }
        }
        wordsLeft = game.count
        Wordslabel.text = String(wordsLeft)
        for i in maxWord{
            letters.append(i)
            letterBool.append(false)
        }
        //putting labels in view
        var yPos = 90
        var xPos = 10
        for i in 0..<game.count {
            let labelNum = UILabel()
            if yPos < Int(TopView.frame.height)-91{
                labelNum.text = game[i]
                labelNum.textAlignment = .center
                labelNum.frame = CGRect( x:xPos, y:yPos, width:90, height: 45)
                yPos += 60
            }
            else{
                yPos = 90
                xPos += 130
                labelNum.text = game[i]
                labelNum.textAlignment = .center
                labelNum.frame = CGRect( x:xPos, y:yPos, width:90, height: 45)
                yPos += 60
            }
            TopView.addSubview(labelNum)
            wordsLabels.append(labelNum)
            wordsLabels[i].text = ""
        }
        
        //putting letters around a circle
        var center = BotView.center
        center.x -= 25
        center.y -= 40
        let radius : CGFloat = BotView.frame.height / 2.8
        let count = letters.count
        
        var angle = CGFloat(2 * Double.pi)
        let step = CGFloat(2 * Double.pi) / CGFloat(count)
        
        for i in 0..<count{
            let x = cos(angle) * radius + center.x
            let y = sin(angle) * radius + center.y
            
            let label = UILabel()
            label.text = String(letters[i])
            label.font = UIFont(name: "Arial", size: 35)
            label.frame = CGRect( x:x-label.frame.midX, y:y-label.frame.midY, width:45, height: 45)
            label.textAlignment = .center
            
            self.view.addSubview(label)
            angle += step
            lettersLabel.append(label)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handlePan(recog: UIPanGestureRecognizer){
        let loc = recog.location(in: self.view)
        for i in 0..<letters.count{
            if lettersLabel[i].frame.origin.x.isLess(than: loc.x) && loc.x.isLess(than:  lettersLabel[i].frame.origin.x + lettersLabel[i].frame.width) && lettersLabel[i].frame.origin.y.isLess(than: loc.y) && loc.y.isLess(than:  lettersLabel[i].frame.origin.y + lettersLabel[i].frame.height) && !letterBool[i]{
                letterSeen.append(lettersLabel[i].text!)
                
                DispatchQueue.main.async {
                    self.lettersLabel[i].backgroundColor = .yellow
                    self.lettersLabel[i].setNeedsDisplay()
                }
                
                letterBool[i] = true
            }
        }
        if recog.state == .ended || recog.state == .failed || recog.state == .cancelled{
            DispatchQueue.global().async {
                 self.doWords()
            }
           
        }
    }
    
    func doWords()
    {
        var theWord = ""
        for i in letterSeen{
            theWord += i
        }
        letterSeen.removeAll()
        for i in 0..<letterBool.count{
            letterBool[i] = false
            DispatchQueue.main.async {
                self.lettersLabel[i].backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8588235294, blue: 1, alpha: 1)
                self.lettersLabel[i].setNeedsDisplay()
            }
            
        }
        print(theWord)
        for i in 0..<game.count{
            if showWords[i] == false && theWord == game[i]{
                print(game[i])
                showWords[i] = true
                wordsLeft-=1
               
                DispatchQueue.main.async{
                    self.wordsLabels[i].text = self.game[i]
                    self.Wordslabel.text = String(self.wordsLeft)
                    self.wordsLabels[i].setNeedsDisplay()
                    self.Wordslabel.setNeedsDisplay()
                }
                break
            }
        }
        
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
