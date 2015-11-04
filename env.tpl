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
    <button type="submit" class="btn btn-default save">添加版本</button>
  </form>
  </div>


  <div class="row" style="padding-top: 20px;">
  <div class=".table-responsive">
    <table class="table table-striped table-bordered table-hover table-condensed">
      <thead>
        <th>版本</td>
        <th>状态</th>
        <th>操作</th>
      </thead>
      <tbody>
        {{$langs := .langs}}
        {{range $pid, $value:=.data}}
        {{$l := index $langs $pid}}
        {{$cn := index $l "cn"}}
        {{$en := index $l "en"}}
        {{$jp := index $l "jp"}}
        <tr>
          <td>
            {{$value.Ver}}
          </td>
          <td>
            {{if eq $value.State "1"}}
            失效
            {{else}}
            生效
            {{end}}
          </td>
          <td>
            <button type="button" class="btn btn-default btn-xs edit" data-cn-title="{{$cn.Title}}" data-cn-msg="{{$cn.Msg}}" data-cn-link="{{$cn.Link}}" data-en-title="{{$en.Title}}" data-en-msg="{{$en.Msg}}" data-en-link="{{$en.Link}}" data-jp-title="{{$jp.Title}}" data-jp-msg="{{$jp.Msg}}" data-jp-link="{{$jp.Link}}" data-id="{{$value.Id}}">编辑信息</button>
            <button type="button" class="btn btn-danger btn-xs delete" data-id="{{$value.Id}}">删除</button>
            {{if eq $value.State "1"}}
            <button type="button" class="btn btn-info btn-xs changestate" data-id="{{$value.Id}}" data-state="2">设为生效</button>
            {{else}}
            <button type="button" class="btn btn-info btn-xs changestate" data-id="{{$value.Id}}" data-state="1">设为失效</button>
            {{end}}
          </td>
        </tr>
        {{end}}
      </tbody>
    </table>
  </div>
  </div>
</div>

<div class="modal" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="editModalLabel">修改配置</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" style="padding-left: 40px; padding-right: 40px;">
          <div class="form-group">
            <label for="editCnTitle">cn-title</label>
            <input class="form-control" type="text" id="editCnTitle" value="" placeholder="cn-title">
          </div>
          <div class="form-group">
            <label for="editCnMsg">cn-msg</label>
            <input class="form-control" type="text" id="editCnMsg" value="" placeholder="cn-msg">
          </div>
          <div class="form-group">
            <label for="editCnLink">cn-link</label>
            <input class="form-control" type="text" id="editCnLink" value="" placeholder="cn-link">
          </div>

          <div class="form-group">
            <label for="editEnTitle">en-title</label>
            <input class="form-control" type="text" id="editEnTitle" value="" placeholder="en-title">
          </div>
          <div class="form-group">
            <label for="editEnMsg">en-msg</label>
            <input class="form-control" type="text" id="editEnMsg" value="" placeholder="en-msg">
          </div>
          <div class="form-group">
            <label for="editEnLink">en-link</label>
            <input class="form-control" type="text" id="editEnLink" value="" placeholder="en-link">
          </div>

          <div class="form-group">
            <label for="editJpTitle">jp-title</label>
            <input class="form-control" type="text" id="editJpTitle" value="" placeholder="jp-title">
          </div>
          <div class="form-group">
            <label for="editJpMsg">jp-msg</label>
            <input class="form-control" type="text" id="editJpMsg" value="" placeholder="jp-msg">
          </div>
          <div class="form-group">
            <label for="editJpLink">jp-link</label>
            <input class="form-control" type="text" id="editJpLink" value="" placeholder="jp-link">
            <input type="hidden" value="" id="editId">
          </div>


        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="editBtn">Save changes</button>
      </div>
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

    $(".edit").click(function(){
        var id = $(this).attr("data-id")

        var cnTitle = $(this).attr("data-cn-title")
        var cnMsg = $(this).attr("data-cn-msg")
        var cnLink = $(this).attr("data-cn-link")

        var enTitle = $(this).attr("data-en-title")
        var enMsg = $(this).attr("data-en-msg")
        var enLink = $(this).attr("data-en-link")

        var jpTitle = $(this).attr("data-jp-title")
        var jpMsg = $(this).attr("data-jp-msg")
        var jpLink = $(this).attr("data-jp-link")

        $("#editCnTitle").attr("value", cnTitle)
        $("#editEnTitle").attr("value", enTitle)
        $("#editJpTitle").attr("value", jpTitle)
        $("#editCnMsg").attr("value", cnMsg)
        $("#editEnMsg").attr("value", enMsg)
        $("#editJpMsg").attr("value", jpMsg)
        $("#editCnLink").attr("value", cnLink)
        $("#editEnLink").attr("value", enLink)
        $("#editJpLink").attr("value", jpLink)
        $("#editId").attr("value", id)

        $('#editModal').modal('show')
    })


    $(".save").click(function(){
        var ver = $("#ver").prop("value")
        $.post("/env/create", {ver:ver}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
    })

    $("#editBtn").click(function(){
        var cnTitle = $.trim($("#editCnTitle").prop("value"))
        var enTitle = $.trim($("#editEnTitle").prop("value"))
        var jpTitle = $.trim($("#editJpTitle").prop("value"))
        var cnMsg = $.trim($("#editCnMsg").prop("value"))
        var enMsg = $.trim($("#editEnMsg").prop("value"))
        var jpMsg = $.trim($("#editJpMsg").prop("value"))
        var cnLink = $.trim($("#editCnLink").prop("value"))
        var enLink = $.trim($("#editEnLink").prop("value"))
        var jpLink = $.trim($("#editJpLink").prop("value"))
        var id = $.trim($("#editId").prop("value"))
        var pdata = {cn_title: cnTitle, cn_msg: cnMsg, cn_link: cnLink, en_title: enTitle, en_msg: enMsg, en_link: enLink, jp_title:jpTitle, jp_msg: jpMsg, jp_link: jpLink, id: id}
        $.post("/env/update", pdata, function(data){
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
        $.post("/env/delete", {id: id}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
    })

    $(".changestate").click(function(){
        var id = $(this).attr("data-id")
        var state = $(this).attr("data-state")
        $.post("/env/change_state", {id: id, state: state}, function(data){
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
