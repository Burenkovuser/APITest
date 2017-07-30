//
//  ServerManager.m
//  APITest
//
//  Created by Vasilii on 29.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "ServerManager.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"

@interface ServerManager()

@property (strong, nonatomic) AFHTTPSessionManager *requesOperationManager;

@end

@implementation ServerManager

+ (ServerManager *)sharedManager {
    
    static ServerManager *manager = nil;
    //вызываем один раз
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    return manager;
}


- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requesOperationManager = [[AFHTTPSessionManager manager] initWithBaseURL:url];
    }
    return self;
}


- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) falure {
    
    //@(count) сокращение для NSNumber
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"263292877", @"user_id",
                            @"name",      @"order",
                            @(count),     @"count",
                            @(offset),    @"offset",
                            @"photo_50",  @"fields",
                            @"non",       @"name_case",
                            nil];
    
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] initWithBaseURL:<#(nullable NSURL *)#>;
    
    [self.requesOperationManager
     GET:@"riends.get"
     parameters:params
     progress:nil
     success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        NSLog(@"JSON: %@", responseObject);
         
         NSArray *dictsArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray *objectArray = [NSMutableArray array];
         
         for (NSDictionary *dict in dictsArray) {
             User *user = [[User alloc] initWithServerResponse:dict];
             [objectArray addObject:user];
         }
         
         if (success) {
             success(objectArray);
         }
         
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];


   // @"https://api.vk.com/method/riends.get";
    
    /*
    @"friends.get";
    
    user_id 263292877
    order name
    count
    offset
    fields photo_50
    name_case non
     https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
     */
    
    
}

@end
