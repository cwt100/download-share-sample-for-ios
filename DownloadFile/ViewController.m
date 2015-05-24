//
//  ViewController.m
//  DownloadFile
//
//  Created by Cherry_Cheng on 2015/5/17.
//  Copyright (c) 2015年 cwt100. All rights reserved.
//

#import "ViewController.h"
#import "DownloadFileObject.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Download
- (void)startDownload:(id)sender {
    
    NSLog(@"Start download");
    NSURL *URL = [NSURL URLWithString:@"http://192.168.1.254/CAM/PHOTO/2015_0515_144623_001.JPG"];//Input your File URL.
    [downloadFileObject downloadFileWithFileURL:URL];
}

- (void)downloadFileObject:(DownloadFileObject *)downloadFileObject didDownloadFileWithLocalFilePath:(NSURL *)localFilePath error:(NSError *)error {
    
    if (error == nil) {
        NSLog(@"Download file success");
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

@end
