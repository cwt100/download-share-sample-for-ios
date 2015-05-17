//
//  DownloadFileObject.m
//  DownloadFile
//
//  Created by Cherry_Cheng on 2015/5/17.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import "DownloadFileObject.h"

@implementation DownloadFileObject

- (void)downloadFileWithFileURL:(NSURL *)fileURL {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [self.delegate downloadFileObject:self didDownloadFileWithLocalFilePath:filePath error:error];
    }];
    [downloadTask resume];
}

@end
