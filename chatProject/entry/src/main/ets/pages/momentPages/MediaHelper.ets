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
  public selectPictures(): Promise<Array<MediaBean>> {

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
        }).then(async filePaths => {
          let photoArr : Array<string>  = filePaths;
          let mediaBeans : Array<MediaBean> = []
          for(let i = 0; i < photoArr.length; i++){
            const mediaBean = await this.buildMediaBean(photoArr[i]);
            mediaBeans.push(mediaBean)
          }
          return mediaBeans;
        });

    } catch (err) {
      console.error(this.TAG, 'PhotoViewPicker failed with err: ' + err);
      return Promise.reject(err);
    }
  }

  /**
   * 选择文件
   */
  public selectFile(): Promise<MediaBean> {
    try {
      let documentSelectOptions = new picker.DocumentSelectOptions();
      let documentPicker = new picker.DocumentViewPicker();
      return documentPicker.select(documentSelectOptions)
        .then((documentSelectResult) => {
          console.info(this.TAG, 'DocumentViewPicker.select successfully, DocumentSelectResult uri: ' + JSON.stringify(documentSelectResult));

          if (documentSelectResult && documentSelectResult.length > 0) {
            let filePath = documentSelectResult[0];
            console.info(this.TAG, 'DocumentViewPicker.select successfully, DocumentSelectResult uri: ' + filePath);
            return filePath;
          }

        }).catch((err) => {
          console.error(this.TAG, 'PhotoViewPicker.select failed with err: ' + err);
          return err;
        }).then(async (filePath) => {

          const mediaBean = await this.buildMediaBean(filePath);
          return mediaBean;

        });
    } catch (err) {
      console.error(this.TAG, 'PhotoViewPicker failed with err: ' + err);
      return Promise.reject(err);
    }
  }




  /**
   * 封装多媒体实体类
   *
   * @param uri 文件路径
   */
  private async buildMediaBean(uri: string): Promise<MediaBean> {

    const mediaBean: MediaBean = new MediaBean();
    mediaBean.localUrl = uri;
    await this.appendFileInfoToMediaBean(mediaBean, uri);
    return mediaBean;
  }

  /**
   * 通过Uri查找所选文件信息，插入到MediaBean中
   * @param mediaBean
   * @param uri
   */
  private async appendFileInfoToMediaBean(mediaBean: MediaBean, uri: string) {


    let fileList: Array<mediaLibrary.FileAsset> = [];

    const parts: string[] = uri.split('/');
    const id: string = parts.length > 0 ? parts[parts.length - 1] : '-1';

    try {

      let media = mediaLibrary.getMediaLibrary(this.mContext);
      let mediaFetchOptions: mediaLibrary.MediaFetchOptions = {
        selections: mediaLibrary.FileKey.ID + '= ?',
        selectionArgs: [id],
        uri: uri
      };

      let fetchFileResult = await media.getFileAssets(mediaFetchOptions);
      console.info(this.TAG, `fileList getFileAssetsFromType fetchFileResult.count = ${fetchFileResult.getCount()}`);
      fileList = await fetchFileResult.getAllObject();
      fetchFileResult.close();
      await media.release();

    } catch (e) {
      console.error(this.TAG, "query: file data  exception ");
    }

    if (fileList && fileList.length > 0) {

      let fileInfoObj = fileList[0];
      console.info(this.TAG, `file id = ${JSON.stringify(fileInfoObj.id)} , uri = ${JSON.stringify(fileInfoObj.uri)}`);
      console.info(this.TAG, `file fileList displayName = ${fileInfoObj.displayName} ,size = ${fileInfoObj.size} ,mimeType = ${fileInfoObj.mimeType}`);

      mediaBean.fileName = fileInfoObj.displayName;
      mediaBean.fileSize = fileInfoObj.size;
      mediaBean.fileType = fileInfoObj.mimeType;

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


