import { BtnCompont } from '../compont/BtnCompont';

@Component
export struct MapView {
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State positionX: number = 0;
  @State positionY: number = 0;
  @State scaleValue: number = 1;
  @State nIndex:number = 0;
  @State btnName: string = "";
  btn_arr: string[] = ["1,江南,-20,250", "2,岭南,150,150", "3,中原,-30,100", "4,西夷,0,-50", "5,西域,-150,-200", "6,塞北,-150,50", "7,辽东,-300,250"];

  build() {
    Stack() {
      ForEach(this.btn_arr, (item: string) => {
        BtnCompont({
          nIndex: parseInt(this.getBtnInfo(item)[0]),
          btnName: this.getBtnInfo(item)[1],
          mTop: parseInt(this.getBtnInfo(item)[2]),
          mLeft: parseInt(this.getBtnInfo(item)[3])
        })
      }, (item: string) => item.toString());
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
            if (this.scaleValue != 1) {
              // 只有放大后才能拖动
              this.offsetX = this.positionX + event.offsetX;
              this.offsetY = this.positionY + event.offsetY;
            }
          })
          .onActionEnd(() => {
            this.positionX = this.offsetX;
            this.positionY = this.offsetY;
          })
      )
    )
    .border({ width: 1, color: Color.Green })
    .margin({top:150})
  }

  getBtnInfo(item: string): string[] {
    return item.split(",");
  }
}