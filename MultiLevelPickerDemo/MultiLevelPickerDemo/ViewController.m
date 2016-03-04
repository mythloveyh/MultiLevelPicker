//
//  ViewController.m
//  MultiLevelPickerDemo
//
//  Created by Digger on 16/3/4.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "ViewController.h"
#import "SCChoicePickerView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer* recg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressSection:)];
    [self.textLB addGestureRecognizer:recg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapPressSection:(UITapGestureRecognizer *)sender {
    NSMutableArray* muarray = [NSMutableArray array];
    NSMutableArray* sectionArr = [NSMutableArray array];
    SectionObject* obj = [[SectionObject alloc] init];
    obj.title = @"北京";
    SectionObject* obj1 = [[SectionObject alloc] init];
    obj1.title = @"上海";
    [sectionArr addObject:obj];
    [sectionArr addObject:obj1];
    [sectionArr addObject:obj];
    [muarray addObject:sectionArr];
    [muarray addObject:sectionArr];
    [muarray addObject:sectionArr];
    
    SCChoicePickerView *addressPickerView = [[SCChoicePickerView alloc]initWithData:muarray];
    addressPickerView.block = ^(SCChoicePickerView *view,UIButton *btn,SectionObject *locate){
        self.textLB.text = [NSString stringWithFormat:@"%@",locate];
        self.textLB.textColor = [UIColor blackColor];
    };
    [addressPickerView show];
    
}

@end
