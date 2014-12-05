<div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
        <a class="bds_qzone"></a>
        <a class="bds_tsina"></a>
        <a class="bds_tqq"></a>
        <a class="bds_renren"></a>
        <a class="bds_t163"></a>
        <span class="bds_more">更多</span>
        <a class="shareCount"></a>
</div>
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=0" ></script>
<script type="text/javascript" id="bdshell_js"></script>
<script type="text/javascript">
    document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
</script>
<script>
  var dataForWeixin = {
    "appid": '',
    "img_url": 'http://fantasyshao.qiniudn.com/logo.png',
    "link": location.href,
    "title": document.querySelector('title').innerHTML,
    "desc": document.querySelector('meta[name="description"]').getAttribute('content')
  };

  var onBridgeReady = function() {
    try {
      // 分享給好友
      WeixinJSBridge.on('menu:share:appmessage', function(argv) {
        WeixinJSBridge.invoke('sendAppMessage', dataForWeixin, function(res) {});
      });
      // 分享到朋友圈
      WeixinJSBridge.on('menu:share:timeline', function(argv) {
        WeixinJSBridge.invoke('shareTimeline', dataForWeixin, function(res) {});
      });
      // 分享到騰訊微博
      WeixinJSBridge.on('menu:share:weibo', function(argv) {
        WeixinJSBridge.invoke('shareWeibo', dataForWeixin, function(res) {});
      });
    } catch(e) {
      console.debug(e);
    }
  };

  document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
</script>
