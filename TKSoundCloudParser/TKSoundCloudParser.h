//
//  TKSoundCloudParser.h
//  TKSoundCloudParser
//
//  Created by Timm Kandziora on 30.10.14.
//  Copyright (c) 2014 shinvou Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKSoundCloudParser : NSObject

+ (void)getSoundCloudInformationForURL:(NSString *)userURL withBlock:(void (^)(NSDictionary *responseData, NSError *error))block;

+ (void)getSoundCloudTrackForURL:(NSString *)userURL withBlock:(void (^)(NSData *trackData, NSString *artist, NSString *title, NSError *error))block;

@end
