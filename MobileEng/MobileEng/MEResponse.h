//
//  MEResponse.h
//  MobileEng
//
//  Created by esther liu on 3/25/14.
//  Copyright (c) 2014 george liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEResponse : NSObject

@property NSString *attrib;
@property NSString *desc;
@property NSString *href;
@property NSString *src;
@property NSURL    *srcURL;
@property UIImage  *srcImage;
@property NSString *user;

@property NSString *avatar;
@property NSString *name;
@property NSString *username;

@property NSString *height;
@property NSString *avatarSrc;
@property NSURL    *avatarSrcURL;
@property UIImage  *avatarSrcImage;
@property NSString *width;

- (MEResponse *) extractFromResponseDictionary: (NSDictionary *) informationOnOneCompany;

@end
