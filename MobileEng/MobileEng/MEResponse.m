//
//  MEResponse.m
//  MobileEng
//
//  Created by esther liu on 3/25/14.
//  Copyright (c) 2014 george liu. All rights reserved.
//

#import "MEResponse.h"

@implementation MEResponse

@synthesize attrib;
@synthesize desc;
@synthesize href;
@synthesize src;
@synthesize srcURL;
@synthesize srcImage;
@synthesize user;
@synthesize avatar;
@synthesize avatarSrcImage;
@synthesize avatarSrcURL;

@synthesize name;
@synthesize username;
@synthesize height;
@synthesize avatarSrc;
@synthesize width;


- (id) getImageFrom: (NSURL *) sourceURL {
    
    NSLog(@"Getting %@...", sourceURL);
    
    NSData * data = [NSData dataWithContentsOfURL:sourceURL];
    if (!data) {
        NSLog(@"Error retrieving %@", sourceURL);
        return nil;
    }
    
    return [[UIImage alloc] initWithData:data];
}

- (MEResponse *) extractFromResponseDictionary: (NSDictionary *) informationOnOneCompany {
    
    attrib = informationOnOneCompany[@"attrib"];
    desc = informationOnOneCompany[@"desc"];
    href = informationOnOneCompany[@"href"];
    src = informationOnOneCompany[@"src"];
    user = informationOnOneCompany[@"user"];
    
    srcURL = [NSURL URLWithString:[src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    srcImage = [self getImageFrom:srcURL];
    if (srcImage == nil) {
        // set srcImage to a local default image
    }
    
    NSDictionary *nsd = informationOnOneCompany[@"user"];
        
    avatar = nsd[@"avatar"];
    name = nsd[@"name"];
    username = nsd[@"username"];
    
    NSDictionary *avatarDict = nsd[@"avatar"];
    height = avatarDict[@"height"];
    avatarSrc = avatarDict[@"src"];
    
    
    avatarSrcURL = [NSURL URLWithString:[avatarSrc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    avatarSrcImage = [self getImageFrom:avatarSrcURL];
    if (avatarSrcImage == nil) {
        // set srcImage to a local default image
    }
    
    width = avatarDict[@"width"];
    
    return self;
}
@end
