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

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let barcodeData = metadataObjects.first{
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject
            if let readableCode = barcodeReadable{
                let alertView = SCLAlertView()
                alertView.showInfo("扫描成功", subTitle: readableCode.stringValue!)
            }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            session?.stopRunning()
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func scanningNotPossible(){
        let alertView = SCLAlertView()
        alertView.showError("无法扫描", subTitle: "设备没有摄像头", closeButtonTitle: "好的")
        session = nil
    }
}
