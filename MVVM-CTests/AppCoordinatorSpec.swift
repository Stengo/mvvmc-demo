import Quick
import Nimble

@testable import MVVM_C

class AppCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("AppCoordinator") { 
            var appCoordinator: AppCoordinator!
            beforeEach({
                let window = UIWindow()
                appCoordinator = AppCoordinator(window: window)
                appCoordinator.start()
            })
            describe("authenticationCoordinatorDidFinish", {
                beforeEach({
                    let authenticationCoordinator = appCoordinator.coordinators[CoordinatorType.Authentication] as! AuthenticationCoordinator
                    appCoordinator.authenticationCoordinatorDidFinish(authenticationCoordinator: authenticationCoordinator)
                })
                it("removes the authentication coordinator from the child coordinator list", closure: {
                    expect(appCoordinator.coordinators[CoordinatorType.Authentication]).to(beNil())
                })
                it("adds the list coordinator to the child coordinator list", closure: { 
                    expect(appCoordinator.coordinators[CoordinatorType.List]).toNot(beNil())
                })
            })
        }
    }
}
