import router from '@ohos.router';

@Entry
@Component
export struct FriendDetailPage {
  private params = router.getParams() as Record<string, Object>;
  chatId: number = this.params.chatId as number;
  chatName: string | Resource = this.params.chatName as string | Resource;
  chatImg: string | Resource = this.params.chatImg as string | Resource;
  lastMsg: string | Resource = this.params.lastMsg as string | Resource;

  build() {

  }

}