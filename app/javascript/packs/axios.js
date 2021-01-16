import axios from 'axios'
import qs from 'qs'

//メタタグのCSRFトークンを取得する
const token = document.querySelector('meta[name=csrf-token]')
//axiosのオーバーライド
const axiosInstance = axios.create({
    headers: {
    'X-Requested-with': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : (token.content) ? token.getAttribute('content') : null
    },

    paramnSerializer: (params)=>{
        return qs.stringify(params,{arrayFormat: 'brackets'})
    } 


})

