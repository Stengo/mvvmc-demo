import Quick
import Nimble

@testable import MVVM_C

class ListCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("ListCoordinator") {
            var listCoordinator: ListCoordinator!
            var window: UIWindow!
            
            beforeEach({
                window = UIWindow()
                listCoordinator = ListCoordinator(window: window)
                listCoordinator.start()
            })
            
            describe("start") {
                it("sets the list view controller as root view controller") {
                    expect(window.rootViewController).to(beAKindOf(MVVMCListViewController))
                }
                
                it("sets the list view model of the controller") {
                    let listViewController = window.rootViewController as! MVVMCListViewController
                    
                    expect(listViewController.viewModel).toNot(beNil())
                }
                
                it("sets itself as the list view models coordinator delegate") {
                    let listViewController = window.rootViewController as! MVVMCListViewController
                    
                    expect(listViewController.viewModel!.coordinatorDelegate).to(beIdenticalTo(listCoordinator))
                }
            }
            
            describe("listViewModelDidSelectData") {
                beforeEach {
                    let viewModel = MVVMCListViewModel()
                    let dataItem = MVVMCDataItem(name: "Bla Blaington", role: "Bla")
                    listCoordinator.listViewModelDidSelectData(viewModel, data: dataItem)
                }
                
                it("sets the detail coordinator") {
                    expect(listCoordinator.detailCoordinator).toNot(beNil())
                }
                
                it("sets itself as the detail coordinators delegate") {
                    expect(listCoordinator.detailCoordinator!.delegate).to(beIdenticalTo(listCoordinator))
                }
            }
            
            describe("detailCoordinatorDidFinish") {
                beforeEach {
                    let viewModel = MVVMCListViewModel()
                    let dataItem = MVVMCDataItem(name: "Bla Blaington", role: "Bla")
                    listCoordinator.listViewModelDidSelectData(viewModel, data: dataItem)
                    listCoordinator.detailCoordinatorDidFinish(detailCoordinator: listCoordinator.detailCoordinator!)
                }
                
                it("removes the detail coordinator") {
                    expect(listCoordinator.detailCoordinator).to(beNil())
                }
                
                it("sets the list view controller as the root view controller") {
                    expect(window.rootViewController).to(beAKindOf(MVVMCListViewController))
                }
            }
        }
    }
}
