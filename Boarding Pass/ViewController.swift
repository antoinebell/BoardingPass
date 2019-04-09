//
//  ViewController.swift
//  Boarding Pass
//
//  Created by Antoine Bellanger on 08.04.19.
//  Copyright © 2019 Antoine Bellanger. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //MARK: PDF417 Properties
    @IBOutlet var codeFrameView: UIView!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var pdf417FrameView: UIView!
    
    //MARK: BoardingPass
    var boardingPass: BoardingPass!
    
    //MARK: UI
    @IBOutlet var boardingPassButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardingPassButton.alpha = 0
        
        prepareForScan()
    }
    
    //MARK: - Scanning
    
    func prepareForScan() {
        
        if (AVCaptureDevice.authorizationStatus(for: AVMediaType.video) != AVAuthorizationStatus.authorized) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { response in
                if response {
                    self.startScan()
                }
            })
        } else {
            startScan()
        }
    }

    //MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            pdf417FrameView.frame = CGRect.zero
            print("No code detected")
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.pdf417 {
            let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            pdf417FrameView.frame = (barcodeObject?.bounds)!
            
            if metadataObj.stringValue != nil {
                
                let metadata = metadataObj.stringValue
                
                do {
                    boardingPass = try BoardingPass(from: metadata!)
                    dump(boardingPass)
                    
                    DispatchQueue.main.async {
                        self.boardingPassButton.alpha = 1
                    }
                    
                } catch {
                    print(error)
                }
                return
            }
        }
    }
    
    //MARK: - Scan
    
    func startScan() {
        
        let captureDevice = AVCaptureDevice.default(for: .video)!
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.pdf417]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = codeFrameView.layer.bounds
            codeFrameView.layer.addSublayer(videoPreviewLayer!)
            
            pdf417FrameView = UIView()
            
            if let pdf417FrameView = pdf417FrameView {
                pdf417FrameView.layer.borderColor = UIColor(red: 79/255, green: 159/255, blue: 249/255, alpha: 1).cgColor
                pdf417FrameView.layer.borderWidth = 2
                codeFrameView.addSubview(pdf417FrameView)
                codeFrameView.bringSubviewToFront(pdf417FrameView)
            }
            
            captureSession?.startRunning()
        } catch {
            print(error)
            return
        }
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let destVC = segue.destination as! BoardingPassTableViewController
            destVC.boardingPass = boardingPass
        }
    }

}

