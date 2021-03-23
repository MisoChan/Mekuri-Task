
export default {
    methods: {
         //InputBoxの選択をする。
        selectId(id_string){
        
            document.getElementById(id_string).select();
        },
        //数値以外入力できなくする
        validateNum (e) {
            const charCode = (e.which) ? e.which : e.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) { // 数字入力のみ許可する
              e.preventDefault()
            } else {
              return true
            }
          },
          format (val) {
            if (!val) {
              return ''
            }
            const replaced = val.replace(/\D/g, '') // 数字以外を除去
            return replaced ? replaced : ''
          }
    

    }
}