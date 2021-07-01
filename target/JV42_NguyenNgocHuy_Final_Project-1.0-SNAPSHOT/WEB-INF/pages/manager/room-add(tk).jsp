<%-- 
    Document   : roomtype-add
    Created on : Jun 23, 2021, 3:05:03 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="mvc" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Type Page</title>
        <jsp:include page="../include/management/manager/css-page.jsp" />
    </head>
    <body class="hold-transition sidebar-mini">
        <jsp:include page="../include/management/menu-page.jsp" />
        <jsp:include page="../include/management/sidebar-container-page.jsp" />
        
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Room Type Add</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="<c:url value="/manager/index"/>">Home</a></li>
                                <li class="breadcrumb-item active">Room Type Add</li>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>


            <!-- Main content -->
            <section class="content">
                <mvc:form id="quickForm" action="${pageContext.request.contextPath}/manager/result-roomtype" method="POST" 
                  modelAttribute="roomtype" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card card-primary">
                                <div class="card-header">
                                    <h3 class="card-title">General</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="inputName">Room Type Name</label>
                                        <input type="text" id="inputName" class="form-control" name="name" value="${roomtype.name}"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputDescription">Room Type Description</label>
                                        <textarea id="inputDescription" class="form-control" rows="4" name="description">${roomtype.description}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputStatus">Status</label>
                                        <select name="status" id="inputStatus" class="form-control custom-select">
                                            <option selected disabled>Select one</option>
                                            <c:forEach items="${status}" var="s">
                                                <c:if test="${roomtype.status == s}">
                                                    <option value="${s}" selected>${s}</option> 
                                                </c:if>
                                                <c:if test="${roomtype.status != s}">
                                                    <option value="${s}">${s}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputSize">Size</label>
                                        <input type="text" id="inputSize" class="form-control" name="sizeRoom" value="${roomtype.sizeRoom}"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputGuests">Guests</label>
                                        <input type="number" id="inputGuests" class="form-control" name="guests" value="${roomtype.guests}">
                                    </div>

                                    <!-- Date -->
                                    <div class="form-group">
                                        <label>Create Date:</label>
                                        <div class="input-group date">
                                            <input type="date" class="form-control datetimepicker-input" name="createDate" value="${roomtype.createDate}"/>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        <!-- /.card -->
                        </div>
                        <div class="col-md-6">
                            <div class="card card-secondary">
                                <div class="card-header">
                                    <h3 class="card-title">Others</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="col-sm-12">
                                        <!-- Select multiple-->
                                        <div class="form-group">
                                            <label>Select Promotions</label>
                                            <select size="9" multiple name="promotionsId" class="form-control">
                                                <c:forEach items="${promotions}" var="promotion">
                                                    <option value="${promotion.id}">${promotion.name}</option> 
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <!-- Select multiple-->
                                        <div class="form-group">
                                            <label>Select Convenients</label>
                                            <select size="9" multiple name="convenientsId" class="form-control">
                                                <c:forEach items="${convenients}" var="convenient">
                                                    <option value="${convenient.id}">${convenient.name}</option> 
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-12" >
                                        <label>Images</label>
                                        <c:if test="${action == 'add'}">
                                            <p>Files to upload: <input type="file" name="imagesUpload" accept="image/png, image/jpeg" multiple /></p>
                                        </c:if>
                                        <c:if test="${action != 'add'}">
                                            <c:forEach items="${roomType.images}" var="image">
                                                <img src="<c:url value="../resources-management/images/${image.name}"/>"  WIDTH="100" HEIGHT="100" style="border:1px solid black""/>
                                                <button class="btn btn-danger"
                                                    onclick="location.href = '<c:url value="/deleteImage/${image.id}" />'">Delete</button>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </div>
                              <!-- /.card-body -->
                            </div>
                        <!-- /.card -->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
    <!--                            <a href="#" class="btn btn-secondary">Cancel</a>-->
                            <div class="form-group">
                                <c:if test="${action == 'add'}">
                                    <button type="submit" class="btn btn-success float-right">Create</button>
                                </c:if>
                                <c:if test="${action != 'add'}">
                                    <button type="submit" class="btn btn-success float-right">Update</button>
                                </c:if>
                            </div>

                        </div>
                    </div>
                </mvc:form>
            </section>
            <!-- /.content -->
            
        </div>
        <!-- /.content-wrapper -->
        
        <jsp:include page="../include/management/footer-page.jsp" />
        <jsp:include page="../include/management/manager/js-page.jsp" />
        
        <!-- jquery-validation -->
        <script src="<c:url value="/resources-management/plugins/jquery-validation/jquery.validate.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/jquery-validation/additional-methods.min.js"/>"></script>
        
        <!-- Page specific script -->
        <script>
        $(function () {
          $.validator.setDefaults({
            submitHandler: function () {
              alert( "Form successful submitted!" );
            }
          });
          $('#quickForm').validate({
            rules: {
              name: {
                required: true
              },
              status: {
                required: true
              },
              sizeRoom: {
                required: true
              },
              guests: {
                required: true,
                minlength: 1
              }
            },
            messages: {
              name: "Please enter a name of room type",
              status: "Please select a status of room type",
              sizeRoom: "Please enter sizeroom of room type",
              guests: "Please enter number of guests of room type"
            },
            errorElement: 'span',
            errorPlacement: function (error, element) {
              error.addClass('invalid-feedback');
              element.closest('.form-group').append(error);
            },
            highlight: function (element, errorClass, validClass) {
              $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
              $(element).removeClass('is-invalid');
            }
          });
        });
        </script>
    </body>
</html>
