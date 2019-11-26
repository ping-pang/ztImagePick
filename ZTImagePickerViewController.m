//
//  ZTImagePickerViewController.m
//  CamereAndAlbum
//
//  Created by zt on 17/4/14.
//  Copyright © 2017年 zt. All rights reserved.
//

#import "ZTImagePickerViewController.h"
@interface ZTImagePickerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ZTImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFunction];
}

-(void)setFunction{
    if (_type == Camera) {
       
        if (![self checkValid]) {
            [self initAlertControllerForError];
            return;
        }
        
    }
    self.delegate = self;

    self.sourceType = _type;
    
    if (_allowEdit == 1) {
        self.allowsEditing = YES;
    }else{
        self.allowsEditing = NO;
    }
}

-(BOOL)checkValid{
    BOOL cameraAvailable = [UIImagePickerController isSourceTypeAvailable:_type];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (!cameraAvailable ||
        authStatus == AVAuthorizationStatusRestricted ||
        authStatus== AVAuthorizationStatusDenied) {
        
        return NO;
    }else{
        return YES;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image;
    NSData *data;
    if (self.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    }
    data = UIImageJPEGRepresentation(image, _quality);
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[self currentTime]]];
    
    [[NSFileManager defaultManager]createFileAtPath:fullPath contents:data attributes:nil];
    NSLog(@"%@",fullPath);
    
    if (self.CallBackImage) {
        self.CallBackImage(image);
    }
    if (self.CallBackPath) {
        self.CallBackPath(fullPath);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)currentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"ddhhMMss"];
    NSString *timeStr = [formatter stringFromDate:date];
    return timeStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initAlertControllerForError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"打开相机失败，请检查相机权限或相机是否可以正常使用" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *tureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:tureBtn];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
