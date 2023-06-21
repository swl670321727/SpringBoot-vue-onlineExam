// 配置一下跨域
module.exports={
    devServer:{
        proxy:{
            'API':{
                target:'http://localhost:8080',
                changeOrigin:true,
                pathRewrite:{
                    '^/API':''//代替target的内容
                }
            }
        }
    }
}