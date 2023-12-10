@Entry
@Component
struct Index {
  // 导航栏数据
  private listItem = [
    { name: '消息', icon: $r('app.media.comments') }, { name: '大语言', icon: $r("app.media.LLM") },
    { name: '联系人', icon: $r("app.media.contacts_") }, { name: '动态', icon: $r('app.media.moment') },
  ]
  // 导航栏宽度
  private navWidth: number = 0
  // 导航栏高度
  private navHeight: number = 0
  // 每项宽度
  private itemWidth = 0
  // 空心圆半径
  private circleRadius = 0
  // 空心圆距离item两边距离
  private circlePadding = 0
  // 路径值
  @State pathValue: string = ''
  // 实心圆x轴偏移量
  @State offsetX: number = 0
  // 选中的item索引
  @State selectIndex: number = 0

  onCreate() {
   this.NavigationContent()
  }

  /**
   * 导航内容
   */
  @Builder NavigationContent(){
    Row() {
      ForEach(this.listItem, (item, index) => {
        Column() {
          Image(item.icon)
            .width(30).height(30)
            .margin({ top: 15, bottom: 24 })
          Text(item.name)
            .fontSize(12)
        }
        .width(this.itemWidth)
        .height('100%')
        .offset({ y: this.selectIndex === index ? -23 : 0 })
        .animation({ duration: 350 })
        .onClick(() => {
          if (this.selectIndex === index) return
          this.selectIndex = index
          animateTo({ delay: 50, duration: 300 }, () => {
            this.selectItem(index)
          })
        })
      }, item => item.name)
    }.width('100%')
    .height('100%')
  }

  build() {
    Column() {
      Text('').layoutWeight(1)

      Stack({ alignContent: Alignment.TopStart }) {
        // 矩形路径
        Path()
          .width('100%')
          .height('100%')
          .fill('#E0FFFF')
          .commands(this.pathValue)

        // 实心圆
        Row() {
        }
        .width(this.circleRadius * 2 - 20)
        .height(this.circleRadius * 2 - 20)
        .backgroundColor('#E0FFFF')
        .borderRadius(this.circleRadius)
        .offset({ x: this.offsetX, y: -this.circleRadius / 2 })
        .shadow({ radius: 10, color: '#E0FFFF' })

        // 导航内容
        this.NavigationContent()

      }
      .width('100%')
      .height(60)
      .onAreaChange((oldValue: Area, newValue: Area) => {
        // 获取组件的宽高
        this.navWidth = parseInt(newValue.width.toString())
        this.navHeight = parseInt(newValue.height.toString())
        // item宽度
        this.itemWidth = this.navWidth / 4
        // 空圆半径
        this.circleRadius = this.navHeight * 0.6
        // 空圆两边间距
        this.circlePadding = (this.itemWidth - this.circleRadius * 2) / 2
        // 默认选中0
        this.selectItem()
      })
    }
    .width('100%')
    .height('100%')
  }

  /**
   * 选中的item
   * @param index = 0 索引
   */
  selectItem(index = 0) {
    // 实心圆的偏移量
    this.offsetX = this.circlePadding + 10 + index * this.itemWidth
    // 矩形四个点坐标
    const leftTop = `0,0`
    const rightTop = `${vp2px(this.navWidth)},0`
    const rightBottom = `${vp2px(this.navWidth)},${vp2px(this.navHeight)}`
    const leftBottom = `0,${vp2px(this.navHeight)}`
    // 路径命令
    this.pathValue = `M${leftTop} L${vp2px(this.circlePadding + index * this.itemWidth - 10)},0
        Q${vp2px(this.circlePadding + index * this.itemWidth)},0
         ${vp2px(this.circlePadding + index * this.itemWidth)},25
        A1,1 0 0 0 ${vp2px(this.circlePadding + this.circleRadius * 2 + index * this.itemWidth)},25
        Q${vp2px(this.circlePadding + this.circleRadius * 2 + index * this.itemWidth)},0
         ${vp2px(this.circlePadding + this.circleRadius * 2 + index * this.itemWidth + 10)},0
        L${rightTop} ${rightBottom} ${leftBottom} Z`
  }
}