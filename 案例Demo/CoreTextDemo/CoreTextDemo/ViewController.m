//
//  ViewController.m
//  CoreTextDemo
//
//  Created by test on 12/16/15.
//  Copyright © 2015 com.asgardgame. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import "DemoDemo.h"
@interface ViewController ()
@property(nonatomic, weak) IBOutlet CTDisplayView *ctView;

@property(nonatomic, strong) NSArray *demoArray;

@property(nonatomic, strong) NSArray *origArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
//    config.textColor = [UIColor redColor];
//    config.width = self.ctView.frame.size.width;
//    CoreTextData *data = [CTFrameParser parseContext:@"Hellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllloo" config:config];
//    self.ctView.data = data;
//    [self.ctView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if(obj.firstAttribute == NSLayoutAttributeHeight) {
//            obj.constant = data.height;
//            [self.ctView layoutIfNeeded];
//            [self.ctView updateConstraints];
//        }
//    }];
//    self.ctView.backgroundColor = [UIColor yellowColor];

//    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
//    config.width = self.ctView.frame.size.width;
//    config.textColor = [UIColor blackColor];
//    NSString *content = @"Hellllllllllllellllllllllllel"
//                        "lllllllllllellllllllllllellllllllllllellllllllllllelll\n""\n\n"
//                        "lllllllllellllllllllllellllllllllllellllllllllllellllllllllllel\n"
//                        "lllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllloo";
//    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content attributes:attr];
//    [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
//    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString config:config];
//    self.ctView.data = data;
//    [self.ctView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if(obj.firstAttribute == NSLayoutAttributeHeight) {
//            obj.constant = data.height;
//            [self.ctView layoutIfNeeded];
//            [self.ctView updateConstraints];
//        }
//    }];
//    self.ctView.backgroundColor = [UIColor yellowColor];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.ctView.frame.size.width;
    CoreTextData *data = [CTFrameParser parseTemplateFile:[[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"] config:config];
    
    self.ctView.data = data;
    [self.ctView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.firstAttribute == NSLayoutAttributeHeight) {
            obj.constant = data.height;
            [self.ctView layoutIfNeeded];
            [self.ctView updateConstraints];
        }
    }];
    self.ctView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)buttonClick:(id)sender
{
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor yellowColor];
    config.width = self.ctView.frame.size.width;
    CoreTextData *data = [CTFrameParser parseContext:@"HellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllelllllllllllleHellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllHellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllellllllllllllelllloo" config:config];
    self.ctView.data = data;
    [self.ctView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.firstAttribute == NSLayoutAttributeHeight) {
            obj.constant = data.height;
            [self.ctView layoutIfNeeded];
            [self.ctView updateConstraints];
        }
    }];
    self.ctView.backgroundColor = [UIColor blackColor];
    [self.ctView setNeedsDisplay];
}

- (IBAction)resetButtonClick:(id)sender
{
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor yellowColor];
    config.width = self.ctView.frame.size.width;
    CoreTextData *data = [CTFrameParser parseContext:@"Helllllllllllle" config:config];
    self.ctView.data = data;
    [self.ctView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.firstAttribute == NSLayoutAttributeHeight) {
            obj.constant = data.height;
            [self.ctView layoutIfNeeded];
            [self.ctView updateConstraints];
        }
    }];
    self.ctView.backgroundColor = [UIColor blackColor];
    [self.ctView setNeedsDisplay];
}


@end
