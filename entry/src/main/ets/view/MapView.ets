import { promptAction } from '@kit.ArkUI';

@Component
export struct MapView {
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State positionX: number = 0;
  @State positionY: number = 0;
  @State scaleValue: number = 1;

  build() {
    Column() {
      Stack() {
        Button("江南")
          .margin({ left: 250 })
          .onClick(() => {
            promptAction.showToast({ message: "江南" })
          })
        Button("塞北")
          .margin({ top: -150, left: 50 })
          .onClick(() => {
            promptAction.showToast({ message: "塞北" })
          })
        Button("岭南")
          .margin({ top: 150, left: 150 })
          .onClick(() => {
            promptAction.showToast({ message: "岭南" })
          })
        Button("西域")
          .margin({ top: -150, left: -200 })
          .onClick(() => {
            promptAction.showToast({ message: "西域" })
          })
      }
      .width('100%')
      .height(500)
      .backgroundImage($r('app.media.map'))
      .backgroundImageSize(ImageSize.FILL)
      .scale({ x: this.scaleValue, y: this.scaleValue, z: 1 }) // 在组件上绑定布局位置信息
      .translate({ x: this.offsetX, y: this.offsetY, z: 0 })
      .gesture(
        // 声明该组合手势的类型为Parallel类型
        GestureGroup(GestureMode.Exclusive,
          // 绑定双击手势(放大/缩小)
          TapGesture({ count: 2 })
            .onAction(() => {
              if (this.scaleValue != 1) {
                this.scaleValue = 1;
                this.offsetX = 0;
                this.offsetY = 0;
              } else {
                this.scaleValue = 3;
              }
            }),
          // 绑定拖动手势
          PanGesture({ fingers: 1, distance: 2 })
            .onActionStart((event: GestureEvent) => {
              console.info('Pan start');
            })// 当触发拖动手势时，根据回调函数修改组件的布局位置信息
            .onActionUpdate((event: GestureEvent) => {
              this.offsetX = this.positionX + event.offsetX;
              this.offsetY = this.positionY + event.offsetY;
            })
            .onActionEnd(() => {
              this.positionX = this.offsetX;
              this.positionY = this.offsetY;
            })
        )
      )
      .border({ width: 1, color: Color.Green })
    }
    // .margin({top: (this.screenHeight - 500) / 2})
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .clip(true)
    .border({ width: 1, color: Color.Red })
  }
}