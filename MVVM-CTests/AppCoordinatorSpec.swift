import Quick
import Nimble

@testable import MVVM_C

class AppCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("AppCoordinator") { 
            var appCoordinator: AppCoordinator!
            
            beforeEach({
                let navigationController = UINavigationController()
                appCoordinator = AppCoordinator(navigationController: navigationController)
                appCoordinator.startWithEndpoint(nil)
            })
            
            describe("startWithEndpoint") {
                it("sets the list coordinator") {
                    expect(appCoordinator.listCoordinator).toNot(beNil())
                }
                
                it("sets itself as the list coordinators delegate") {
                    expect(appCoordinator.listCoordinator!.delegate!).to(beIdenticalTo(appCoordinator))
                }
            }
            
            describe("listCoordinatorDidFinish") {
                beforeEach({
                    appCoordinator.listCoordinatorDidFinish(listCoordinator: appCoordinator.listCoordinator!)
                })
                
                it("removes the list coordinator") {
                    expect(appCoordinator.listCoordinator).to(beNil())
                }
            }
        }
    }
}
