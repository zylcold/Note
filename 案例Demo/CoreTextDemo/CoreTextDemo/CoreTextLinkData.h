//
//  CoreTextLinkData.h
//  CoreTextDemo
//
//  Created by test on 12/18/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, assign) NSRange range;
@end
