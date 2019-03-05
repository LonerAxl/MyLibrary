//
//  ScanViewController.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/5.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import AVFoundation
import SCLAlertView

class ScanViewController: ViewController, AVCaptureMetadataOutputObjectsDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var session : AVCaptureSession?
    var preview : AVCaptureVideoPreviewLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        session = AVCaptureSession()
        let videoCaptureDevice = AVCaptureDevice.default(for: .video)
        let videoInput : AVCaptureDeviceInput?
        do {
            videoInput = try AVCaptureDeviceInput.init(device: videoCaptureDevice!)
        }catch{
            print("camera error")
            return
        }
        if ((session?.canAddInput(videoInput!))!){
            session?.addInput(videoInput!)
        }else{
            scanningNotPossible()
        }
        
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if ((session?.canAddOutput(metadataOutput))!){
            session?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.ean13]
        }else{
            scanningNotPossible()
        }
        
        preview = AVCaptureVideoPreviewLayer.init(session: session!)
        preview.frame = view.layer.bounds
        preview.videoGravity = .resizeAspectFill
        metadataOutput.rectOfInterest = self.calculateScanRect()
        view.layer.addSublayer(preview)
        
        session?.startRunning()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!(session?.isRunning)!){
            session?.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if((session?.isRunning)!){
            session?.stopRunning()
        }
    }


    
    func calculateScanRect()->CGRect{
        let previewSize: CGSize = self.preview.frame.size
        let scanSize: CGSize = CGSize.init(width: previewSize.width * 3/4, height: previewSize.height * 3/4)
        var scanRect:CGRect = CGRect.init(x: (previewSize.width-scanSize.width)/2, y: (previewSize.height-scanSize.height)/2, width: scanSize.width, height: scanSize.height)
        // AVCapture输出的图片大小都是横着的，而iPhone的屏幕是竖着的，那么我把它旋转90°
        scanRect = CGRect.init(x: scanRect.origin.y/previewSize.height,
                               y: scanRect.origin.x/previewSize.width,
                               width: scanRect.size.height/previewSize.height,
                               height: scanRect.size.width/previewSize.width);
        return scanRect
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let barcodeData = metadataObjects.first{
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject
            if let readableCode = barcodeReadable{
                self.performSegue(withIdentifier: "ScanSegue", sender: readableCode)
//                let alertView = SCLAlertView()
//                alertView.showInfo("扫描成功", subTitle: readableCode.stringValue!)
            }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            session?.stopRunning()
        }
        
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ScanSegue"{
            let destVC = segue.destination as! ScanResultViewController
            destVC.isbn = (sender as! AVMetadataMachineReadableCodeObject).stringValue!
        }
    }
    

    func scanningNotPossible(){
        let alertView = SCLAlertView()
        alertView.showError("无法扫描", subTitle: "设备没有摄像头", closeButtonTitle: "好的")
        session = nil
    }
}
