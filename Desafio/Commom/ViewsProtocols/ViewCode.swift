protocol ViewCode {
    func addViews()
    func addConstraints()
    func additionalSetup()
    func setupView()
}

extension ViewCode {
    func additionalSetup() {}
    func setupView() {
        addViews()
        addConstraints()
        additionalSetup()
    }
}
