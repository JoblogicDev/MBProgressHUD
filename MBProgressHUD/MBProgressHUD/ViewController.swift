//
//  ViewController.swift
//  MBProgressHUD
//
//  Created by Duy Bui on 22/07/2024.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Show progress HUD
        showProgress()
        
        // Hide alert after 3s
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.hideProgress()
        })
    }
    
    private func showProgress() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            MBProgressHUD.showAdded(to: self.view, animated: true )
        }
    }

    private func hideProgress() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

