function slideToggle(t, e, o) {
    0 === t.clientHeight ? j(t, e, o, !0) : j(t, e, o)
}

function slideUp(t, e, o) {
    j(t, e, o)
}

function slideDown(t, e, o) {
    j(t, e, o, !0)
}

function j(t, e, o, i) {
    void 0 === e && (e = 400), void 0 === i && (i = !1), t.style.overflow = "hidden", i && (t.style.display = "block");
    var p, l = window.getComputedStyle(t), n = parseFloat(l.getPropertyValue("height")),
        a = parseFloat(l.getPropertyValue("padding-top")), s = parseFloat(l.getPropertyValue("padding-bottom")),
        r = parseFloat(l.getPropertyValue("margin-top")), d = parseFloat(l.getPropertyValue("margin-bottom")),
        g = n / e, y = a / e, m = s / e, u = r / e, h = d / e;
    window.requestAnimationFrame(function l(x) {
        void 0 === p && (p = x);
        var f = x - p;
        i ? (t.style.height = g * f + "px", t.style.paddingTop = y * f + "px", t.style.paddingBottom = m * f + "px", t.style.marginTop = u * f + "px", t.style.marginBottom = h * f + "px") : (t.style.height = n - g * f + "px", t.style.paddingTop = a - y * f + "px", t.style.paddingBottom = s - m * f + "px", t.style.marginTop = r - u * f + "px", t.style.marginBottom = d - h * f + "px"), f >= e ? (t.style.height = "", t.style.paddingTop = "", t.style.paddingBottom = "", t.style.marginTop = "", t.style.marginBottom = "", t.style.overflow = "", i || (t.style.display = "none"), "function" == typeof o && o()) : window.requestAnimationFrame(l)
    })
}

// let sidebarItems = document.querySelectorAll('.sidebar-item.has-sub');
// for(var i = 0; i < sidebarItems.length; i++) {
//     let sidebarItem = sidebarItems[i];
// 	sidebarItems[i].querySelector('.sidebar-link').addEventListener('click', function(e) {
//         e.preventDefault();
////         let submenu = sidebarItem.querySelector('.submenu');
//         if( submenu.classList.contains('active') ) submenu.style.display = "block"
//
//         if( submenu.style.display == "none" ) submenu.classList.add('active')
//         else submenu.classList.remove('active')
//         slideToggle(submenu, 300)
//     })
// }
//
window.addEventListener('DOMContentLoaded', (event) => {
    var w = window.innerWidth;
    if(w < 1200) {
        closeNav();
    }
});
window.addEventListener('resize', (event) => {
    var w = window.innerWidth;
    if(isTouch==0){
        if(w < 1200) {
            closeNav();
        }else{
            openNav();
        }
    }
});

var isTouch=0;
window.addEventListener('touchstart', (event) => {
    isTouch=1;
    // console.log('touchstart'+isTouch);
});
window.addEventListener('touchmove', (event) => {
    isTouch=1;
    // console.log('touchmove'+isTouch);
});
window.addEventListener('touchend', (event) => {
    isTouch=0;
    // console.log('touchend'+isTouch);
});

// document.querySelector('.burger-btn').addEventListener('click', () => {
//     document.getElementById('sidebar').classList.toggle('active');
// })
// document.querySelector('.sidebar-hide').addEventListener('click', () => {
//     document.getElementById('sidebar').classList.toggle('active');
//
// })


// Perfect Scrollbar Init
// if(typeof PerfectScrollbar == 'function') {
//     const container = document.querySelector(".sidebar-wrapper");
//     const ps = new PerfectScrollbar(container, {
//         wheelPropagation: false
//     });
// }

// Scroll into active sidebar
// document.querySelector('.sidebar-item.active').scrollIntoView(false)

$(document).ready(function () {
    if(window.innerWidth>=1200){
        document.getElementById("sidebar2").style.transition = "0s";
        document.getElementById("main").style.transition = "0s";
        document.getElementById("sidebar2").style.width = "300px";
        document.getElementById("main").style.marginLeft = "300px";
        isNavOpened = 1;
    }
//        transition: 0.5s;
})

var isNavOpened = 0;
var mainWidth = 0;
function openNav() {
    if (isNavOpened == 0) {
        var screenWidth = "300px";
        mainWidth=document.getElementById("main").offsetWidth
        if (window.innerWidth < 1200) {
            screenWidth = window.innerWidth + "px";
            document.getElementById("main").style.display = "none";
        }
        document.getElementById("sidebar2").style.transition = "0.5s";
        document.getElementById("main").style.transition = "0.5s";
        document.getElementById("sidebar2").style.width = screenWidth;
        document.getElementById("main").style.marginLeft = screenWidth;
        isNavOpened = 1;
        // console.log(mainWidth);
    } else {
        closeNav();
    }
}

function closeNav() {
    document.getElementById("sidebar2").style.transition = "0.5s";
    document.getElementById("main").style.transition = "0.5s";
    document.getElementById("sidebar2").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    // if (window.innerWidth < 1200) {
        document.getElementById("main").style.display = "block";
    // }
    isNavOpened = 0;
}

var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
})