protocol ViewsProtocol {
    func buildView()
    func buildConstraints()
    func buildViewHierarchy()
    func setupView()
}

extension ViewsProtocol {
    func buildView() {
        buildViewHierarchy()
        buildConstraints()
        setupView()
    }
}
