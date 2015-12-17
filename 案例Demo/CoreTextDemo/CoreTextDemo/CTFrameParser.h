//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by test on 12/17/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoreTextData, CTFrameParserConfig;
@interface CTFrameParser : NSObject
+ (CoreTextData *)parseContext:(NSString *)content config:(CTFrameParserConfig *)config;
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config;
@end
