$ = (str) -> document.getElementById(str)

navlist = $('nav').children

navi = ->
    if window.location.href isnt location.origin + '/'
        pathname = location.pathname
        if pathname is '/categories.html'
            navlist[2].className = 'nav-selected'
        else if pathname is '/archive.html'
            navlist[3].className = 'nav-selected'
        else if pathname is '/links.html'
            navlist[4].calssName = 'nav-selected'
        else if pathname is '/about.html'
            navlist[5].className = 'nav-selected'
    else
        navlist[1].className = 'nav-selected' 

window.onload = navi()