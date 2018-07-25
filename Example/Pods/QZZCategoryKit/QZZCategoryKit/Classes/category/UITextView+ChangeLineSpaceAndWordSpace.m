//
//  UITextView+ChangeLineSpaceAndWordSpace.m
//  
//
//  Created by 秦忠增 on 2018/7/25.
//

#import "UITextView+ChangeLineSpaceAndWordSpace.h"

@implementation UITextView (ChangeLineSpaceAndWordSpace)

+ (void)changeLineSpace:(UITextView *)textView WithSpace:(float)space {
    
    NSString *labelText = textView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    textView.attributedText = attributedString;
    [textView sizeToFit];
    
}

+ (void)changeWordSpace:(UITextView *)textView WithSpace:(float)space {
    
    NSString *labelText = textView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    textView.attributedText = attributedString;
    [textView sizeToFit];
    
}

+ (void)changeSpace:(UITextView *)textView withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = textView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    textView.attributedText = attributedString;
    [textView sizeToFit];
    
}
+ (void)changeSpace:(UITextView *)textView withLineSpace:(float)lineSpace WordSpace:(float)wordSpace textAlignment:(NSTextAlignment)textAlignment{
    
    NSString *labelText = textView.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.alignment = textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    textView.attributedText = attributedString;
    [textView sizeToFit];
}
@end
