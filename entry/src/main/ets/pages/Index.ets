


@Styles function KeyBoxStyleOther(){
  .width(60)
  .backgroundColor('#ffe0dddd')
  .height(60)
  .borderRadius(8)
}
@Styles function KeyBoxStyle(){
  .width(60)
  .backgroundColor(Color.White)
  .height(60)
  .borderRadius(8)
}

const nums:string[] = ['7', '8', '9', '4', '5', '6', '1', '2', '3', '0', '.']

@Entry
@Component
struct Index {

  //对于行列的进行规划
  columnsTemplate: string = '1fr 1fr 1fr 1fr'
  @State rowsTemp: string = '1fr 1fr 1fr 1fr 1fr'
  @State rows: number = 5

  @State expression: string = ''
  @State result: string = '0'
  @State excessive:string = ''   //对于计算结果的在相加
  @State excessiveSymbol:boolean = false //再相加的判断

  @State @Watch('aboutToAppear') isShowMore: boolean = false //用于判断是否要更多的的展示
  @State expressionFontSize: number = 40
  @State expressionColor: string = '#000000'
  @State resultFontSize: number = 30
  @State resultColor: string = '#000000'

  aboutToAppear(): void {
    this.JudgeIsMore(this.isShowMore)
  }

  JudgeIsMore(judge: boolean) {
    if (judge == true) {
      this.rowsTemp = '1fr 1fr 1fr 1fr 1fr 1fr'
      this.rows = 6
    } else {
      this.rowsTemp = '1fr 1fr 1fr 1fr 1fr'
      this.rows = 5
    }
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.three_dot'))
          .width(50)
          .height(50)
          .margin(20)
          .onClick(() => {
            this.isShowMore = !this.isShowMore
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Top) //位于顶端

      Column() {
        Row() {
          TextInput({ text: this.result })
            .fontSize(lengthSize(this.result))
            .fontColor(this.resultColor)
            .fontWeight(700)
            .textAlign(TextAlign.End)
            .backgroundColor(Color.White)
            .padding({ bottom: 20 })
            .animation({ duration: 500 })
        }
        .padding({ right: 15 })
        .justifyContent(FlexAlign.End)
        .width('100%')

        Divider().width('90%').color(Color.Black).height(20)

        Row() {
          TextInput({ text: this.expression })
            .textAlign(TextAlign.End)
            .backgroundColor(Color.White)
            .fontSize(lengthSize(this.expression))
            .fontColor(this.expressionColor)
            .animation({ duration: 500 })
        }
        .padding({ top: 5, bottom: 5 })
        .justifyContent(FlexAlign.End)
        .width('100%')
        .height(70)


        Grid() {
          //是否展开，根据按钮的不同有不同的情况
          if (this.isShowMore) {
            GridItem() {
              Image($r('app.media.rightbucket'))
                .width(30)
            }.KeyBoxStyleOther()
            .onClick(() => {
              this.expression += '('
              this.result = this.expression
              this.excessiveSymbol = false
            })

            GridItem() {
              Image($r('app.media.leftbucket'))
                .width(30)
            }.KeyBoxStyleOther()
            .onClick(() => {
              this.expression += ')'
              this.result = this.expression
              this.excessiveSymbol = false
            })

            GridItem() {
              Image($r('app.media.percent'))
                .width(30)
            }.KeyBoxStyleOther()
            .onClick(() => {
              this.expression += '!'
              this.result = this.expression
              this.excessiveSymbol = false
            })

            GridItem() {
              Image($r('app.media.mi'))
                .width(30)
            }.KeyBoxStyleOther()
            .onClick(() => {
              this.expression += '^'
              this.result = this.expression
              this.excessiveSymbol = false
            })
          }

          //原有键的布局
          GridItem() {
            Image($r('app.media.C'))
              .width(30)
          }.KeyBoxStyleOther()
          .onClick(() => { //对于数据的全部清除
            this.expression = ''
            this.excessive = ''
            this.excessiveSymbol = false
            this.result = '0'

            console.log('just '+JSON.stringify(this.excessiveSymbol))
          })

          GridItem() {
            Image($r('app.media.gf_obelus'))
              .width(30)
          }.KeyBoxStyleOther()
          .onClick(() => {
            this.expression = SymbolRecep(this.expression, '/')
            this.excessiveSymbol = false
            this.result = this.expression

          })

          GridItem() {
            Image($r('app.media.mul'))
              .width(30)
          }.KeyBoxStyleOther()
          .onClick(() => {
            this.expressionFontSize
            this.expression = SymbolRecep(this.expression, '*')
            this.excessiveSymbol = false
            this.result = this.expression
          })

          GridItem() {
            Image($r('app.media.delete_left'))
              .width(40)
          }.KeyBoxStyleOther()
          .onClick(() => { //删除最后一位数据
            this.expression = this.expression.slice(0, this.expression.length - 1)
            this.result = this.expression
          })

          GridItem() {
            Image($r('app.media.jiecheng'))
              .width(30)
          }
          .onClick(() => {
            this.expression = SymbolRecep(this.expression, '%')
            this.result = this.expression
            this.excessiveSymbol = false
          })
          .KeyBoxStyleOther()
          .rowStart(this.rows - 1)
          .rowEnd(this.rows - 1)
          .columnStart(0)
          .columnEnd(0)

          GridItem() {
            Image($r('app.media.minus'))
              .width(30)
          }
          .onClick(() => {
            this.expression = SymbolRecep(this.expression, '-')
            this.result = this.expression
            this.excessiveSymbol = false
          })
          .KeyBoxStyleOther()
          .rowStart(this.rows - 4)
          .rowEnd(this.rows - 4)
          .columnStart(3)
          .columnEnd(3)

          GridItem() {
            Image($r('app.media.plus'))
              .width(30)
          }.KeyBoxStyleOther()
          .onClick(() => {
            this.expression = SymbolRecep(this.expression, '+')
            this.result = this.expression
            this.excessiveSymbol = false
          })
          .rowStart(this.rows - 3)
          .columnStart(3)

          GridItem() {
            Text('=')
              .fontColor(Color.White)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
          }
          .onClick(() => {
            this.excessiveSymbol = true //已经再次相加
            this.expressionFontSize = lengthSize(this.expression)
            this.resultFontSize = lengthSize(this.result)

            console.log('just '+JSON.stringify(this.excessiveSymbol))

            this.result = total(this.expression).toString()
            this.expression = this.result
          })
          .KeyBoxStyleOther()
          .rowStart(this.rows - 2)
          .rowEnd(this.rows - 1)
          .columnStart(3)
          .height(130)
          .columnEnd(3)
          .backgroundColor('#ffff6b14')

          //循环加载数字键盘
          ForEach(nums, (item: string) => {
            GridItem() {
              Text(item)
                .fontSize(20)
                .fontWeight(700)
            }
            .onClick(() => {
              console.log('just '+JSON.stringify(this.excessiveSymbol))

              if(this.excessiveSymbol) {
                this.expression = item
              } else {
                this.expression += item
              }
              this.excessiveSymbol = false
              this.result = this.expression
            })
            .KeyBoxStyle()
          })
        }
        .rowsTemplate(this.rowsTemp)
        .columnsTemplate(this.columnsTemplate)
        .rowsGap(20)
        .columnsGap(8)
        .width('100%')
        .height(this.isShowMore == false ? '55%' : '65%')
        .animation({ duration: 200, curve: Curve.FastOutSlowIn, delay: 5 })
        .backgroundColor("#ffeeebed")
        .padding({
          bottom: 20,
          top: 20,
          left: 8,
          right: 8
        })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.End)
    }
  }
}

