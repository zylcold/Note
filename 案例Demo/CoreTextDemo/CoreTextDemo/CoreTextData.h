//
//  CoreTextData.h
//  CoreTextDemo
//
//  Created by test on 12/17/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreText;
@interface CoreTextData : NSObject
@property(nonatomic, assign) CTFrameRef ctFrame;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, strong) NSArray *imageArray;
@property(nonatomic, copy) NSArray *linkArray;

@end
