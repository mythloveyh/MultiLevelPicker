//
//  SCChoicePickerView.m
//
//  Created by sunchao on 15/5/27.
//

#import "SCChoicePickerView.h"

@interface SCChoicePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (strong, nonatomic) SectionObject *section;

//省 数组
@property (strong, nonatomic) NSArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSArray *areaArr;

@end
@implementation SCChoicePickerView

- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SCChoicePickerView" owner:nil options:nil] firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        [self customView];
    }
    return self;
}

/**
 *  带数组初始化
 *
 *  @param data NSArray
 *
 *  @return instancetype
 */
- (instancetype)initWithData:(NSArray*) data{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SCChoicePickerView" owner:nil options:nil] firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        self.sourceArray = data;
        [self customView];
    }
    return self;
}

- (void)customView{
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - setter && getter

- (SectionObject *)section{
    if (!_section) {
        _section = [[SectionObject alloc] init];
    }
    return _section;
}

#pragma mark - action

//选择完成
- (IBAction)finishBtnPress:(UIButton *)button {
    if (self.block) {
        self.section.title = @"";
        //获取用户最终选择结果
        for (int i = 0; i < self.sourceArray.count; i++) {
            NSInteger index = [self.pickView selectedRowInComponent:i];
            NSArray* rows = self.sourceArray[0];
            SectionObject* obj = ((SectionObject*)rows[index]);
            self.section.title = [NSString stringWithFormat:@"%@ %@",self.section.title,obj.title];
        }
        self.block( self , button , self.section);
    }
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [win.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.sourceArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return ((NSArray*)[self.sourceArray objectAtIndex:component]).count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString* content = ((SectionObject*)[((NSArray*)[self.sourceArray objectAtIndex:component]) objectAtIndex:row]).title;
    return content;
}
#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString* content = ((SectionObject*)[((NSArray*)[self.sourceArray objectAtIndex:component]) objectAtIndex:row]).title;
    self.section.title = [NSString stringWithFormat:@"%@ %@",self.section.title,content];
    if (component == self.sourceArray.count - 1) {
        return;
    }
    [self.pickView reloadComponent: component + 1];
    [self.pickView selectRow:0 inComponent:component + 1 animated:YES];
}


@end