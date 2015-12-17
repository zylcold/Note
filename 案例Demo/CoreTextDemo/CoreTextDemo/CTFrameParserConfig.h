//
//  CTFrameParserConfig.h
//  CoreTextDemo
//
//  Created by test on 12/17/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface CTFrameParserConfig : NSObject
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat fontSize;
@property(nonatomic, assign) CGFloat lineSpace;
@property(nonatomic, strong) UIColor *textColor;
@end
