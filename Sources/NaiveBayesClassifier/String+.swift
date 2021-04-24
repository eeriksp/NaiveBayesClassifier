extension String {
    func removeAllOccurrencesOf(_ removables: [String]) -> String {
        var t = self
        for i in removables {
            t = t.replacingOccurrences(of: i, with: "")
        }
        return t
    }
}