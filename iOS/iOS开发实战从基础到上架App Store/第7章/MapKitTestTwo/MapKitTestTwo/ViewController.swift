//
//  ViewController.swift
//  MapKitTestTwo
//
//  Created by vip on 17/3/9.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController,MKMapViewDelegate {
    private var mapView:MKMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView(frame: self.view.frame)
        mapView?.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.26, 116.3), MKCoordinateSpanMake(5, 5))
        mapView?.delegate = self
        mapView?.mapType = .standard
        self.view.addSubview(mapView!)
        
        //导航设置
        let fromcoor = CLLocationCoordinate2DMake(39.26, 116.3)
        let tocoor = CLLocationCoordinate2DMake(33.33, 113.33)
        //创建出发点和目的点的信息
        let fromPlace = MKPlacemark(coordinate: fromcoor)
        let toPlace = MKPlacemark(coordinate: tocoor)
        //创建触发节点和目的节点
        let formItem = MKMapItem(placemark: fromPlace)
        let toItem = MKMapItem(placemark: toPlace)
        //创建一个位置信息对象，第一个参数为经纬度 第二个参数为纬度检索范围单位为米，第三个参数为经度检索范围单位为米
        let region = MKCoordinateRegionMakeWithDistance(tocoor, 5000, 5000)
        //初始化一个检索请求对象
        let req = MKLocalSearchRequest()
        //设置检索参数
        req.region = region
        //兴趣关键字
        req.naturalLanguageQuery = "school"
        //初始化检索
        let ser = MKLocalSearch(request: req)
        //开始检索
        ser.start { (response, error) in
            //兴趣节点数组
            let array = response!.mapItems
            for item in array {
                let point = MKPointAnnotation()
                point.title = item.name
                point.subtitle = item.phoneNumber
                point.coordinate = item.placemark.coordinate
                self.mapView?.addAnnotation(point)
            }
        }
        //初始化导航搜索请求
        let request = MKDirectionsRequest()
        request.source = formItem
        request.destination = toItem
        request.requestsAlternateRoutes = true
        //初始化请求检索
        let directions = MKDirections(request: request)
        //开始检索 结果会返回在回调中
        directions.calculate { (response, error) in
            if error != nil {
                print(error!)
            }else{
                //提取导航线路结果中的一条线路
                let route = response!.routes[0]
                //将线路中每一步节点提取出来
                let stepArray = route.steps
                //进行遍历
                for step in stepArray {
                    //添加大头针
                    let point = MKPointAnnotation()
                    point.coordinate = step.polyline.coordinate
                    point.title = step.instructions
                    point.subtitle = step.notice
                    self.mapView?.addAnnotation(point)
                    //进行画线
                    self.mapView?.add(step.polyline)
                }
            }
        }
        
       
    }
    //地图覆盖物
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.red
        render.lineWidth = 4.0
        return render
    }
    //标注
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        view.canShowCallout = true
        return view
    }
}

