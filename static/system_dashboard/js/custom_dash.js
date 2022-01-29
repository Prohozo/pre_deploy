$(document).ready(function(){
    $.ajax({
        type: "GET",
        url: "/get_menu",
        contentType: "application/json",
        dataType: "text",
        success: function (data) {
            document.getElementById("menu_item").innerHTML += data;

            var id_choice_menu = window.location.href.split('/')[3];
            document.getElementById(id_choice_menu).setAttribute('class', 'nav-link js-arrow active')
        },
        error: function (jqXHR) {
            console.log(jqXHR);
        }
    });
});

function change_logo(){
    var menu = document.getElementById("menu_dsa");
    var logo = document.getElementById("logo_dsa");
    var arrow = document.getElementById("arrow");
    var arrow_2 = document.getElementById("arrow_2");

    if (logo.getAttribute("src").split("/").slice(-1)[0] != "Dsa_icon.png" && menu.getAttribute("w") == 73){
        logo.setAttribute("src", "../../static/system_dashboard/images/icon/Dsa_icon.png");
        arrow.setAttribute("style", "visibility: hidden;")
        arrow_2.setAttribute("style", "visibility: hidden;")
    } else{
        logo.setAttribute("src", "../../static/system_dashboard/images/icon/logo_ngang.png");
        arrow.removeAttribute("style");
        arrow_2.removeAttribute("style");
    }
}

$(document).ready(function(){
    $("#click_menu").click(function(){
        var menu = document.getElementById("menu_dsa");
        if (menu.getAttribute("w") == 73){
            menu.setAttribute("w", 249);
        } else{
            menu.setAttribute("w", 73);
        }
        change_logo();
    });
});

$(document).ready(function(){
    $("#menu_dsa").hover(function(){
        change_logo();
        }, function(){
        change_logo();
    });
    
    var path_name = window.location.pathname;
    if (path_name == '/') {
        document.getElementById('home_li').setAttribute("class", "nav-item seleted");
        document.getElementById('home_a').setAttribute("class", "nav-link active js-arrow");
    }
    else {
        var id = path_name.split('/');
        document.getElementById(id[1]+'_li').setAttribute("class", "nav-item has-treeview seleted menu-open");
        document.getElementById(id[1]+'_a').setAttribute("class", "nav-link active js-arrow");
        document.getElementById(id[2]).setAttribute("class", "nav-link active");
        
        var title = document.getElementById(id[2]+'_title').innerHTML.toUpperCase();
        document.getElementById("title-top").innerHTML="DASHBOARD TÀI CHÍNH - " + title;
    }
});