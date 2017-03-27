//
//  Users.h
//  Contacts
//
//  Created by user on 25.03.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject

@property (nonatomic, copy) NSString *firstNameUser;
@property (nonatomic, copy) NSString *lastNameUser;
@property (nonatomic, copy) NSString *sexUser;
@property (nonatomic, assign) NSDate *ageUser;
@property (nonatomic, copy) NSString *countryUser;

- (instancetype) initWithfirstNameUser:(NSString *) firstNameUser
                          lastNameUser:(NSString *) lastNameUser
                          sexUser:(NSString *) sexUser
                               ageUser:(NSDate *) ageUser
                           countryUser:(NSString *) countryUser;

@end
