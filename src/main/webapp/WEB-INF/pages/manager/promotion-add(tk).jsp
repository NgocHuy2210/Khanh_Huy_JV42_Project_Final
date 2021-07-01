<%-- 
    Document   : promotion-add
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
        <title>Promotion Page</title>
        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/fontawesome-free/css/all.min.css"/>">
        <!-- daterange picker -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/daterangepicker/daterangepicker.css"/>">
        <!-- iCheck for checkboxes and radio inputs -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/icheck-bootstrap/icheck-bootstrap.min.css"/>">
        <!-- Bootstrap Color Picker -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css"/>">
        <!-- Tempusdominus Bootstrap 4 -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css"/>">
        <!-- Select2 -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/select2/css/select2.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css"/>">
        <!-- Bootstrap4 Duallistbox -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css"/>">
        <!-- BS Stepper -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/bs-stepper/css/bs-stepper.min.css"/>">
        <!-- dropzonejs -->
        <link rel="stylesheet" href="<c:url value="/resources-management/plugins/dropzone/min/dropzone.min.css"/>">
        <!-- Theme style -->
        <link rel="stylesheet" href="<c:url value="/resources-management/dist/css/adminlte.min.css"/>">
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
                            <c:if test="${action == 'add'}">
                                <h1>Add Promotion</h1>
                            </c:if>
                            <c:if test="${action != 'add'}">
                                <h1>Update Promotion</h1>
                            </c:if>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="<c:url value="/manager/index"/>">Home</a></li>
                                <c:if test="${action == 'add'}">
                                    <li class="breadcrumb-item active">Add Promotion</li>
                                </c:if>
                                <c:if test="${action != 'add'}">
                                    <li class="breadcrumb-item active">Update Promotion</li>
                                </c:if>
                            </ol>
                        </div>
                    </div>
                </div><!-- /.container-fluid -->
            </section>

            <!-- Main content -->
            <section class="content">
                <mvc:form id="quickForm" action="${pageContext.request.contextPath}/manager/result-promotion" method="POST" 
                  modelAttribute="promotion" >
                    <c:if test="${action == 'edit'}">
                        <input type="text" name="id" value="${promotion.id}" hidden />
                    </c:if>
                    
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
                                        <label for="inputName">Name</label>
                                        <input type="text" id="inputName" class="form-control" name="roomNumber" value="${promotion.name}">
                                    </div>
                                    <div class="form-group">
                                        <label for="inputDescription">Promotion Description</label>
                                        <textarea id="inputDescription" class="form-control" rows="4" name="description">${promotion.description}</textarea>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="inputStatus">Status</label>
                                        <select name="status" class="form-control">
                                            <option selected disabled>Select one</option>
                                            <c:forEach items="${status}" var="s">
                                                <c:if test="${room.status == s}">
                                                    <option value="${s}" selected>${s}</option> 
                                                </c:if>
                                                <c:if test="${room.status != s}">
                                                    <option value="${s}">${s}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputDiscount">Discount</label>
                                        <input type="number" id="inputDiscount" class="form-control" name="discount" value="${promotion.discount}">
                                    </div>
                                    <!-- Date -->
<!--                                    <div class="form-group">
                                        <label>Start Date:</label>
                                        <div class="input-group date">
                                            <input type="date" class="form-control datetimepicker-input" name="startDate" value="${promotion.startDate}"/>
                                        </div>
                                    </div>-->
                                    
<!--                                    <div class="form-group">
                                        <label for="dateRange">Date range:</label>
                                        <div class="input-group">
                                            <input type="text" name="dataRange" class="form-control" id="dateRange" autocomplete="off"/>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                  <i class="far fa-calendar-alt"></i>
                                                </span>
                                            </div>
                                        </div>
                                         /.input group 
                                        <input type="hidden" name="startDate" value="${promotion.startDate}"/>
                                        <input type="hidden" name="endDate" value="${promotion.endDate}"/>
                                    </div>-->
