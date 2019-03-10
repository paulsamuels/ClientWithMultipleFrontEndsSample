import HtmlVaporSupport
import Shared
import Vapor

public func routes(_ router: Router) throws {
    router.get(use: Index.action)
}
