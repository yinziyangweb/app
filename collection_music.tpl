<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>合集音乐编辑页面</title>

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

  <!--<div class="row">
  <form class="form-inline" method="POST" action="collection/create">
    <div class="form-group">
      <input type="text" class="form-control" id="name" name="name" value="" placeholder="填入合集名称">
    </div>
    <button type="submit" class="btn btn-default add-btn">添加</button>
  </form>
  </div>-->


  <div class="row col-md-12" style="padding-top: 20px;">
    <div class="col-md-6">
    <span id="collection_id" value="{{.data.Id}}" style="display:none"></span>
    <span>合集{{.data.Name}}的歌曲列表:</span>
    <div class=".table-responsive" style="padding-top: 35px;">
      <table class="table table-striped table-bordered table-hover table-condensed">
        <thead>
          <th>music_id</td>
          <th>音乐名称</th>
          <th>操作</th>
        </thead>
        <tbody class="musics">
          {{range .musics}}
          <tr class="dis_row">
            <td class="music_id">
              {{.Id}}
            </td>
            <td class="music_name">
              {{.MusicName}}
            </td>
            <td>
              <button type="button" class="btn btn-danger btn-xs dis_music_btn">删除歌曲</button>
            </td>
          </tr>
          {{end}}
        </tbody>
      </table>
    </div>
    </div>

    <div class="col-md-6">
      <form class="form-inline" onkeydown="if(event.keyCode==13){return false;}">
        <div class="form-group">
          <input type="text" class="form-control" id="name" name="name" value="" placeholder="填入音乐名">
        </div>
        <button type="button" class="btn btn-default search">搜索</button>
        <button type="button" class="btn btn-default batch">批量添加选中数据</button>
        <a href="../" class="btn btn-default pull-right">返回合集列表</a>
      </form>

      <div class=".table-responsive" style="padding-top: 20px;">
        <table class="table table-striped table-bordered table-hover table-condensed">
          <thead>
            <th class="text-center">
              <input type="checkbox" class="check_all">
            </th>
            <th>music_id</td>
            <th>音乐名称</th>
            <th>操作</th>
          </thead>
          <tbody class="search_musics">
            {{range .search_musics}}
            <tr class="search_row">
              <td class="text-center">
                <input type="checkbox" class="check_music_id">
              </td>
              <td class="search_music_id">
                {{.Id}}
              </td>
              <td class="search_music_name">
                {{.MusicName}}
              </td>
              <td>
                <button type="button" class="btn btn-default btn-xs search_music_btn">添加歌曲</button>
              </td>
            </tr>
            {{end}}
          </tbody>
        </table>
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

    $(".search").click(function(){
        var music_name = $("#name").prop("value")
        $.getJSON("../../search_music", {music_name: music_name}, function(data){
            $(".check_all").attr("checked", false)
            $(".search_music_id").html("")
            $(".search_music_name").html("")
            $(".check_music_id").attr("checked", false)
            $(".search_row").hide()
            if(data==null){
                return false
            }else{
                //$(".search_musics").empty()
                for(i=0; i<data.length; i++){
                    $(".search_music_id").eq(i).html(data[i].music_id)
                    $(".search_music_name").eq(i).html(data[i].song_name)
                    $(".search_row").eq(i).show()
                }
            }
        })
    })

    $(".search_music_btn").click("click", function(){
        var pid = $(".search_music_btn").index(this)
        var music_id = $.trim($(".search_music_id").eq(pid).html())
        var collection_id = $("#collection_id").attr("value")
        $.post("create", {collection_id: collection_id, music_id: music_id}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
        //var music_name = $.trim($(".search_music_name").eq(pid).html())
        //$(".musics").append("<tr class='dis_row'><td class='music_id'>"+music_id+"</td><td class='music_name'>"+music_name+"</td><td><button type='button' class='btn btn-danger btn-xs dis_music_btn'>删除歌曲</button></td></tr>")
        //$(".search_row").eq(pid).remove()
    })

    $(".dis_music_btn").click("click", function(){
        var pid = $(".dis_music_btn").index(this)
        var music_id = $.trim($(".music_id").eq(pid).html())
        var collection_id = $("#collection_id").attr("value")
        $.post("delete", {collection_id: collection_id, music_id: music_id}, function(data){
            if(data=="success"){
                reloadPage()
            }else{
                alert(data)
                return false
            }
        })
        //var music_name = $.trim($(".music_name").eq(pid).html())
        //$(".search_musics").append("<tr class='search_row'><td class='search_music_id'>"+music_id+"</td><td class='search_music_name'>"+music_name+"</td><td><button type='button' class='btn btn-default btn-xs search_music_btn'>添加歌曲</button></td></tr>")
        //$(".dis_row").eq(pid).remove()
    })

    $(".batch").click(function(){
        $.ajaxSetup({
            async : false
        });
        var collection_id = $("#collection_id").attr("value")
        var push_data = false
        $(".check_music_id").each(function(){
            if($(this).prop("checked")==true){
                var pid = $(".check_music_id").index(this)
                var music_id = $.trim($(".search_music_id").eq(pid).html())
                $.post("create", {collection_id: collection_id, music_id: music_id}, function(data){
                })
                push_data = true
            }
        })
        if(push_data==false){
            alert("没有选中任何数据")
        }else{
            reloadPage()
        }
    })


    $(".check_all").click(function(){
        if($(this).prop("checked")==true){
            $(".check_music_id").prop("checked", true)
        }else{
            $(".check_music_id").prop("checked", false)
        }
    })
})
</script>
</body>
</html>
