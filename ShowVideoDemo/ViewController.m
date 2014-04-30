//
//  ViewController.m
//  ShowVideoDemo
//
//  Created by qingyun on 3/25/14.
//  Copyright (c) 2014 qingyun. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBegin];
    [self createView];
    
    //[self testMove];  //移动按钮
//    CGRect dFram  = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 60);
//    DrawView *brawView = [[DrawView alloc]initWithFrame:dFram];
//    [self.view addSubview:brawView];
//    
//     movieShow = [[UIWebView alloc] initWithFrame:dFram];
//
    //[self testCompressionSession];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)createBegin
{
    CGRect dFram  = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 60);
    DrawView *brawView = [[DrawView alloc]initWithFrame:dFram];
    [self.view addSubview:brawView];
    movieShow = [[UIWebView alloc] initWithFrame:dFram];
}

-(void)recoderBtnPress
{
    
    
    myScreenRecorder = [[ScreenRecorder alloc] init];
    myScreenRecorder.ParentID = self;
    [myScreenRecorder readyGo:self.view];
    [myScreenRecorder startRecord:VideoPath];
    
    movieShow.hidden = YES;
    //[self performSelector:@selector(delayStop) withObject:nil afterDelay:10.0f];
    //[self performSelector:@selector(recordCompleted) withObject:nil afterDelay:11.0f];
    //[movieShow setBackgroundColor:[UIColor redColor]];
    //[self.view addSubview:myDrawView];
    
    NSLog(@"recoder");
}

-(void)showBtnPress
{
    NSLog(@"recoder");
}


-(void)delayStop
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [myScreenRecorder performSelectorOnMainThread:@selector(stopRecord) withObject:nil waitUntilDone:YES];
    });
}

