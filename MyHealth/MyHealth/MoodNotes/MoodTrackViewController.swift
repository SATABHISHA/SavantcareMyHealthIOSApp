//
//  MoodHomeViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 20/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//
import Foundation
import UIKit

class MoodTrackViewController: UIViewController{

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    var imageListDown: [String] = ["flat.png","flat.png","happylevel1.png","happylevel2.png","happylevel3.png"]
    var imageList: [String] = ["flat.png","sadlevel1.png","sadlevel2.png","sadlevel3.png"]
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var swipeImageView: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnAddDetail: UIButton!
    
    @IBAction func btnAddDetails(_ sender: Any) {
        self.performSegue(withIdentifier: "addDetails", sender: self)
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.performSegue(withIdentifier: "moodnotesHome", sender: self)
    }
    var imageIndex:NSInteger = 1
    let maxImages = 2
    override func viewDidLoad() {
        super.viewDidLoad()

        label1.isHidden = true
        label2.isHidden = true
        swipeImageView.isHidden = true
        //===============to swipe the image using switch case code starts========
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        //===============to swipe the image using switch case code ends=======
        
        //==============code for pan gesture starts=============
     /*   let panGesture = UIPanGestureRecognizer(target: self, action: #selector (handlePanGesture))
        myView.addGestureRecognizer(panGesture)*/
        //==============code for pan gesture ends==========
        
        swipeImageView.image = UIImage(named: "flat.png")
    }
    
    //=============demo code for pan gesture testing==========
  /*  var swipePosition = 0
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        // get translation
        let translation = panGesture.translation(in: view)
        panGesture.setTranslation(CGPoint(x: 0, y: 0), in: view)
        print(translation)
        
        // create a new Label and give it the parameters of the old one
        let label = panGesture.view as! UIView
//        myView.center = CGPoint(x: label.center.x+translation.x, y: label.center.y+translation.y)
        if translation.y <= 0 && swipePosition <= imageList.count-1 {
           
            swipeImageView.image = UIImage(named: imageList[swipePosition])
             swipePosition += 1
            
        }
      
//        myView.isMultipleTouchEnabled = true
        myView.isUserInteractionEnabled = true
        if panGesture.state == UIGestureRecognizerState.began {
            // add something you want to happen when the Label Panning has started
          
        }
        if panGesture.state == UIGestureRecognizerState.ended {
            // add something you want to happen when the Label Panning has ended
        }
        if panGesture.state == UIGestureRecognizerState.changed {
            // add something you want to happen when the Label Panning has been change ( during the moving/panning )
          
        
        } else {
            // or something when its not moving
        }
    }*/
     //=============demo code for pan gesture testing==========
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   /* override func viewWillAppear(_ animated: Bool)
    {
        //Some Code here
      
        
//        label2.center.x -= view.bounds.width
    }*/
    override func viewDidAppear(_ animated: Bool) {
     
        super.viewDidAppear(animated)
        label1.isHidden = false
        label2.isHidden = false
        swipeImageView.isHidden = false
       
//        label1.center.x = view.center.x // Place it in the center x of the view.
        label1.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
        label2.center.x += view.bounds.width
        swipeImageView.center.y -= view.bounds.height
        // animate it from the left to the right
        UIView.animate(withDuration: 1.5, delay: 0.2,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: [], animations: {
                        self.label1.center.x += self.view.bounds.width
                        self.label2.center.x -= self.view.bounds.width
                        self.swipeImageView.center.y += self.view.bounds.height
                        self.view.layoutIfNeeded()
                        //                                    self.label2.center.x -= self.view.bounds.width
        }, completion: nil)
        /*UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.label1.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)*/
    }
    //================function to convert hexacode to UIColor code starts==============
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
 //================function to convert hexacode to UIColor code ends==============
    
    
    //===============switch case code starts=========
    var swipePosition = 0
    var swipeHappy = 0
 @objc  func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//    self.myView.backgroundColor = UIColor.gray
//    self.myView.backgroundColor = hexStringToUIColor(hex: "#d3d3d3")
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                if swipePosition >= imageList.count-1 && swipeHappy<imageListDown.count - 1{
                    
                }else if(swipePosition == 0 && swipeHappy == 0){
                    swipeHappy = 0
                    swipePosition += 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                    
                }else if(swipePosition == 1 && swipeHappy == 0){
                    swipeHappy = 0
                    swipePosition += 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#5B97B8")
                   
                }else if(swipePosition == 2 && swipeHappy == 0){
                    swipeHappy = 0
                    swipePosition += 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#5B8398")
                    
                }else if(swipePosition == 3 && swipeHappy == 0){
                    swipeHappy = 0
                    swipePosition += 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#8E8D8E")
                }
                
                
                if swipeHappy == 0 && swipePosition == 0{
                    
                }else if(swipeHappy == 4 && swipePosition == 0){
                    swipeHappy -= 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#EDB220")
                }else if(swipeHappy == 3 && swipePosition == 0){
                    swipeHappy -= 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#81C127")
                }else if(swipeHappy == 2 && swipePosition == 0){
                    swipeHappy -= 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#49B768")
                }else if(swipeHappy == 1 && swipePosition == 0){
                    swipeHappy -= 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#8E8D8E")
                }
                
                
            case UISwipeGestureRecognizerDirection.down:
              
                if swipePosition == 0 && swipeHappy == 0{
//                    swipeHappy += 1
                }else if(swipePosition == 3 && swipeHappy == 0){
                    swipePosition -= 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#8E8D8E")
                }else if(swipePosition == 2 && swipeHappy == 0){
                    swipePosition -= 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#5B8398")
                }else if(swipePosition == 1 && swipeHappy == 0){
                    swipePosition -= 1
                    swipeImageView.image = UIImage(named: imageList[swipePosition])
                    self.myView.backgroundColor = hexStringToUIColor(hex: "#5B97B8")
                }
               
                if(swipeHappy == 0 && swipePosition == 0){
                    swipeHappy += 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#5B97B8")
                }else if(swipeHappy == 1 && swipePosition == 0){
                    swipeHappy += 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#5B97B8")
                }else if(swipeHappy == 2 && swipePosition == 0){
                    swipeHappy += 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#49B768")
                }else if(swipeHappy == 3 && swipePosition == 0){
                    swipeHappy += 1
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#81C127")
                  
                }else if(swipeHappy == 4 && swipePosition == 0){
                    swipeImageView.image = UIImage(named: imageListDown[swipeHappy])
                     self.myView.backgroundColor = hexStringToUIColor(hex: "#EDB220")
                }
                else if(swipeHappy >= imageListDown.count - 1 && swipePosition == 0){
                    
                }
              
            default:
                break
            }
        }
    }
    //===============switch case code ends===========
    

}
