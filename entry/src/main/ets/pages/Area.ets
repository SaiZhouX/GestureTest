import { router } from '@kit.ArkUI';
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
          .width('100%')
          .height('100%')
          .clip(true)
          .clipShape(new Rect({width: '500px', height: '280px' }))
      }
    }
    .backgroundImage($r('app.media.foreground'))
  }
}