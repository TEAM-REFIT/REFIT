//
//  NetworkCheckExtension.swift
//  REFIT
//
//  Created by 김동윤 on 2023/03/30.
//

import Foundation
import Network
import UIKit

final class NetworkCheck {
    static let shared = NetworkCheck()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    /// 네트워크 오류 custom alert가 표시되었는지에 대한 여부
    /// network alert의 중복을 방지하기 위함
    private var networkAlertViewIsVisible = false
    
    // 연결타입
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    // monotior 초기화
    private init() {
        monitor = NWPathMonitor()
    }
    
    // Network Monitoring 시작
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            if self?.isConnected == true {
                // 연결 되었을 때
            } else {
                // 연결 되지 않았을 때
                self?.showNetworkVCOnRoot()
            }
        }
    }
    
    // Network Monitoring 종료
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    // Network 연결 타입
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    private func showNetworkVCOnRoot() {
        DispatchQueue.main.async {
            
            if NetworkCheck.shared.networkAlertViewIsVisible == true { return }
            
            if let vc = UIApplication.shared.keyWindow?.visibleViewController as? UIViewController {
                let alertController = UIAlertController(
                    title: "네트워크에 접속할 수 없습니다.",
                    message: "네트워크 연결 상태를 확인해주세요.",
                    preferredStyle: .alert
                )
                
                let retryAction = UIAlertAction(title: "재시도", style: .default) { _ in
                    NetworkCheck.shared.networkAlertViewIsVisible = false
                    NetworkCheck.shared.startMonitoring()
                }
                
                let endAction = UIAlertAction(title: "앱 종료", style: .destructive) { _ in
                    // 앱 종료
                    NetworkCheck.shared.stopMonitoring()
                    
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
                
                alertController.addAction(endAction)
                alertController.addAction(retryAction)
                vc.present(alertController, animated: true)
                NetworkCheck.shared.networkAlertViewIsVisible = true
            }
            
        }
    }
}