function total(expression: string):number {
  //检查是否含有这些符号
  if('+ - / % * ^ '.includes((expression[expression.length-1])))
    return NaN

  // 自动补全小数
  expression = Automatically_complete_the_decimal_point(expression)

  // 自动补全乘号
  expression = Autocomplete_multiplier_signs(expression)

  //expression 为 .3 时，正则表达式中的 \d+ 期望至少有一个数字开头，因此 .3 会被分为两个部分："." 和 "3"。
  //然而，由于正则表达式没有独立的模式来捕捉孤立的点，它仅匹配了数字 "3"，因此 tokens 数组只包含 "3"。
  // 使用正则划分出 整数或小数和符号的数组，修改正则表达式以支持负数
  let tokens: string[] = expression.match(/(\d+(\.\d+)?|\+|-|\*|\/|\%|\^|\(|\)|!)/g) || [];

  //用于检查输入的符号
  for(let i=0;i<tokens.length;i++) {
    console.log(tokens[i].toString())
  }

  let output: string[] = []
  let operations: string[] = []

  // 增加前一个token，用来判断!前是否有数字，以及判断-是否为负号
  let prevToken:string = 'NaN';

  for (let token of tokens) {
      // 是数字直接入栈（包括负数）
      if (!isNaN(Number(token))) {
        output.push(token)
      } else if (token == '(') {
        operations.push(token)
      } else if (token == '!') {
        if (isNaN(Number(prevToken)))  //判断前面有没有数字
          return NaN
        else
          operations.push(token)
      } else if (token == '-' && (prevToken == 'NaN' || prevToken == '(' || '+-*/%^'.includes(prevToken))) {
        // 处理负号的情况,用乘号进行处理
        output.push('-1')
        operations.push('*')
      } else {
        //栈顶优先级大于当前优先级，符号栈顶出栈
        while (operations.length > 0 && getPrecedence(operations[operations.length - 1]) >= getPrecedence(token)) {
          let op = operations.pop()
          if (op === '(')
            break
          if (op) {
            output.push(op)
          }
        }
        if (token != ')')
          operations.push(token)
      }
      prevToken = token;
    }

    while (operations.length > 0) {
      const op = operations.pop()
      if (op !== undefined&&op!='(')
        output.push(op)
    }

  console.log('以下为后缀表达式中的表示')

  for(let i=0;i<output.length;i++) {
    console.log(output[i])
  }

    //定义一个数组栈，用来计算最终结果
    let nums: number[] = []

    for (let value of output) {
      if (!isNaN(Number(value))) {
        nums.push(Number(value))
      } else if (value == '!') {
        let num1 = nums.pop()
        if (num1 !== undefined && isPositiveInteger(JSON.stringify(num1)) )
          nums.push(factorial(num1))
      } else {
        //左侧为空就是右侧，要不然是左侧
        let num1 = nums.pop() ?? 0
        let num2 = nums.pop() ?? 0
        switch (value) {
          case '+':
            nums.push(num2 + num1)
            break
          case '-':
            if(num2==0) {
              nums.push(num1)
            }
            else{
              nums.push(num2 - num1)
            }
            break
          case '/':
            if (num1 !== 0)
              if(num2==0) {
                nums.push(num1)
              }
              else{
                nums.push(num2 / num1)
              }
            else
              return NaN  // 除数为零
            break
          case '*':
            num1*=100000000000
            num2*=100000000000
            if(num2==0) {
              nums.push(num1/100000000000)
            }
            else{
              nums.push(num2/100000000000 * num1 /100000000000)
            }
            break
          case '%':
            if(num2==0) {
              nums.push(num1)
            }
            else{
              nums.push(num2 % num1)
            }
            break
          case '^':
            nums.push(Math.pow(num2, num1))
            break
        }
      }
    }
    return nums[0] ?? NaN
}

