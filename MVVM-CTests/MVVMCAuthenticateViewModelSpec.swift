import Quick
import Nimble

@testable import MVVM_C

class MVVMCAuthenticateViewModelSpec: QuickSpec {
    override func spec() {
        describe("MVVMCAuthenticateViewModel") {
            var authenticateViewModel: MVVMCAuthenticateViewModel!
            var mockDelegate: MockAuthenticateViewModelDelegate!
            var mockCoordinatorDelegate: MockAuthenticateViewModelCoordinatorDelegate!
            
            beforeEach {
                authenticateViewModel = MVVMCAuthenticateViewModel()
                mockDelegate = MockAuthenticateViewModelDelegate()
                authenticateViewModel.viewDelegate = mockDelegate
            }
            
            describe("canSubmit") {
                context("given an invalid password") {
                    beforeEach {
                        authenticateViewModel.password = "passw"
                    }
                    
                    context("given an invalid address") {
                        beforeEach {
                            authenticateViewModel.email = "***"
                        }
                        
                        it("returns false") {
                            expect(authenticateViewModel.canSubmit).to(beFalse())
                        }
                    }
                    
                    context("given a valid address") {
                        beforeEach {
                            authenticateViewModel.email = "b.blaington@blainc.com"
                        }
                        
                        it("returns false") {
                            expect(authenticateViewModel.canSubmit).to(beFalse())
                        }
                    }
                }
                
                context("given a valid password") {
                    beforeEach {
                        authenticateViewModel.password = "password"
                    }
                    
                    context("given an invalid address") {
                        beforeEach {
                            authenticateViewModel.email = "***"
                        }
                        
                        it("returns false") {
                            expect(authenticateViewModel.canSubmit).to(beFalse())
                        }
                    }
                    
                    context("given a valid address") {
                        beforeEach {
                            authenticateViewModel.email = "b.blaington@blainc.com"
                        }
                        
                        it("returns true") {
                            expect(authenticateViewModel.canSubmit).to(beTrue())
                        }
                    }
                }
            }
            
            describe("submit") {
                var mockModel: MockAuthenticateModel!
                
                beforeEach {
                    mockModel = MockAuthenticateModel()
                    authenticateViewModel.model = mockModel
                }
                
                context("given that it can not submit") {
                    beforeEach {
                        authenticateViewModel.email = "***"
                        authenticateViewModel.password = "passw"
                        authenticateViewModel.submit()
                    }
                    
                    it("does not call its data model") {
                        expect(mockModel.wasCalled).to(beFalse())
                    }
                }
                
                context("given that it can submit") {
                    beforeEach {
                        authenticateViewModel.email = "b.blaington@blainc.com"
                        authenticateViewModel.password = "password"
                    }
                    
                    it("calls its data model") {
                        authenticateViewModel.submit()
                        expect(mockModel.wasCalled).to(beTrue())
                    }
                    
                    it("calls its coordinator delegate") {
                        waitUntil { done in
                            mockCoordinatorDelegate = MockAuthenticateViewModelCoordinatorDelegate(completion: done)
                            authenticateViewModel.coordinatorDelegate = mockCoordinatorDelegate
                            authenticateViewModel.submit()
                        }
                    }
                }
            }
            
            describe("email") {
                context("given that it can not submit") {
                    beforeEach {
                        authenticateViewModel.password = "passw"
                        authenticateViewModel.email = "b.blaington@blainc.com"
                    }
                    
                    it("does not call its view delegate") {
                        expect(mockDelegate.wasCalled).to(beFalse())
                    }
                }
                
                context("given that it can submit") {
                    beforeEach {
                        authenticateViewModel.password = "password"
                        authenticateViewModel.email = "b.blaington@blainc.com"
                    }
                    
                    it("calls its view delegate") {
                        expect(mockDelegate.wasCalled).to(beTrue())
                    }
                }
            }
            
            describe("password") {
                context("given that it can not submit") {
                    beforeEach {
                        authenticateViewModel.email = "***"
                        authenticateViewModel.password = "password"
                    }
                    
                    it("does not call its view delegate") {
                        expect(mockDelegate.wasCalled).to(beFalse())
                    }
                }
                
                context("given that it can submit") {
                    beforeEach {
                        authenticateViewModel.email = "b.blaington@blainc.com"
                        authenticateViewModel.password = "password"
                    }
                    
                    it("calls its view delegate") {
                        expect(mockDelegate.wasCalled).to(beTrue())
                    }
                }
            }
        }
    }
}

private class MockAuthenticateViewModelDelegate: AuthenticateViewModelViewDelegate {
    private(set) var wasCalled = false
    
    func canSubmitStatusDidChange(viewModel: AuthenticateViewModel, status: Bool) {
        wasCalled = true
    }
    
    func errorMessageDidChange(viewModel: AuthenticateViewModel, message: String) {
        
    }
}

private class MockAuthenticateModel: AuthenticateModel {
    private(set) var wasCalled = false
    
    func login(email email: String, password: String, completionHandler: (error: NSError?) ->()) {
        completionHandler(error: nil)
        wasCalled = true
    }
    
    func loggedIn(completionHandler: (loggedIn: Bool) -> Void) {
        completionHandler(loggedIn: false)
    }
}

private class MockAuthenticateViewModelCoordinatorDelegate: AuthenticateViewModelCoordinatorDelegate {
    typealias CompletionClosure = ()->()
    
    private let completion: CompletionClosure
    
    init(completion: CompletionClosure) {
        self.completion = completion
    }
    
    func authenticateViewModelDidLogin(viewModel viewModel: AuthenticateViewModel) {
        completion()
    }
}
