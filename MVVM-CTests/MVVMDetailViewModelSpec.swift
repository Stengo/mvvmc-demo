import Quick
import Nimble

@testable import MVVM_C

class MVVMDetailViewModelSpec: QuickSpec {
    override func spec() {
        describe("MVVMDetailViewModel") {
            var detailViewModel: MVVMCDetailViewModel!
            
            beforeEach {
                detailViewModel = MVVMCDetailViewModel()
            }
            
            describe("model") {
                var mockViewDelegate: MockDetailViewModelViewDelegate!
                var mockModel: MockDetailModel!
                
                beforeEach {
                    mockViewDelegate = MockDetailViewModelViewDelegate()
                    detailViewModel.viewDelegate = mockViewDelegate
                    mockModel = MockDetailModel()
                    detailViewModel.model = mockModel
                }
                
                it("calls its view delegate") {
                    expect(mockViewDelegate.wasCalled).to(beTrue())
                }
            }
            
            describe("done") {
                var mockCoordinatorDelegate: MockDetailViewModelCoordinatorDelegate!
                
                beforeEach {
                    mockCoordinatorDelegate = MockDetailViewModelCoordinatorDelegate()
                    detailViewModel.coordinatorDelegate = mockCoordinatorDelegate
                    detailViewModel.done()
                }
                
                it("calls its coordinator delegate") {
                    expect(mockCoordinatorDelegate.wasCalled).to(beTrue())
                }
            }
        }
    }
}

private class MockDetailViewModelViewDelegate: DetailViewModelViewDelegate {
    var wasCalled = false
    
    func detailDidChange(viewModel viewModel: DetailViewModel) {
        wasCalled = true
    }
}

private class MockDetailModel: DetailModel {
    let exampleItem: DataItem = MVVMCDataItem(name: "Bla Blaington", role: "Bla")
    
    func detail(completionHandler: (item: DataItem?) -> Void) {
        completionHandler(item: exampleItem)
    }
    
}

private class MockDetailViewModelCoordinatorDelegate: DetailViewModelCoordinatorDelegate {
    var wasCalled = false
    
    func detailViewModelDidEnd(viewModel: DetailViewModel) {
        wasCalled = true
    }
}
