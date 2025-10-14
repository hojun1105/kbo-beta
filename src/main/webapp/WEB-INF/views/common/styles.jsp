<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    body {
        margin: 0;
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f5f5f5;
        color: #222;
    }
    
    .logo-img {
        height: 60px;
        vertical-align: middle;
    }
    
    .navbar {
        background-color: #0a0a23;
        padding: 0 40px;
        height: 60px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    .navbar-left {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .navbar-brand {
        color: white;
        font-size: 1.4em;
        font-weight: bold;
    }

    .nav-group-left,
    .nav-group-right {
        display: flex;
        gap: 20px;
    }

    .nav-link {
        color: white;
        text-decoration: none;
        font-weight: 600;
        padding: 6px 0;
        border-bottom: 3px solid transparent;
        transition: border 0.2s ease;
    }

    .nav-link:hover,
    .nav-link.active {
        border-bottom: 3px solid #c30452;
    }
    
    footer {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background-color: #f8f9fa;
        text-align: center;
        padding: 10px 0;
    }
</style>

