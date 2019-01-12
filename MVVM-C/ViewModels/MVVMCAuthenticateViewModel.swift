//
//  MVVMCAuthenticateViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 20/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

class MVVMCAuthenticateViewModel: AuthenticateViewModel
{
    
    weak var viewDelegate: AuthenticateViewModelViewDelegate?
    weak var coordinatorDelegate: AuthenticateViewModelCoordinatorDelegate?
    var model: AuthenticateModel?
    
    
    /// Email
    
    var email: String = "" {
        didSet {
            if oldValue != email {
                let oldCanSubmit = canSubmit
                emailIsValidFormat = validateEmailFormat(email: email)
                if canSubmit != oldCanSubmit {
                    viewDelegate?.canSubmitStatusDidChange(viewModel: self, status: canSubmit)
                }
            }
        }
    }
    
    
    private var emailIsValidFormat: Bool = false
    
    /// Password
    var password: String = "" {
        didSet {
            if oldValue != password {
                let oldCanSubmit = canSubmit
                passwordIsValidFormat = validatePasswordFormat(password: password)
                if canSubmit != oldCanSubmit {
                    viewDelegate?.canSubmitStatusDidChange(viewModel: self, status: canSubmit)
                }
            }
        }
    }
    
    
    private var passwordIsValidFormat: Bool = false
    
    /// Submit
    var canSubmit: Bool {
        return emailIsValidFormat && passwordIsValidFormat
    }
    
    
    
    /// Errors
    private(set) var errorMessage: String = "" {
        didSet {
            if oldValue != errorMessage {
                viewDelegate?.errorMessageDidChange(viewModel: self, message: errorMessage)
            }
        }
    }
    
    private func validateEmailFormat(email: String) -> Bool
    {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email)
    }
    
    
    /// Validate password is at least 6 characters
    private func validatePasswordFormat(password: String) -> Bool
    {
        let trimmedString = password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString.count > 5
    }
    
    
    func submit()
    {
        errorMessage = ""
        guard let dataModel = model, canSubmit else {
            errorMessage = NSLocalizedString("NOT_READY_TO_SUBMIT", comment: "")
            return
        }
        
        let modelCompletionHandler = { (error: NSError?) in
            //Make sure we are on the main thread
            DispatchQueue.main.async {
                guard let error = error else {
                    self.coordinatorDelegate?.authenticateViewModelDidLogin(viewModel: self)
                    return
                }
                self.errorMessage = error.localizedDescription
            }
        }
        dataModel.login(email: email, password: password, completionHandler: modelCompletionHandler)
    }
}
