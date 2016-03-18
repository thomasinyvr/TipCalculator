//
//  ViewController.m
//  TipCalculator
//
//  Created by Thomas Friesman on 2016-03-18.
//  Copyright © 2016 Thomas Friesman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UIButton *calculateTip;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *changeTipField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateTip:(id)sender
{
    NSString *billAmountString = self.billAmountTextField.text;
    float billAmount = [billAmountString floatValue];
    
    NSString *changedTipPercentage = self.changeTipField.text;
    float changedTipFloat = [changedTipPercentage floatValue] / 100;
    

    if (changedTipFloat) {
        float changedTipCalculate = billAmount * changedTipFloat;
        
        self.tipAmountLabel.text = [NSString stringWithFormat:@"$%f", changedTipFloat];
    } else {
        float tipAmount = billAmount *0.15;
        NSLog(@"$%f", tipAmount);
        
        self.tipAmountLabel.text = [NSString stringWithFormat:@"$%f", tipAmount];
    }
    
    
//    float tipAmount = (billAmount * 15)/100;
//    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%f", tipAmount];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}



-(void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    _scrollView.contentInset = contentInsets;
    
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect.activeField.frame.origin))
//    {
//        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
//    }
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    _scrollView.contentInset = contentInsets;
    
    _scrollView.scrollIndicatorInsets = contentInsets;
}



@end
