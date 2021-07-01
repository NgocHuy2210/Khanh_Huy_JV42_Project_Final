<%-- 
    Document   : view-available-rooms
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
        <!-- iCheck for checkboxes and radio inputs -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/icheck-bootstrap/icheck-bootstrap.min.css"/>">
        <!-- Theme style -->
        <link rel="stylesheet" href="<c:url value="/resources-management/dist/css/adminlte.min.css"/>">
        <!-- daterange picker -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/daterangepicker/daterangepicker.css"/>">
        
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
                            <h1>All rooms available for booking</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="<c:url value="/manager/index"/>">Home</a></li>
                                <li class="breadcrumb-item active">All rooms available for booking</li>
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
                                    <h3 class="card-title">View All rooms available for booking</h3>
                                </div>
                                <!-- /.card-header -->
                                <div class="card-body">
                                    <!-- Date -->
                                    <div class="form-group">
                                        <label>Check in - Check out date:</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="dateRange" autocomplete="off"/>
                                            <input type="hidden" id="tomorrow" value="${tomorrow}"/>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                  <i class="far fa-calendar-alt"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <input type="hidden" name="checkinDate"/>
                                        <input type="hidden" name="checkoutDate"/>
                                    </div>
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Room Available</th>
                                                <th>Service Available</th>
                                                <th>Total Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                                <c:forEach items="${rooms}" var="room">
                                                    <tr>
                                                        <td>
                                                            <img src="<c:url value="../resources-management/images/${room.images[0].name}"/>"
                                                                 WIDTH="700" HEIGHT="380" style="border:1px solid black""/>
                                                            <br><b>Room Number:</b> ${room.roomNumber}
                                                            &nbsp;<b>Convenients:</b>
                                                                <c:forEach items="${room.convenients}" var="convenient">
                                                                    ${convenient.name},
                                                                </c:forEach>
                                                            
                                                            &nbsp;<b>Number of bed:</b> ${room.numberOfBed}
                                                            <br><b>Room Type:</b> ${room.roomType.name}
                                                            &nbsp;<b>Size of room:</b> ${room.roomType.sizeRoom}
                                                            &nbsp;<b>Guests:</b> ${room.roomType.guests}
                                                            <br><b>Original Price:</b>
                                                                <fmt:setLocale value = "vi_VN" scope="session"/>
                                                                <fmt:formatNumber type="currency" value="${room.price}" />
                                                            <div class="card">
                                                                <div class="card-header">
                                                                  <h3 class="card-title">Promotions</h3>
                                                                </div>
                                                                <!-- /.card-header -->
                                                                <div class="card-body p-0">
                                                                  <table class="table table-striped">
                                                                    <thead>
                                                                      <tr>
                                                                        <th>#</th>
                                                                        <th>Name</th>
                                                                        <th>Discount (%)</th>
                                                                        <th>Price</th>
                                                                        <th>Select?</th>
                                                                      </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach items="${room.discounts}" var="discount" varStatus="status">
                                                                            <tr>
                                                                                <td>${status.count}.</td>
                                                                                <td>${discount.name}</td>
                                                                                <td>${discount.discount}</td>
                                                                                <td>
                                                                                    <fmt:setLocale value = "vi_VN" scope="session"/>
                                                                                    <fmt:formatNumber type="currency" value="${room.price * (1 - discount.discount/100)} " />
                                                                                </td>
                                                                                <td>
                                                                                    <div class="form-check">
                                                                                        <input class="form-check-input" type="checkbox" checked>
                                                                                        
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    
                                                                    </tbody>
                                                                  </table>
                                                                </div>
                                                                <!-- /.card-body -->
                                                              </div>
                                                        </td>
                                                        <td>
                                                            <c:forEach items="${services}" var="service" varStatus="status">
                                                                <b>Service ${status.count}</b>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" checked>
                                                                    <label class="form-check-label"><b>Name: </b>${service.name}<br><b>Price: </b>${service.price}
                                                                    </label>
                                                                </div>
                                                            </c:forEach>
                                                            
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </c:forEach>
                                            
                                            
                                        </tbody>
                                        <tfoot>
                                        <tr>
                                            <th>Room Available</th>
                                            <th>Service Available</th>
                                            <th>Total Price</th>
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
        <!-- date-range-picker -->
        <script src="<c:url value="/resources-management/plugins/moment/moment.min.js"/>"></script>
        <script src="<c:url value="/resources-management/plugins/daterangepicker/daterangepicker.js"/>"></script>
        <!-- Page specific script -->
        <script>
          $(function () {
            $("#example1").DataTable({
              "responsive": true, "lengthChange": false, "autoWidth": false
            }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
            $('#example2').DataTable({
              "paging": true,
              "lengthChange": false,
              "searching": true,
              "ordering": true,
              "info": true,
              "autoWidth": false,
              "responsive": true,
            });
          });
        
        var tomorrow = $('#tomorrow').val();
    
        var $dateRange = $('#dateRange');
        $dateRange.daterangepicker({
            locale: {
                format: 'YYYY-MM-DD'
            },
            minDate: tomorrow
        });
        $dateRange.on('apply.daterangepicker', function (ev, picker) {
            $('input[name="checkinDate"]').val(picker.startDate.format('YYYY-MM-DD'));
            $('input[name="checkoutDate"]').val(picker.endDate.format('YYYY-MM-DD'));
        });
        </script>
    </body>
</html>
