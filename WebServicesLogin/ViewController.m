//
//  ViewController.m
//  WebServicesLogin
//
//  Created by prmdev on 2/3/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//


#import "ViewController.h"

static NSString *URL = @"http://www.softwaremerchant.com/onlinecourse.asmx";


@interface ViewController ()

@end


@implementation ViewController
{
    NSMutableData *responseData;
    NSMutableString *currentElement;
    NSString *username, *password;
    BOOL isUserValidResult, verbose;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    verbose = appDel.verbose;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginPressed:(id)sender
{
    username = self.usernameField.text;
    password = self.passwordField.text;
    
    NSString *envelopeText = [NSString stringWithFormat:
                              @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                              "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
                              "                 xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
                              "                 xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
                              "  <soap12:Body>\n"
                              "    <IsUserValid xmlns=\"http://tempuri.org/\">\n"
                              "      <UserID>%@</UserID>\n"
                              "      <Password>%@</Password>\n"
                              "    </IsUserValid>\n"
                              "  </soap12:Body>\n"
                              "</soap12:Envelope>\n",
                              username, password];
    NSData *envelopeData = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelopeData];
    [request setValue:@"application/soap+xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%li", [envelopeData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection)
        responseData = [NSMutableData data];
    else
        NSLog(@"[NSURLConnction connectionWithRequest: delegate: ] failed to return a connection.");
}

- (void)displayResult:(BOOL)loginResult {
    NSString *title = loginResult ? @"Login Successful" : @"Login Failed";
    NSString *message = loginResult ? [NSString stringWithFormat:@"Welcome to SM's OnlineCourse, %@", username] :
                                      [NSString stringWithFormat:@"You are NOT %@. Get off his phone!", username];
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

#pragma mark - URL Connection Method

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection failed with error: %@ %@",
          [error localizedDescription], [error.userInfo objectForKey:NSURLErrorFailingURLErrorKey]);
}

#pragma mark - URL Connection Data Method

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    isUserValidResult = NO;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
    [parser setDelegate:self];
    [parser parse];
    
    if (verbose) {
        NSString *responseDataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", responseDataString);
    }
}

#pragma mark - XML Parser Method

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement = [NSMutableString string];
    if ([elementName isEqualToString:@"IsUserValidResult"])
        isUserValidResult = YES;
    else
        isUserValidResult = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentElement appendString:string];
    if (verbose)
        NSLog(@"Processing %@", currentElement);
    
    if (isUserValidResult) {
        NSNumber *resultNumber = @([currentElement integerValue]);
        [self displayResult:[resultNumber boolValue]];
    }
}

@end
