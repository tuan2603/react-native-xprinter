

@objc(Xprinter)
class Xprinter: NSObject, POSWIFIManagerDelegate {
    
  let manager = POSWIFIManager.sharedInstance()
    
 var connectResolve: RCTPromiseResolveBlock?
 var connectReject: RCTPromiseRejectBlock?
    
  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve(a*b)
  }
    
    
    @objc(connect:withResolver:withRejecter:)
    func connect(ipAddress: String, resolve:@escaping RCTPromiseResolveBlock,reject:@escaping RCTPromiseRejectBlock) -> Void {

        connectResolve = resolve
        connectReject = reject
        
        if ((manager?.isConnect) != nil) {
            manager?.disconnect()
        }

        manager?.connect(withHost: ipAddress, port: 9100)
    }
    
    func poSwifiConnected(toHost host: String!, port: UInt16) {
        // Xử lý khi kết nối thành công
        print("Connected to host: \(String(describing: host)) on port: \(port)")
        connectResolve?(true)
    }
        
    func poSwifiDisconnectWithError(_ error: Error!) {
        // Xử lý khi kết nối bị ngắt
        if let error = error {
            print("Disconnected with error: \(error.localizedDescription)")
            connectReject?("Error occurred: \(error.localizedDescription)", nil, error)
        } else {
            print("Disconnected without error")
            connectResolve?(false)
        }
       
    }


}
