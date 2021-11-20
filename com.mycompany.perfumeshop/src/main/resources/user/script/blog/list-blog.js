$(document).ready(function () {
    setMenuBanner();
    $('.close-btn-alert').click(function () {
        $('.alert').removeClass("show");
        $('.alert').addClass("hide");
    });
    $("#searchStr").val("");
    //load init
    loadData(null, 1, null);

    $("body").on("click", ".row-left-sidebar", function () {
        $('#searchStr').val("");

        $('.table-categoty').find('.selected-category').removeClass('selected-category');
        $('.table-categoty').find('.chosed').removeClass('chosed');

        var id_category = $(this).attr('id');
        loadData(null, 1, id_category, null, null);
        $(this).addClass('chosed');
        $(this).addClass('selected-category');
        var title = $(this).children('td:nth-child(2)').text();
        $('#title-banner').find('h2').html("Danh mục sản phẩm");
        $('#title-banner').find('p').html("Trang chủ > " + title);
    });

    $("body").on("click", ".pagination li a", function (event) {
        event.preventDefault();
        var page = $(this).attr('data-page');
        var id_category = $('.table-categoty').find('.chosed').attr('id');
      
        var txtSearch = $("#searchStr").val();
        if (txtSearch != "") {
            loadData(txtSearch, page, id_category);
        } else {
            loadData(null, page, id_category);
        }
    });

    $("body").on("click","#search", function () {
        $('#list-category-blog').find('.selected-category').removeClass('selected-category');
        var txtSearch = $("#searchStr").val();
        console.log(txtSearch);
        if (txtSearch != "") {
            loadData(txtSearch, 1, null);
        } else {
            loadData(null, 1, null);
        }
    });

    $("body").on("click","#list-category-blog li", function () {
        $('#searchStr').val("");

        $('#list-category-blog').find('.selected-category').removeClass('selected-category');
        $('#list-category-blog').find('.chosed').removeClass('chosed');

        var id_category = $(this).attr('id');
        loadData(null, 1, id_category);
        $(this).addClass('chosed');
        $(this).addClass('selected-category');

        var title = $(this).find('p:first-child').text();
        $('#title-banner').find('h2').html("Blogs");
        $('#title-banner').find('p').html("Trang chủ > " + title);
    });

});

function setMenuBanner() {
    var titlebanner = '';
    $("#img-banner").html('<img src="/user/img/my-image/banner/news.png" alt="" width="200">');
    titlebanner += '<h2>Blog</h2>';
    titlebanner += '<p> Trang chủ <span>></span> Blog </p>';
    $("#title-banner").html(titlebanner);

    $("#mainNav li").each(function (index) {
        $(this).removeClass("my-menu-active");
    });

    $("#menu-blog").addClass("my-menu-active");
}

function loadData(searchStr, page, id_category) {
    $.ajax({
        url: "/all-blog",
        type: "GET",
        data: {
            searchStr: searchStr,
            page: page,
            id_category: id_category
        },
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (result) {
            var html = '';
            if ((result.blogs.length == 0 || result.blogs == null) && searchStr != null && searchStr != "") {
                html += '<div style="margin:auto;text-align:center">';
                html += ' <img src="/user/img/NotFoundBlog.png" width="300" style="margin:auto"/>';
                html += '<br/>'
                html += ' <p style="text-align:center; margin: 25px 0px 30px;">Không tìm thấy blog phù hợp!</p>';
                html += '</div>';
                $("#load-pagination").html("");
            } else if ((result.blogs.length == 0 || result.blogs == null) && id_category != null && id_category != "") {
                html += '<div style="margin:auto;text-align:center">';
                html += ' <img src="/user/img/NotFoundBlog.png" width="300" style="margin:auto"/>';
                html += '<br/>'
                html += ' <p style="text-align:center; margin: 25px 0px 30px;">Không có blog nào trong danh mục!</p>';
                html += '</div>';
                $("#load-pagination").html("");
            } else {
                $.each(result.blogs, function (index, item) {
                    html += '<article class="blog_item" onclick="detail(' + item.id + ')">';
                    html += '		<div class="blog_item_img">';
                    html += '         <img class="card-img rounded-0" width="750" height="375" src="/upload/' + item.avatar + '	" alt="">';
                    if (item.updatedDate != null) {
                        html += '         <div class="blog_item_date">';
                        html += '       		<h3>' + item.updatedDate.slice(0, 2) + '</h3>';
                        html += '     		<p>Tháng ' + item.updatedDate.slice(3, 5) + '</p>';
                        html += ' 		</div>';
                    } else {
                        html += '         <div class="blog_item_date">';
                        html += '       		<h3>' + item.createdDate.slice(0, 2) + '</h3>';
                        html += '     		<p>Tháng ' + item.createdDate.slice(3, 5) + '</p>';
                        html += ' 		</div>';
                    }

                    html += '		</div>';
                    html += '    <div class="blog_details">';
                    html += '        <div class="d-inline-block">';
                    html += '            <h2>' + item.name + '</h2>';
                    html += '        </div>';
                    html += '         <p>' + item.description + '</p>';
                    html += '        <ul class="blog-info-link">';
                    html += '            <li><div><i class="far fa-user"></i>' + item.categoryname + '</div></li>';
                    html += '        </ul>';
                    html += '    </div>';
                    html += '</article>';
                });
                //create pagination
                var pagination_string = "";
                var currentPage = result.currentPage;
                var totalPage = result.totalPage;


                if (currentPage > 1) {
                    var previousPage = currentPage - 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + previousPage + '><i class="fas fa-angle-double-left" style="font-size:18px"></i></a></li>';
                }

                for (i = 1; i <= totalPage; i++) {
                    if (i == currentPage) {
                        pagination_string += '<li class="page-item active"><a href="" class="page-link" data-page=' + i + '>' + currentPage + '</a></li>';
                    } else if (i >= currentPage - 3 && i <= currentPage + 4) {
                        pagination_string += '<li class="page-item"><a href="" class="page-link" data-page=' + i + '>' + i + '</a></li>';
                    }
                }

                if (currentPage > 0 && currentPage < totalPage) {
                    var nextPage = currentPage + 1;
                    pagination_string += '<li class="page-item"><a href="" class="page-link"  data-page=' + nextPage + '><i class="fas fa-angle-double-right" style="font-size:18px"></i></a></li>';
                }
                $("#load-pagination").html(pagination_string);
            }
            $("#blog-container").html(html);
        }

    });
}

function detail(id_blog) {
    $.ajax({
        url: "/detail-blog",
        type: "GET",
        data: {
            idBlog: id_blog
        },
        dataType: "json",
        contentType: "application/json;charset=utf-8",
        success: function (result) {
            $("#load-pagination").html("");
            var html = '';
            html += result.detail;
            $("#blog-container").html(html);
        }

    });
};