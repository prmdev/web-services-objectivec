//
//  ConnectionToWebService.h
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebServiceParserDelegate;

@interface WebServiceConnectionDelegate : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {

    NSMutableData *responseDataMutable;
    BOOL verbose;
}

@property (nonatomic, copy)     NSString *url;
@property (nonatomic, copy)     NSString *method;
@property (nonatomic, readonly) NSData *responseData;
@property (nonatomic, readonly) BOOL connectionDidFinish;

- (instancetype)init;
- (instancetype)initWithUrl:(NSString *)u method:(NSString *)m;
- (void)establishConnection;
- (NSString *)generateEnvelope;

@end
