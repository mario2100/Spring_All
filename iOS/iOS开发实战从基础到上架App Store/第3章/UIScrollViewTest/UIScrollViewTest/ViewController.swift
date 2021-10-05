//
//  ViewController.swift
//  UIScrollViewTest
//
//  Created by vip on 16/12/26.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView(frame: self.view.frame)
        let imageView = UIImageView(frame: CGRect(x: 40, y: 50, width: 240, height: 400))
        imageView.image = UIImage(named: "image")
        scrollView.addSubview(imageView)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width*2, height: self.view.frame.size.height*2)
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal=true
        scrollView.alwaysBounceVertical = true
        scrollView.isPagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=true
        scrollView.showsVerticalScrollIndicator=true
        scrollView.indicatorStyle = .black
        scrollView.scrollsToTop=true
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2.0
        scrollView.bouncesZoom = true

    }
    //滚动视图是否支持点击状态栏滚动回顶部
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    //滚动视图已经滚动到顶端时触发的方法
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
    //滚动视图将要开始拖拽时触发的方法
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    //滚动视图拖拽将要完成时触发的方法
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    //滚动视图将要减速时触发的方法
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    //滚动视图减速完成时触发的方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    //滚动视图将要开始缩放时触发的方法
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
    }
    //滚动视图缩放过程中触发的方法
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
    //滚动视图拖拽结束时触发的方法
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    //滚动视图缩放结束时触发的方法
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
    //滚动视图滚动动画结束时触发的方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    //滚动视图滚动过程中触发的方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    //设置可以进行缩放操作的子视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

