import { display } from '@kit.ArkUI';
import { MapView } from '../view/MapView';

@Entry
@Component
struct Index {
  @State containerHeight: number = 0;

  build() {
    Column() {
      //ImageViewerView().border({width:1,color:Color.Red});
      MapView({ containerHeight: this.containerHeight })
        .clip(true)
        .width('100%')
        .height('100%')
        .border({ width: 1, color: Color.Red });
    }
    .onAreaChange((oldValue: Area, newValue: Area) => {
      // TODO：性能知识点：onAreaChange是高频回调，仅在父组件尺寸改变时获取新的父组件宽高，避免性能损耗
      if (oldValue.height !== newValue.height) {
        this.containerHeight = newValue.height as number;
      }
    })
    .border({ width: 5, color: Color.Yellow })
  }
}