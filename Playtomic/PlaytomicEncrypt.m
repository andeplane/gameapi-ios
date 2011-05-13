//
//  PlaytomicEncrypt.m
//  ObjectiveCTest
//
//  Created by ben@playtomic.com on 2/25/11.
//  Copyright 2011 Playtomic LLC. All rights reserved.
//

#import "PlaytomicEncrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation PlaytomicEncrypt


// via http://stackoverflow.com/questions/1524604/md5-algorithm-in-objective-c

+ (NSString*) md5: (NSString*) string
{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
