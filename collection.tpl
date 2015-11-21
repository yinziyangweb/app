<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>合集编辑页面</title>

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
  <form class="form-inline" method="POST" action="collection/create">
    <div class="form-group">
      <input type="text" class="form-control" id="name" name="name" value="" placeholder="填入合集名称">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="icon" name="icon" value="" placeholder="填入合集图片">
    </div>
    <button type="submit" class="btn btn-default add-btn">添加</button>
    <a href="#" class="btn btn-primary batch-btn">保存所有</a>
  </form>
  </div>


  <div class="row" style="padding-top: 20px;">
    <div id="sortTrue" class="list-group">

      {{range .data}} 
      <div class="list-group-item">
        <table class="table table-striped table-bordered table-hover table-condensed">
          <tr>
            <td>
              {{.Id}}
            </td>
            <td>
		      <input type="text" class="form-control input-sm name" value="{{.Name}}">
            </td>
            <td class="text-left">
		      <input type="text" class="form-control input-sm icon" value="{{.Icon}}">
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
		      <button type="button" value="{{.Id}}" class="btn btn-primary btn-sm save-btn">保存</button>
              <a href="collection/music/edit?id={{.Id}}" class="btn btn-primary btn-sm">添加音乐</a>
              <button type="button" value="{{.Id}}" class="btn btn-danger btn-sm delete-btn">删除合集</button>
            </td>
          </tr>
        </table>
      </div>
      {{end}}
    </div>
  </div>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="/js/bootstrap.min.js"></script>
<script src="/js/Sortable.js"></script>
<script>
$(document).ready(function(){

    Sortable.create(sortTrue, {
        group: "sorting",
        sort: true
    });

	$(".add-btn").click(function(){
		var name = $.trim($("#name").prop("value"))
		var icon = $.trim($("#icon").prop("value"))
		if(name==""){
			alert("合集名称不能为空")
			return false
		}
		if(icon==""){
			alert("合集图片不能为空")
			return false
		}

		$.post("/collection/create", {name:name, icon:icon}, function(data){
			if(data!="success"){
				alert(data)
				return false
			}else{
				reloadPage()
			}
		})
		return false
	})


	$(".delete-btn").click(function(){
		var collection_id = $(this).attr("value")
		$.post("/collection/delete", {id: collection_id}, function(data){
			if(data!="success"){
				alert(data)
				return false
			}else{
				reloadPage()
			}
		})
	})

	$(".save-btn").click(function(){
		var pid = $(".save-btn").index(this)
		var collection_id = $(this).attr("value")
		var name = $(".name").eq(pid).prop("value")
		var icon = $(".icon").eq(pid).prop("value")
        var state = $(".state").eq(pid).prop("value")
        var order_id = $(".order-id").eq(pid).prop("value")
		$.post("/collection/edit", {id: collection_id, name: name, icon: icon, state: state, order_id: order_id}, function(data){
			if(data!="success"){
				alert(data)
				return false
			}else{
				reloadPage()
			}
		})
	})


    $(".batch-btn").click(function(){
        $.ajaxSetup({ 
            async : false 
        }); 
        var all_len = $(".name").length
        $(".name").each(function(){
            var pid = $(".name").index(this)
            var collection_id = $(".save-btn").eq(pid).prop("value")
            var name = $(".name").eq(pid).prop("value")
            var icon = $(".icon").eq(pid).prop("value")
            var state = $(".state").eq(pid).prop("value")
            var order_id = all_len-pid
            var post_data = {id: collection_id, name: name, icon: icon, state: state, order_id: order_id}
            console.log(post_data)
		    $.post("/collection/edit", {id: collection_id, name: name, icon: icon, state: state, order_id: order_id}, function(data){
            })
        })
	    reloadPage()
    })



    function reloadPage(){
        window.location.href = window.location.href
    }
    //$("#group").change(function(){
    //    $("#group_name").attr("value", $(this).find("option:selected").text())
    //})

    //$("#add-btn").click(function(){
    //    var singerName = $.trim($("#singer_name").prop("value"))
    //    var tag = $.trim($("#tag").prop("value"))
    //    var group = $.trim($("#group").prop("value"))
    //    var groupName = $.trim($("#group_name").prop("value"))
    //    var country = $.trim($("#country").prop("value"))
    //    if(singerName.length=="" || tag=="" || group=="" || groupName=="" || country==""){
    //        alert("信息不全无法添加") 
    //        return false
    //    }else{
    //        return true
    //    }
    //})
})
</script>
</body>
</html>
