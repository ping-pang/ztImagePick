//
//  ZTShowImagesView.m
//  CamereAndAlbum
//
//  Created by zt on 17/4/14.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "ZTShowImagesView.h"
#define space 20
@implementation ZTShowImagesView
{
    CGFloat _widht;
    CGFloat _height;
    
    CGFloat _imgW;
    CGFloat _imgH;
    NSInteger _num;
}
-(instancetype)initWithFrame:(CGRect)frame andImageNumWithHorizontal:(NSInteger)num{
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor grayColor];
        _widht = frame.size.width;
        _height = frame.size.height;
        _imgW = _imgH = (_widht-(num+1)*space)/num;
        _num = num;
    }
    return self;
}

-(void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
}

-(void)addImage:(UIImage *)image{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithCapacity:0];
    }
        [_imageArray addObject:image];
        
        [self addImageView:image];
    
}

-(void)addImageView:(UIImage *)image{
    if (_imageArray.count == 0) {
        return;
    }else{
        
        NSInteger heng = (_imageArray.count-1)%_num;
        NSInteger shu = (_imageArray.count-1)/_num;
        CGFloat x = heng*_imgW + heng*space + space;
        CGFloat y = shu * _imgW + shu*space + space;
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, _imgW, _imgH)];
        imgV.image = _imageArray.lastObject;
        [self addSubview:imgV];
        
        CGFloat height = (shu+1) * (_imgH + space);
        if (height>_height) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGRect frame = self.frame;
                frame.size.height = height;
                self.frame = frame;
            });
        }
    }
    
    
}

@end
