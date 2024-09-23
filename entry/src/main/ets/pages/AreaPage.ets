import { promptAction, RectShape, router } from '@kit.ArkUI';
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
  arr: string[][] = [];

  aboutToAppear(): void {
    this.createArr();
  }

  private createArr() {
    let sentence: string[] = [];
    let poem: string = "江南好, 风景旧曾谙。 日出江花红胜火, 春来江水绿如蓝。 能不忆江南？ ";
    // let lines = poem.split(/[,。？]/); // 使用正则表达式作为分隔符，然后过滤空行
    let lines = poem.split(" ")
    for (let i = 0; i < lines.length - 1; i++) {
      if (sentence.length != 0) {
        sentence = [];
      }
      sentence = Array.from(lines[i]);
      this.arr.push(sentence);
    }
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
            fontSize: 32,
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
            .position({ x: 30, y: 0 })

          ForEach(this.arr, (item: string[], index: number) => {
            GridShowGraduallyCompont({
              arr: item,
              fontSize: 28,
              back_color: '#00000000',
              duration: 3000,
              interval: 1500,
              columnsTemplate: '1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr',
              rowsTemplate: '1fr 1fr 1fr 1fr 1fr',
              rowsGap: 0,
              columnsGap: 0,
              gridWidth: 400,
              gridHeight: 50
            })
              .position({ x: (this.containerWidth - 400) / 2, y: 20 + 30 * (index + 1) })
          }, (item: string) => item.toString())
        }
      }

      Text($r('app.string.find_more')).onClick(() => {
        promptAction.showToast({ message: "more onClick" })
      })
        .fontSize(32)
        .border({
          width: 5,
          color: 0x317AF7,
          radius: 10,
          style: BorderStyle.Dashed
        })
        .position({ x: 250, y: 450 })
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