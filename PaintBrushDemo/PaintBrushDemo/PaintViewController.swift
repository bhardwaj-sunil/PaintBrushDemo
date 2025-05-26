import UIKit

final class PaintViewController: UIViewController {
    private let canvasView = PaintCanvasView()
    private let viewModel = PaintViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCanvasView()
        Task {
            await viewModel.loadBrushSettings()
            applyBrushSettings()
        }
    }

    private func setupCanvasView() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func applyBrushSettings() {
        guard let settings = viewModel.brushSettings else { return }
        canvasView.brushColor = UIColor(hex: settings.colorHex)
        canvasView.strokeWidth = settings.strokeWidth
    }
}
