//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by test on 12/16/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextData.h"
#import "CoreTextImageData.h"
@import CoreText;
@interface CTDisplayView ()<UIGestureRecognizerDelegate>

@end
@implementation CTDisplayView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self setUpEvents];
    }
    return self;
}

- (void)setUpEvents
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapGRDetected:)];
    tapGR.delegate = self;
    [self addGestureRecognizer:tapGR];
    self.userInteractionEnabled = YES;
}

- (void)userTapGRDetected:(UITapGestureRecognizer *)tapGR
{
    CGPoint point = [tapGR locationInView:self];
    for (CoreTextImageData *imageData in self.data.imageArray) {
        CGRect imageRect = imageData.imagePostion;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height-imageRect.origin.y-imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        if(CGRectContainsPoint(rect, point)) {
            NSLog(@"bingo");
            break;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //翻转坐标系
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //
    if(self.data) {
        CTFrameDraw(self.data.ctFrame, context);
        [self.data.imageArray enumerateObjectsUsingBlock:^(CoreTextImageData *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[UIImage imageNamed:obj.name] drawInRect:obj.imagePostion];
        }];
    }
}


@end
