//
//  OXTouchTextView.m
//  RACTest
//
//  Created by obally on 2017/8/15.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OXTouchTextView.h"

@implementation OXTouchTextView
- (void)texta
{
    NSLog(@"-------textViewTest");
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //No.1
    //开始写代码,触摸操作开始时,获取当前触摸位置的字符所属的单词。并用UIAlertView显示出来(提示：触摸位置需向下调整10个点，以便与文本元素对齐)
    //开始写代码,触摸操作开始时,获取当前触摸位置的字符所属的单词。并用UIAlertView显示出来(提示：触摸位置需向下调整10个点，以便与文本元素对齐)
    UITouch *touch =[touches anyObject];
    CGPoint touchPoint =[touch locationInView:self];
    
    
    NSInteger characterIndex = [self.layoutManager characterIndexForPoint:touchPoint inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
    if (characterIndex<self.text.length) {
        NSString *s=[self.text substringWithRange:NSMakeRange(characterIndex, 1)];
        NSLog(@"%@",s);
        [self showAlert:s];
    }
    
    
    //end_code
    [super touchesBegan: touches withEvent: event];
}

- (void)showAlert:(NSString *)selectedWord {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你所选的单词是" message:selectedWord delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


@end
