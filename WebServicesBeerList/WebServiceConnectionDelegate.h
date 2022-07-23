//
//  ConnectionToWebService.h
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionDidFinishSignal.h"

@class WebServiceParserDelegate;

@interface WebServiceConnectionDelegate : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {

    NSMutableData *responseDataMutable;
    BOOL verbose;
}

@property (nonatomic, weak)     id <ConnectionDidFinishSignal> signalDelegate;
@property (nonatomic, copy)     NSString *url;
@property (nonatomic, copy)     NSString *method;
@property (nonatomic, readonly) NSData *responseData;

- (instancetype)init;
- (instancetype)initWithUrl:(NSString *)u method:(NSString *)m;
- (void)establishConnection;

@end
