//
//  ViewController.m
//  DownloadFile
//
//  Created by Cherry_Cheng on 2015/5/17.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import "ViewController.h"
#import "DownloadFileObject.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface ViewController () <DownloadFileObjectDelegate>

@end

@implementation ViewController {
    DownloadFileObject *downloadFileObject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    downloadFileObject = [[DownloadFileObject alloc] init];
    downloadFileObject.delegate = self;
    
    [self.downloadButton addTarget:self
                            action:@selector(startDownload:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    [self initDownloadProgressView];
}

- (void)initDownloadProgressView {
    
    [self.downloadProgressView setHidden:YES];
    [self.downloadProgressView setProgress:0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Download
- (void)startDownload:(id)sender {
    
    NSLog(@"Start download");
    NSURL *URL = [NSURL URLWithString:@"http://jgospel.net/media/35878/.118134.bt.jpg"];//Input your File URL.
    NSURLSessionDownloadTask *downloadTask = [downloadFileObject downloadFileWithFileURL:URL];
    [self.downloadProgressView setHidden:NO];
    [self.downloadProgressView setProgressWithDownloadProgressOfTask:downloadTask animated:YES];
}

- (void)downloadFileObject:(DownloadFileObject *)downloadFileObject didDownloadFileWithLocalFilePath:(NSURL *)localFilePath error:(NSError *)error {
    
    if (error == nil) {
        NSLog(@"Download file success");
        [self initDownloadProgressView];
        [self shareWithFilePath:localFilePath];
    }else {
        NSLog(@"Download file error: %@", error);
    }
}

#pragma mark - Share
- (void)shareWithFilePath:(NSURL *)filePath {
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:filePath] applicationActivities:nil];
    
    //Setup not support item.
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypeMessage, UIActivityTypeMail];
    
    [activityViewController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        
        if (activityError == nil) {
            NSLog(@"Share file is success");
        }else {
            NSLog(@"Share file is error: %@", activityError);
        }
    }];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)shareImageWithFileUrl:(NSURL *)fileUrl {
    
    
}

@end