<!--                                    <div class="form-group">
                                        <label>Date range:</label>

                                        <div class="input-group">
                                          <div class="input-group-prepend">
                                            <span class="input-group-text">
                                              <i class="far fa-calendar-alt"></i>
                                            </span>
                                          </div>
                                          <input type="text" class="form-control float-right" id="reservation">
                                        </div>
                                         /.input group 
                                    </div>-->

                                    <!-- Date -->
                <div class="form-group">
                  <label>Date:</label>
                    <div class="input-group date" id="reservationdate" data-target-input="nearest">
                        <input type="text" class="form-control datetimepicker-input" data-target="#reservationdate"/>
                        <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                        </div>
                    </div>
                </div>
                <!-- Date and time -->
                <div class="form-group">
                  <label>Date and time:</label>
                    <div class="input-group date" id="reservationdatetime" data-target-input="nearest">
                        <input type="text" class="form-control datetimepicker-input" data-target="#reservationdatetime"/>
                        <div class="input-group-append" data-target="#reservationdatetime" data-toggle="datetimepicker">
                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                        </div>
                    </div>
                </div>
                <!-- /.form group -->
                <!-- Date range -->
                <div class="form-group">
                  <label>Date range:</label>

                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="far fa-calendar-alt"></i>
                      </span>
                    </div>
                    <input type="text" class="form-control float-right" id="reservation">
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->

                <!-- Date and time range -->
                <div class="form-group">
                  <label>Date and time range:</label>

                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="far fa-clock"></i></span>
                    </div>
                    <input type="text" class="form-control float-right" id="reservationtime">
                  </div>
                  <!-- /.input group -->
                </div>
                <!-- /.form group -->

                <!-- Date and time range -->
                <div class="form-group">
                  <label>Date range button:</label>

                  <div class="input-group">
                    <button type="button" class="btn btn-default float-right" id="daterange-btn">
                      <i class="far fa-calendar-alt"></i> Date range picker
                      <i class="fas fa-caret-down"></i>
                    </button>
                  </div>
                </div>
                <!-- /.form group -->
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
                                        <!-- select -->
                                        
                                      </div>
                                </div>
                              <!-- /.card-body -->
                            </div>
                        <!-- /.card -->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <a href="<c:url value="/manager/view-rooms"/>" class="btn btn-secondary">Cancel</a>
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
        
        
<!-- jQuery -->
<script src="<c:url value="/resources-management/plugins/jquery/jquery.min.js"/>"></script>
<!-- Bootstrap 4 -->
<script src="<c:url value="/resources-management/plugins/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
<!-- Select2 -->
<script src="<c:url value="/resources-management/plugins/select2/js/select2.full.min.js"/>"></script>
<!-- Bootstrap4 Duallistbox -->
<script src="<c:url value="/resources-management/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"/>"></script>
<!-- InputMask -->
<script src="<c:url value="/resources-management/plugins/moment/moment.min.js"/>"></script>
<script src="<c:url value="/resources-management/plugins/inputmask/jquery.inputmask.min.js"/>"></script>
<!-- date-range-picker -->
<script src="<c:url value="/resources-management/plugins/daterangepicker/daterangepicker.js"/>"></script>
<!-- bootstrap color picker -->
<script src="<c:url value="/resources-management/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"/>"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="<c:url value="/resources-management/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"/>"></script>
<!-- Bootstrap Switch -->
<script src="<c:url value="/resources-management/plugins/bootstrap-switch/js/bootstrap-switch.min.js"/>"></script>
<!-- BS-Stepper -->
<script src="<c:url value="/resources-management/plugins/bs-stepper/js/bs-stepper.min.js"/>"></script>
<!-- dropzonejs -->
<script src="<c:url value="/resources-management/plugins/dropzone/min/dropzone.min.js"/>"></script>
<!-- AdminLTE App -->
<script src="<c:url value="/resources-management/dist/js/adminlte.min.js"/>"></script>
<!-- AdminLTE for demo purposes -->
<script src="<c:url value="/resources-management/dist/js/demo.js"/>"></script>
<!-- Page specific script -->
<script>
  $(function () {
    //Initialize Select2 Elements
    $('.select2').select2()

    //Initialize Select2 Elements
    $('.select2bs4').select2({
      theme: 'bootstrap4'
    })

    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
    //Money Euro
    $('[data-mask]').inputmask()

    //Date picker
    $('#reservationdate').datetimepicker({
        format: 'L'
    });

    //Date and time picker
    $('#reservationdatetime').datetimepicker({ icons: { time: 'far fa-clock' } });

    //Date range picker
    $('#reservation').daterangepicker()
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({
      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        format: 'MM/DD/YYYY hh:mm A'
      }
    })
    //Date range as a button
    $('#daterange-btn').daterangepicker(
      {
        ranges   : {
          'Today'       : [moment(), moment()],
          'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month'  : [moment().startOf('month'), moment().endOf('month')],
          'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        startDate: moment().subtract(29, 'days'),
        endDate  : moment()
      },
      function (start, end) {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
      }
    )

    //Timepicker
    $('#timepicker').datetimepicker({
      format: 'LT'
    })

    //Bootstrap Duallistbox
    $('.duallistbox').bootstrapDualListbox()

    //Colorpicker
    $('.my-colorpicker1').colorpicker()
    //color picker with addon
    $('.my-colorpicker2').colorpicker()

    $('.my-colorpicker2').on('colorpickerChange', function(event) {
      $('.my-colorpicker2 .fa-square').css('color', event.color.toString());
    })

    $("input[data-bootstrap-switch]").each(function(){
      $(this).bootstrapSwitch('state', $(this).prop('checked'));
    })

  })
  // BS-Stepper Init
  document.addEventListener('DOMContentLoaded', function () {
    window.stepper = new Stepper(document.querySelector('.bs-stepper'))
  })

  // DropzoneJS Demo Code Start
  Dropzone.autoDiscover = false

  // Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
  var previewNode = document.querySelector("#template")
  previewNode.id = ""
  var previewTemplate = previewNode.parentNode.innerHTML
  previewNode.parentNode.removeChild(previewNode)

  var myDropzone = new Dropzone(document.body, { // Make the whole body a dropzone
    url: "/target-url", // Set the url
    thumbnailWidth: 80,
    thumbnailHeight: 80,
    parallelUploads: 20,
    previewTemplate: previewTemplate,
    autoQueue: false, // Make sure the files aren't queued until manually added
    previewsContainer: "#previews", // Define the container to display the previews
    clickable: ".fileinput-button" // Define the element that should be used as click trigger to select files.
  })

  myDropzone.on("addedfile", function(file) {
    // Hookup the start button
    file.previewElement.querySelector(".start").onclick = function() { myDropzone.enqueueFile(file) }
  })

  // Update the total progress bar
  myDropzone.on("totaluploadprogress", function(progress) {
    document.querySelector("#total-progress .progress-bar").style.width = progress + "%"
  })

  myDropzone.on("sending", function(file) {
    // Show the total progress bar when upload starts
    document.querySelector("#total-progress").style.opacity = "1"
    // And disable the start button
    file.previewElement.querySelector(".start").setAttribute("disabled", "disabled")
  })

  // Hide the total progress bar when nothing's uploading anymore
  myDropzone.on("queuecomplete", function(progress) {
    document.querySelector("#total-progress").style.opacity = "0"
  })

  // Setup the buttons for all transfers
  // The "add files" button doesn't need to be setup because the config
  // `clickable` has already been specified.
  document.querySelector("#actions .start").onclick = function() {
    myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED))
  }
  document.querySelector("#actions .cancel").onclick = function() {
    myDropzone.removeAllFiles(true)
  }
  // DropzoneJS Demo Code End
</script>
    </body>
</html>
