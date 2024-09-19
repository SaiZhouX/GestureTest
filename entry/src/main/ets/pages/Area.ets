import { RectShape, router } from '@kit.ArkUI';
import { ImageViewerConstants } from '../constants/ImageViewerConstants';

const ITEM_COUNTS = 9;
const ITEM_COLOR = '#ED6F21';
const INTERVAL = 300;
const DURATION = 3000;

@Entry
@Component
struct Area {
  @State nIndex: number = Object(router.getParams())['nIndex'];
  @State nX: number = Object(router.getParams())['nX'];
  @State nY: number = Object(router.getParams())['nY'];
  @State containerHeight: number = Object(router.getParams())['containerHeight'];
  @State numbers: string[] = ["忆", "江", "南"]
  startNumber: number = 4;

  aboutToAppear(): void {
    console.info("nIndex=" + this.nIndex + ",nX=" + this.nX + ",nY=" + this.nY)
  }

  build() {
    Stack() {
      Text() {
        ForEach(this.numbers, (item: string, index: number) => {
          // ForEach下的直接组件需配置transition效果
          Span(item)
            .transition(TransitionEffect.OPACITY
              .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }))// 对每个方格的转场添加delay，实现组件的渐次出现消失效果
              .animation({ duration: DURATION, curve: Curve.Friction, delay: INTERVAL * index }))
        }, (item: string) => item)
      }.border({ width: 1, color: Color.Red })

      // Column() {
      //   ForEach(this.numbers, (item: string) => {
      //     // ForEach下的直接组件需配置transition效果
      //     Text(item)
      //       .width(240)
      //       .height(60)
      //       .fontSize(18)
      //       .borderWidth(1)
      //       .backgroundColor(Color.Orange)
      //       .textAlign(TextAlign.Center)
      //       .transition({ type: TransitionType.All, translate: { x: 200 }, scale: { x: 0, y: 0 } })
      //   }, (item: string) => item)
      // }
      // .margin(10)
      // .justifyContent(FlexAlign.Start)
      // .alignItems(HorizontalAlign.Center)
      // .width("90%")
      // .height("70%")
      //
      // Button('向尾部添加元素')
      //   .width(160)
      //   .fontSize(16)
      //   .onClick(() => {
      //     animateTo({ duration: 1000 }, () => {
      //       // 往数组尾部插入一个元素，导致ForEach在尾部增加对应的组件
      //       this.numbers.push(this.startNumber.toString());
      //       this.startNumber++;
      //     })
      //   })
    }
    .width('100%')
    .backgroundImage($r('app.media.jiangnan'))
    .backgroundImageSize(ImageSize.FILL)
    .height(ImageViewerConstants.MAP_VIEW_HEIGHT)
    .margin({ top: (770 - ImageViewerConstants.MAP_VIEW_HEIGHT) / 2 })
    .border({ width: 1, color: Color.Green })
  }
}