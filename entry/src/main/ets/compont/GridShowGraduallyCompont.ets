/**
 *Grid渐次显示组件
 */
@Reusable
@Component
export struct GridShowGraduallyCompont {
  @Prop arr: string[];
  @Prop back_color: string;
  @Prop duration: number;
  @Prop interval: number;
  @Prop columnsTemplate: string;
  @Prop rowsTemplate: string;
  @Prop rowsGap: number;
  @Prop columnsGap: number;
  @Prop gridWidth: number;
  @Prop gridHeight: number;

  aboutToAppear(): void {
    console.info("columnsTemplate=" + this.columnsTemplate)
  }

  build() {
    Grid() {
      ForEach(this.arr, (item: string, index: number) => {
        GridItem() {
          Stack() {
            Text(item)
              .fontStyle(FontStyle.Italic)
              .fontSize(36)
          }
          // .border({ width: 1, color: Color.Red })
          .size({ width: 50, height: 50 })
          .backgroundColor(this.back_color)
          .transition(TransitionEffect.OPACITY
            .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }))// 对每个方格的转场添加delay，实现组件的渐次出现消失效果
            .animation({ duration: this.duration, curve: Curve.Friction, delay: this.interval * index }))
          .borderRadius(10)
        }
        // 消失时，如果不对方格的所有父控件添加转场效果，则方格的消失转场不会生效
        // 此处让方格的父控件在出现消失转场时一直以0.99的透明度显示，使得方格的转场效果不受影响
        .transition(TransitionEffect.opacity(0.99))
      }, (item: number) => item.toString())
    }
    .border({ width: 2, color: Color.Red })
    .columnsTemplate(this.columnsTemplate)
    .rowsTemplate(this.rowsTemplate)
    .rowsGap(this.rowsGap)
    .columnsGap(this.columnsGap)
    .size({ width: this.gridWidth, height: this.gridHeight })
    // 消失时，如果不对方格的所有父控件添加转场效果，则方格的消失转场不会生效
    // 此处让父控件在出现消失转场时一直以0.99的透明度显示，使得方格的转场效果不受影响
    .transition(TransitionEffect.opacity(0.99))
  }
}