//计算出等级
function getPrecedence (op:string):number {
  switch(op){
    case '!':
      return 6
    case '^':
      return 4
    case '%':
      return 3
    case '*':
    case '/':
      return 2
    case '+':
    case '-':
      return 1
    case '(':
      case ')':
      return 0
    default :
      return -1
  }
}

//计算阶乘
function factorial(num: number): number {
  let result = 1;
  for (let i = 2; i <= num; i++) {
    result *= i;
  }
  return result;
}

//保证运算符只出现一次
function SymbolRecep(expression: string,chara:string): string {
  if (expression[expression.length-1] == '+' || expression[expression.length-1] == '-' ||
    expression[expression.length-1] == '*' || expression[expression.length-1] == '/' ||
    expression[expression.length-1] == '%' ) {
    return expression.slice(0, expression.length - 1) + chara
  } else
    return expression + chara
}

function lengthSize(expression: string): number {
  if(expression.length<12)
    return 40
  else if(expression.length<20)
    return 25
  else
    return 20
}

//自动补全小数的函数例如输入 .3 会按照 0.3 进行处理
function Automatically_complete_the_decimal_point(expression:string) :string {
  let newExpression = ''
  let prevSymbol = 'infinite'
  for (let symbol of expression) {
    if (symbol === '.' && ['+', '-', '/', '%', '*', '^', '(', ')', 'infinite'].includes(prevSymbol)) {
      // 如果当前符号是小数点，并且前一个符号是操作符或'infinite'，则在小数点前添加0
      newExpression += '0'
    }
    newExpression += symbol // 将当前符号添加到新的表达式中
    prevSymbol = symbol // 更新prevSymbol为当前符号
  }

  // 现在newExpression包含了修改后的表达式
  expression = newExpression
  return expression
}

//检查是否是正整数
function isPositiveInteger(str: string): boolean {
  // 检查字符串是否代表一个正整数
  const regex = /^[1-9]\d*|0$/
  return regex.test(str) && str.indexOf('.') === -1
}

//自动补全乘号
function Autocomplete_multiplier_signs(expression:string) :string {
  let newExpression = ''
  let prevSymbol = ''
  for (let symbol of expression) {
    if (symbol === '(' && !(['+', '-', '/', '%', '*', '^', 'infinite'].includes(prevSymbol))) {
      // 如果当前符号是小数点，并且前一个符号是操作符或'infinite'，则在小数点前添加0
      newExpression += '*'
    }
    newExpression += symbol // 将当前符号添加到新的表达式中
    prevSymbol = symbol // 更新prevSymbol为当前符号
  }

  // 现在newExpression包含了修改后的表达式
  expression = newExpression
  return expression


}