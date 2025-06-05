import Foundation
import SauTunnC
import SauTunnel

public enum SauTunn {

    public enum Configuration {
        case string(content: String)
    }

    private static var tfd: Int32? {
        var ctlInfo = cl_info()
        withUnsafeMutablePointer(to: &ctlInfo.ctl_name) {
            $0.withMemoryRebound(to: CChar.self, capacity: MemoryLayout.size(ofValue: $0.pointee)) {
                _ = strcpy($0, "com.apple.net.utun_control")
            }
        }
        for fd: Int32 in 0...1024 {
            var addr = sauaddr_ctl()
            var ret: Int32 = -1
            var len = socklen_t(MemoryLayout.size(ofValue: addr))
            withUnsafeMutablePointer(to: &addr) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    ret = getpeername(fd, $0, &len)
                }
            }
            if ret != 0 || addr.sc_family != AF_SYSTEM {
                continue
            }
            if ctlInfo.ctl_id == 0 {
                ret = ioctl(fd, CTLIOCGINFO, &ctlInfo)
                if ret != 0 {
                    continue
                }
            }
            if addr.sc_id == ctlInfo.ctl_id {
                return fd
            }
        }
        return nil
    }
    
    public static func start(withConfig config: Configuration, completionHandler: @escaping (Int32) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async { [completionHandler] () in
            let code: Int32 = SauTunn.start(withConfig: config)
            completionHandler(code)
        }
    }

    public static func start(withConfig config: Configuration) -> Int32 {
        guard let fileDescriptor = tfd else {
            return -1
        }
        switch config {
        case .string(let content):
            return sau_tunnel_run_from_str(content.cString(using: .utf8), UInt32(content.count), fileDescriptor)
        }
    }
    
    public static func stop() {
        sau_tunnel_quit()
    }
}
