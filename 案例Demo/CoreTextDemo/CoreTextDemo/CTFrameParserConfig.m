//
//  CTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by test on 12/17/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig
- (instancetype)init
{
    if(self = [super init]) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1];
    }
    return self;
}
@end
