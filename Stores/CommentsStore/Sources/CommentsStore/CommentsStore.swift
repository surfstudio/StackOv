
import Foundation
import Combine
import Common
import HTMLMarkdown

public final class CommentsStore: ObservableObject {
    
    // MARK: - Public properties
    
    @Published public private(set) var comments: [CommentModel]
    @Published public private(set) var numberOfFollowingItems: Int = 0
    
    // MARK: - Internal properties
    
    var models: [CommentModel]
    var activeModelsCount: Int = 0

    let step: Int = 5
    let unitsCash = Cache<Int, HTMLMarkdown.Unit>()
    
    // MARK: - Initialization
    
    public init(model: [CommentModel]) {
        self.models = model
        activeModelsCount = model.count > step ? step : model.count
        comments = Array(model[0..<activeModelsCount])
        calculateNumberOfFollowingItems()
    }
    
    // MARK: - Public methods
    
    public func unit(of model: CommentModel) -> Result<HTMLMarkdown.Unit, Error> {
        unit(forId: model.id, htmlText: model.body)
    }
    
    // MARK: - Internal methods
    
    func calculateNumberOfFollowingItems() {
        numberOfFollowingItems = models.count - activeModelsCount > step ? step : models.count - activeModelsCount
    }
    
    func unit(forId id: Int, htmlText: String) -> Result<HTMLMarkdown.Unit, Error> {
        if let unit = unitsCash[id] { return .success(unit) }
        do {
            let unit = try HTMLMarkdown.Unit.make(with: htmlText)
            unitsCash[id] = unit
            return .success(unit)
        } catch {
            return .failure(error)
        }
    }
}

// MARK: - Actions

public extension CommentsStore {
    
    func showMore() {
        let newActiveModelsCount = activeModelsCount + numberOfFollowingItems
        comments += Array(models[activeModelsCount..<newActiveModelsCount])
        activeModelsCount = newActiveModelsCount
        calculateNumberOfFollowingItems()
    }
    
}
