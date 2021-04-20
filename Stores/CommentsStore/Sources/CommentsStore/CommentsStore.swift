
import Foundation
import Combine
import Common

public final class CommentsStore: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published public private(set) var comments: [CommentModel]
    @Published public private(set) var numberOfFollowingItems: Int = 0
    
    // MARK: - Internal Properties
    
    var models: [CommentModel]
    var activeModelsCount: Int = 0

    let step: Int = 5
    
    // MARK: - Initialization
    
    public init(model: [CommentModel]) {
        self.models = model
        activeModelsCount = model.count > step ? step : model.count
        comments = Array(model[0..<activeModelsCount])
        calculateNumberOfFollowingItems()
    }
    
    // MARK: - Internal Methods
    
    func calculateNumberOfFollowingItems() {
        numberOfFollowingItems = models.count - activeModelsCount > step ? step : models.count - activeModelsCount
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
