//
//  MEMainTableTableViewController.h
//  MobileEng
//
//  Created by esther liu on 3/25/14.
//  Copyright (c) 2014 george liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEMainTableTableViewController : UITableViewController <NSURLConnectionDelegate> {
    NSMutableData *_responseData;
    NSMutableArray *_responseArray;  // an array of NSDictionaries
    NSString *_hrefString;
}

@end
