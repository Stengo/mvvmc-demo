import Quick
import Nimble

@testable import MVVM_C

class MVVMCListViewModelSpec: QuickSpec {
    override func spec() {
        describe("MVVMCListViewModel") {
            var listViewModel: MVVMCListViewModel!
            
            beforeEach {
                listViewModel = MVVMCListViewModel()
            }
            
            describe("model") {
                var mockModel: MockListModel!
                var mockViewDelegate: MockListViewModelViewDelegate!
                
                beforeEach {
                    mockViewDelegate = MockListViewModelViewDelegate()
                    listViewModel.viewDelegate = mockViewDelegate
                    mockModel = MockListModel()
                    listViewModel.model = mockModel
                }
                
                it("calls its view delegate") {
                    expect(mockViewDelegate.wasCalled).to(beTrue())
                }
            }
            
            describe("numberOfItems") {
                var mockModel: MockListModel!
                
                beforeEach {
                    mockModel = MockListModel()
                    listViewModel.model = mockModel
                }
                
                it("returns the item count of the list model") {
                    expect(listViewModel.numberOfItems).to(equal(1))
                }
            }
            
            describe("itemAtIndex") {
                var mockModel: MockListModel!
                
                beforeEach {
                    mockModel = MockListModel()
                    listViewModel.model = mockModel
                }
                
                context("given a valid index") {
                    it("returns the correct item") {
                        expect(listViewModel.itemAtIndex(0)!.name).to(equal(mockModel.exampleItems[0].name))
                    }
                }
                
                context("given an invalid index") {
                    it("returns nil") {
                        expect(listViewModel.itemAtIndex(1)).to(beNil())
                    }
                }
            }
            
            describe("useItemAtIndex") {
                var mockModel: MockListModel!
                var mockCoordinatorDelegate: MockListViewCoordinatorDelegate!
                
                beforeEach {
                    mockCoordinatorDelegate = MockListViewCoordinatorDelegate()
                    listViewModel.coordinatorDelegate = mockCoordinatorDelegate
                    mockModel = MockListModel()
                    listViewModel.model = mockModel
                }
                
                context("given a valid index") {
                    beforeEach {
                        listViewModel.useItemAtIndex(0)
                    }
                    
                    it("calls its coordinator delegate") {
                        expect(mockCoordinatorDelegate.wasCalled).to(beTrue())
                    }
                    
                    it("passes the correct data to its coordinator delegate") {
                        expect(mockCoordinatorDelegate.lastData.name).to(equal(mockModel.exampleItems[0].name))
                    }
                }
            }
        }
    }
}

private class MockListModel: ListModel {
    let exampleItems: [DataItem] = [MVVMCDataItem(name: "Bla Blaington", role: "Bla")]
    
    func items(completionHandler: (items: [DataItem]) -> Void) {
        let items = exampleItems
        completionHandler(items: items)
    }
}

private class MockListViewModelViewDelegate: ListViewModelViewDelegate {
    var wasCalled = false
    
    func itemsDidChange(viewModel viewModel: ListViewModel) {
        wasCalled = true
    }
}

private class MockListViewCoordinatorDelegate: ListViewModelCoordinatorDelegate {
    var wasCalled = false
    var lastData: DataItem!
    
    func listViewModelDidSelectData(viewModel: ListViewModel, data: DataItem) {
        wasCalled = true
        lastData = data
    }
}
