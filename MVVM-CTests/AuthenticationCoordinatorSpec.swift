import Quick
import Nimble

@testable import MVVM_C

class AuthenticationCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("AuthenticationCoordinator") {
            var authenticationCoordinator: AuthenticationCoordinator!
            var window: UIWindow!
            
            beforeEach({
                window = UIWindow()
                authenticationCoordinator = AuthenticationCoordinator(window: window)
                authenticationCoordinator.start()
            })
            
            describe("start") {
                it("sets the authentication view controller as root view controller") {
                    expect(window.rootViewController).to(beAKindOf(MVVMCAuthenticationViewController))
                }
            }
            
            describe("authenticateViewModelDidLogin") {
                var mockDelegate: MockAuthenticationCoordinatorDelegate!
                
                beforeEach {
                    mockDelegate = MockAuthenticationCoordinatorDelegate()
                    authenticationCoordinator.delegate = mockDelegate
                    let viewModel = MVVMCAuthenticateViewModel()
                    authenticationCoordinator.authenticateViewModelDidLogin(viewModel: viewModel)
                }
                
                it("calls the delegates did finish function") {
                    expect(mockDelegate.wasCalled).to(beTrue())
                }
            }
        }
    }
}

private class MockAuthenticationCoordinatorDelegate: AuthenticationCoordinatorDelegate {
    private(set) var wasCalled = false
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator authenticationCoordinator: AuthenticationCoordinator) {
        wasCalled = true
    }
}
