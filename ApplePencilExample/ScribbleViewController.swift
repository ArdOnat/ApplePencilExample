//
//  ScribbleViewController.swift
//  ApplePencilExample
//
//  Created by Arda Onat on 25.03.2021.
//

import UIKit

class ScribbleViewController: UIViewController {
    
    @IBOutlet weak var defaultTextField: UITextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scribbleTextField: UITextField!
    @IBOutlet weak var indirectScribbleTextField: UITextField!
    @IBOutlet weak var indirectScribbleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scribbleInteraction = UIScribbleInteraction(delegate: self)
        scribbleTextField.addInteraction(scribbleInteraction)
        
        let indirectScribleInteraction = UIIndirectScribbleInteraction(delegate: self)
        indirectScribbleView.addInteraction(indirectScribleInteraction)
        
        navigationController?.navigationBar.isHidden = false
    }
}

extension ScribbleViewController: UIScribbleInteractionDelegate {
    func scribbleInteractionWillBeginWriting(_ interaction: UIScribbleInteraction) {
        let lineHeight = scribbleTextField.font?.lineHeight ?? 17.0
        let height = lineHeight * 4.0
        heightConstraint.constant = height
    }
}

extension ScribbleViewController: UIIndirectScribbleInteractionDelegate {
    func indirectScribbleInteraction(_ interaction: UIInteraction, focusElementIfNeeded elementIdentifier: String, referencePoint focusReferencePoint: CGPoint, completion: @escaping ((UIResponder & UITextInput)?) -> Void) {
        if indirectScribbleTextField != nil {
            indirectScribbleTextField.becomeFirstResponder()
        }
        completion(indirectScribbleTextField)
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, isElementFocused elementIdentifier: String) -> Bool {
        return indirectScribbleTextField?.isFirstResponder ?? false
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, frameForElement elementIdentifier: String) -> CGRect {
        return indirectScribbleView.bounds
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, requestElementsIn rect: CGRect, completion: @escaping ([String]) -> Void) {
        completion(["IndirectScribbleTextView"])
    }
}

