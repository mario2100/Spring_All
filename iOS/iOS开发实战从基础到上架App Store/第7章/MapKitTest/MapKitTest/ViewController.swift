//
//  ViewController.swift
//  MapKitTest
//
//  Created by vip on 17/3/7.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let map = MKMapView(frame: self.view.frame)
//        map.mapType = .hybridFlyover
        map.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.26, 116.3), MKCoordinateSpanMake(1.8, 2.05))
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.delegate = self
        self.view.addSubview(map)
        
        let ann = MKPointAnnotation()
        ann.coordinate = CLLocationCoordinate2DMake(33.23, 113.112)
        ann.title = "我的位置"
        ann.subtitle = "中华人民共和国北京"
        map.addAnnotation(ann)
//        var coor = Array<CLLocationCoordinate2D>()
//        for i in 0..<5{
//            let po = CLLocationCoordinate2DMake(33.23+Double(i)*0.01, 113.112+Double(i%2)*0.01)
//            coor.append(po)
//        }
//        //创建一个折线对象
//        let line = MKPolyline(coordinates: &coor, count: 5)
//        map.add(line)
//        
//        let circle = MKCircle(center: CLLocationCoordinate2DMake(34.23, 113.112), radius: 500)
//        map.add(circle)
        var coor = Array<CLLocationCoordinate2D>()
        for i in 0..<5{
            let po = CLLocationCoordinate2DMake(33.23+Double(i)*0.01, 113.112+Double((i%2==0) ? 0.01 : -0.01))
            coor.append(po)
        }
        coor.append(CLLocationCoordinate2DMake(33.23, 113.112))
        let gon = MKPolygon(coordinates: coor, count: 6)
        map.add(gon)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let view  = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
//        view.pinTintColor = UIColor.purple
//        return view
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "id")
        view.image = UIImage(named: "image")
        //设置开启详情视图
        view.canShowCallout = true
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view1.backgroundColor = UIColor.red
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view2.backgroundColor = UIColor.blue
        view.leftCalloutAccessoryView = view1
        view.rightCalloutAccessoryView = view2
        //设置拖拽
        view.isDraggable = true
        return view
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        //折线覆盖物提供类
//        let render = MKPolylineRenderer(polyline: overlay as! MKPolyline)
//        //设置线宽
//        render.lineWidth = 3
//        //设置颜色
//        render.strokeColor = UIColor.red
//        return render
//        let render = MKCircleRenderer(overlay: overlay)
//        render.lineWidth = 3
//        //填充颜色
//        render.fillColor = UIColor.green
//        render.strokeColor = UIColor.red
//        return render
        let render = MKPolygonRenderer(overlay: overlay)
        render.lineWidth = 3
        render.strokeColor = UIColor.red
        return render
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

