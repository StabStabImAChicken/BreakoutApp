//
//  ViewController.swift
//  breakoutApp
//
//  Created by user168408 on 4/29/21.
//  Copyright © 2021 Shane. Z. Thomas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var gameCount = 0
    var bricks = 10
    var brickCount = 10
    
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var brickView1: UIView!
    @IBOutlet weak var brckView2: UIView!
    @IBOutlet weak var brickView3: UIView!
    @IBOutlet weak var brickView4: UIView!
    @IBOutlet weak var brickView5: UIView!
    @IBOutlet weak var brick6: UIView!
    @IBOutlet weak var brickView7: UIView!
    @IBOutlet weak var brickView8: UIView!
    @IBOutlet weak var brickView9: UIView!
    @IBOutlet weak var brickView10: UIView!
    
    @IBOutlet weak var startButton: UIButton!
    
    var dynamicAnimator: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!
    var collisionBehavior: UICollisionBehavior!
    var barDynamicBehavior: UIDynamicItemBehavior!
    var ballDynamicBehavior: UIDynamicItemBehavior!
    var brickDynamicBehavior: UIDynamicItemBehavior!
    
    var brickArray = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        brickArray = [brickView1, brckView2, brickView3, brickView4, brickView5, brick6, brickView7, brickView8, brickView9, brickView10]
        ballView.layer.cornerRadius = 15
        barView.isHidden = true
        ballView.isHidden = true
        
    }
    @IBAction func panGesturePanBar(_ sender: UIPanGestureRecognizer) {
        barView.center = CGPoint(x: sender.location(in: view).x, y: barView.center.y)
        dynamicAnimator.updateItem(usingCurrentState: barView)
    }
    
    func dynamicBehavior(){
        ballView.layer.cornerRadius = 12.0
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        pushBehavior = UIPushBehavior(items: [ballView], mode: UIPushBehavior.Mode.instantaneous)
        pushBehavior.pushDirection = CGVector(dx: 0.7, dy: 1)
        pushBehavior.active = true
        pushBehavior.magnitude = 0.4
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [ballView, barView] + brickArray)
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        ballDynamicBehavior = UIDynamicItemBehavior(items: [ballView])
        ballDynamicBehavior.allowsRotation = false
        ballDynamicBehavior.elasticity = 1.0
        ballDynamicBehavior.friction = 0.0
        ballDynamicBehavior.resistance = 0.0
        dynamicAnimator.addBehavior(ballDynamicBehavior)
        
        barDynamicBehavior = UIDynamicItemBehavior(items: [barView])
        barDynamicBehavior.allowsRotation = false
        barDynamicBehavior.density = 1000.0
        dynamicAnimator.addBehavior(barDynamicBehavior)
        
        brickDynamicBehavior = UIDynamicItemBehavior(items: brickArray)
        brickDynamicBehavior.allowsRotation = false
        brickDynamicBehavior.density = 10000000000000.0
        dynamicAnimator.addBehavior(brickDynamicBehavior)
        
        collisionBehavior.collisionDelegate = self
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        for brick in brickArray{
            if item1.isEqual(ballView) && (item2.isEqual(brick)) || item1.isEqual(brick) && item2.isEqual(ballView) {
                brick.backgroundColor = UIColor.orange
                print (brick.tag)
                
                if item1.isEqual(ballView) && (item2.isEqual(brick)) && brick.backgroundColor == UIColor.orange || item1.isEqual(brick) && item2.isEqual(ballView) && brick.backgroundColor == UIColor.orange{
                    brick.backgroundColor = UIColor.yellow
                    brick.tag = 3
                    print (brick.tag)
                    
                    if item1.isEqual(ballView) && (item2.isEqual(brick)) && brick.backgroundColor == UIColor.yellow || item1.isEqual(brick) && item2.isEqual(ballView) && brick.backgroundColor == UIColor.yellow{
                            collisionBehavior.removeItem(brick)
                            brick.isHidden = true
                            brickCount -= 1
                            print (brickCount)
                    }
                }
            }
            if brickCount == 0{
                let alert = UIAlertController(title: "You Won!", message: nil, preferredStyle: .alert)
                let reset = UIAlertAction(title: "RESET", style: .default) { (action) in
                    self.ballView.isHidden = false
                    self.startButton.isHidden = false
                    self.brickCount = 10
                }
                alert.addAction(reset)
            }
            
        }
        
    }

    @IBAction func gameStart(_ sender: Any) {
        if gameCount == 0{
            dynamicBehavior()
        }
        startButton.isHidden = true
        ballView.isHidden = false
        barView.isHidden = false
        
    }
    //func resetGame(){
       // brickArray.all.isHidden = false
       // gameCount = +1
       // brickCount = 10
        
    //}
    
    func synth(){
        
    }
    
}

