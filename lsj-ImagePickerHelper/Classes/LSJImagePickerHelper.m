//
//  LSJImagePickerHelper.m
//  lsj-ImagePickerHelper
//
//  Created by lishangjing on 2024/7/11.
//

#import "LSJImagePickerHelper.h"
#import <MobileCoreServices/MobileCoreServices.h> // 用于UTType常量
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    LSJImagePickerHelperTypeImage,
    LSJImagePickerHelperTypeVideo,
} LSJImagePickerHelperType;

@interface LSJImagePickerHelper()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) LSJImagePickerHelperType pickType;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, copy) ImagePickerCompletion imageCompletion;

@property (nonatomic, copy) VideoPickerCompletion videoCompletion;


@end

@implementation LSJImagePickerHelper

// MARK: - Life
- (void)dealloc{
    NSLog(@"LSJImagePickerHelper:%s", __func__);
}

// MARK: - Public
- (void)pickImageFromViewController:(UIViewController *)controller
                         completion:(ImagePickerCompletion)completion{
    self.pickType = LSJImagePickerHelperTypeImage;
    self.imageCompletion = completion;
    [self presentImagePickerControllerViewController:controller];
}

- (void)pickVideoFromViewController:(UIViewController *)controller 
                         completion:(VideoPickerCompletion )completion{
    self.pickType = LSJImagePickerHelperTypeVideo;
    self.videoCompletion = completion;
    [self presentImagePickerControllerViewController:controller];
}

- (void)presentImagePickerControllerViewController:(UIViewController *)controller{
    // type
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 设备不可用  直接返回
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        // TODO: create error to completion
        return;
    }
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = sourceType;
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = NO;
    if (self.pickType == LSJImagePickerHelperTypeVideo) {
        self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
        // 不配置这个，系统默认会进行重新编码，存在特殊视频选择视频后，无法获取到 url，失败案例Demo：
        self.imagePickerController.videoExportPreset = AVAssetExportPresetPassthrough;
    }
    // Image default value is an array containing kUTTypeImage.
    [controller presentViewController:self.imagePickerController animated:YES completion:nil];
}

// MARK: UIImagePickerController Delegate

///  选择照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self)weakSelf = self;
    [picker dismissViewControllerAnimated:true completion:^{
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            if (strongSelf.pickType == LSJImagePickerHelperTypeImage) {
                UIImage *image = info[UIImagePickerControllerOriginalImage];
                if (strongSelf.imageCompletion) {
                    NSLog(@"LSJImagePickerHelper:图片选择放回：%@",image);
                    strongSelf.imageCompletion(image);
                }else{
                    NSLog(@"LSJImagePickerHelper:未实现 completion 回调，无法返回");
                }
            }else if (strongSelf.pickType == LSJImagePickerHelperTypeVideo) {
                NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
                if ([type isEqualToString:(NSString *)kUTTypeMovie]) {
                    NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
                    if (videoUrl) {
                        if (strongSelf.videoCompletion) {
                            strongSelf.videoCompletion(videoUrl);
                            NSLog(@"LSJImagePickerHelper:视频选择放回：%@",videoUrl);
                        }else{
                            NSLog(@"LSJImagePickerHelper:未实现 completion 回调，无法返回");
                        }
                    }else{
                        // TODO: error
                        NSLog(@"NSURL videoUrl 为空");
                    }
                }
            }
        }else{
            NSLog(@"LSJImagePickerHelper:被销毁强制销毁，不进行后续逻辑");
        }
    }];
}

/**
 相册代理取消操作
 低版本设备，不实现该方法，无法关闭相册
 @param picker 相册对象
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