-(void)recordCompleted
{
    movieShow.hidden = NO;
    
    NSLog(@"completed");
    [self.view addSubview:movieShow];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[VideoPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSLog(@"requestffJ:%@",VideoPath);
    [movieShow loadRequest:request];
}


-(void)createView
{
    UIButton *recorderBtn = [[UIButton alloc]init];
    recorderBtn.frame = CGRectMake(20, 20, 80, 40);
    [recorderBtn addTarget:self action:@selector(recoderBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [recorderBtn setImage:[UIImage imageNamed:@"btnPress.png"] forState:UIControlStateNormal];
    [recorderBtn setImage:[UIImage imageNamed:@"btnPressed.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:recorderBtn];
    
    UILabel *recoderLabel = [[UILabel alloc]init];
    recoderLabel.backgroundColor = [UIColor clearColor];
    recoderLabel.textColor = [UIColor whiteColor];
    recoderLabel.frame = CGRectMake(0,0, 80, 40);
    recoderLabel.text = @"recoder";
    recoderLabel.textAlignment = UITextAlignmentCenter;
    recoderLabel.font = [UIFont systemFontOfSize:13];
    [recorderBtn addSubview:recoderLabel];
    
    
    UIButton *showBtn = [[UIButton alloc]init];
    showBtn.frame = CGRectMake(120, 20, 80, 40);
    [showBtn addTarget:self action:@selector(recordCompleted) forControlEvents:UIControlEventTouchUpInside];
    [showBtn setImage:[UIImage imageNamed:@"btnPress.png"] forState:UIControlStateNormal];
    [showBtn setImage:[UIImage imageNamed:@"btnPressed.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:showBtn];
    
    UILabel *showLabel = [[UILabel alloc]init];
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.textColor = [UIColor whiteColor];
    showLabel.frame = CGRectMake(0,0, 80, 40);;;
    showLabel.text = @"show";
    showLabel.textAlignment =  UITextAlignmentCenter;
    showLabel.font = [UIFont systemFontOfSize:13];
    [showBtn addSubview:showLabel];
    
    UIButton *stopBtn = [[UIButton alloc]init];
    stopBtn.frame = CGRectMake(220, 20, 80, 40);
    [stopBtn addTarget:self action:@selector(delayStop) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn setImage:[UIImage imageNamed:@"btnPress.png"] forState:UIControlStateNormal];
    [stopBtn setImage:[UIImage imageNamed:@"btnPressed.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:stopBtn];
    
    UILabel *stopLabel = [[UILabel alloc]init];
    stopLabel.backgroundColor = [UIColor clearColor];
    stopLabel.textColor = [UIColor whiteColor];
    stopLabel.frame = CGRectMake(0,0, 80, 40);;;
    stopLabel.text = @"stop";
    stopLabel.textAlignment =  UITextAlignmentCenter;
    stopLabel.font = [UIFont systemFontOfSize:13];
    [stopBtn addSubview:stopLabel];

}



-(void)testMove
{
    moveBtn = [[UIButton alloc ]init];
    moveBtn.frame = CGRectMake(0, 30, 60, 60);
    moveBtn.backgroundColor = [UIColor redColor];
    //[moveBtn addTarget:self action:@selector(moveBtn) forControlEvents:UIControlEventTouchDown];
    //[moveBtn addTarget:self action:@selector(moveBtnEnd) forControlEvents:UIControlEventTouchUpInside];
    
    [moveBtn addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
    [moveBtn addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moveBtn];
}

- (void) dragMoving: (UIButton *)btn withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    CGFloat btnx = btn.frame.size.width/2;
    CGFloat btny = btn.frame.size.height/2;
    
    if(x<=btnx)
    {
        point.x = btnx;
    }
    if(x >= self.view.bounds.size.width - btnx)
    {
        point.x = self.view.bounds.size.width - btnx;
    }
    
    NSLog(@"fs:%f %f",x, btnx);
    btn.center = point;
    NSLog(@"%f,,,%f",btn.center.x,btn.center.y);
}

-(void)doClick:(UIButton*)sender
{
   NSLog(@"1111");
}
/*
-(void)moveBtn
{
    isMove = YES;
    NSLog(@"moveBtn");
}

-(void)moveBtnEnd
{
    isMove = NO;
    NSLog(@"moveEnd");
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =  [touches anyObject];
    moveLocation = [touch locationInView:[touch view]];
    
    //NSLog(@"%f  %f",moveLocation.x ,moveLocation.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch =  [touches anyObject];
    moveLocation = [touch locationInView:[touch view]];
    if(isMove)
    {
        moveBtn.frame = CGRectMake(moveLocation.x, moveLocation.y, 30, 30);
    }
    NSLog(@"%f  %f",moveLocation.x ,moveLocation.y);
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
 */
/*
- (void) testCompressionSession
{
    CGSize size = CGSizeMake(480, 320);
    
    NSString *betaCompressionDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    
    NSError *error = nil;
    
    unlink([betaCompressionDirectory UTF8String]);
    
    //----initialize compression engine
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:betaCompressionDirectory]
                                                           fileType:AVFileTypeQuickTimeMovie
                                                              error:&error];
    NSParameterAssert(videoWriter);
    if(error)
        NSLog(@"error = %@", [error localizedDescription]);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:size.height], AVVideoHeightKey, nil];
    AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput
                                                                                                                     sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    NSParameterAssert(writerInput);
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    
    if ([videoWriter canAddInput:writerInput])
        NSLog(@"I can add this input");
    else
        NSLog(@"i can't add this input");
    
    [videoWriter addInput:writerInput];
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    //---
    // insert demo debugging code to write the same image repeated as a movie
    
    CGImageRef theImage = [[UIImage imageNamed:@"btnPress.png"] CGImage];
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("mediaInputQueue", NULL);
    int __block frame = 0;
    
    [writerInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        while ([writerInput isReadyForMoreMediaData])
        {
            if(++frame >= 120)
            {
                [writerInput markAsFinished];
                //[videoWriter finishWriting];
                [videoWriter finishWritingWithCompletionHandler:^{
                }];
                //[videoWriter release];
                break;
            }
            
            CVPixelBufferRef buffer = (CVPixelBufferRef)[self pixelBufferFromCGImage:theImage size:size];
            if (buffer)
            {
                if(![adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(frame, 20)])
                    NSLog(@"FAIL");
                else
                    NSLog(@"Success:%d", frame);
                CFRelease(buffer);
            }
        }
    }];
    
    NSLog(@"outside for loop");
    
}

- (CVPixelBufferRef )pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey, nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, size.width, size.height, kCVPixelFormatType_32ARGB, (__bridge  CFDictionaryRef) options, &pxbuffer);
    // CVReturn status = CVPixelBufferPoolCreatePixelBuffer(NULL, adaptor.pixelBufferPool, &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width, size.height, 8, 4*size.width, rgbColorSpace, 2);//kCGImageAlphaPremultipliedFirst
    NSParameterAssert(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image), CGImageGetHeight(image)), image);
    
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
