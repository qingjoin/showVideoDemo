//
//  ViewController.h
//  ShowVideoDemo
//
//  Created by qingyun on 3/25/14.
//  Copyright (c) 2014 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DrawView.h"
#import "ScreenRecorder.h"

#define MainFrame [[UIScreen mainScreen] applicationFrame]
#define MainFrameLandscape CGRectMake(0.0f, 0.0f, MainFrame.size.height, MainFrame.size.width)
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]
#define VideoPath [DOCSFOLDER stringByAppendingPathComponent:@"test.mp4"]


//#define DOCSFOLDER   NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//#define VideoPath [DOCSFOLDER stringByAppendingPathComponent:@"test.mp4"]

@interface ViewController : UIViewController
{
     ScreenRecorder *myScreenRecorder;
    UIWebView *movieShow;
    
    
    
    
    
    
    UIButton *moveBtn;
}

@end
