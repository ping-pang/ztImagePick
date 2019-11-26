//
//  ZTShowImagesView.h
//  CamereAndAlbum
//
//  Created by zt on 17/4/14.
//  Copyright © 2017年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTShowImagesView : UIView

@property(nonatomic,strong)NSMutableArray *imageArray;

-(instancetype)initWithFrame:(CGRect)frame andImageNumWithHorizontal:(NSInteger)num;
-(void)addImage:(UIImage *)image;
@end
