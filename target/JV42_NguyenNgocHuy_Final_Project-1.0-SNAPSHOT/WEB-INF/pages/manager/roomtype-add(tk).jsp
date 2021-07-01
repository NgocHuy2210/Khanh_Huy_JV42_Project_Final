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
            <div class="row">
                <div class="col-sm-12">
                    <c:if test="${type != null && type == 'error'}">
                        <div class="alert alert-danger">
                            ${message}
                        </div>
                    </c:if>
                    <c:if test="${type != null && type == 'success'}">
                        <div class="alert alert-success">
                            ${message}
                        </div>
                    </c:if>
                </div>
            </div>
            
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
                    <div class="container-fluid">
                        <div class="row">
                            <!-- left column -->
                            <div class="col-md-12">
                                <!-- jquery validation -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Quick Example <small>jQuery Validation</small></h3>
                                    </div>
                                    <!-- /.card-header -->
                                    <!-- form start -->
                                    <form id="quickForm">
                                        <div class="card-body">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">Email address</label>
                                                <input type="email" name="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Password</label>
                                                <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                            </div>
                                            <div class="form-group mb-0">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" name="terms" class="custom-control-input" id="exampleCheck1">
                                                    <label class="custom-control-label" for="exampleCheck1">I agree to the <a href="#">terms of service</a>.</label>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.card-body -->
                                      <div class="card-footer">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                      </div>
                                    </form>
                                </div>
                                <!-- /.card -->
                                </div>
                            <!--/.col (left) -->
                            <!-- right column -->
                            <div class="col-md-6">

                            </div>
                            <!--/.col (right) -->
                        </div>
                        <!-- /.row -->
                    </div><!-- /.container-fluid -->
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
              email: {
                required: true,
                email: true,
              },
              password: {
                required: true,
                minlength: 5
              },
              terms: {
                required: true
              },
            },
            messages: {
              email: {
                required: "Please enter a email address",
                email: "Please enter a vaild email address"
              },
              password: {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long"
              },
              terms: "Please accept our terms"
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
