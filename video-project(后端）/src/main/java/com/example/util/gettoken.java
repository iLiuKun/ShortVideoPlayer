package com.example.util;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;

public class gettoken {
    String ACCESS_KEY = "cRmYPEHlq_MXaaXDumyuSAytL0JXd_5AKIyS9KyU";
    String SECRET_KEY = "V4PwodhSbs9YhGVS1RLBcvUdd_GkssAJQxTz5Hiq";
    //要上传的空间
    String bucketname = "xiaohuteam";
    //上传到七牛后保存的文件名.用不到
//    String key = "my-java.png";
    //上传文件的路径
//    String filePath = "/.../...";
    Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
    //对上传的视频触发转码，暂时不用
    //设置转码操作参数
//    String fops = "avthumb/mp4/s/640x360/vb/1.25m";
    //设置转码的队列
//    String pipeline = "default.sys";
//    String urlbase64 = UrlSafeBase64.encodeToString("目标Bucket_Name:自定义文件key");
//    String pfops = fops + "|saveas/" + urlbase64;
    public static void main(String args[]) {
        System.out.println("ACCESS_KEY");
        new gettoken().getUpToken();
    }
    // 覆盖上传
    public String getUpToken() {
        //<bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，已存在同名资源则会被本次覆盖。
        //如果希望只能上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
        //第三个参数是token的过期时间
        String token = auth.uploadToken(bucketname, null, 36000000,null);
        System.out.println(token);
        return token;
    }
}

