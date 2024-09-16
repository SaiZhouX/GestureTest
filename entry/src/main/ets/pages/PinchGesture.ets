@Entry
@Component
struct Index {
  @State scaleValue: number = 1;
  @State pinchValue: number = 1;
  @State pinchX: number = 0;
  @State pinchY: number = 0;

  aboutToAppear(): void {

  }

  build() {
    Column() {
      Column() {
        Text('PinchGesture scale:\n' + this.scaleValue)
        Text('PinchGesture center:\n(' + this.pinchX + ',' + this.pinchY + ')')
      }

      Image($r('app.media.startIcon'))
        .width(100)
        .height(100)// 在组件上绑定布局位置信息
          // 在组件上绑定缩放比例，可以通过修改缩放比例来实现组件的缩小或者放大
        .scale({ x: this.scaleValue, y: this.scaleValue, z: 1 })
        .gesture(
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
            })
        )
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}