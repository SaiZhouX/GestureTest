import { RectShape, router } from '@kit.ArkUI';
import { DataModel } from '../compont/BtnCompont';

@Entry
@Component
struct Area {
  @State nIndex: number = Object(router.getParams())['nIndex'];

  aboutToAppear(): void {
    console.info("nIndex=" + this.nIndex)
  }

  build() {
    Stack() {
      Column() {
        Text("111");
        Text("222");
        Text("333");
        Image($r('app.media.map'))
          .border({ width: 5, color: Color.Red })
          .width("100%")
          .height("100%")
          .clip(true)
          .clipShape(new RectShape({ width: 300, height: 300 }).position({ x: 100, y: 200 }))
      }
    }
    .backgroundImage($r('app.media.foreground'))
  }
}