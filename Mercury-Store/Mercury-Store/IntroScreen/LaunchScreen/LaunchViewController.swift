//
//  LaunchViewController.swift
//  Mercury-Store
//
//  Created by Esraa Khaled   on 16/06/2022.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = AnimationView()
        animationView.animation = Animation.named("E-commerce")
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        animationView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        animationView.center = view.center
       
        animationView.play()
        view.addSubview(animationView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else {return}
            //here to do put PagesViewController(THe Intro)
            //let startVC = HomeViewController( nibName:"HomeViewController", bundle: nil)
           // self.navigationController?.pushViewController(startVC, animated: true)
        }

    }


  

}
