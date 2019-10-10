//
//  GraphView.swift
//  recycle
//
//  Created by TORU ISHIHARA on 10/10/19.
//  Copyright © 2019 nariuchi. All rights reserved.
//

import UIKit

private struct Constants {
  static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
  static let margin: CGFloat = 20.0
  static let topBorder: CGFloat = 60
  static let bottomBorder: CGFloat = 50
  static let colorAlpha: CGFloat = 0.3
  static let circleDiameter: CGFloat = 5.0
}

@IBDesignable class GraphView: UIView {
    var totalPoints = [0, 2, 6, 8, 12, 13, 25]
    let topColor = UIColor(red:80/255, green:215/255, blue:155/255, alpha:1)
    let bottomColor = UIColor(red:67/255, green:139/255, blue:185/255, alpha:1)

    override func draw(_ rect: CGRect) {
        backgroundColor = UIColor.white
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath(roundedRect: rect,
                          byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
      
        // 2
        let context = UIGraphicsGetCurrentContext()!
        let colors = [topColor.cgColor, bottomColor.cgColor]
      
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
      
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
      
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                     colors: colors as CFArray,
                                  locations: colorLocations)!
      
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                          start: startPoint,
                            end: endPoint,
                        options: [])
        
        //calculate the x point
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
          //Calculate the gap between points
          let spacing = graphWidth / CGFloat(self.totalPoints.count - 1)
          return CGFloat(column) * spacing + margin + 2
        }
        
        // calculate the y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = totalPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y // Flip the graph
        }
        
        // draw the line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
            
        // set up the points line
        let graphPath = UIBezierPath()

        // go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(totalPoints[0])))
            
        // add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<totalPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(totalPoints[i]))
            graphPath.addLine(to: nextPoint)
        }

        graphPath.stroke()
        
        //Create the clipping path for the graph gradient

        //1 - save the state of the context (commented out for now)
        //context.saveGState()
            
        //2 - make a copy of the path
        let clippingPath = graphPath.copy() as! UIBezierPath
            
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(x: columnXPoint(totalPoints.count - 1), y:height))
        clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
        clippingPath.close()
            
        //4 - add the clipping path to the context
        clippingPath.addClip()
            
        //5 - check clipping path - temporary code
        UIColor.green.setFill()
        let rectPath = UIBezierPath(rect: rect)
        rectPath.fill()
        //end temporary code
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
                
        context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
        //context.restoreGState()
        
        //draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        //Draw the circles on top of the graph stroke
        for i in 0..<totalPoints.count {
          var point = CGPoint(x: columnXPoint(i), y: columnYPoint(totalPoints[i]))
          point.x -= Constants.circleDiameter / 2
          point.y -= Constants.circleDiameter / 2
              
          let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
          circle.fill()
        }
        
        //Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()

        //top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))

        //center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight/2 + topBorder))

        //bottom line
        linePath.move(to: CGPoint(x: margin, y:height - bottomBorder))
        linePath.addLine(to: CGPoint(x:  width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
            
        linePath.lineWidth = 1.0
        linePath.stroke()
    }
}
