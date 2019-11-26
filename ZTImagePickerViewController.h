//
//  ZTImagePickerViewController.h
//  CamereAndAlbum
//
//  Created by zt on 17/4/14.
//  Copyright © 2017年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger,SourceType) {
    PhotoLibrary,
    Camera,
    PhotosAlbum
};
@interface ZTImagePickerViewController : UIImagePickerController

@property(nonatomic,assign)UIImagePickerControllerSourceType type;

@property(nonatomic,assign)BOOL allowEdit;
@property(nonatomic,assign)CGFloat quality;  //压缩比

@property(nonatomic,copy)void (^CallBackImage)(UIImage *image);
@property(nonatomic,copy)void (^CallBackPath)(NSString *path);

@end
