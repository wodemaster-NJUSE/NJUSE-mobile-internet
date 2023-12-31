import common from '@ohos.app.ability.common';
import picker from '@ohos.file.picker';
import mediaLibrary from '@ohos.multimedia.mediaLibrary';


/**
 * 多媒体辅助类
 */
export class MediaHelper {
  private readonly TAG: string = 'MediaHelper';

  private mContext: common.Context;

  constructor(context: common.Context) {
    this.mContext = context;
  }

  /**
   * 选择图片
   */
  public selectPictures(): Promise<Array<string>> {

    try {
      let photoSelectOptions = new picker.PhotoSelectOptions();
      photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      photoSelectOptions.maxSelectNumber = 9;// 最大选择数量
      let photoPicker = new picker.PhotoViewPicker();
      return photoPicker.select(photoSelectOptions)
        .then((photoSelectResult) => {
          console.info(this.TAG, 'PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(photoSelectResult));

          if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
            let filePaths : Array<string> = photoSelectResult.photoUris;// 获取图片url
            console.info(this.TAG, 'PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + filePaths[0]);// 能输出第一个就说明没问题
            return filePaths;// 返回所有图片url
          }
        }).catch((err) => {
          console.error(this.TAG, 'PhotoViewPicker.select failed with err: ' + err);
          return err;
        })
    } catch (err) {
      console.error(this.TAG, 'PhotoViewPicker failed with err: ' + err);
      return Promise.reject(err);
    }
  }


}
/**
 * 多媒体数据类
 */
export class MediaBean {
  /**
   * 文件名称
   */
  public fileName: string;
  /**
   * 文件大小
   */
  public fileSize: number;
  /**
   * 文件类型
   */
  public fileType: string;
  /**
   * 本地存储地址
   */
  public localUrl: string;
}


