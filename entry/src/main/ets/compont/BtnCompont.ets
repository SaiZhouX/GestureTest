import { promptAction, router } from '@kit.ArkUI'

@Reusable
@Component
export struct BtnCompont {
  @Prop nIndex: number;
  @Prop btnName: string;
  @Prop nX: number;
  @Prop nY: number;
  @Prop containerHeight: number;

  build() {
    Button(this.btnName)
      .fontColor(Color.Blue)
      .stateEffect(false)// 无点击效果
      .backgroundColor('#00000000')// 背景色设置为透明
      .position({x:this.nX,y:this.nY})
      // .margin({ top: this.mTop, left: this.mLeft })
      .onClick(() => {
        promptAction.showToast({ message: this.btnName })
        this.JumpClick()
      })
  }

  JumpClick() {
    router.pushUrl({
      url: 'pages/Area', // 目标url
      params: {
        nIndex: this.nIndex,
        nX: this.nX,
        nY: this.nY,
        containerHeight: this.containerHeight
      }
    }, router.RouterMode.Standard, (err) => {
      if (err) {
        console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      console.info('Invoke pushUrl succeeded.');
    });
  }
}

export class DataModel {
  id: string = "";
}
