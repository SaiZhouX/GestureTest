import { display } from '@kit.ArkUI';
import { MapView } from '../view/MapView';

@Entry
@Component
struct Index {
  build() {
    Column() {
      //ImageViewerView().border({width:1,color:Color.Red});
      MapView()
        .width('100%')
        .height('100%')
        .clip(true)
        .border({ width: 1, color: Color.Red });
    }
    .border({ width: 3, color: Color.Yellow })
  }
}