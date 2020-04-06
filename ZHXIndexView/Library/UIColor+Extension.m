//
//  UIColor+Extension.m
//  Ticket
//
//  Created by Bob on 16/7/8.
//  Copyright © 2016年 Arron Zhang. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithString:(NSString *)string{
    if ([string isKindOfClass:[NSString class]]) {
        string = [string stringByReplacingOccurrencesOfString:@"'" withString:@""];
        if ([string rangeOfString:@"#"].location==0) {
            const char *s = [string cStringUsingEncoding:NSASCIIStringEncoding];
            if (*s == '#') {
                ++s;
            }
            unsigned long long value = strtoll(s, nil, 16);
            int r, g, b, a;
            switch (strlen(s)) {
                case 2:
                    // xx
                    r = g = b = (int)value;
                    a = 255;
                    break;
                case 3:
                    // RGB
                    r = ((value & 0xf00) >> 8);
                    g = ((value & 0x0f0) >> 4);
                    b = ((value & 0x00f) >> 0);
                    r = r * 16 + r;
                    g = g * 16 + g;
                    b = b * 16 + b;
                    a = 255;
                    break;
                case 6:
                    // RRGGBB
                    r = (value & 0xff0000) >> 16;
                    g = (value & 0x00ff00) >>  8;
                    b = (value & 0x0000ff) >>  0;
                    a = 255;
                    break;
                default:
                    // RRGGBBAA
                    r = (value & 0xff000000) >> 24;
                    g = (value & 0x00ff0000) >> 16;
                    b = (value & 0x0000ff00) >>  8;
                    a = (value & 0x000000ff) >>  0;
                    break;
            }
            return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
        }
        else
        {
            if ([string isEqualToString:@"clear"]) {
                return [UIColor clearColor];
            }
            if ([string isEqualToString:@"black"]) {
                return [UIColor blackColor];
            }
            if ([string isEqualToString:@"darkGray"]) {
                return [UIColor darkGrayColor];
            }
            if ([string isEqualToString:@"lightGray"]) {
                return [UIColor lightGrayColor];
            }
            if ([string isEqualToString:@"white"]) {
                return [UIColor whiteColor];
            }
            if ([string isEqualToString:@"gray"]) {
                return [UIColor grayColor];
            }
            if ([string isEqualToString:@"red"]) {
                return [UIColor redColor];
            }
            if ([string isEqualToString:@"green"]) {
                return [UIColor greenColor];
            }
            if ([string isEqualToString:@"blue"]) {
                return [UIColor blueColor];
            }
            if ([string isEqualToString:@"cyan"]) {
                return [UIColor cyanColor];
            }
            if ([string isEqualToString:@"yellow"]) {
                return [UIColor yellowColor];
            }
            if ([string isEqualToString:@"magenta"]) {
                return [UIColor magentaColor];
            }
            if ([string isEqualToString:@"orange"]) {
                return [UIColor orangeColor];
            }
            if ([string isEqualToString:@"purple"]) {
                return [UIColor purpleColor];
            }
            if ([string isEqualToString:@"brown"]) {
                return [UIColor brownColor];
            }
            return nil;
        }
    } else if([string isKindOfClass:[UIColor class]]){
        return (UIColor *)string;
    }
    return nil;
}


@end
