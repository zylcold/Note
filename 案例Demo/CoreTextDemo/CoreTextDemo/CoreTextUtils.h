//
//  Util.h
//  CoreTextDemo
//
//  Created by test on 12/18/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class CoreTextData, CoreTextLinkData;
@interface CoreTextUtils : NSObject
+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;
@end
