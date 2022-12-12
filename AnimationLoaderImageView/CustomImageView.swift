//
//  CustomImageView.swift
//  AnimationLoaderImageView
//
//  Created by Vadlet on 12.12.2022.
//

import UIKit

class CustomImageView: UIImageView {
    
    let progressIndecatorView = CircularLoaderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        progressIndecatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(progressIndecatorView)
        NSLayoutConstraint.activate([
            progressIndecatorView.widthAnchor.constraint(equalTo: widthAnchor),
            progressIndecatorView.heightAnchor.constraint(equalTo: heightAnchor),
            progressIndecatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressIndecatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        ])
        
        let urlString = "https://s1.1zoom.ru/big3/753/371608-svetik.jpg"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        session.downloadTask(with: url)
            .resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomImageView: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let data = try? Data(contentsOf: location) else { return }
        let image = UIImage(data: data)
        DispatchQueue.main.async {
            self.image = image
            self.progressIndecatorView.reveal()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = totalBytesWritten / totalBytesExpectedToWrite
        DispatchQueue.main.async {
            self.progressIndecatorView.progress = CGFloat(progress)
        }
    }
    
    
}
