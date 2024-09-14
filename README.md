# lsj-ImagePickerHelper

[![CI Status](https://img.shields.io/travis/534016847@qq.com/lsj-ImagePickerHelper.svg?style=flat)](https://travis-ci.org/534016847@qq.com/lsj-ImagePickerHelper)
[![Version](https://img.shields.io/cocoapods/v/lsj-ImagePickerHelper.svg?style=flat)](https://cocoapods.org/pods/lsj-ImagePickerHelper)
[![License](https://img.shields.io/cocoapods/l/lsj-ImagePickerHelper.svg?style=flat)](https://cocoapods.org/pods/lsj-ImagePickerHelper)
[![Platform](https://img.shields.io/cocoapods/p/lsj-ImagePickerHelper.svg?style=flat)](https://cocoapods.org/pods/lsj-ImagePickerHelper)

## 修订历史

| SDK 版本 | 修订日期 | 修订说明 |
|---|---|---|
| 0.1.0 | 2024.07.11 | 单选图片 & 单选视频 |

## Overview

满足项目单选视频图片的低要求，并规避一些系统 Api 问题，也可作为系统 Api 的基础使用 Demo

| ![iukuv-78s5a](assets/iukuv-78s5a.gif) |
|---|

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

``` ObjectiveC

@interface LSJViewController ()

@property (nonatomic, strong) LSJImagePickerHelper *imagePickerHelper;

@end


- (void)viewDidLoad {
    [super viewDidLoad];
	 // Do any additional setup after loading the view, typically from a nib.
    
    self.imagePickerHelper = [LSJImagePickerHelper new];
    
}

/// 图片选择
- (void)pickImage{
    __weak typeof(self)weakSelf = self;
    [self.imagePickerHelper pickImageFromViewController:self completion:^(UIImage *image) {
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            self.resultLabel.text = [NSString stringWithFormat:@"图片：%@",image];
        }
    }];
}

/// 视频选择
- (void)pickVideo{
    __weak typeof(self)weakSelf = self;
    [self.imagePickerHelper pickVideoFromViewController:self completion:^(NSURL *url) {
        __strong typeof(self)strongSelf = weakSelf;
        if (strongSelf) {
            self.resultLabel.text = [NSString stringWithFormat:@"视频：%@",url];
        }
    }];
}

```



## Requirements
iOS 11 +


## Installation

lsj-ImagePickerHelper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'lsj-ImagePickerHelper'
```

## Author

534016847@qq.com

## License

lsj-ImagePickerHelper is available under the MIT license. See the LICENSE file for more info.




## Future

- 相册 Api 虽然没有说明什么时候要放弃这个 API ，但是苹果推荐了一个新的 API `PHPicker`（支持多选）。

    Will be removed in a future release, use PHPicker.
    
    ```
    typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
        UIImagePickerControllerSourceTypePhotoLibrary API_DEPRECATED("Will be removed in a future release, use PHPicker.", ios(2, API_TO_BE_DEPRECATED), visionos(1.0, API_TO_BE_DEPRECATED)),
        UIImagePickerControllerSourceTypeCamera API_UNAVAILABLE(visionos),
        UIImagePickerControllerSourceTypeSavedPhotosAlbum API_DEPRECATED("Will be removed in a future release, use PHPicker.", ios(2, API_TO_BE_DEPRECATED), visionos(1.0, API_TO_BE_DEPRECATED)),
    } API_UNAVAILABLE(tvos);
    ```


## 相册系统 API 存在的已知问题

视频选择时不配置这个，系统默认会进行重新编码，存在片段丢失视频的选择视频重新编码后，无法获取到 url，导致视频选择失败，案例Demo：[连接](https://github.com/lishangjing-dmeo/Demo-UIImagePickerControllerError)
`self.imagePickerController.videoExportPreset = AVAssetExportPresetPassthrough;`