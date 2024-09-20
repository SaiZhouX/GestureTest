import { RectShape, router } from '@kit.ArkUI';
import { GridShowGraduallyCompont } from '../compont/GridShowGraduallyCompont';
import { ImageViewerConstants } from '../constants/ImageViewerConstants';

const ITEM_COUNTS = 9;
const INTERVAL = 1500;
const DURATION = 3000;

@Entry
@Component
struct AreaPage {
  @State nIndex: number = Object(router.getParams())['nIndex'];
  @State nX: number = Object(router.getParams())['nX'];
  @State nY: number = Object(router.getParams())['nY'];
  @State containerHeight: number = Object(router.getParams())['containerHeight'];
  @State isGridShow: boolean = false;
  @State titleArr: string[] = Array.from("忆江南");
  @State poetryArr: string[] = Array.from("江南好，风景旧曾谙。日出江花红胜火，春来江水绿如蓝。能不忆江南？");
  @State containerWidth: number = 0;
  arr: string[][] =
    [Array.from("江南好，"), Array.from("风景旧曾谙。"), Array.from("日出江花红胜火，"), Array.from("春来江水绿如蓝。"),
      Array.from("能不忆江南？")];

  aboutToAppear(): void {
    console.info("nIndex=" + this.nIndex + ",nX=" + this.nX + ",nY=" + this.nY)
  }

  onPageShow(): void {
    animateTo({
      duration: DURATION + INTERVAL * (ITEM_COUNTS - 1),
      curve: Curve.Friction
    }, () => {
      this.isGridShow = true;
    })
  }

  build() {
    Stack() {
      if (this.isGridShow) {
        Column() {
          GridShowGraduallyCompont({
            arr: this.titleArr,
            fontSize: 36,
            back_color: '#00000000',
            duration: 3000,
            interval: 1500,
            columnsTemplate: '1fr 1fr 1fr',
            rowsTemplate: "",
            rowsGap: 15,
            columnsGap: 15,
            gridWidth: 180,
            gridHeight: 60
          })
            .position({ x: (this.containerWidth - 180) / 2, y: 50 })

          ForEach(this.arr, (item: string[], index: number) => {
            GridShowGraduallyCompont({
              arr: item,
              fontSize: 30,
              back_color: '#00000000',
              duration: 3000,
              interval: 1500,
              columnsTemplate: '1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr',
              rowsTemplate: '1fr 1fr 1fr 1fr 1fr',
              rowsGap: 0,
              columnsGap: 0,
              gridWidth: 400,
              gridHeight: 60
            })
              .position({ x: (this.containerWidth - 400) / 2, y: 50 + 50 * (index + 1) })
          }, (item: string) => item.toString())
        }
      }
    }
    .width('100%')
    .backgroundImage($r('app.media.jiangnan'))
    .backgroundImageSize(ImageSize.FILL)
    .height(ImageViewerConstants.MAP_VIEW_HEIGHT)
    .margin({ top: (770 - ImageViewerConstants.MAP_VIEW_HEIGHT) / 2 })
    .border({ width: 1, color: Color.Green })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      // TODO：性能知识点：onAreaChange是高频回调，仅在父组件尺寸改变时获取新的父组件宽高，避免性能损耗
      if (oldValue.width !== newValue.width) {
        this.containerWidth = newValue.width as number;
      }
    })
  }
}