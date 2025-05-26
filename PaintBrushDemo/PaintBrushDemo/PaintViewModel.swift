import Foundation

final class PaintViewModel {
    private let service: BrushSettingsServiceProtocol
    private(set) var brushSettings: BrushSettings?

    init(service: BrushSettingsServiceProtocol = BrushSettingsService()) {
        self.service = service
    }

    @MainActor
    func loadBrushSettings() async {
        do {
            self.brushSettings = try await service.fetchBrushSettings()
        } catch {
            print("Failed to load brush settings: \(error)")
            // Fallback to default brush settings
            self.brushSettings = BrushSettings(colorHex: "#FF5733", strokeWidth: 8.0)
        }
    }
}
