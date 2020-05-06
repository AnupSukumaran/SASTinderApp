//
//  ViewController.swift
//  SASTinderApp
//
//  Created by Sukumar Anup Sukumaran on 03/05/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var thumbImgView: UIImageView!
    
    var divisor:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
    }
    
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let c = sender.view!
        let p = sender.translation(in: view)
        let newXCenter = c.center.x - view.center.x
        
        c.center = CGPoint(x: view.center.x + p.x, y: view.center.y + p.y)
        let rAngle = newXCenter / view.frame.width * 0.61
        
//        let r =  newXCenter/divisor
//        print("r = \(r)")
        print("newXCenter = \(newXCenter)")
        print("view.center.x = \(view.center.x)")
        let scale = min(((view.center.x/2)/abs(newXCenter)), 1)
        print("scale = \(scale)")
        c.transform = CGAffineTransform(rotationAngle: rAngle ).scaledBy(x: scale, y: scale)
        if newXCenter > 0 {
            thumbImgView.image = #imageLiteral(resourceName: "like")
            thumbImgView.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        } else {
            thumbImgView.image = #imageLiteral(resourceName: "dislike")
            thumbImgView.tintColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        
        thumbImgView.alpha = abs(newXCenter) / view.center.x
        
        if sender.state == UIGestureRecognizer.State.changed {
            //print("c.center.x = \(c.center.x)")
        }
        
        if sender.state == UIGestureRecognizer.State.ended {
            
            if c.center.x < 75 {
                /// MOVE  OFF TO LEFT
                UIView.animate(withDuration: 0.2) {
                    c.center = CGPoint(x: c.center.x - 200, y: c.center.y + 75)
                    c.alpha = 0
                }
                
                return
            } else if c.center.x > (view.frame.width - 75) {
                /// MOVE OFF  TO THE RIGHT
               
                
                UIView.animate(withDuration: 0.2) {
                    c.center = CGPoint(x: c.center.x + 200, y: c.center.y + 75)
                    c.alpha = 0
                }
                
                return
            }
            
            
            resetCard()
            
        }
    }
    
    @IBAction func rest(_ sender: Any) {
        resetCard()
    }
    
    func resetCard() {
         UIView.animate(withDuration: 0.2) {
             self.cardView.alpha = 1
            self.cardView.center = self.view.center
             self.thumbImgView.alpha = 0
            self.cardView.transform = .identity
            
         }
    }

}

