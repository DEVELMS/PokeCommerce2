//
//  ApplicationController.swift
//  PokeCommerce
//
//  Created by Storm on 14/12/16.
//  Copyright © 2016 DEVELMS. All rights reserved.
//

import UIKit

class ApplicationController: UIViewController {

    fileprivate let service = ApplicationService()
    fileprivate let gifImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGifAttributes()
        downloadContent()
    }
    
    fileprivate func setGifAttributes() {
    
        let x: CGFloat = 0
        let y: CGFloat = 0
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        
        let gif = UIImage(gifName: "pokeball")
        let manager = SwiftyGifManager(memoryLimit:60)
        gifImageView.setGifImage(gif, manager: manager, loopCount: -1)
        
        gifImageView.frame = CGRect(x: x, y: y, width: width, height: height)
        gifImageView.contentMode = .scaleAspectFill
        view.addSubview(gifImageView)
    }
    
    fileprivate func stopGif() {
    
        self.gifImageView.stopAnimatingGif()
        self.gifImageView.removeFromSuperview()
    }
    
    fileprivate func downloadContent() {
        
        let service = ApplicationService()
        
        service.getApplication( success: {
            
            Do.wait(seconds: 1) {
                
                self.stopGif()
                self.presentNavigation()
            }
            
        }, fail: { failure in
            self.stopGif()
            self.showAlert(message: failure)
        })
    }
    
    fileprivate func showAlert(message: String) {
        
        let alert = UIAlertController(title: ":(", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.default) {
            action in
            
            self.downloadContent()
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func presentNavigation() {
    
        let pokeListNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "PokeListNavigationController") as! UINavigationController
        
        self.present(pokeListNavigationController, animated: true)
    }
}
