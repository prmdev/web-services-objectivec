//
//  ConnectionToWebService.m
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "WebServiceConnectionDelegate.h"
#import "WebServiceParserDelegate.h"

@interface WebServiceConnectionDelegate()

@property (nonatomic, readwrite) WebServiceParserDelegate *xmlParser;
@property (nonatomic, readwrite) NSData *responseData;
/*@property (nonatomic, assign)    BOOL connectionDidFinish;*/

@end

@implementation WebServiceConnectionDelegate

- (instancetype)init {
    
    self = [self initWithUrl:nil method:nil];
    return self;
}

- (instancetype)initWithUrl:(NSString *)u method:(NSString *)m {
    
    self = [super init];
    
    if (self) {
        self.url = u;
        self.method = m;
        /*self.connectionDidFinish = NO;*/
        responseDataMutable = [NSMutableData data];
        verbose = NO;
    }
    
    return self;
}

- (void)establishConnection {
    
    if (self.url == nil || self.method == nil) {
        return;
    }
    NSString *envelopeText = [self generateEnvelope];
    NSData *envelopeData = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelopeData];
    [request setValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%li", [envelopeData length]] forHTTPHeaderField:@"Content-Length"];
    
    /*[NSURLConnection connectionWithRequest:request delegate:self];*/
    NSURLConnection __unused *con = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (NSString *)generateEnvelope {
    
    return [NSString stringWithFormat:
            @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
            "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
            "                 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
            "                 xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
            "  <soap12:Body>\n"
            "    <%@ xmlns=\"http://tempuri.org/\" />\n"
            "  </soap12:Body>\n"
            "</soap12:Envelope>\n",
            self.method];
}


#pragma mark - URL Connection Delegate Method

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"WebServiceConnection failed with error: %@ %@",
          [error localizedDescription], [error.userInfo objectForKey:NSURLErrorFailingURLErrorKey]);
}


#pragma mark - URL Connection Data Method

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseDataMutable appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    self.responseData = [NSData dataWithData:responseDataMutable];
    if (verbose) {
        NSString *dataString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"WebServiceConnection returned data successfully.\n\n%@", dataString);
    }
    [self.signalDelegate signalFrom:self];
}


@end
