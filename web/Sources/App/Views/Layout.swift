import HtmlVaporSupport

enum Layout {
    /// Provide the boilerplate to render our content within.
    /// This boilerplate includes all the links to css and any required javascript.
    ///
    /// - Parameter content: The content to render.
    /// - Returns: A `Node` that can be rendered.
    static func render(content: [Node]) -> Node {
        let headNodes = head([
            meta([ charset("utf-8") ]),
            meta(viewport: .width(.deviceWidth), .initialScale(1)),
            bootStrap(),
            title("JSONPlaceholderClient Debugger")
            ])
        
        let bodyNodes = body([
            div([ `class`("container"), style("height: 100%") ], [
                h1(["JSONPlaceholderClient Debugger"]),
                ] + content + js())
            ])
        
        return html([ headNodes, bodyNodes ])
    }
}

private func bootStrap() -> ChildOf<Tag.Head> {
    return link([
        rel(.stylesheet),
        href("https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"),
        .init("integrity", "sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"),
        .init("crossorigin", "anonymous")
        ])
}

private func js() -> [Node] {
    return [
        script([
            src("https://code.jquery.com/jquery-3.2.1.slim.min.js"),
            .init("integrity", "sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"),
            crossorigin(.anonymous)
            ]),
        script([
            src("https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"),
            .init("integrity", "sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"),
            crossorigin(.anonymous)
            ]),
        script([
            src("https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"),
            .init("integrity", "sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"),
            crossorigin(.anonymous)
            ])
    ]
}