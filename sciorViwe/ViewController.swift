//
//  ViewController.swift
//  sciorViwe
//
//  Created by 田中章生 on 2016/01/20.
//  Copyright © 2016年 t_souta. All rights reserved.
//

import UIKit

/*
そーた改良版

ホーム画像とホラー画像をそれぞれimagePickerで拾ってこようとした
→　どっちのボタンを押してもホラー画像が変わってしまう

l30:picFlag で押されたボタンの判別
それによってl90〜　で条件分岐
*/

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate{
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    //ViewControllerにImageViewをOutlet接続
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imagevie: UIImageView!
    //Label宣言
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var picFlag=0

    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        let now = NSDate() // 現在日時の取得
        
        //デートフォーマットのインスタンスを作成
        let dateFormatterForTime = NSDateFormatter()
        dateFormatterForTime.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatterForTime.dateFormat = "HH:mm" // フォーマットの設定
        print(dateFormatterForTime.stringFromDate(now)) // -> 11:14
        //ラベルに時刻を表示
        timeLabel.text = String(dateFormatterForTime.stringFromDate(now))

        //時刻用デートフォーマットのインスタンスを作成
        let dateFormatterForDate = NSDateFormatter()
        dateFormatterForDate.locale = NSLocale(localeIdentifier: "ja_JP") // ロケールの設定
        dateFormatterForDate.dateFormat = "MM月dd" // 日付フォーマットの設定
        print(dateFormatterForDate.stringFromDate(now)) // -> 6月24日
        //ラベルに時刻を表示
        dateLabel.text = String(dateFormatterForDate.stringFromDate(now))

        //スクロールビューのフレーム設定
        scrollView.contentSize.width = 1125
        scrollView.contentOffset = CGPointMake(750, 0)
        
        //初期画面の位置を右端のホーム画面に設定
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //画面の位置を右端のホーム画面に設定
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }
    
    
    @IBAction func selectHomePict(sender: AnyObject) {
        
        let magePickerController:UIImagePickerController = UIImagePickerController()
        
        magePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        magePickerController.delegate = self
        
        picFlag = 1
        self.presentViewController(magePickerController, animated: true, completion: nil)
        
        print("home")
        
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }

    @IBAction func selectHorrorPict(sender: AnyObject) {
        
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        
        picFlag = 2
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        
        //ホーム画面を設定
        if picFlag==1{
            self.image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        }
        //ホラー画面を設定
        if picFlag==2{
            self.imagevie.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("finish")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("スクロール開始")
    }
        
}
