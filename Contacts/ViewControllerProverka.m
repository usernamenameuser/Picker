//
//  ViewControllerProverka.m
//  Contacts
//
//  Created by user on 20.03.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerProverka.h"
#import "Users.h"

@interface ViewControllerProverka ()

@property (weak, nonatomic) IBOutlet UILabel *theName;
@property (weak, nonatomic) IBOutlet UILabel *theLastName;
@property (weak, nonatomic) IBOutlet UILabel *theSex;
@property (weak, nonatomic) IBOutlet UILabel *theAge;
@property (weak, nonatomic) IBOutlet UILabel *theCountry;

@end

@implementation ViewControllerProverka


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.theName.text = self.firstName;
    self.theLastName.text = self.lastName;
    self.theSex.text = self.sex;
    self.theAge.text = self.age;
    self.theCountry.text = self.country;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
