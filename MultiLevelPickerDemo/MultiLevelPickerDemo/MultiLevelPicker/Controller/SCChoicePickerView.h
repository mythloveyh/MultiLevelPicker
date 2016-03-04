//
//  SCChoicePickerView.h
//
//  Created by sunchao on 15/5/27.
//

#import <UIKit/UIKit.h>
#import "SectionObject.h"

@class SCChoicePickerView;

typedef void (^SCChoicePickerViewBlock)(SCChoicePickerView *view, UIButton *btn,SectionObject *locate);

@interface SCChoicePickerView : UIView

@property (nonatomic,copy)SCChoicePickerViewBlock block;

/** NSArray作为数据源 */
@property (nonatomic,strong) NSArray* sourceArray;

- (instancetype)initWithData:(NSArray*) data;

- (void)show;
@end
