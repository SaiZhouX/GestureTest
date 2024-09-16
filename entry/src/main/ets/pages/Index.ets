import { ImageViewerView } from '../view/ImageViewerView';

@Entry
@Component
struct Index {
  build() {
    Column(){
      ImageViewerView().border({width:1,color:Color.Red});
    }
  }
}