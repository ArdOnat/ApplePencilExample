//
//  ViewController.swift
//  ApplePencilExample
//
//  Created by Arda Onat on 19.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func pencilKitButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func scribbleButtonPressed(_ sender: Any) {
        guard let drawingViewController = storyboard?.instantiateViewController(withIdentifier: "ScribbleViewController") as? ScribbleViewController,
            let navigationController = navigationController else {
                return
        }
        navigationController.pushViewController(drawingViewController, animated: true)
    }
    
}
