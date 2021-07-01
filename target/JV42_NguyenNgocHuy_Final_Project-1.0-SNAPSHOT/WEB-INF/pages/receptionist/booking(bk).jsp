<%-- 
    Document   : booking
    Created on : Jun 23, 2021, 3:05:03 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bookings</title>
        
        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/fontawesome-free/css/all.min.css"/>">
        <!-- DataTables -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/datatables-responsive/css/responsive.bootstrap4.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/datatables-buttons/css/buttons.bootstrap4.min.css"/>">
        <!-- Theme style -->
        <link rel="stylesheet" href="<c:url value="/resources-management/dist/css/adminlte.min.css"/>">
        
    </head>
    <body class="hold-transition sidebar-mini">
        <jsp:include page="../include/management/menu-page.jsp" />
        <jsp:include page="../include/management/sidebar-container-page.jsp" />
        
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Bookings</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="<c:url value="/manager/index"/>">Home</a></li>
                                <li class="breadcrumb-item active">Bookings</li>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>
            <section class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-12">
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
                    
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">View all rooms</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body">
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Room Number</th>
                                                <th>Service Booking</th>
                                                <th>Promotion</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${sessionScope.myBookingDetailItems != null && fn:length(sessionScope.myBookingDetailItems) > 0}">
                                                <c:forEach items="${sessionScope.myBookingDetailItems}" var="item">
                                                    <tr>
                                                        <td>
                                                            <p>${item.value.room.roomNumber}</p>
                                                            <p>${item.value.room.price}</p>
                                                            <p>${item.value.room.roomTypeName}</p>
                                                            <img src="<c:url value="../resources-management/images/${item.value.room.imageName[0].name}"/>"  WIDTH="100" HEIGHT="100" style="border:1px solid black""/>
                                                        </td>
                                                        <td>
                                                            <c:forEach items="${item.value.services}" var="service">
                                                                <p>${item.value.service.name}</p>
                                                                <p>${item.value.service.price}</p>
                                                            </c:forEach>
                                                            <form action="${pageContext.request.contextPath}/updatebooking" method="post">
                                                                <input type="number" id="quantity" class="form-control" name="quantity" value="${item.value.service}"/>
                                                                <input name="productId" value="${item.value.room.id}" hidden/>
                                                                <button class="btn btn-info"
                                                                        type="submit" >Update</button>
                                                            </form>
                                                        </td>
                                                        <td>
                                                            <p>${item.value.discount}</p>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-success"
                                                                    onclick="location.href = '<c:url value="/booking-delete/${room.id}" />'">Delete</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${sessionScope.myBookingDetailItems == null || fn:length(sessionScope.myBookingDetailItems) <= 0}">
                                                 <tr><td colspan="12" style="color: red">No Value!!!</td></tr>
                                            </c:if>
                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <th>Room Number</th>
                                            <th>Service Booking</th>
                                            <th>Promotion</th>
                                            <th>Delete</th>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <!-- /.card-body -->
                            </div>
                            <!-- /.card -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>     
        <jsp:include page="../include/management/footer-page.jsp" />

        <!-- jQuery -->
        <script src="<c:url value="/resources-management/plugins/jquery/jquery.min.js"/>"></script>
        <!-- Bootstrap 4 -->
        <script src="<c:url value="/resources-management/plugins/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
        <!-- DataTables  & Plugins -->
        <script src="<c:url value="/resources-management/plugins/datatables/jquery.dataTables.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-responsive/js/dataTables.responsive.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-buttons/js/dataTables.buttons.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/jszip/jszip.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/pdfmake/pdfmake.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/pdfmake/vfs_fonts.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-buttons/js/buttons.html5.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-buttons/js/buttons.print.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/datatables-buttons/js/buttons.colVis.min.js"/>"></script>
        <!-- AdminLTE App -->
        <script src="<c:url value="/resources-management/dist/js/adminlte.min.js"/>"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="<c:url value="/resources-management/dist/js/demo.js"/>"></script>
        <!-- Page specific script -->
        <script>
          $(function () {
            $("#example1").DataTable({
              "responsive": true, "lengthChange": false, "autoWidth": false,
              "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
            }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
            $('#example2').DataTable({
              "paging": true,
              "lengthChange": false,
              "searching": false,
              "ordering": true,
              "info": true,
              "autoWidth": false,
              "responsive": true,
            });
          });
        </script>
    </body>
</html>
