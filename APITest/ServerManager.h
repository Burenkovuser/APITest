//
//  ServerManager.h
//  APITest
//
//  Created by Vasilii on 29.07.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject
//синглтон
+ (ServerManager *) sharedManager;
// получаем друзей и записываем в блок если успех
- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) falure;

@end
