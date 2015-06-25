//
//  DownloadFileObject.h
//  DownloadFile
//
//  Created by Cherry_Cheng on 2015/5/17.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol DownloadFileObjectDelegate;

@interface DownloadFileObject : NSObject

@property (nonatomic, strong) id<DownloadFileObjectDelegate> delegate;

/**
 * @brief Download file.
 * @param fileURL The value of NSURL, ex: @"http://192.168.1.254/CAM/PHOTO/123.JPG".
 */
- (NSURLSessionDownloadTask *)downloadFileWithFileURL:(NSURL *)fileURL;

@end

@protocol DownloadFileObjectDelegate <NSObject>

@optional
/**
 * @brief Did download file Delegate.
 * @param downloadFileObject The value of DownloadFileObject.
 * @param localFilePath The value of NSURL, document path.
 * @param error The value of NSError.
 */
- (void)downloadFileObject:(DownloadFileObject *)downloadFileObject didDownloadFileWithLocalFilePath:(NSURL *)localFilePath error:(NSError *)error;

@end
