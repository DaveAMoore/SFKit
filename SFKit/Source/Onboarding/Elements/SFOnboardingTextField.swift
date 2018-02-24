//
//  SFOnboardingTextField.swift
//  SFKit
//
//  Created by David Moore on 2/12/18.
//  Copyright © 2018 Moore Development. All rights reserved.
//

open class SFOnboardingTextField: SFOnboardingControl {
    
    /// Boolean value indicating if the text field will be for secure text entry.
    open var isSecureTextEntry: Bool = false
    
    /// Type of return key that will be presented in the cell.
    open var returnKeyType: UIReturnKeyType = .default
    
    open var keyboardType: UIKeyboardType = .default
    
    open var textContentType: UITextContentType?
    
    //open var 
    
    /// Initializes a new receiver.
    public init(localizedPlaceholder: String? = nil, actions: [Action] = [.inherited]) {
        super.init(localizedTitle: localizedPlaceholder ?? "", actions: actions)
    }
    
    open override func prepare(_ control: UIControl, withDefaultAction defaultAction: SFOnboardingControl.Action?,
                               for controller: SFOnboardingStageViewController?) {
        // Assert the required condition.
        assert(control is UITextField, "expected control to be a UITextField")
        
        // Call super.
        super.prepare(control, withDefaultAction: defaultAction, for: controller)
        
        // Cast the control as the text field.
        let textField = control as! UITextField
        
        // Configure the text field.
        textField.placeholder = localizedTitle
        textField.isSecureTextEntry = isSecureTextEntry
        textField.returnKeyType = returnKeyType
        textField.keyboardType = keyboardType
        if let textContentType = textContentType { textField.textContentType = textContentType }
        textField.enablesReturnKeyAutomatically = true
    }
}
