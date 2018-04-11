<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="wetechfn" uri="http://wetech.tech/admin/tags/wetech-functions" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style type="text/css">
    /*div#rMenu {
        position: absolute;
        visibility: hidden;
        padding: 2px;
        font-size: 14px;
    }

    div#rMenu ul {
        min-width: 50px;
    }*/
    div#rMenu {
        position: absolute;
        visibility: hidden;
        text-align: left;
        padding: 2px;
        width: auto;
        border: 1px
    }

    .dropdown-menu {
        background-color: #ffffff;
        border: 1px solid #ddd;
        box-shadow: 0 1px 8px rgba(0, 0, 0, 0.1);
        display: none;
        float: left;
        font-family: "Segoe UI", Helvetica, Arial, sans-serif;
        font-size: 14px;
        left: 0;
        list-style: outside none none;
        margin: 0;
        padding: 5px;
        position: absolute;
        text-shadow: none;
        top: 100%;
        z-index: 1000;
        min-width: 90px;
    }

    .dropdown-menu > li > a {
        clear: both;
        color: #333;
        display: block;
        font-weight: 400;
        line-height: 1.42857;
        padding: 3px 10px;
        white-space: nowrap;
    }

    .ztree li {
        padding: 0;
        margin: 0;
        list-style: none;
        line-height: 20px;
        text-align: left;
        white-space: nowrap
    }

    .ztree li span {
        margin-right: 2px;
        font-weight: lighter;
        font-size: 14px;
        color: #000;
        font-family: inherit;
    }
</style>
<section class="content-header" style="">
    <h1>
        日志管理
        <small>系统日志的管理页面</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">系统管理</a></li>
        <li class="active">日志管理</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="col-xs-12 col-sm-3">
                        <div class="panel panel-default">
                            <div class="panel-heading">组织机构树</div>
                            <div class="panel-body">
                                <ul id="tree" class="ztree"></ul>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading"><span class="fa fa-bookmark"></span> 提示</div>
                            <div class="panel-body">
                                鼠标单击右键操作树节点 : )
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-9">
                        <div class="panel panel-default">
                            <div class="panel-heading">组织机构树管理</div>
                            <div class="panel-body">
                                <form class="form-horizontal" onsubmit="return false;" id="editForm">
                                    <input type="hidden" name="id" required>
                                    <input type="hidden" name="available" required>
                                    <input type="hidden" name="parentId" required>
                                    <input type="hidden" name="parentIds" required>
                                    <div class="form-group">
                                        <label for="name" class="col-sm-2 control-label">组织机构名称<span class="asterisk"></span></label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="editName" name="name" placeholder="组织机构的名称" required>
                                            <div class="help-block with-errors"></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="eidtPriority" class="col-sm-2 control-label">序号</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" name="priority" id="eidtPriority" placeholder="节点的序号">
                                            <div class="help-block with-errors"></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10 text-right">
                                            <button type="submit" form="editForm" class="btn btn-primary" data-action="{type:'submit',form:'#editForm',url:'<%=request.getContextPath()%>/organization/update',after:'$.myAction.refreshContent'}">保存</button>
                                            <button type="reset" class="btn btn-warning">重置</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->

        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</section>

<!-- add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addModalLabel">添加节点</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" onsubmit="return false;">
                    <input type="hidden" name="parentId" required/>
                    <div class="form-group">
                        <label class="control-label" for="parentName">上级节点:</label>
                        <input type="text" class="form-control" id="parentName" name="parentName" placeholder="上级节点不存在" readonly required/>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="name">节点名称:</label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="节点的名称" required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="priority">排序:</label>
                        <input type="text" class="form-control" name="priority" id="priority" placeholder="节点的名称" required>
                        <div class="help-block with-errors"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" form="addForm" class="btn btn-primary"
                        data-action="{type:'submit',form:'#addForm',url:'<%=request.getContextPath()%>/organization/create',after:'$.myAction.refreshContent'}">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>

