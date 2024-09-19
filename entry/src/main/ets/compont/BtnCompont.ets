import { promptAction, router } from '@kit.ArkUI'

@Reusable
@Component
export struct BtnCompont {
  @Prop nIndex: number;
  @Prop btnName: string;
  @Prop mTop: number;
  @Prop mLeft: number;

  build() {
    Button(this.btnName)
      .fontColor(Color.Blue)
      .stateEffect(false)// 无点击效果
      .backgroundColor('#00000000')// 背景色设置为透明
      .margin({ top: this.mTop, left: this.mLeft })
      .onClick(() => {
        promptAction.showToast({ message: this.btnName })
        this.JumpClick()
      })
  }

  JumpClick() {
    let paramsInfo: DataModel = {
      id: "123"
    };

    router.pushUrl({
      url: 'pages/Area', // 目标url
      params: {nIndex:this.nIndex }
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
