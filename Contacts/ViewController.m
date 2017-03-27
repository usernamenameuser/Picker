//
//  ViewController.m
//  Contacts
//
//  Created by user on 20.03.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerProverka.h"

#import "Users.h"

@interface ViewController ()

@property (strong, nonatomic) Users *users;

@property (weak, nonatomic) ViewControllerProverka *vcController;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userLastNameField;
@property (weak, nonatomic) IBOutlet UITextField *userSexField;
@property (weak, nonatomic) IBOutlet UITextField *userAgeField;
@property (weak, nonatomic) IBOutlet UITextField *userCountryField;

@property (strong, nonatomic) NSArray *sex;
@property (strong, nonatomic) NSArray *countries;

@property (weak, nonatomic) IBOutlet UIView *pickerSexContainer;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerSex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerSexBottom;

@property (weak, nonatomic) IBOutlet UIView *pickerAgeContainer;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerAge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerAgeBottom;

@property (weak, nonatomic) IBOutlet UIView *pickerCountryContainer;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCountry;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerCountryBottom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.users = [[Users alloc] init];
    
    self.sex = [[NSArray alloc] initWithObjects:@"Мужской", @"Женский", nil];
    
    self.pickerAge.maximumDate = [NSDate date];
    [self.pickerAge addTarget:self action:@selector(pickerAgeValueChanged) forControlEvents:UIControlEventValueChanged];
    self.countries = [NSLocale ISOCountryCodes];
    self.pickerSexBottom.constant = -256;
    self.pickerAgeBottom.constant = -256;
    self.pickerCountryBottom.constant = -256;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Seguepo

- (IBAction)showProverkaSugueCliked:(id)sender {
    [self performSegueWithIdentifier:@"ShowProverka" sender:nil];
    self.users.firstNameUser = self.userNameField.text;
    self.users.lastNameUser = self.userLastNameField.text;
    self.users.sexUser = self.userSexField.text;
    self.users.ageUser = self.eventDate;
    self.users.countryUser = self.userCountryField.text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowProverka"]) {
        self.vcController = [segue destinationViewController];
        self.vcController.firstName = self.userNameField.text;
        self.vcController.lastName = self.userLastNameField.text;
        self.vcController.age = self.userAgeField.text;
        self.vcController.sex = self.userSexField.text;
        self.vcController.country = self.userCountryField.text;
    }
}


#pragma mark - Keyboard

- (void)subscribeToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboarDidChange:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboarDidChange:)
                               name:UIKeyboardWillChangeFrameNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidHide:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

- (void)unsubscribeFromKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillShowNotification
                                object:nil];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillChangeFrameNotification
                                object:nil];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillHideNotification
                                object:nil];
}

- (void)keyboarDidChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    [UIView animateWithDuration:duration animations:^{
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1,
                                                        self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }];
}


#pragma mark - Text Fields

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.userSexField || textField == self.userAgeField || textField == self.userCountryField) {
        if ([textField isEqual:self.userSexField]) {
            self.pickerSexBottom.constant = 0;
        }
        else if ([textField isEqual:self.userAgeField]) {
            self.pickerAgeBottom.constant = 0;
        }
        else if ([textField isEqual:self.userCountryField]) {
            self.pickerCountryBottom.constant = 0;
        }
        [self.view endEditing:YES];
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.userNameField]) {
        [self.userLastNameField becomeFirstResponder];
    } else if ([textField isEqual:self.userLastNameField]) {
        [self.userSexField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.userNameField] || [textField isEqual:self.userLastNameField]) {
        NSCharacterSet *tolkoBukvy = [[NSCharacterSet letterCharacterSet] invertedSet];
        NSArray *chek = [string componentsSeparatedByCharactersInSet:tolkoBukvy];
        if ([chek count] > 1) return NO;
        NSString *ogranichitel = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return [ogranichitel length] <= 20;
    }
    return YES;
}


#pragma mark - Pickers

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerSex) {
        return self.sex.count;
    }
    else {
        return self.countries.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerSex) {
        return self.sex[row];
    }
    else {
        return [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countries[row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerSex) {
        self.userSexField.text = self.sex[row];
    }
    else {
        self.userCountryField.text = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countries[row]];
    }
}

- (void) pickerAgeValueChanged {
    self.eventDate = self.pickerAge.date;
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.eventDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    self.userAgeField.text = [NSString stringWithFormat:@"%@", dateString];
}

- (IBAction)pickerHideButton:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.pickerSexBottom.constant = -256;
    [UIView commitAnimations];
}

- (IBAction)pickerAgeHideButton:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.pickerAgeBottom.constant = -256;
    [UIView commitAnimations];
}

- (IBAction)pickerCountryHideButton:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.pickerCountryBottom.constant = -256;
    [UIView commitAnimations];
}

@end
