//
//  Users.m
//  Contacts
//
//  Created by user on 25.03.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import "Users.h"

@implementation Users

- (instancetype) initWithfirstNameUser:(NSString *) firstNameUser
                          lastNameUser:(NSString *) lastNameUser
                               sexUser:(NSString *) sexUser
                                   ageUser:(NSDate *) ageUser
                           countryUser:(NSString *) countryUser
{
    self = [super init];
    if (self) {
        _firstNameUser = firstNameUser;
        _lastNameUser = lastNameUser;
        _sexUser = sexUser;
        _ageUser = ageUser;
        _countryUser = countryUser;
    }
    return self;
}

- (NSString *)description{
    NSString *ageFormate = [NSDateFormatter localizedStringFromDate:self.ageUser dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    
    return [NSString stringWithFormat:@"Имя: %@ %@\n Пол: %@\n День Рождения: %@\n Страна: %@", self.firstNameUser, self.lastNameUser, self.sexUser, ageFormate, self.countryUser];
}

@end
