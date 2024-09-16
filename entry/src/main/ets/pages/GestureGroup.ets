@Entry
@Component
struct Index {
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State positionX: number = 0;
  @State positionY: number = 0;
  @State scaleValue: number = 1;
  @State pinchValue: number = 1;
  @State pinchX: number = 0;
  @State pinchY: number = 0;

  build() {
    Column() {
      Text('PanGesture Offset:\nX: ' + this.offsetX + '\n' + 'Y: ' + this.offsetY)
        .fontSize(28)
        .height(200)
        .width(300)

      Column() {
        Text('PinchGesture scale:\n' + this.scaleValue)
        Text('PinchGesture center:\n(' + this.pinchX + ',' + this.pinchY + ')')
      }

      Image($r('app.media.map'))
        .clip(true)
        .width(100)
        .height(100)
        .border({ width: 3 })
          // 在组件上绑定缩放比例，可以通过修改缩放比例来实现组件的缩小或者放大
        .scale({ x: this.scaleValue, y: this.scaleValue, z: 1 })
          // 在组件上绑定布局位置信息
        .translate({ x: this.offsetX, y: this.offsetY, z: 0 })
        .gesture(
          // 声明该组合手势的类型为Sequence类型
          GestureGroup(GestureMode.Parallel,
            // 在组件上绑定2指触发的捏合手势
            PinchGesture({ fingers: 2 })
              .onActionStart((event: GestureEvent) => {
                console.info('Pinch start');
              })// 当捏合手势触发时，可以通过回调函数获取缩放比例，从而修改组件的缩放比例
              .onActionUpdate((event: GestureEvent) => {
                this.scaleValue = this.pinchValue * event.scale;
                this.pinchX = event.pinchCenterX;
                this.pinchY = event.pinchCenterY;
              })
              .onActionEnd(() => {
                this.pinchValue = this.scaleValue;
                console.info('Pinch end');
              }),
            // 绑定拖动手势
            PanGesture()
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
    }
    .height(200)
    .width(250)
  }
}