import Foundation

protocol BrushSettingsServiceProtocol {
    func fetchBrushSettings() async throws -> BrushSettings
}

final class BrushSettingsService: BrushSettingsServiceProtocol {
    func fetchBrushSettings() async throws -> BrushSettings {
        let url = URL(string: "https://mockapi.io/brushsettings")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(BrushSettings.self, from: data)
    }
}

struct BrushSettings: Codable {
    let colorHex: String
    let strokeWidth: CGFloat
}
