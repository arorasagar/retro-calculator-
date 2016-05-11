//
//  ViewController.swift
//  retro-calculator
//
//  Created by Sagar Arora  on 5/9/16.
//  Copyright © 2016 Sagar Arora . All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    enum Operation: String {
       
        case Divide = "/"
        case Multiply = "*"
        case Addition = "+"
        case Subtraction = "-"
        case Empty = "Empty"
       
        
    }
    
    //Outlets
    @IBOutlet weak var outPutLbl: UILabel!
    
    var BtnSound: AVAudioPlayer!
    var leftValStr = ""
    var rightValStr = ""
    var runningNumber = ""
    var CurrentOperation: Operation = Operation.Empty
    var result = ""
    // Created an Operator as a variable, initialized as empty because when you first open a calculator no operation is used.
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
         let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try BtnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            BtnSound.prepareToPlay()
            
        } catch let err as NSError {
           
            print(err.debugDescription)
            
            
        
        }
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func ProcessOperation(op: Operation) {
        playSound()
        
        
            if CurrentOperation != Operation.Empty {
                
                // Run Some Math(Clicking second operation whether that is a = or something else)
                // A user selected an operator, and then selected another one without first selecting a number dont do anything until they click another number
                
                
                if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                
                if CurrentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                    
                }
                else if CurrentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                    
                } else if CurrentOperation == Operation.Addition {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                    
                    
                } else if CurrentOperation == Operation.Subtraction {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                    
                }
                
                leftValStr = result
                outPutLbl.text = result
            }
            
        
        
        
            CurrentOperation = op
            // We need to perform the previous calculation then store the next one into a operation variable 
            
        } else {
        leftValStr = runningNumber
        runningNumber = ""
        CurrentOperation = op
        // This is the first time an operator has been inputed and you just have to store it.
        }
        
        
    }
    
    
    func playSound() {
        if BtnSound.playing {
            BtnSound.stop()
        }
        BtnSound.play()
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound() 
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        result = ""
        CurrentOperation = Operation.Empty
        outPutLbl.text = "0"
   
        
        
            
        
    }
    
    @IBAction func numberPressed(Btn: UIButton!) {
        playSound()
        
        runningNumber += "\(Btn.tag)"
        // Inject a variable into a expression, running number is defaulted to nothing and everytime you click numberPressed numbers are added to runningNumber
        outPutLbl.text = runningNumber
        
        
        
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        ProcessOperation(Operation.Divide)
        
        
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        ProcessOperation(Operation.Multiply)
       
        
        
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        ProcessOperation(Operation.Addition)
        
    }
    
    @IBAction func onSubtractionPressed(sender: AnyObject) {
        ProcessOperation(Operation.Subtraction)
        
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        ProcessOperation(CurrentOperation)
        
        
        
    }
 
}

