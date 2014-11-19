//
//  TKSoundCloudParser.m
//  TKSoundCloudParser
//
//  Created by Timm Kandziora on 30.10.14.
//  Copyright (c) 2014 shinvou Dev. All rights reserved.
//

#import "TKSoundCloudParser.h"

#define kClientID @"b45b1aa10f1ac2941910a7f0d10f8e28"
#define kUserAgent @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/600.1.17 (KHTML, like Gecko) Version/7.1 Safari/537.85.10"

@implementation TKSoundCloudParser

+ (void)getSoundCloudInformationForURL:(NSString *)userURL withBlock:(void (^)(NSDictionary *responseData, NSError *error))block
{
    NSURL *trackURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.soundcloud.com/resolve.json?url=%@&client_id=%@", userURL, kClientID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:trackURL];
    [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (!error) {
                                   NSMutableDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   block(responseData, nil);
                               } else {
                                   block(nil, error);
                               }
                           }
     ];
    
}

+ (void)getSoundCloudTrackForURL:(NSString *)userURL withBlock:(void (^)(NSData *trackData, NSString *artist, NSString *title, NSError *error))block
{
    [self getSoundCloudInformationForURL:userURL withBlock:^(NSDictionary *responseData, NSError *error) {
        if (!error) {
            NSString *artist = [[responseData objectForKey:@"user"] objectForKey:@"username"];
            NSString *title = [responseData objectForKey:@"title"];
            
            NSURL *streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@", [responseData objectForKey:@"stream_url"], kClientID]];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:streamURL];
            [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
            [request setHTTPMethod:@"GET"];
            
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                       if (!error) {
                                           block(data, artist, title, nil);
                                       } else {
                                           block(nil, nil, nil, error);
                                       }
                                   }];
        } else {
            block(nil, nil, nil, error);
        }
    }];
}

@end
