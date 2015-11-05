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
  <form class="form-inline" method="POST" action="/banner/create">
    <div class="form-group">
      <input type="text" class="form-control" id="icon" name="icon" placeholder="icon">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="title" name="title" placeholder="title">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="link" name="link" placeholder="link">
    </div>
    <button type="submit" class="btn btn-default create">添加</button>
  </form>
  </div>


  <div class="row" style="padding-top: 20px;">
  <div class=".table-responsive">
    <table class="table table-striped table-bordered table-hover table-condensed">
      <thead>
        <th>icon</th>
        <th>title</th>
        <th>link</th>
        <th>排序号</th>
        <th>状态</th>
        <th>操作</th>
      </thead>
      <tbody>
        {{range .data}} 
        <tr>
          <td>
            <input type="text" value="{{.Icon}}" class="icon form-control" />
          </td>
          <td>
            <input type="text" value="{{.Title}}" class="title form-control" />
          </td>
          <td>
            <input type="text" value="{{.Link}}" class="link form-control" />
          </td>
          <td>
            <input type="text" value="{{.OrderId}}" class="order-id form-control" />
          </td>
          <td>
            {{$state := .State}}
            <select type="text" class="state form-control">
              <option value="1" {{if eq $state "1"}}selected="selected"{{end}}>失效</option>
              <option value="2" {{if eq $state "2"}}selected="selected"{{end}}>生效</option>
            </select>
          </td>
          <td>
            <button type="button" value="{{.Id}}" class="btn btn-default save">保存修改</button>
            <button type="button" value="{{.Id}}" class="btn btn-danger delete">删除</button>
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
        var pid = $(".save").index(this)
        var icon = $(".icon").eq(pid).prop("value")
        var title = $(".title").eq(pid).prop("value")
        var link = $(".link").eq(pid).prop("value")
        var state = $(".state").eq(pid).prop("value")
        var order_id = $(".order-id").eq(pid).prop("value")
        var id = $(this).attr("value")
        $.post("/banner/update", {id:id, icon:icon, title:title, link:link, order_id:order_id, state:state}, function(data){
			if(data!="success"){
			    alert(data)
			    return false
			}else{
			    alert(data)
                reloadPage()
			}
        })
    })

    $(".create").click(function(){
        var icon = $("#icon").prop("value")
        var title = $("#title").prop("value")
        var link = $("#link").prop("value")
        $.post("/banner/create", {icon:icon, title:title, link:link}, function(data){
			if(data!="success"){
			    alert(data)
			    return false
			}else{
			    alert(data)
                reloadPage()
			}
        })
		return false
    })


    $(".delete").click(function(){
        var id = $(this).attr("value")
        $.post("/banner/delete", {id:id}, function(data){
			if(data!="success"){
			    alert(data)
			    return false
			}else{
			    alert(data)
                reloadPage()
			}
        })
    })
})
</script>
</body>
</html>
