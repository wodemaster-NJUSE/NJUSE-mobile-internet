package chat.pojo.vo;

import lombok.Data;

import java.util.List;

@Data
public class MomentModel {

//    id: string
//    user: ChatContact
//    text: string
//    time: string = ''
//    imageList: Array<string> = new Array<string>()
//    media: string = '' // media为需要获取的视频url
//    mediaPreview: string = '' //mediaPreview为需要获取的视频预览图url
    private String id;

    private UserVO user;

    private String text;

    private String time;
    //TODO 存储图片
    private List<String> imageList;

    private String media;

    private String mediaPreview;

}
