import { promptAction } from '@kit.ArkUI'

@Reusable
@Component
export struct BtnCompont {
  @Prop nIndex:number;
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
      })
  }
}