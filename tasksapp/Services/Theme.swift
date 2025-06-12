enum AppTheme: String, CaseIterable, Identifiable {
    case system, light, dark
    
    var id: String { self.rawValue }

    var displayName: String {
        switch self {
        case .system: return "System Default"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}
