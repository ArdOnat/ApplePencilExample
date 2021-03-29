//
//  PencilKitViewController.swift
//  ApplePencilExample
//
//  Created by Arda Onat on 25.03.2021.
//

import UIKit

import PencilKit

class PencilKitViewController: UIViewController {
    
    @IBOutlet weak var canvasView: PKCanvasView!
    
    var toolPicker: PKToolPicker!
    
    /// On iOS 14.0, this is no longer necessary as the finger vs pencil toggle is a global setting in the toolpicker
    var pencilFingerBarButtonItem: UIBarButtonItem!
    
    /// Hide the home indicator, as it will affect latency.
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 14.0, *) {
            toolPicker = PKToolPicker()
        } else {
            let window = parent?.view.window
            toolPicker = PKToolPicker.shared(for: window!)
        }
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        
        // Before iOS 14, add a button to toggle finger drawing.
        if #available(iOS 14.0, *) { } else {
            pencilFingerBarButtonItem = UIBarButtonItem(title: "Enable Finger Drawing",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(toggleFingerPencilDrawing(_:)))
            navigationItem.rightBarButtonItems?.append(pencilFingerBarButtonItem)
            canvasView.allowsFingerDrawing = false
        }
        
        let pencilInteraction = UIPencilInteraction()
        self.view.addInteraction(pencilInteraction)
        pencilInteraction.delegate = self
        
        
        // Always show a back button.
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    /// Action method: Turn finger drawing on or off, but only on devices before iOS 14.0
    @IBAction func toggleFingerPencilDrawing(_ sender: Any) {
        if #available(iOS 14.0, *) { } else {
            canvasView.allowsFingerDrawing.toggle()
            let title = canvasView.allowsFingerDrawing ? "Disable Finger Drawing" : "Enable Finger Drawing"
            pencilFingerBarButtonItem.title = title
        }
    }
}

extension PencilKitViewController: UIPencilInteractionDelegate {
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        if canvasView.backgroundColor != .black {
            canvasView.backgroundColor = .black
        }
        else {
            canvasView.backgroundColor = .white
        }
    }
}
