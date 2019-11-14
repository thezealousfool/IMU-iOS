//
//  ViewController.swift
//  NavCogIMU
//
//  Created by Vivek Roy on 11/13/19.
//  Copyright © 2019 Vivek Roy. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var accX: UILabel!
    @IBOutlet weak var accY: UILabel!
    @IBOutlet weak var accZ: UILabel!
    @IBOutlet weak var gyroX: UILabel!
    @IBOutlet weak var gyroY: UILabel!
    @IBOutlet weak var gyroZ: UILabel!
    @IBOutlet weak var gravX: UILabel!
    @IBOutlet weak var gravY: UILabel!
    @IBOutlet weak var gravZ: UILabel!
    @IBOutlet weak var magX: UILabel!
    @IBOutlet weak var magY: UILabel!
    @IBOutlet weak var magZ: UILabel!
    
    let motion = CMMotionManager()
    let g = 9.8
    let updateInterval = 0.2
    
    func startAccHandler() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = updateInterval
            motion.startAccelerometerUpdates(to: OperationQueue.main) { (data: CMAccelerometerData?, e : Error?) in
                if let validData = data {
                    self.accX.text = NSString(format: "%5.2f", validData.acceleration.x*self.g) as String
                    self.accY.text = NSString(format: "%5.2f", validData.acceleration.y*self.g) as String
                    self.accZ.text = NSString(format: "%5.2f", validData.acceleration.z*self.g) as String
                }
            }
        }
    }
    
    func startGyroHandler() {
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = updateInterval
            motion.startGyroUpdates(to: OperationQueue.main) { (data: CMGyroData?, e : Error?) in
                if let validData = data {
                    self.gyroX.text = NSString(format: "%5.2f", validData.rotationRate.x) as String
                    self.gyroY.text = NSString(format: "%5.2f", validData.rotationRate.y) as String
                    self.gyroZ.text = NSString(format: "%5.2f", validData.rotationRate.z) as String
                }
            }
        }
    }
    
    func startMagHandler() {
        if motion.isMagnetometerAvailable {
            motion.magnetometerUpdateInterval = updateInterval
            motion.startMagnetometerUpdates(to: OperationQueue.main) { (data: CMMagnetometerData?, e: Error?) in
                if let validData = data {
                    self.magX.text = NSString(format: "%5.2f", validData.magneticField.x) as String
                    self.magY.text = NSString(format: "%5.2f", validData.magneticField.y) as String
                    self.magZ.text = NSString(format: "%5.2f", validData.magneticField.z) as String
                }
            }
        }
    }
    
    func startHandlers() {
        startGyroHandler()
        startAccHandler()
        startMagHandler()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startHandlers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        motion.stopGyroUpdates()
        motion.stopAccelerometerUpdates()
        motion.stopMagnetometerUpdates()
    }

}

