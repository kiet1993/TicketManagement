//
//  HNHHEQVisualizer.m
//  HNHH
//
//  Created by Dobango on 9/17/13.
//  Copyright (c) 2013 RC. All rights reserved.
//

#import "PCSEQVisualizer.h"
#import "UIImage+Color.h"

#define kWidth 3
#define kHeight 16
#define kPadding 1

@interface PCSEQVisualizer ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *barArray;
@property (nonatomic, assign) NSInteger numberOfBars;

@end

@implementation PCSEQVisualizer

- (id)initWithNumberOfBars:(int)numberOfBars barColor: (UIColor *)barColor {
    self = [super init];
    if (self) {
        self.numberOfBars = numberOfBars;
        self.barColor = barColor;
        self.frame = CGRectMake(0, 0, kPadding*numberOfBars+(kWidth*numberOfBars), kHeight);
        NSMutableArray* tempBarArray = [[NSMutableArray alloc]initWithCapacity:numberOfBars];
        for(int i=0;i<numberOfBars;i++) {
            UIImageView* bar = [[UIImageView alloc]initWithFrame:CGRectMake(i*kWidth+i*kPadding, 0, kWidth, 1)];
            bar.image = [UIImage imageWithColor:self.barColor];
            [self addSubview:bar];
            [tempBarArray addObject:bar];
        }
        self.barArray = [[NSArray alloc]initWithArray:tempBarArray];
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2*2);
        self.transform = transform;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stop) name:@"stopTimer" object:nil];
    }
    return self;
}

- (void)start {
    [self stop];
    self.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(ticker) userInfo:nil repeats:YES];
    [NSRunLoop.mainRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)ticker {
    [UIView animateWithDuration:.3 animations:^{
        for(UIImageView* bar in self.barArray) {
            CGRect rect = bar.frame;
            rect.size.height = arc4random() % kHeight + 1;
            bar.frame = rect;
        }
    }];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(kPadding*self.numberOfBars+(kWidth*self.numberOfBars), kHeight);
}

@end
