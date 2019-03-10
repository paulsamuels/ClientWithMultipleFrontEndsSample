import HtmlVaporSupport
import Shared
import Vapor

extension Index {
    /// Wrap the input data up in HTML.
    /// The marking up of the data is a little involved as we are using bootstrap
    /// to make things slightly less ugly on the eyes.
    ///
    /// - Parameter result: The simplified representation of the data to render.
    /// - Returns: A `Node` that can be rendered.
    static func render(_ result: Index.Result) -> Node {
        return Layout.render(content:
            errorsOrEmpty(result) +
                [
                    div([ `class`("row") ], [
                        // Show the JSON representation of the raw data.
                        div([ `class`("col-6 border") ], [
                            pre([ code( [ .text(result.raw) ]) ])
                            ]),
                        
                        // Show the JSON representation of the Decoded items.
                        div([ `class`("col-6 border") ], [
                            pre([ code( [ .text(result.decoded) ]) ])
                            ])
                        ]),
            ]
        )
    }
}

private func errorsOrEmpty(_ result: Index.Result) -> [Node] {
    return result.errors.isEmpty
        ? []
        : [
            p([
                div([ `class`("row border rounded") ], [
                    div([ `class`("col-12 border bg-warning"), style("height: 25%; overflow: auto") ],
                        result.errors.map { p([ .text($0) ]) }
                    )
                    ])
                ])
    ]
}
