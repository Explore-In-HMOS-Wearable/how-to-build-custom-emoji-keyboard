import { CATEGORIZED_EMOJIS, EmojiCategory } from '../model/UnicodeEmoji';

@Entry
@Component
struct SmartWatchEmojiKeyboard {
  @State textValue: string = '';
  @State activeCategoryIndex: number = 0;
  textController: TextInputController = new TextInputController();

  @Builder
  CustomEmojiKeyboard() {
    Column() {
      Row() {
        Button('D')
          .width(36)
          .height(36)
          .borderRadius(8)
          .backgroundColor('#007AFF')
          .fontColor(Color.White)
          .onClick(() => this.textController.stopEditing())

        List({ space: 8 }) {
          ForEach(CATEGORIZED_EMOJIS, (cat: EmojiCategory, index: number) => {
            ListItem() {
              Text(cat.emojis[0])
                .fontSize(20)
                .width(36)
                .height(36)
                .textAlign(TextAlign.Center)
                .backgroundColor(this.activeCategoryIndex === index ? '#FFFFFF' : Color.Transparent)
                .borderRadius(8)
                .onClick(() => {
                  this.activeCategoryIndex = index;
                })
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%').height(44).padding(4).backgroundColor('#BCC0C9')

      Grid() {
        ForEach(CATEGORIZED_EMOJIS[this.activeCategoryIndex].emojis, (emoji: string) => {
          GridItem() {
            Text(emoji).fontSize(28).textAlign(TextAlign.Center)
          }
          .width(45).height(45).borderRadius(8)
          .onClick(() => {
            this.textValue += emoji;
          })
        })
      }
      .rowsTemplate('1fr 1fr 1fr')
      .rowsGap(4)
      .columnsGap(4)
      .layoutWeight(1)
      .padding(8)
    }
    .width('100%').height('100%').backgroundColor('#D1D3D9')
  }

  build() {
    Column({ space: 30 }) {

      TextInput({ text: this.textValue, controller: this.textController, placeholder: '' })
        .id('emojiInput')
        .customKeyboard(this.CustomEmojiKeyboard()) // add this to your textInput
        .height(45)
        .width('85%')
        .fontSize(24)
        .textAlign(TextAlign.Center)
        .borderRadius(12)
        .backgroundColor(Color.Gray)
        .fontColor(Color.White)
        .focusable(true)

      Button('Open Emoji Keyboard', { type: ButtonType.Capsule })
        .backgroundColor('#34C759')
        .width('80%')
        .height(50)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          focusControl.requestFocus('emojiInput');
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
    .justifyContent(FlexAlign.Center)
  }
}
