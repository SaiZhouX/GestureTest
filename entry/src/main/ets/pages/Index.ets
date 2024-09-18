import { display } from '@kit.ArkUI';
import { MapView } from '../view/MapView';

@Entry
@Component
struct Index {
  build() {
    Column() {
      //ImageViewerView().border({width:1,color:Color.Red});
      MapView();
    }
  }
}