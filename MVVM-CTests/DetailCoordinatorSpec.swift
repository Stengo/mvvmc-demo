import Quick
import Nimble

@testable import MVVM_C

class DetailCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("DetailCoordinator") {
            var detailCoordinator: DetailCoordinator!
            var navigationController: UINavigationController!
            
            beforeEach {
                navigationController = UINavigationController()
                let dataItem = MVVMCDataItem(name: "Bla Blaington", role: "Bla")
                detailCoordinator = DetailCoordinator(navigationController: navigationController, dataItem: dataItem)
                detailCoordinator.start()
            }
            
            describe("start") {
                it("sets the detail view controller as root view controller") {
                    expect(navigationController.topViewController).to(beAKindOf(MVVMCDetailViewController))
                }
                
                it("sets the detail view model of the controller") {
                    let detailViewController = navigationController.topViewController as! MVVMCDetailViewController
                    
                    expect(detailViewController.viewModel).toNot(beNil())
                }
                
                it("sets itself as the detail view models coordinator delegate") {
                    let detailViewController = navigationController.topViewController as! MVVMCDetailViewController
                    
                    expect(detailViewController.viewModel!.coordinatorDelegate).to(beIdenticalTo(detailCoordinator))
                }
            }
            
            describe("detailViewModelDidEnd") {
                var mockDelegate: MockDetailCoordinatorDelegate!
                
                beforeEach {
                    mockDelegate = MockDetailCoordinatorDelegate()
                    detailCoordinator.delegate = mockDelegate
                    let viewModel = MVVMCDetailViewModel()
                    detailCoordinator.detailViewModelDidEnd(viewModel)
                }
                
                it("calls the delegates did finish function") {
                    expect(mockDelegate.wasCalled).to(beTrue())
                }
                
                it("passes itself to the did finish function") {
                    expect(mockDelegate.lastCaller).to(beIdenticalTo(detailCoordinator))
                }
            }
        }
    }
}

private class MockDetailCoordinatorDelegate: DetailCoordinatorDelegate {
    private(set) var wasCalled = false
    private(set) var lastCaller: DetailCoordinator!
    
    func detailCoordinatorDidFinish(detailCoordinator detailCoordinator: DetailCoordinator) {
        wasCalled = true
        lastCaller = detailCoordinator
    }
}
