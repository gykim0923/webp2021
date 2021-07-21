/**
 * Created by 전병욱 on 2017-07-01.
 */
var checked = 0;
var student_id = new Array();
var checked_id = new Array();
var manage_studnet = new Array();
var manage_council = new Array();
var manage_assist = new Array();
var manage_pro = new Array();
var manage_admin = new Array();
var phase = 0;
student_id[0] = 'admin';
student_id[1] = 201612923;

function set_grad(index) {
    console.log(index);
    $("#date_filter").val(index);
}

function set_phase(index) {
    console.log(index);
    $("#stage_filter").val(index);
}

function set_sort(index) {
    console.log(index);
    $("#order_by").val(index);
}

function select_all() {
    console.log("all");
    $("#memo_target option:eq(1)").attr("selected", "selected");
}
function autoselect(num) {
    $("#memo_target").val(num);
}

function check_all() {
    if ($("#checkall").prop("checked")) {
        $(".chk").prop("checked", true);
    } else {
        $(".chk").prop("checked", false);
    }
}
function check_all_num(num) {
    if (num == 1) {
        if ($("#checkall1").prop("checked")) {
            $(".chk1").prop("checked", true);
        } else {
            $(".chk1").prop("checked", false);
        }
    }
    else if (num == 2) {
        if ($("#checkall2").prop("checked")) {
            $(".chk2").prop("checked", true);
        } else {
            $(".chk2").prop("checked", false);
        }
    }
    else if (num == 3) {
        if ($("#checkall3").prop("checked")) {
            $(".chk3").prop("checked", true);
        } else {
            $(".chk3").prop("checked", false);
        }
    }
    else if (num == 4) {
        if ($("#checkall4").prop("checked")) {
            $(".chk4").prop("checked", true);
        } else {
            $(".chk4").prop("checked", false);
        }
    }
    else if (num == 5) {
        if ($("#checkall5").prop("checked")) {
            $(".chk5").prop("checked", true);
        } else {
            $(".chk5").prop("checked", false);
        }
    }

}
function excel_All() {
    checked = 0;
    for (var n = -1; n < 400; n++) {
        if ($("#id_" + n).prop("checked")) {
            console.log('hello' + student_id[n + 1]
            );
            checked_id[checked] = student_id[n + 1];
            checked++;
        }
        else {

        }
    }
    console.log('checked : ' + checked_id)
    $("#excel_target").val(checked_id);
}
function check_checked() {

    checked = 0;
    for (var n = -1; n < 400; n++) {
        if ($("#id_" + n).prop("checked")) {
            console.log('hello' + student_id[n + 1]
            );
            checked_id[checked] = student_id[n + 1];
            checked++;
        }
        else {

        }
    }
    console.log('checked : ' + checked_id)
    $("#memo_target").val(checked_id);
}
function check_delete() {

    checked = 0;
    for (var n = -1; n < 400; n++) {
        if ($("#id_" + n).prop("checked")) {
            console.log('hello' + student_id[n + 1]
            );
            checked_id[checked] = student_id[n + 1];
            checked++;
        }
        else {

        }
    }
    console.log('checked : ' + checked_id)
    $("#delete_target").val(checked_id);
}
function showsearch() {
    $("#search").css("max-width", "100%");
    /*$("#search").css("transition", "max-width 0.35s ease-in");*/
    $("#search").css("z-index", "100");
    $("#search").css("visibility", "visible");
    $("#shadow").css("min-width", "100%");
    $("#shadow").css("max-height", "100%");
    $("#shadow").css("z-index", "10");

}
function showaddstudent() {
    /*$("#student_add_box").css("max-width", "100%");*/
    /*$("#search").css("transition", "max-width 0.35s ease-in");*/
    $("#student_add_container").css("z-index", "20");
    $("#student_add_box").css("z-index", "10");
    $("#student_add_box").css("visibility", "visible");
}
function showConsult() {
    /*$("#student_add_box").css("max-width", "100%");*/
    /*$("#search").css("transition", "max-width 0.35s ease-in");*/
    $("#consult_add_container").css("z-index", "20");
    $("#consult_add_box").css("z-index", "10");
    $("#consult_add_box").css("visibility", "visible");
    console.log(phase);
}
function showaddmemo() {
    /*$("#memo_add_box").css("max-width", "100%");*/
    /*$("#search").css("transition", "max-width 0.35s ease-in");*/
    $("#memo_add_container").css("z-index", "20");
    $("#memo_add_box").css("z-index", "10");
    $("#memo_add_box").css("visibility", "visible");
}
function showCal() {
    $("#cal_add_container").css("z-index", "20");
    $("#cal_add_box").css("z-index", "10");
    $("#cal_add_box").css("visibility", "visible");
}

window.onclick = function (e) {
    if (e.target.matches('.arrow-right')) {

    }
    else if (e.target.matches('#searchbox')) {

    }
    else if (e.target.matches('#searchdiv')) {

    }
    else if (!e.target.matches('#searchbutton')) {
        $("#search").css("z-index", "0");
        $("#shadow").css("min-width", "0");
        $("#shadow").css("max-height", "0");
        $("#search").css("visibility", "hidden");
    }
};
