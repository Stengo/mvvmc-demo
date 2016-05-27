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
            
            describe("start") {
                it("adds some coordinator to the child coordinator list") {
                    expect(appCoordinator.coordinators[CoordinatorType.Authentication]).toNot(beNil())
                }
                
                it("adds the authentication coordinator to the child coordinator list") {
                    if (appCoordinator.coordinators[CoordinatorType.Authentication] is AuthenticationCoordinator) == false {
                        fail("Expected an AuthenticationCoordinator, got something else")
                    }
                }
                
                it("sets itself as the authentication coordinators delegate") {
                    let authenticationCoordinator = appCoordinator.coordinators[CoordinatorType.Authentication] as! AuthenticationCoordinator
                    expect(authenticationCoordinator.delegate!).to(beIdenticalTo(appCoordinator))
                }
            }
            
            describe("authenticationCoordinatorDidFinish") {
                beforeEach({
                    let authenticationCoordinator = appCoordinator.coordinators[CoordinatorType.Authentication] as! AuthenticationCoordinator
                    appCoordinator.authenticationCoordinatorDidFinish(authenticationCoordinator: authenticationCoordinator)
                })
                
                it("removes the authentication coordinator from the child coordinator list") {
                    expect(appCoordinator.coordinators[CoordinatorType.Authentication]).to(beNil())
                }
                
                it("adds some coordinator to the child coordinator list") {
                    expect(appCoordinator.coordinators[CoordinatorType.List]).toNot(beNil())
                }
                
                it("adds a list coordinator to the child coordinator list") {
                    if (appCoordinator.coordinators[CoordinatorType.List] is ListCoordinator) == false {
                        fail("Expected a ListCoordinator, got something else")
                    }
                }
                
                it("sets itself as the list coordinators delegate") {
                    let listCoordinator = appCoordinator.coordinators[CoordinatorType.List] as! ListCoordinator
                    expect(listCoordinator.delegate!).to(beIdenticalTo(appCoordinator))
                }
            }
            
            describe("listCoordinatorDidFinish") {
                beforeEach({
                    let authenticationCoordinator = appCoordinator.coordinators[CoordinatorType.Authentication] as! AuthenticationCoordinator
                    appCoordinator.authenticationCoordinatorDidFinish(authenticationCoordinator: authenticationCoordinator)
                    let listCoordinator = appCoordinator.coordinators[CoordinatorType.List] as! ListCoordinator
                    appCoordinator.listCoordinatorDidFinish(listCoordinator: listCoordinator)
                })
                
                it("removes the list coordinator from the child coordinator list") {
                    expect(appCoordinator.coordinators[CoordinatorType.List]).to(beNil())
                }
            }
        }
    }
}
