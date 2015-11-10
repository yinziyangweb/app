<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>Bootstrap 101 Template</title>

<!-- Bootstrap -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body style="padding-top: 70px;">

<div class="container">

  <div class="row">
  <form class="form-inline" method="GET">
    <div class="form-group">
      <input type="text" class="form-control" id="ver" name="ver" placeholder="输入版本号">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="ad" name="ad" placeholder="输入ad(数字)">
    </div>
    <button type="submit" class="btn btn-default save">添加ad信息</button>
  </form>
  </div>


  <div class="row" style="padding-top: 20px;">
  <div class=".table-responsive">
    <table class="table table-striped table-bordered table-hover table-condensed">
      <thead>
        <th>版本</td>
        <th>ad</td>
        <th>操作</th>
      </thead>
      <tbody>
        {{range $pid, $value:=.data}}
        <tr>
          <td>
            {{$value.Ver}}
          </td>
          <td>
            <div class="col-xs-2">
            <input class="form-control input-sm edit-ad" type="text" value="{{$value.Ad}}">
            </div>
            <button type="button" class="btn btn-default btn-xs edit-ad-btn" data-ver="{{$value.Ver}}" data-app="{{$value.App}}">编辑ad</button>
          </td>
          <td>
            <button type="button" class="btn btn-danger btn-xs delete" data-id="{{$value.Id}}">删除</button>
          </td>
        </tr>
        {{end}}
      </tbody>
    </table>
  </div>
  </div>
</div>




<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
    function reloadPage(){
        window.location.href = window.location.href
    }

    $(".save").click(function(){
        var ver = $("#ver").prop("value")
        var ad = $("#ad").prop("value")
        $.post("/env/change_ad", {ver:ver, ad:ad}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
    })

    $(".edit-ad-btn").click(function(){
        var pid = $(".edit-ad-btn").index(this)
        var editAd = $.trim($(".edit-ad").eq(pid).prop("value"))
        var ver = $(this).attr("data-ver")
        $.post("/env/change_ad", {ver: ver, ad: editAd}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
    })

    $(".delete").click(function(){
        var id = $(this).attr("data-id")
        $.post("/ad/delete", {id: id}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
    })




})
</script>
</body>
</html>
