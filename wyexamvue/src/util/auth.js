import VueCookies from 'vue-cookies'

const TokenKey = 'VUE-TOKEN'

export function getToken(){
    return VueCookies.get(TokenKey)
}

export function setToken(token){
    let t = VueCookies.get("uInfo")
    if(t){
        console.log("yes")
        console.log(t)
        console.log(token)
        return VueCookies.set(t)
    }
    return ''
}

export function removeToken(){
    return VueCookies.remove(TokenKey)
}