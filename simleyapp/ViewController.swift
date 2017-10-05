//
//  ViewController.swift
//  simleyapp
//
//  Created by Syed Hakeem Abbas on 10/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOrignalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var trayIsOpen: Bool = false
    var newlyCreatedFace: UIImageView!
    var faceOriginalCenter: CGPoint!

    @IBOutlet weak var arrowButton: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + trayView.frame.height - arrowButton.frame.height)
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: trayView.center.y)
        trayView.center = trayCenterWhenClosed
        trayIsOpen = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func openTray() {
            trayIsOpen = true;
            self.trayView.center = self.trayCenterWhenOpen
    }
    
    private func closeTray() {
        trayIsOpen = false
         self.trayView.center = self.trayCenterWhenClosed
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = sender.location(in: trayView)
        let vilocity = sender.velocity(in: view)
        
        if sender.state == .began {
            print("Gesture began at: \(point)")
            trayOrignalCenter = trayView.center
        } else if sender.state == .changed {
            print("Gesture changed at: \(point)")
            
            let translation = sender.translation(in: trayView)
            trayView.center = CGPoint(x: trayOrignalCenter.x, y: trayOrignalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended at: \(point)")
            if(vilocity.y < 0) {
                openTray()
                print("going up")
            } else {
                closeTray()
                print("going down")
            }
        }
    }

    @IBAction func onFacePanGesture(_ sender: UIPanGestureRecognizer) {
        print("face pan")
        let point = sender.location(in: view)
        if sender.state == .began {
            // Gesture recognizers know the view they are attached to
            let imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = point
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            //newlyCreatedFace.center.y += trayView.frame.origin.y
            //newlyCreatedFace.center.y = point.y
            faceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == .changed {
            let translation = sender.translation(in: view)
            newlyCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: faceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            
        }
    }
}

