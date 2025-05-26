import UIKit

final class PaintCanvasView: UIView {
    private var lines: [Line] = []
    private var currentLine: Line?
    var brushColor: UIColor = .black
    var strokeWidth: CGFloat = 5.0

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newLine = Line(color: brushColor, strokeWidth: strokeWidth, points: [touch.location(in: self)])
        currentLine = newLine
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, var line = currentLine else { return }
        line.points.append(touch.location(in: self))
        currentLine = line
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let finalLine = currentLine {
            lines.append(finalLine)
        }
        currentLine = nil
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        for line in lines + (currentLine.map { [$0] } ?? []) {
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            for (i, point) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
    }
}

struct Line {
    let color: UIColor
    let strokeWidth: CGFloat
    var points: [CGPoint]
}