<!-- delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteSmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="deleteSmallModalLabel">删除节点</h4>
            </div>
            <div class="modal-body">
                <form id="deleteForm">
                    <input type="hidden" name="id">
                </form>
                确定要删除该节点?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" form="deleteForm" class="btn btn-primary"
                        data-action="{type:'submit',form:'#deleteForm',url:'<%=request.getContextPath()%>/organization/delete',after:'$.myAction.refreshContent'}">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>

<%-- 隐藏的右键菜单 --%>
<div id="rMenu">
    <ul role="menu" class="dropdown-menu" aria-labelledby="dropdownMenu3">
        <li data-toggle="modal" data-target="#addModal"><a href="#organization" id="rAdd-chi">添加子节点</a></li>
        <%--<li role="separator" class="divider"></li>--%>
        <li data-toggle="modal" data-target="#deleteModal"><a href="#organization" id="rDel">删除节点</a></li>
    </ul>
</div>
<script type="text/javascript">
    $(function () {

        var pathURL = path + '/organization/',
            createURL = pathURL + 'create',
            updateURL = pathURL + 'update';

        var rMenu = $('#rMenu'),
            setting = {
                data: {
                    simpleData: {
                        enable: true
                    }
                },
                callback: {
                    asyncError: zTreeOnAsyncError, // 加载错误的fun
                    beforeClick: beforeClick, // 捕获单击节点之前的事件回调函数
                    onRightClick: OnRightClick
                }
            },
            zNodes = [
                <c:forEach items="${organizationList}" var="o">
                {
                    id:${o.id},
                    pId:${o.parentId},
                    name: "${o.name}",
                    parentIds: "${o.parentIds}",
                    available: ${o.available},
                    priority: '${o.priority}',
                    open:${o.rootNode}
                },
                </c:forEach>
            ];

        $(document).ready(function () {
            $.fn.zTree.init($("#tree"), setting, zNodes);
        });

        // 加载错误的fun
        function zTreeOnAsyncError(event, treeId, treeNode) {
            alert('数据加载失败!');
        }

        // 点击之后的动作
        function beforeClick(treeId, treeNode) {
            // 销毁表单验证
            $('#editForm').validator('destroy');
            // 取消被选中状态
            $('#editForm [type="radio"]').removeAttr('checked');
            // 将值赋给编辑表单
            $.each(treeNode, function (key, value) {
                if ($('#editForm [name="' + key + '"]').attr('type') == 'radio') {
                    $('#editForm [name="' + key + '"][value="' + value + '"]').prop('checked', true);
                } else {
                    $('#editForm [name="' + key + '"]').val(value);
                }
            });
            $('#editForm [name="parentId"]').val(treeNode.pId ? treeNode.pId : "0");
        }

        //  右键触发事件
        // 在ztree上的右击事件
        function OnRightClick(event, treeId, treeNode) {
            // 是否叶子节点
            try {
                // 在这里运行代码
                showRMenu(event.clientX, event.clientY, treeNode.id, treeNode.name, treeNode.pId, treeNode);
            } catch (err) {
                // 在这里处理错误
                console.log(err);
            }
        }

        // 显示右键菜单
        function showRMenu(x, y, id, pName, pId, treeNode) {
            $('#addForm [name="parentId"]').val(id);
            $('#addForm [name="parentName"]').val(pName);
            $('#deleteForm [name="id"]').val(id);
            $('#rMenu ul').show();
            // 是否父id为0
            if (treeNode.isParent) {
                $('#rDel').hide();
            } else {
                $('#rDel').show();
            }

            rMenu.css({
                "top": y + "px",
                "left": x + "px",
                "visibility": "visible"
            }); // 设置右键菜单的位置、可见
            $("body").bind("mousedown", onBodyMouseDown);
        }

        // 隐藏右键菜单
        function hideRMenu() {
            if (rMenu)
                rMenu.css({
                    "visibility": "hidden"
                }); // 设置右键菜单不可见
            $("body").unbind("mousedown", onBodyMouseDown);
        }

        // 鼠标按下事件
        function onBodyMouseDown(event) {
            if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
                rMenu.css({
                    "visibility": "hidden"
                });
            }
        }

        //  rDel删除节点
        $('#rDel').click(function () {
            var id = $('#addForm [name="parentId"]').val();
        });
    });
</script>